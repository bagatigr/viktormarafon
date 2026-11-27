---
name: plan
description: Use after grill and before writing code, to turn a task into a short plan (at most 40 lines) along Questions, Research, Design, Structure, Plan.
---

# Plan

Last reviewed: 2026-11-27

The person reads the final code, not a thousand-line plan. Keep it short.

1. **Questions**: what is still unknown after grill. Answer them or go back to grill.
2. **Research**: read the code, docs and `docs/wiki/` that touch the task. Note facts with
   their file paths. Put findings worth keeping in `docs/wiki/`.
3. **Design**: the simplest approach that solves the task. One or two sentences on why;
   name the alternatives you rejected.
4. **Structure**: which files change or are created, and what each change is.
5. **Plan**: numbered steps, each small enough to test and commit.
6. Write it to `docs/plans/active/<task>.md` with a `Last reviewed: YYYY-MM-DD` line.
   At most 40 lines. Longer means the task is too big: split it into several tasks
   (one PR each) and plan only the first.
7. A task that cannot be split and spans sessions uses the full template
   [docs/PLANS.md](../../PLANS.md) instead.
8. Next: [contract](../contract/SKILL.md), which adds "Done when" to the same file.
9. When the task is merged, move the file to `docs/plans/completed/`.
