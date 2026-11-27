# AGENTS.md

Start here. This file is a map: read it whole, then open only the links you need.

## Purpose

The product for this repository is not chosen yet: there is no product code and no stack.
For now it holds the agent workspace: the rules, procedures and checks that let any agent
(Devin, Claude Code, Codex) or person work here the same way, from files in the repo.

## Commands

- `./init.sh`: start of every session. Last progress entries, `git log -20`, active plans, then verify.
- `./verify.sh`: the one check. Green (exit 0) before you call anything done. Each error says how to fix it.
- `./worktree.sh <task-name>`: own worktree and branch in `.worktrees/<task-name>` for parallel work.

## Map

| Path | What it is |
| --- | --- |
| [CLAUDE.md](CLAUDE.md) | One line, `@AGENTS.md`: every agent reads the same rules. |
| [progress.md](progress.md) | Session log, newest entry last: done, state, next step, open questions. |
| [feature_list.json](feature_list.json) | Feature backlog, `[{"id", "description", "steps": [...], "passes": bool}]`. Change only `passes`, only after verify-before-done. Never delete or rewrite items or tests. |
| [docs/CONTEXT.md](docs/CONTEXT.md) | Glossary: terms and their exact meaning. |
| [docs/decisions.md](docs/decisions.md) | Decision log: date, decision, why, rejected options. |
| [docs/golden-principles.md](docs/golden-principles.md) | Rules of taste. |
| [docs/tech-debt.md](docs/tech-debt.md) | Tech-debt tracker. |
| [docs/harness.md](docs/harness.md) | Registry of workspace rules and checks, and why each exists. |
| [docs/wiki/index.md](docs/wiki/index.md) | Knowledge base: research, notes, answers to important questions. |
| [docs/PLANS.md](docs/PLANS.md) | Template for a plan that spans sessions. |
| [docs/plans/active/](docs/plans/active/), [docs/plans/completed/](docs/plans/completed/) | Plans in progress and done. |
| [docs/experiments/README.md](docs/experiments/README.md) | Template for autonomous experiment loops. |
| [docs/skills/](docs/skills/) | Procedures, one folder each (list below). |
| [.devcontainer/](.devcontainer/) | Base environment, the same for every agent and person. |
| [.github/](.github/) | CI (`./verify.sh` on every PR) and the PR template with the checklist. |
| [.env.example](.env.example) | Names of environment variables. Real values only in `.env` (git-ignored). |
| `logs/` | Git-ignored. All logs go to `logs/app.log`. |

## Four ground rules

1. Say your assumptions before you start. When something is ambiguous, give options, not a silent pick.
2. The simplest solution that solves the task. Nothing "for later".
3. Change only what was asked. Do not touch neighbouring code or formatting.
4. Every task has a checkable goal: "done when ...".

## Working rules

- One task = one session = one PR, about an hour of work. Bigger: split it.
- Session start: `./init.sh`. Session end: commit and an entry in `progress.md`;
  context more than half full: [handoff](docs/skills/handoff/SKILL.md).
- Order: grill → plan → contract → tdd → verify-before-done → review.
  Small fixes may shorten it to contract → verify-before-done.
- Do not ask "what next": follow the plan. Stop only before decisions that are hard to undo.
- A significant decision: an entry in `docs/decisions.md`. A new term: `docs/CONTEXT.md`.
- Your own "done" is not final: an independent reviewer checks the work.
- Any agent mistake: [ratchet](docs/skills/ratchet/SKILL.md).

## Procedures (docs/skills/)

| Procedure | Use it |
| --- | --- |
| [grill](docs/skills/grill/SKILL.md) | Before any new task: ask until every branch of the decision is closed. |
| [plan](docs/skills/plan/SKILL.md) | Questions → Research → Design → Structure → Plan, at most 40 lines. |
| [contract](docs/skills/contract/SKILL.md) | Before work: 3-7 checkable "done when" criteria and how to check them. |
| [tdd](docs/skills/tdd/SKILL.md) | Red → green → refactor. Failing test first. |
| [debug](docs/skills/debug/SKILL.md) | Reproduce → hypothesis → failing test → fix → regression test. |
| [verify-before-done](docs/skills/verify-before-done/SKILL.md) | Before saying "done": verify green, criteria checked as a person would, evidence in the PR. |
| [review](docs/skills/review/SKILL.md) | Independent, skeptical review against the contract, by someone who did not write the code. |
| [handoff](docs/skills/handoff/SKILL.md) | Context over half full or session ending: state into `progress.md`, new session. |
| [ratchet](docs/skills/ratchet/SKILL.md) | After any agent mistake: a rule in AGENTS.md; twice, a check in verify.sh. |
| [gardening](docs/skills/gardening/SKILL.md) | Weekly: stale docs and rules, small fixing PRs. |
| [prune-harness](docs/skills/prune-harness/SKILL.md) | After a model change: switch rules off one by one, drop what is not needed. |

Where a task's plan and contract live: `docs/plans/active/<task>.md`; a small fix without a
plan keeps its contract in its `progress.md` entry. The PR checklist is in
[.github/pull_request_template.md](.github/pull_request_template.md).
