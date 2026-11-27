# Context: glossary

Last reviewed: 2026-11-27

Terms used in this repository and their exact meaning. Add a term when it first appears;
correct a term when its meaning is refined. One line each, alphabetical.

- **Agent**: any AI coding tool (Devin, Claude Code, Codex) or person working in this repo.
- **Contract**: 3-7 checkable "done when" criteria of a task and how each is checked. Lives in the task's plan file, or in its `progress.md` entry for a small fix. See [contract](skills/contract/SKILL.md).
- **Decision**: a choice that is hard to undo or that others must know; logged in [decisions.md](decisions.md).
- **Done when**: the criteria that make a task finished; see Contract.
- **Feature**: one item of `feature_list.json`: `{"id": unique non-empty string, "description": non-empty string, "steps": non-empty list of non-empty strings, "passes": true|false}`. Its `steps` are its acceptance test. Only `passes` may change, and only after verify-before-done.
- **Golden principle**: a rule of taste in [golden-principles.md](golden-principles.md).
- **Handoff**: compressing session state into `progress.md` so a new session can continue.
- **Harness**: the rules and checks of this workspace (AGENTS.md, procedures, `verify.sh`), listed in [harness.md](harness.md).
- **Plan**: a short task plan in `plans/active/<task>.md`; the long form follows [PLANS.md](PLANS.md).
- **Procedure**: a step-by-step skill in `docs/skills/<name>/SKILL.md`.
- **Ratchet**: turning a mistake into a rule, and a repeated mistake into a check. See [ratchet](skills/ratchet/SKILL.md).
- **Session**: one continuous run of one agent on one task, from `./init.sh` to the `progress.md` entry.
- **Task**: one unit of work, about an hour, ending in one PR.
- **Verify**: running `./verify.sh`; green means exit code 0.
- **Worktree**: a separate checkout made by `./worktree.sh <task-name>` in `.worktrees/`, so agents work in parallel.
