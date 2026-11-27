---
name: handoff
description: Use when the context is more than half full or the session is ending, to compress the state into progress.md and continue in a new session.
---

# Handoff

Last reviewed: 2026-11-27

1. Stop starting new work. Finish or revert the step in progress, so the tree is clean.
2. Commit and push what is done.
3. Append an entry to `progress.md` (newest last):
   - `## YYYY-MM-DD: <task>`
   - **Done**: what is finished, with commits.
   - **Where we stopped**: the exact state, files, failing test if any.
   - **Next step**: the first concrete action for the next session.
   - **Open questions**: what is undecided, who can answer.
4. If there is a plan in `docs/plans/active/`, update its Progress and Surprises sections.
5. Start a new session. It begins with `./init.sh`, which shows this entry.
