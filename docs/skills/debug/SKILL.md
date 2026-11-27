---
name: debug
description: Use when something is broken or behaves unexpectedly, to find the cause systematically instead of guessing fixes.
---

# Debug

Last reviewed: 2026-11-27

1. **Reproduce**: get the failure on demand. Write down the exact command, input and output.
   Read `logs/app.log` (all logs go there). Cannot reproduce: collect more data, do not guess.
2. **Hypothesis**: one concrete cause that explains all of the evidence. Write it down.
3. **Minimal failing test**: the smallest test that fails because of the bug. It must fail now.
4. **Fix**: the smallest change that makes that test pass. Wrong hypothesis: back to step 2,
   and revert the attempt.
5. **Regression test**: keep the test from step 3 in the suite, so the bug cannot return.
6. Search for the same pattern elsewhere (`git grep`) and fix or list every other site.
7. Run `./verify.sh`. Record the cause and fix in `progress.md`; if an agent caused it,
   run [ratchet](../ratchet/SKILL.md).
