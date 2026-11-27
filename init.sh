#!/usr/bin/env bash
# ./init.sh: run at the start of every session. Shows where the work stands, then runs ./verify.sh.
cd "$(dirname "$0")" || exit 1

echo "== progress.md: last 3 entries (newest last) =="
if [ -f progress.md ]; then
  start=$(grep -n '^## ' progress.md | tail -n 3 | head -n 1 | cut -d: -f1)
  tail -n +"${start:-1}" progress.md
else
  echo "(no progress.md: create it, see AGENTS.md)"
fi

echo
echo "== git log -20 =="
git --no-pager log -20 --oneline

echo
echo "== active plans (docs/plans/active) =="
ls docs/plans/active/*.md 2>/dev/null || echo "(none)"

echo
echo "== ./verify.sh =="
exec ./verify.sh
