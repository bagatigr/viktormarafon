## What and why

<!-- What this PR changes and why, in 2-3 lines. -->

## Contract

<!-- Link to the task's "Done when" list: docs/plans/active/<task>.md, or the progress.md entry for a small fix. -->

## How it was checked

<!-- Per criterion: how you checked it, as a person would use it, and the evidence (./verify.sh output, screenshots, logs). -->

## Independent review

<!-- Result from a session or subagent that did not write the code: verdict and per-criterion findings. -->

## What did not work

<!-- What is not done or could not be checked, and why. "Nothing" if so. -->

## New harness rules

<!-- New rows in docs/harness.md (from ratchet), or "None". -->

## Checklist (AGENTS.md)

- [ ] Assumptions stated before starting; options given where it was ambiguous.
- [ ] Simplest solution that solves the task; nothing "for later".
- [ ] Only what was asked changed; no neighbouring code or formatting touched.
- [ ] The task has a checkable "done when", linked above.
- [ ] One task, one session, one PR (about an hour of work).
- [ ] Session started with `./init.sh`; ended with a commit and a `progress.md` entry.
- [ ] Order followed: grill → plan → contract → tdd → verify-before-done → review (or contract → verify-before-done for a small fix).
- [ ] Significant decisions in `docs/decisions.md`; new terms in `docs/CONTEXT.md`.
- [ ] `./verify.sh` is green.
- [ ] Reviewed independently (section above).
- [ ] Agent mistakes went through ratchet.
