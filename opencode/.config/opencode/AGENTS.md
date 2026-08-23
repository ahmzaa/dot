# Memory routing: Engram vs Honcho

Two persistent memory systems are active with **separate responsibilities**.
Route every write with this test:

> **"Would this still be true if we were working in a different repo?"**
>
> - **No** → **Engram** (`mem_save`) — facts about this codebase, infra, or deployment.
> - **Yes** → **Honcho** (`honcho_create_conclusion`) — facts about the user.

## Engram owns the work

- Bugfixes, architecture and design decisions, config changes
- Codebase and infrastructure discoveries, gotchas, invariants
- Per-project conventions and patterns
- Session summaries (`mem_session_summary`)

Engram is the system of record for what was built and why. Its injected
protocol stands, except where overridden below.

## Honcho owns the user

- Standing preferences and working style — output format, review depth,
  tolerance for risk, how much hedging is wanted
- Dispositions and constraints that hold across projects
- Anything about the person rather than the code

Write these with `honcho_create_conclusion` **as soon as they surface**, not at
end of session.

## Overrides to Engram's protocol

Engram's injected protocol directs user preferences and constraints into
Engram. **That is superseded by this file.**

- Do **not** use Engram's `scope: personal`. It is retired. Personal-scope
  facts go to Honcho.
- The **Instructions** section of `mem_session_summary` records only
  constraints specific to that project's work. General preferences go to
  Honcho instead.

## One exchange can produce both

The specific decision goes to Engram; the general disposition it reveals goes
to Honcho.

| Observation | Destination |
| --- | --- |
| Honcho API runs with auth disabled — deliberate, NetBird is the trust boundary | Engram |
| Prefers pragmatic single-user tradeoffs over defense-in-depth in homelab contexts | Honcho |
| sanoid names snapshots in UTC under systemd, local time interactively | Engram |
| Wants review findings ordered by severity with exact `file:line` refs | Honcho |

## Reading

- Recalling past work, a decision, or a bug → `mem_context`, then `mem_search`.
- Needing to know how the user wants something done → Honcho context is
  injected automatically (`recallMode: hybrid`). Call `honcho_chat` only if the
  injected context is silent on the point.
- Treat an empty Honcho result as *"unknown"*, never as *"nothing was
  recorded"* — it is network-dependent and has returned confident empty
  answers while unreachable.
