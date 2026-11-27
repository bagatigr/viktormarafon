---
name: tdd
description: Use when writing or changing code behaviour, to work red, green, refactor with a failing test before the code.
---

# TDD

Last reviewed: 2026-11-27

1. **Red**: write one test for the next small piece of behaviour from the contract.
   Run it and watch it fail for the expected reason. A test that passes at once tests nothing new.
2. **Green**: write the least code that makes it pass. Run the test, then `./verify.sh`.
3. **Refactor**: clean up names and duplication with all tests green. No new behaviour here.
4. Commit. Repeat from step 1 for the next piece.
5. Code written before its test: delete it and start again from red.
6. Never weaken, skip or delete an existing test to get green. If a test is wrong, say so
   and treat it as a decision (`docs/decisions.md`).
7. Until a stack is chosen there is no test runner; the checks in `./verify.sh` play that role.
