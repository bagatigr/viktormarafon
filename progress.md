# Progress

Session log, newest entry last. `./init.sh` shows the last three entries.
At the end of each session append one entry: a `## YYYY-MM-DD: <task>` heading, then
**Done**, **State**, **Next step**, **Open questions** (see docs/skills/handoff/SKILL.md).
A small fix without a plan file also keeps its contract ("Done when") in its entry.

## 2026-11-27: agent workspace

- **Done**: built the agent workspace on branch `feat/agent-workspace`: AGENTS.md, CLAUDE.md,
  docs/ (glossary, decisions, golden principles, tech debt, harness, wiki, plans, experiments),
  11 procedures in docs/skills/, progress.md, feature_list.json, init.sh, verify.sh, worktree.sh,
  devcontainer, CI, PR template. No product code, no stack.
- **Contract** (the owner's "Done when", in English):
  - [ ] `./verify.sh` is green locally and in CI.
  - [ ] AGENTS.md is at most 100 lines and all its links work.
  - [ ] All files and all 11 procedures exist and pass the verify checks.
  - [ ] docs/decisions.md has its first entry; docs/harness.md has a row for every verify.sh check.
  - [ ] `./worktree.sh test-task` creates a worktree, verify passes inside it, and the worktree is removed afterwards.
  - [ ] The repository has no product code and no chosen stack.
- **State**: pushed for review; CI and the independent review run on the pull request.
- **Next step**: merge; then add the Devin Knowledge entry "Before any task, read AGENTS.md and
  follow the procedures in docs/skills/".
- **Open questions**: product and stack are not chosen yet.
