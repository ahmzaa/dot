#!/usr/bin/env bash
set -euo pipefail

SERVER_DEFAULT="http://prd-vps-lon-01.netbird.ahmza.com:18080"

usage() {
  cat <<'USAGE'
Usage: onboard-opencode.sh --project NAME --token-file PATH [--server URL]

Configures an existing Linux OpenCode + Engram installation to use the
NetBird-only Engram Cloud service. The token remains in a mode-0600 file and
is loaded only by the generated opencode-engram launcher.

Required:
  --project NAME       Engram project to enroll on this client
  --token-file PATH    File containing only the Engram client bearer token

Optional:
  --server URL         Engram Cloud URL
                       (default: http://prd-vps-lon-01.netbird.ahmza.com:18080)
USAGE
}

project=""
token_file=""
server="$SERVER_DEFAULT"
while (($#)); do
  case "$1" in
    --project) project="${2:-}"; shift 2 ;;
    --token-file) token_file="${2:-}"; shift 2 ;;
    --server) server="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

[[ -n "$project" ]] || { printf '%s\n' 'Error: --project is required.' >&2; exit 2; }
[[ -n "$token_file" ]] || { printf '%s\n' 'Error: --token-file is required.' >&2; exit 2; }
[[ -f "$token_file" ]] || { printf 'Error: token file not found: %s\n' "$token_file" >&2; exit 2; }

for command_name in curl engram opencode; do
  command -v "$command_name" >/dev/null 2>&1 || {
    printf 'Error: required command is missing: %s\n' "$command_name" >&2
    exit 127
  }
done

# Ensure the credential is not group/world-readable.
chmod 600 "$token_file"
IFS= read -r token < "$token_file" || true
[[ -n "$token" ]] || { printf '%s\n' 'Error: token file is empty.' >&2; exit 2; }
case "$token" in
  *$'\n'*|*$'\r'*) printf '%s\n' 'Error: token must be a single line.' >&2; exit 2 ;;
esac

printf 'Checking NetBird Engram endpoint...\n'
curl --fail --silent --show-error --max-time 10 "$server/health" >/dev/null

printf 'Checking bearer authentication and project access...\n'
curl --fail --silent --show-error --max-time 15 \
  --header "Authorization: Bearer $token" \
  --get --data-urlencode "project=$project" \
  "$server/sync/pull" >/dev/null

printf 'Configuring Engram Cloud endpoint...\n'
engram cloud config --server "$server"

printf 'Installing/updating the OpenCode Engram integration...\n'
engram setup opencode

printf 'Enrolling project and verifying cloud synchronization...\n'
ENGRAM_CLOUD_TOKEN="$token" \
ENGRAM_CLOUD_SERVER="$server" \
engram cloud enroll "$project"
ENGRAM_CLOUD_TOKEN="$token" \
ENGRAM_CLOUD_SERVER="$server" \
engram sync --cloud --status --project "$project"

launcher_dir="$HOME/.local/bin"
launcher="$launcher_dir/opencode-engram"
mkdir -p "$launcher_dir"
quoted_token_file=$(printf '%q' "$token_file")
quoted_server=$(printf '%q' "$server")
cat > "$launcher" <<EOF
#!/usr/bin/env bash
set -euo pipefail
token_file=\${ENGRAM_TOKEN_FILE:-$quoted_token_file}
[[ -r "\$token_file" ]] || { printf 'Engram token file is not readable: %s\\n' "\$token_file" >&2; exit 2; }
IFS= read -r ENGRAM_CLOUD_TOKEN < "\$token_file" || true
[[ -n "\$ENGRAM_CLOUD_TOKEN" ]] || { printf '%s\\n' 'Engram token file is empty.' >&2; exit 2; }
export ENGRAM_CLOUD_TOKEN
export ENGRAM_CLOUD_SERVER=$quoted_server
export ENGRAM_CLOUD_AUTOSYNC=1
exec opencode "\$@"
EOF
chmod 700 "$launcher"

printf '\nConfigured successfully.\n'
printf 'Start OpenCode with: %s\n' "$launcher"
printf 'Project: %s\nServer: %s\n' "$project" "$server"
printf '%s\n' 'The Engram MCP/autosync process will inherit the token from the secure launcher.'
