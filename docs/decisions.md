# Decisions

Last reviewed: 2026-11-27

One entry per significant decision, newest last: date, decision, why, rejected options.
Never rewrite an old entry; add a new one that supersedes it.

## 2026-11-27: Agent workspace layout

- **Decision**: The repo starts as a tool-neutral agent workspace with no product code and no stack.
  Entry point `AGENTS.md` (CLAUDE.md is `@AGENTS.md`); knowledge in `docs/` (glossary, decisions,
  principles, tech debt, harness, wiki, plans, experiments); 11 procedures in `docs/skills/<name>/SKILL.md`;
  session memory in `progress.md` and `feature_list.json` at the root; scripts `init.sh`, `verify.sh`,
  `worktree.sh` at the root; worktrees in `.worktrees/<task-name>` (git-ignored), branch named as the task;
  CI runs `./verify.sh` on every PR. `main` started with one empty commit; everything else came in one PR.
- **Why**: Any agent or person must see how to work, where things are and how to check work from the
  repo alone. Files work for every tool; tool settings do not travel.
- **Rejected**: Tool-specific setup (Devin Knowledge, Claude Code plugins such as Superpowers) as the
  source of the rules; a README instead of AGENTS.md; plans and experiments at the root (kept in `docs/`
  so the map stays short).

## 2026-11-27: verify.sh in bash; dependencies git and jq

- **Decision**: `init.sh`, `verify.sh`, `worktree.sh` are bash. Their only dependencies are git and jq
  (jq validates `feature_list.json`). The devcontainer is the stock
  `mcr.microsoft.com/devcontainers/base:ubuntu-24.04` image (git and jq included); CI uses
  `ubuntu-24.04` with `actions/checkout@v7`.
- **Why**: No stack is chosen; bash, git and jq exist on every dev machine and CI runner. Boring tools.
- **Rejected**: Python or Node scripts (picks a stack early); a JSON-schema library (a dependency for one
  small file); running CI inside the devcontainer (slower; see tech-debt.md).
