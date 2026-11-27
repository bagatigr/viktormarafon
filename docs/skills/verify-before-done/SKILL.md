---
name: verify-before-done
description: Use before saying a task is done, to prove it with a green ./verify.sh, every contract criterion checked as a person would use it, and evidence in the PR.
---

# Verify before done

Last reviewed: 2026-11-27

1. Run `./verify.sh`. It must end with `verify: green`. Fix every error; read the warnings.
2. Take the contract ("Done when"). Check each criterion the way a person will use it:
   run the command, open the page, click through. Not only unit tests, not "should work".
3. Keep the evidence: command output, screenshots, logs. Put it in the PR under
   "How it was checked".
4. A criterion you could not check: say so in the PR with the reason. Never call it done.
5. Only now: set `passes: true` for the matching item in `feature_list.json` (change nothing else).
6. Commit, push, write the `progress.md` entry.
7. Your "done" is not final: hand over to [review](../review/SKILL.md).
