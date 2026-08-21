#!/usr/bin/env bash
# Materialise herdr workspace presets declared in presets.toml.
#
# Invoked two ways:
#   * [[startup]] hook  — every server start, including `herdr update` handoff
#   * [[actions]] apply — on demand, via keybinding or `plugin action invoke`
#
# Idempotent by workspace label: a preset whose label already exists is skipped,
# so repeated startups never duplicate workspaces.
#
# Usage: apply.sh [--dry-run] [preset-name ...]
#        (no names = every preset in the file)
#
# Written for bash 3.2 so it runs against stock /bin/bash on macOS.

set -uo pipefail

readonly PROG="presets"

dry_run=0
case "${1:-}" in
    --dry-run|-n) dry_run=1; shift ;;
esac

log()  { printf '%s: %s\n' "$PROG" "$*" >&2; }
die()  { log "$*"; exit 1; }

# ── Dependencies ────────────────────────────────────────────────────────────
# Prefer the running binary herdr injects; it is correct for named sessions and
# for the Unix-socket vs named-pipe transport difference.
HERDR="${HERDR_BIN_PATH:-herdr}"
command -v "$HERDR" >/dev/null 2>&1 || die "herdr binary not found (HERDR_BIN_PATH=${HERDR_BIN_PATH:-unset})"

# Startup hooks inherit a login-ish env but not necessarily an interactive PATH,
# so look in the usual Homebrew prefixes before giving up.
find_yq() {
    local c
    for c in yq /opt/homebrew/bin/yq /usr/local/bin/yq; do
        command -v "$c" >/dev/null 2>&1 && { command -v "$c"; return 0; }
    done
    return 1
}
YQ="$(find_yq)" || die "yq not found; install with 'brew install yq' (needs TOML support, i.e. mikefarah/yq v4+)"
command -v jq >/dev/null 2>&1 || die "jq not found"

# ── Preset file ─────────────────────────────────────────────────────────────
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
PRESETS="${HERDR_PRESETS_FILE:-}"
if [ -z "$PRESETS" ]; then
    for candidate in \
        "${HERDR_PLUGIN_CONFIG_DIR:-/nonexistent}/presets.toml" \
        "$config_home/herdr/presets.toml"
    do
        if [ -f "$candidate" ]; then PRESETS="$candidate"; break; fi
    done
fi
if [ -n "${HERDR_PRESETS_FILE:-}" ]; then
    [ -f "$PRESETS" ] || die "HERDR_PRESETS_FILE=$PRESETS does not exist"
else
    [ -n "$PRESETS" ] || die "no presets.toml found (looked in \$HERDR_PLUGIN_CONFIG_DIR and $config_home/herdr)"
fi

spec="$("$YQ" -p toml -o json '.' "$PRESETS" 2>&1)" \
    || die "failed to parse $PRESETS: $spec"

total="$(printf '%s' "$spec" | jq '(.workspace // []) | length')"
[ "$total" -gt 0 ] || { log "no [[workspace]] entries in $PRESETS; nothing to do"; exit 0; }

# ── Helpers ─────────────────────────────────────────────────────────────────
q() { printf '%s' "$spec" | jq -r "$1"; }

expand_tilde() {
    case "$1" in
        "~")   printf '%s' "$HOME" ;;
        "~/"*) printf '%s%s' "$HOME" "${1#\~}" ;;
        *)     printf '%s' "$1" ;;
    esac
}

# Only apply presets named on the command line, when any were given.
argc=$#
filter=""
for a in "$@"; do filter="$filter
$a"; done

wanted() {
    [ "$argc" -eq 0 ] && return 0
    printf '%s\n' "$filter" | grep -Fxq -- "$1"
}

# Startup must never steal focus from a restored session. A manual invocation
# focuses the first workspace it creates, which is what you want from a keybind.
focus_first=1
[ "${HERDR_PLUGIN_EVENT:-}" = "startup" ] && focus_first=0
focused_one=0

existing="$("$HERDR" workspace list 2>/dev/null | jq -r '.result.workspaces[].label' 2>/dev/null)"

created=0 skipped=0 failed=0

# ── Apply ───────────────────────────────────────────────────────────────────
i=0
while [ "$i" -lt "$total" ]; do
    idx="$i"; i=$((i + 1))

    name="$(q ".workspace[$idx].name // empty")"
    [ -n "$name" ] || { log "workspace[$idx] has no name; skipping"; failed=$((failed + 1)); continue; }

    wanted "$name" || continue

    if printf '%s\n' "$existing" | grep -Fxq -- "$name"; then
        skipped=$((skipped + 1))
        continue
    fi

    cwd="$(expand_tilde "$(q ".workspace[$idx].cwd // empty")")"
    [ -n "$cwd" ] || cwd="$HOME"
    if [ ! -d "$cwd" ]; then
        log "$name: cwd '$cwd' does not exist; skipping"
        failed=$((failed + 1))
        continue
    fi

    if [ "$dry_run" -eq 1 ]; then
        log "would create '$name' cwd=$cwd tabs=$(( $(q "(.workspace[$idx].tabs // []) | length") + 1 ))"
        created=$((created + 1))
        continue
    fi

    resp="$("$HERDR" workspace create --cwd "$cwd" --label "$name" --no-focus 2>&1)"
    ws="$(printf '%s' "$resp" | jq -r '.result.workspace.workspace_id // empty' 2>/dev/null)"
    root_tab="$(printf '%s' "$resp" | jq -r '.result.tab.tab_id // empty' 2>/dev/null)"
    root_pane="$(printf '%s' "$resp" | jq -r '.result.root_pane.pane_id // empty' 2>/dev/null)"
    if [ -z "$ws" ]; then
        log "$name: workspace create failed: $resp"
        failed=$((failed + 1))
        continue
    fi

    # First tab: herdr labels it "1" by default, which looks broken next to the
    # named tabs that follow. Always give it a name — `tab` if set, else the
    # workspace name.
    first_tab="$(q ".workspace[$idx].tab // empty")"
    [ -n "$first_tab" ] || first_tab="$name"
    [ -n "$root_tab" ] && \
        "$HERDR" tab rename "$root_tab" "$first_tab" >/dev/null 2>&1

    cmd="$(q ".workspace[$idx].command // empty")"
    [ -n "$cmd" ] && [ -n "$root_pane" ] && \
        "$HERDR" pane run "$root_pane" "$cmd" >/dev/null 2>&1

    # Additional tabs.
    ntabs="$(q "(.workspace[$idx].tabs // []) | length")"
    t=0
    while [ "$t" -lt "$ntabs" ]; do
        tidx="$t"; t=$((t + 1))

        tname="$(q ".workspace[$idx].tabs[$tidx].name // empty")"
        tcmd="$(q ".workspace[$idx].tabs[$tidx].command // empty")"
        tcwd="$(q ".workspace[$idx].tabs[$tidx].cwd // empty")"
        if [ -n "$tcwd" ]; then tcwd="$(expand_tilde "$tcwd")"; else tcwd="$cwd"; fi

        tresp="$("$HERDR" tab create --workspace "$ws" --cwd "$tcwd" \
                    ${tname:+--label "$tname"} --no-focus 2>&1)"
        tpane="$(printf '%s' "$tresp" | jq -r '.result.root_pane.pane_id // empty' 2>/dev/null)"
        if [ -z "$tpane" ]; then
            log "$name/${tname:-tab$tidx}: tab create failed: $tresp"
            continue
        fi

        [ -n "$tcmd" ] && "$HERDR" pane run "$tpane" "$tcmd" >/dev/null 2>&1
    done

    created=$((created + 1))
    existing="$existing
$name"

    if [ "$focus_first" -eq 1 ] && [ "$focused_one" -eq 0 ]; then
        "$HERDR" workspace focus "$ws" >/dev/null 2>&1
        focused_one=1
    fi
done

log "created=$created skipped=$skipped failed=$failed (${HERDR_PLUGIN_EVENT:-manual})"
[ "$failed" -eq 0 ] || exit 1
exit 0
