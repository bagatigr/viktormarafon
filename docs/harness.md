# Harness registry

Last reviewed: 2026-11-27

Every rule and check of this workspace and the model weakness it covers. Add a row with each
new rule ([ratchet](skills/ratchet/SKILL.md)); [prune-harness](skills/prune-harness/SKILL.md)
removes rows that are no longer needed and updates "Last checked needed".

| Rule | Weakness it covers | Added | Last checked needed |
| --- | --- | --- | --- |
| `verify.sh` `check_agents_md`: AGENTS.md at most 100 lines | Long entry files get skimmed; rules are lost in long context. | 2026-11-27 | 2026-11-27 |
| `verify.sh` `check_links`: relative links in AGENTS.md and docs/ resolve | The model invents paths and leaves stale links after moves. | 2026-11-27 | 2026-11-27 |
| `verify.sh` `check_skills`: each SKILL.md has name and description, name = folder, at most 60 lines | Procedures without a clear "when" are not used; long ones are not followed. | 2026-11-27 | 2026-11-27 |
| `verify.sh` `check_feature_list`: feature_list.json matches its schema | The model edits JSON loosely and breaks or reshapes the backlog. | 2026-11-27 | 2026-11-27 |
| `verify.sh` `check_last_reviewed`: every docs/ file has `Last reviewed`; over 30 days warns | The model trusts stale docs as current. | 2026-11-27 | 2026-11-27 |
| `verify.sh` `check_secrets`: no known key formats, no tracked `.env`, `.env.example` exists | The model pastes keys into code, config and logs. | 2026-11-27 | 2026-11-27 |
| Say assumptions first; options when ambiguous | The model silently picks one reading. | 2026-11-27 | 2026-11-27 |
| Simplest solution, nothing for later | The model over-builds and adds speculative features. | 2026-11-27 | 2026-11-27 |
| Change only what was asked | The model "improves" neighbouring code and formatting. | 2026-11-27 | 2026-11-27 |
| Every task has a checkable "done when" | The model declares done without a test of done. | 2026-11-27 | 2026-11-27 |
| One task, one session, one PR (about an hour) | Quality drops on long tasks and long contexts. | 2026-11-27 | 2026-11-27 |
| `./init.sh` at start; commit and progress.md entry at end | The model starts without state and forgets to leave it. | 2026-11-27 | 2026-11-27 |
| Order grill → plan → contract → tdd → verify-before-done → review | The model jumps to code. | 2026-11-27 | 2026-11-27 |
| Do not ask "what next"; stop only before hard-to-undo decisions | The model stalls, or acts on irreversible steps unasked. | 2026-11-27 | 2026-11-27 |
| Decisions to decisions.md, terms to CONTEXT.md | Knowledge stays in chats the next agent cannot see. | 2026-11-27 | 2026-11-27 |
| Independent review; own "done" is not final | The model grades its own work too kindly. | 2026-11-27 | 2026-11-27 |
| Handoff when context is over half full | Quality drops as the context fills. | 2026-11-27 | 2026-11-27 |
| Any mistake runs ratchet | The same mistake repeats across sessions. | 2026-11-27 | 2026-11-27 |
| feature_list.json: change only `passes`, after verify-before-done | The model deletes or rewrites tests to make them pass. | 2026-11-27 | 2026-11-27 |
