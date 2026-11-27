---
name: review
description: Use after verify-before-done, for an independent and skeptical review of a change against its contract, by a session or subagent that did not write the code.
---

# Review

Last reviewed: 2026-11-27

Who: a separate session or subagent that did not write the code. For architectural decisions
and large diffs: a model from a different family than the author's.

1. Read the contract ("Done when") and the diff. Do not read the author's summary first.
2. Be skeptical by default: assume each criterion is unmet until you see evidence.
3. For each criterion: check it yourself (run the command, try the behaviour). Mark it
   met / not met / not checkable, with your evidence.
4. Check the four ground rules in `AGENTS.md`: assumptions stated, simplest solution,
   only what was asked changed, checkable goal.
5. Check: `./verify.sh` green, no deleted or weakened tests, `feature_list.json` changed only
   in `passes`, decisions and terms recorded.
6. Write the result in the PR's "Independent review" section: verdict, per-criterion
   findings, requested changes.
7. The author fixes; review again until every criterion is met.
