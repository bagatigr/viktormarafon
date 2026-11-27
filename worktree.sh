#!/usr/bin/env bash
# ./worktree.sh <task-name>: a separate git worktree and branch for one task, so 2-3 agents
# can work in parallel. Creates .worktrees/<task-name> (git-ignored) under the main checkout,
# on a new branch <task-name> from the current commit.
set -euo pipefail
cd "$(dirname "$0")"

if [ "$#" -ne 1 ]; then
  echo "usage: ./worktree.sh <task-name>   (letters, digits, '.', '_', '-')" >&2
  exit 2
fi
name="$1"
if ! [[ "$name" =~ ^[A-Za-z0-9._-]+$ ]] || ! git check-ref-format --branch "$name" >/dev/null 2>&1; then
  echo "error: '$name' is not a usable task name. Fix: use only letters, digits, '.', '_', '-', not starting with '-' or '.', e.g. add-login." >&2
  exit 2
fi

# The main checkout is the folder that holds the shared .git directory.
root="$(cd "$(git rev-parse --git-common-dir)/.." && pwd)"
path="$root/.worktrees/$name"

if git show-ref --verify --quiet "refs/heads/$name"; then
  echo "error: branch '$name' already exists. Fix: pick another task name, or delete the old branch: git branch -D $name" >&2
  exit 1
fi
if [ -e "$path" ]; then
  echo "error: $path already exists. Fix: pick another task name, or remove it: git worktree remove $path" >&2
  exit 1
fi

git worktree add --quiet -b "$name" "$path"
echo "Worktree ready: $path"
echo "Branch:         $name (from $(git rev-parse --short HEAD))"
echo "Start:          cd $path && ./init.sh"
echo "Remove later:   git -C $root worktree remove $path && git -C $root branch -D $name"
