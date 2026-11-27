---
name: grill
description: Use before starting any new task, to close every open branch of the decision with questions before any plan or code.
---

# Grill

Last reviewed: 2026-11-27

Goal: no silent guesses. Every open question is answered or written down as an assumption.

1. Read the task, `docs/CONTEXT.md`, `docs/decisions.md` and the code or docs it touches.
2. List the decision branches: what exactly is asked, for whom, what is out of scope,
   what "done" looks like, which existing behaviour must not change.
3. For each open branch, ask one concrete question. Offer 2-3 options and your default
   instead of an open question when you can.
4. Ask until every branch is closed. Do not start planning with an open branch.
5. If nobody can answer now: write the assumption down and say it out loud before starting.
6. Record the answers: new or sharper terms in `docs/CONTEXT.md`; choices that are hard to
   undo in `docs/decisions.md` (date, decision, why, rejected options).
7. Next: [plan](../plan/SKILL.md).
