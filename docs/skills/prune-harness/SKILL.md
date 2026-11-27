---
name: prune-harness
description: Use after the agent's model changes, to switch harness rules off one at a time and delete those the new model no longer needs.
---

# Prune harness

Last reviewed: 2026-11-27

Rules cost context and time. A stronger model may not need some of them.

1. Pick a representative task with a clear contract.
2. Take one row from `docs/harness.md`. Switch only that rule off (comment out the check in
   `CHECKS`, or remove the text rule) on a branch.
3. Run the task with the new model. Check the result against the contract and with
   `./verify.sh` restored.
4. The mistake the rule covers did not happen: delete the rule and its row (record it in
   `docs/decisions.md`). It happened: restore the rule and set "Last checked needed" to today.
5. One rule at a time; one PR per removed rule.
