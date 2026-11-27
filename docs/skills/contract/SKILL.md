---
name: contract
description: Use before starting work on any task, to fix 3-7 checkable "done when" criteria and how each one is checked.
---

# Contract

Last reviewed: 2026-11-27

1. Write a "Done when" list of 3-7 criteria. Each one is checkable: a command and its
   expected output, a behaviour a person can try, a file that must exist. No "works well".
2. For each criterion, write how it is checked (command, test name, manual steps).
3. Always include: `./verify.sh` is green.
4. If the task is an item of `feature_list.json`, its `steps` are the core of the contract.
5. Where it goes:
   - a task with a plan: a "Done when" section in `docs/plans/active/<task>.md`;
   - a small fix without a plan: the task's entry in `progress.md`.
6. Say the contract to the person before starting if they are around; otherwise go on.
7. Changing the contract later is a decision: note what changed and why in the same file.
8. The PR template's contract field links to this list.
   [verify-before-done](../verify-before-done/SKILL.md) and [review](../review/SKILL.md)
   check against it.
