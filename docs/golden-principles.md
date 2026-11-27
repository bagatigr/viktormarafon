# Golden principles

Last reviewed: 2026-11-27

Rules of taste. A change that breaks one needs an entry in [decisions.md](decisions.md).

- Boring, proven technology.
- A new dependency only with an entry in [decisions.md](decisions.md).
- Deterministic work is done by code, not by the model: search, build, scheduling, checks.
- For agent work: CLI and scripts. MCP only for external services that have no CLI.
- All logs go to one file, `logs/app.log`, so an agent reads them with one command.
- No secrets and no real personal data in the repository.
- A rule that can be checked by code is checked by code (in `verify.sh`), not by text.
