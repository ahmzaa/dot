// Caps and stabilises the memory block injected by @honcho-ai/opencode-honcho.
//
// WHY THIS EXISTS
// ---------------
// The Honcho plugin (v0.1.3) injects recalled memory through
// `experimental.chat.system.transform`, i.e. into the SYSTEM PROMPT, and
// refreshes it on INTERNAL_CONTEXT_REFRESH = { messageThreshold: 30,
// ttlSeconds: 300 } (dist/index.js:15579). Two problems follow:
//
//   1. SIZE. The block is uncapped. Measured 11,910 bytes / ~3,000 tokens on
//      a young session, and it grows with history. hermes' own Honcho client
//      caps this via `contextTokens: 1200`, but that field does not exist in
//      the opencode plugin (grep: 0 occurrences) and 0.1.3 is the latest
//      published version, so there is no upgrade path.
//
//   2. CHURN. Prompt caching is prefix-based and the system prompt is the head
//      of the prefix, so ANY change re-writes the whole cached conversation.
//      Honcho's hook also returns early on most turns (`shouldSkip`), so the
//      block alternates between present and absent — churning the prefix even
//      when the content itself has not changed.
//
// Measured over 56 sessions, cache writes were 58% of spend and cache reads
// 37%, vs 5.6% for output. Context size and prefix stability are the cost
// drivers — the same reasoning behind `compaction.prune` and `tail_turns: 2`
// in opencode.jsonc.
//
// WHAT IT DOES
//   - Caps the block to MAX_CHARS, dropping whole low-value sections first
//     (agent self-reflection before user facts) rather than blind truncation.
//   - Serves a cached copy for STABILITY_TTL_MS so the prefix stays
//     byte-identical far longer than Honcho's 300s.
//   - Re-emits the cached block on turns where Honcho skips, so the prefix
//     does not flap between present and absent.
//   - Guarantees exactly one Honcho block regardless of plugin hook order
//     (see ORDER INDEPENDENCE below).
//
// ORDER INDEPENDENCE
// opencode's plugin hook order is not documented and the binary is compressed,
// so we do not assume we run after Honcho. We patch `push` on the live
// `output.system` array, so a later Honcho push is transformed on the way in,
// and we also transform anything already present from an earlier push.
// Duplicate blocks are dropped. Both orderings converge on one capped block.
//
// Set HONCHO_CAP_DISABLE=1 to bypass entirely.
// Set HONCHO_CAP_DEBUG=1 to append what it did to $HONCHO_CAP_LOG
// (default /tmp/honcho-cap.log) — the only way to see this working, since the
// effect lands in the system prompt where it cannot be inspected from a turn.

import { appendFileSync } from "node:fs";

const MARKER = "## Honcho Memory";

const DEBUG = process.env.HONCHO_CAP_DEBUG === "1";
const LOG_PATH = process.env.HONCHO_CAP_LOG || "/tmp/honcho-cap.log";

function log(event, fields) {
  if (!DEBUG) return;
  try {
    const parts = Object.entries(fields).map(([k, v]) => `${k}=${v}`);
    appendFileSync(LOG_PATH, `${new Date().toISOString()} ${event} ${parts.join(" ")}\n`);
  } catch {
    // logging must never break a turn
  }
}

// ~1200 tokens, matching hermes' `contextTokens`. ~4 chars/token.
const MAX_CHARS = 4800;

// Honcho refreshes every 300s. We hold a stable copy far longer; each change
// costs a full prompt-cache write.
const STABILITY_TTL_MS = 30 * 60 * 1000;

// Sections are dropped in this order when over budget — lowest value first.
// Names must match the headings Honcho emits.
const DROP_FIRST = [
  "AI Self-Reflection",
  "Agent Work Context",
  "Recent Session Summary",
  "AI Summary Of User",
];

// Every top-level heading we know about, used to split the body. Anything not
// listed stays attached to the preceding section.
const KNOWN_SECTIONS = [
  "User Memory Profile",
  "Agent Work Context",
  "Recent Session Summary",
  "AI Summary Of User",
  "AI Self-Reflection",
];

/** sessionID -> { text, at } */
const cache = new Map();
/** Arrays whose `push` we have already patched. */
const patched = new WeakSet();

const isHonchoBlock = (v) => typeof v === "string" && v.startsWith(MARKER);

/**
 * Split the block into { preamble, sections: [{ name, text }] }.
 * Falls back to a single unnamed section if no known headings are found.
 */
function parseSections(block) {
  const lines = block.split("\n");
  const starts = [];
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (!line.startsWith("## ")) continue;
    const name = line.slice(3).trim();
    if (KNOWN_SECTIONS.includes(name)) starts.push({ i, name });
  }
  if (starts.length === 0) return { preamble: block, sections: [] };

  const preamble = lines.slice(0, starts[0].i).join("\n");
  const sections = starts.map((s, idx) => {
    const end = idx + 1 < starts.length ? starts[idx + 1].i : lines.length;
    return { name: s.name, text: lines.slice(s.i, end).join("\n").replace(/\s+$/, "") };
  });
  return { preamble, sections };
}

/** Trim to MAX_CHARS, dropping whole sections before cutting mid-text. */
function capBlock(block) {
  if (block.length <= MAX_CHARS) return block;

  const { preamble, sections } = parseSections(block);
  if (sections.length === 0) return hardTruncate(block);

  const kept = sections.slice();
  const dropped = [];
  const size = () =>
    preamble.length + kept.reduce((n, s) => n + s.text.length + 2, 0);

  for (const name of DROP_FIRST) {
    if (size() <= MAX_CHARS) break;
    const idx = kept.findIndex((s) => s.name === name);
    if (idx !== -1) dropped.push(...kept.splice(idx, 1).map((s) => s.name));
  }

  let out = [preamble.replace(/\s+$/, ""), ...kept.map((s) => s.text)]
    .filter(Boolean)
    .join("\n\n");

  if (out.length > MAX_CHARS) out = hardTruncate(out);
  if (dropped.length > 0) out += `\n\n_(omitted for context budget: ${dropped.join(", ")})_`;
  return out;
}

/** Last resort: cut at a line boundary so we never emit half a record. */
function hardTruncate(text) {
  const slice = text.slice(0, MAX_CHARS);
  const at = slice.lastIndexOf("\n");
  return `${(at > MAX_CHARS * 0.5 ? slice.slice(0, at) : slice).replace(/\s+$/, "")}\n\n_(truncated for context budget)_`;
}

/**
 * Return the block to actually inject: a cached copy while it is still fresh,
 * otherwise a newly capped one. Keeping the text byte-identical is the point —
 * it is what preserves the prompt cache.
 */
function stabilise(block, sessionID) {
  const key = sessionID || "__no_session__";
  const now = Date.now();
  const hit = cache.get(key);
  if (hit && now - hit.at < STABILITY_TTL_MS) {
    log("cache-hit", { session: key, bytes: hit.text.length, age_s: Math.round((now - hit.at) / 1000) });
    return hit.text;
  }
  const text = capBlock(block);
  cache.set(key, { text, at: now });
  log("capped", {
    session: key,
    in_bytes: block.length,
    out_bytes: text.length,
    in_tok: Math.round(block.length / 4),
    out_tok: Math.round(text.length / 4),
    saved_pct: Math.round((1 - text.length / block.length) * 100),
  });
  return text;
}

/**
 * Patch `push` so a Honcho block added AFTER us is capped on the way in, and
 * so a second block is never appended.
 */
function patchPush(arr, sessionID) {
  if (patched.has(arr)) return;
  patched.add(arr);
  const original = Array.prototype.push.bind(arr);
  Object.defineProperty(arr, "push", {
    configurable: true,
    writable: true,
    enumerable: false,
    value: (...items) => {
      const accepted = [];
      for (const item of items) {
        if (!isHonchoBlock(item)) {
          accepted.push(item);
          continue;
        }
        if (arr.some(isHonchoBlock)) continue; // already have one
        accepted.push(stabilise(item, sessionID));
      }
      return accepted.length > 0 ? original(...accepted) : arr.length;
    },
  });
}

export const HonchoContextCapPlugin = async () => {
  if (process.env.HONCHO_CAP_DISABLE === "1") return {};

  return {
    "experimental.chat.system.transform": async (input, output) => {
      try {
        const sessionID = input?.sessionID;
        if (!Array.isArray(output.system)) output.system = [];
        const arr = output.system;

        // Case A: Honcho already pushed (it ran before us, unpatched).
        let seen = false;
        for (let i = 0; i < arr.length; i++) {
          if (!isHonchoBlock(arr[i])) continue;
          if (seen) {
            arr.splice(i, 1);
            i--;
            continue;
          }
          arr[i] = stabilise(arr[i], sessionID);
          seen = true;
        }

        // Case B: Honcho skipped this turn. Re-emit the cached block so the
        // prefix does not flap between present and absent.
        if (!seen) {
          const hit = cache.get(sessionID || "__no_session__");
          if (hit && Date.now() - hit.at < STABILITY_TTL_MS) {
            Array.prototype.push.call(arr, hit.text);
            seen = true;
            log("re-emit", { session: sessionID || "__no_session__", bytes: hit.text.length });
          }
        }

        // Case C: Honcho runs after us — catch its push.
        patchPush(arr, sessionID);
      } catch {
        // Never break the turn over a context optimisation.
      }
    },
  };
};
