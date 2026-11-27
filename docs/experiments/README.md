# Experiments

Last reviewed: 2026-11-27

Template for future autonomous loops: an agent changes something, measures, and keeps or
reverts the change, many times without a person. Run a loop only when there is a numeric metric.

One folder per experiment, `docs/experiments/<name>/`, with:
- `program.md`: the instruction to the agent: goal, what it may change, what it must not touch,
  how many iterations, when to stop.
- The metric file (e.g. `metric.sh`): prints one number. Immutable: the agent never edits it;
  a change to it is a new experiment.
- `log.md`: one line per iteration: change, metric before, metric after, kept or reverted.

Keep/revert rule: run the metric before and after each change. Keep the change only if the
metric improves and `./verify.sh` is green; otherwise revert it with git and log why.
