# Tech debt

Last reviewed: 2026-11-27

Known shortcuts and gaps. Add a row when you take one; delete the row when it is paid.

| Item | Why it matters | Added | Next step |
| --- | --- | --- | --- |
| Secrets check knows only fixed key formats; a plain password literal passes. | A hard-coded password would reach git. | 2026-11-27 | Add a scanner (e.g. gitleaks) once a stack exists, with a decisions.md entry. |
| CI runs `./verify.sh` on the runner, not inside the devcontainer. | Runner and devcontainer can drift apart. | 2026-11-27 | Run CI in the devcontainer when stack tools are added to it. |
| `verify.sh` has no automated self-test; its checks were tested by hand on mutated copies (PR 1). | A broken check could pass silently. | 2026-11-27 | Add a self-test when a check is changed or breaks. |
| The rule "only `passes` changes in feature_list.json" is text, not a check. | An agent could rewrite or delete items. | 2026-11-27 | Ratchet: turn into a check once it is broken twice. |
