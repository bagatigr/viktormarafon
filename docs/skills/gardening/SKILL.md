---
name: gardening
description: Use once a week, to find stale docs, outdated rules and departures from golden-principles.md, and fix them with small PRs.
---

# Gardening

Last reviewed: 2026-11-27

1. Run `./verify.sh`. Every "last reviewed ... days ago" warning is a file to look at.
2. For each such file, and for `AGENTS.md`: is it still true for the current repo?
   Check paths, commands and rules against the code.
3. Look for departures from `docs/golden-principles.md` in the code and docs
   (new dependencies without a decision, logs outside `logs/app.log`, rules only in text
   that code could check).
4. Check `docs/tech-debt.md` and `docs/wiki/` for paid debt and contradictions.
5. Fix each finding in its own small PR (one topic, one PR).
6. Update `Last reviewed` to today in every file you re-checked, even if nothing changed.
7. Note what was found and fixed in `progress.md`.
