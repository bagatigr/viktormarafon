---
name: ratchet
description: Use after any agent mistake, to turn it into a rule in AGENTS.md and, when it repeats, into a check in verify.sh.
---

# Ratchet

Last reviewed: 2026-11-27

Every mistake makes the workspace stricter, so it does not happen again.

1. Name the mistake in one line: what happened and what should have happened.
2. Fix the mistake itself first.
3. First time: add a short rule to `AGENTS.md` (Working rules) that would have prevented it.
   Keep AGENTS.md under 100 lines: merge or shorten rules if needed.
4. Second time (the rule already exists and was broken again): turn it into a check in
   `verify.sh`: a new `check_<name>` function added to `CHECKS`, whose error says what to
   fix and how. Then remove or shorten the text rule.
5. Add a row to `docs/harness.md`: the rule or check, the model weakness it covers, the date
   added and the date last checked needed.
6. Run `./verify.sh`. Note the ratchet in `progress.md` and in the PR's harness section.
