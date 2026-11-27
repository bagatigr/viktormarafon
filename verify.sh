#!/usr/bin/env bash
# ./verify.sh: the one check for this repository. Exit 0 means green.
# Each check is one function, listed in CHECKS. Errors fail the run, warnings never do.
# Every error names the file, what is wrong and how to fix it.
# Needs: bash, git, jq (see docs/decisions.md).
set -o pipefail
cd "$(dirname "$0")" || exit 1

ERRORS=0
WARNINGS=0
err()  { echo "  error: $*"; ERRORS=$((ERRORS + 1)); }
warn() { echo "  warning: $*"; WARNINGS=$((WARNINGS + 1)); }

# Files as git sees them: tracked plus untracked, minus ignored (.worktrees/, logs/, .env).
FILES=()
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "error: $(pwd) is not a git checkout. Fix: run ./verify.sh inside a clone of the repository."
  exit 1
fi
while IFS= read -r -d '' f; do
  [ -f "$f" ] && FILES+=("$f")
done < <(git ls-files -z --cached --others --exclude-standard | sort -zu)

# Markdown files the doc checks cover: AGENTS.md and everything under docs/.
doc_files() {
  local f
  for f in "${FILES[@]}"; do
    case "$f" in AGENTS.md | docs/*.md) echo "$f" ;; esac
  done
}

# --- AGENTS.md is at most 100 lines -------------------------------------------
check_agents_md() {
  if [ ! -f AGENTS.md ]; then
    err "AGENTS.md is missing. Fix: restore it (git checkout -- AGENTS.md); it is the entry point for every agent."
    return
  fi
  local n
  n=$(wc -l < AGENTS.md | tr -d ' ')
  if [ "$n" -gt 100 ]; then
    err "AGENTS.md has $n lines, the limit is 100. Fix: move detail into docs/ and leave a one-line link in AGENTS.md."
  fi
}

# --- Relative links in AGENTS.md and docs/ point to existing files --------------
# Inline links, images and reference definitions; skips URLs with a scheme,
# pure #anchors and fenced code blocks.
check_links() {
  local file line target path
  # shellcheck disable=SC2016  # the awk program is meant to be single-quoted
  while IFS=$'\t' read -r file line target; do
    target="${target#<}"; target="${target%%>*}"; target="${target%% *}"
    case "$target" in '' | '#'*) continue ;; esac
    if [[ "$target" =~ ^[A-Za-z][A-Za-z0-9+.-]*: ]]; then continue; fi
    path="${target%%#*}"; path="${path%%\?*}"
    if [ "${path:0:1}" = "/" ]; then path=".${path}"; else path="$(dirname "$file")/$path"; fi
    if [ ! -e "$path" ]; then
      err "$file:$line: link '$target' points to a missing file. Fix: correct the path (it is relative to the folder of $file; a leading / means the repo root) or create the file."
    fi
  done < <(doc_files | tr '\n' '\0' | xargs -0 awk '
    FNR == 1 { fence = 0 }
    /^[ \t]*(```|~~~)/ { fence = !fence; next }
    fence { next }
    {
      s = $0
      gsub(/`[^`]*`/, "", s)
      if (match(s, /^[ \t]*\[[^]]+\]:[ \t]*[^ \t]+/)) {
        t = s; sub(/^[ \t]*\[[^]]+\]:[ \t]*/, "", t); sub(/[ \t].*$/, "", t)
        print FILENAME "\t" FNR "\t" t
        next
      }
      while (match(s, /\]\([^)]*\)/)) {
        print FILENAME "\t" FNR "\t" substr(s, RSTART + 2, RLENGTH - 3)
        s = substr(s, RSTART + RLENGTH)
      }
    }')
}

# --- Procedures: docs/skills/<name>/SKILL.md with name and description, <= 60 lines --
check_skills() {
  local f dir name skill n fm_end key val
  local -a dirs=()
  for f in "${FILES[@]}"; do
    case "$f" in docs/skills/*/*) dir="${f#docs/skills/}"; dirs+=("${dir%%/*}") ;; esac
  done
  if [ "${#dirs[@]}" -eq 0 ]; then
    err "docs/skills/ has no procedures. Fix: restore docs/skills/<name>/SKILL.md (git checkout -- docs/skills)."
    return
  fi
  for name in $(printf '%s\n' "${dirs[@]}" | sort -u); do
    skill="docs/skills/$name/SKILL.md"
    if [ ! -f "$skill" ]; then
      err "docs/skills/$name/ has no SKILL.md. Fix: add $skill (frontmatter with name and description) or delete the folder."
      continue
    fi
    n=$(wc -l < "$skill" | tr -d ' ')
    if [ "$n" -gt 60 ]; then
      err "$skill has $n lines, the limit is 60. Fix: cut it to the steps; move background to docs/wiki/ and link it."
    fi
    if [ "$(head -n 1 "$skill")" != "---" ]; then
      err "$skill does not start with frontmatter. Fix: make line 1 '---', then 'name: $name', 'description: <when to use it>', then '---'."
      continue
    fi
    fm_end=$(awk 'NR > 1 && /^---[ \t]*$/ { print NR; exit }' "$skill")
    if [ -z "$fm_end" ]; then
      err "$skill: frontmatter is not closed. Fix: add a line '---' after the description."
      continue
    fi
    for key in name description; do
      val=$(sed -n "2,$((fm_end - 1))p" "$skill" | sed -n "s/^$key:[ \t]*//p" | head -n 1)
      val="${val%\"}"; val="${val#\"}"; val="${val%\'}"; val="${val#\'}"
      if [ -z "${val// /}" ]; then
        err "$skill: frontmatter has no non-empty '$key:'. Fix: add '$key: ...' on one line between the two '---' lines."
      elif [ "$key" = name ] && [ "$val" != "$name" ]; then
        err "$skill: name is '$val' but the folder is '$name'. Fix: make them equal (rename the folder or the name)."
      fi
    done
  done
}

# --- feature_list.json matches its schema ---------------------------------------
check_feature_list() {
  local schema='[{"id": "<unique non-empty string>", "description": "<non-empty string>", "steps": ["<non-empty string>", ...], "passes": false}]'
  if [ ! -f feature_list.json ]; then
    err "feature_list.json is missing. Fix: restore it (git checkout -- feature_list.json) or create it with [] . Schema: $schema"
    return
  fi
  if ! command -v jq >/dev/null 2>&1; then
    err "jq is not installed, so feature_list.json cannot be checked. Fix: install jq (apt-get install jq / brew install jq) or open the devcontainer."
    return
  fi
  local out
  if ! out=$(jq -r '
    def bad($i; $m): "item \($i): \($m)";
    if type != "array" then "the top level must be an array"
    else
      (to_entries[] | .key as $i | .value |
        if type != "object" then bad($i; "must be an object")
        else
          ((keys - ["description", "id", "passes", "steps"])[] | bad($i; "unknown key \"\(.)\""))
          , ((["id", "description", "steps", "passes"] - keys)[] | bad($i; "missing key \"\(.)\""))
          , (if has("id") and ((.id | type) != "string" or .id == "") then bad($i; "id must be a non-empty string") else empty end)
          , (if has("description") and ((.description | type) != "string" or .description == "") then bad($i; "description must be a non-empty string") else empty end)
          , (if has("steps") and ((.steps | type) != "array" or (.steps | length) == 0 or (.steps | all(.[]; type == "string" and length > 0) | not)) then bad($i; "steps must be a non-empty array of non-empty strings") else empty end)
          , (if has("passes") and (.passes | type) != "boolean" then bad($i; "passes must be true or false") else empty end)
        end)
      , ([.[] | objects | .id | strings] | group_by(.) | map(select(length > 1))[] | "id \"\(.[0])\" is used \(length) times")
    end' feature_list.json 2>&1); then
    err "feature_list.json is not valid JSON ($(echo "$out" | head -n 1)). Fix: repair the syntax. Schema: $schema"
    return
  fi
  local msg
  while IFS= read -r msg; do
    [ -n "$msg" ] && err "feature_list.json: $msg. Fix: match the schema $schema (change only 'passes' of existing items)."
  done <<< "$out"
}

# --- Every docs/ file has 'Last reviewed: YYYY-MM-DD'; older than 30 days warns --
to_epoch() { date -u -d "$1" +%s 2>/dev/null || date -u -j -f %Y-%m-%d "$1" +%s 2>/dev/null; }
check_last_reviewed() {
  local f d ts now days
  now=$(date -u +%s)
  while IFS= read -r f; do
    case "$f" in docs/*) ;; *) continue ;; esac
    d=$(sed -n 's/^Last reviewed: \([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)[ \t]*$/\1/p' "$f" | head -n 1)
    if [ -z "$d" ]; then
      err "$f has no 'Last reviewed: YYYY-MM-DD' line. Fix: add a line 'Last reviewed: $(date -u +%F)' after you have checked the file is still true."
      continue
    fi
    if ! ts=$(to_epoch "$d") || [ -z "$ts" ]; then
      err "$f: 'Last reviewed: $d' is not a real date. Fix: use YYYY-MM-DD, e.g. $(date -u +%F)."
      continue
    fi
    days=$(( (now - ts) / 86400 ))
    if [ "$days" -gt 30 ]; then
      warn "$f was last reviewed $days days ago ($d). Fix: re-read it, correct what is stale and update the date (procedure: docs/skills/gardening)."
    fi
  done < <(doc_files)
}

# --- No secrets in the repository; .env.example exists ---------------------------
# Only well-known key formats. A finding prints file, line and pattern name, never
# the matched text (the repository and its CI logs are public).
SECRET_PATTERNS=(
  "AWS access key|(AKIA|ASIA)[0-9A-Z]{16}"
  "GitHub token|(gh[pousr]_[A-Za-z0-9]{36,}|github_pat_[A-Za-z0-9_]{22,})"
  "Slack token|xox[abposr]-[A-Za-z0-9-]{10,}"
  "private key block|-----BEGIN ([A-Z]+ )*PRIVATE KEY( BLOCK)?-----"
  "sk- style API key|(^|[^A-Za-z0-9_-])sk-[A-Za-z0-9_-]{20,}"
  "Google API key|AIza[0-9A-Za-z_-]{35}"
  "Stripe live key|[rs]k_live_[0-9A-Za-z]{24,}"
)
check_secrets() {
  local f entry label re hit base
  if [ ! -f .env.example ]; then
    err ".env.example is missing. Fix: create it listing the names of the environment variables the project needs (names only, no values)."
  fi
  for f in "${FILES[@]}"; do
    base="${f##*/}"
    case "$base" in
      .env.example) ;;
      .env | .env.*) err "$f is in git. Fix: git rm --cached '$f', keep real values outside the repo and list only names in .env.example." ;;
    esac
  done
  [ "${#FILES[@]}" -eq 0 ] && return
  for entry in "${SECRET_PATTERNS[@]}"; do
    label="${entry%%|*}"; re="${entry#*|}"
    while IFS= read -r hit; do
      [ -n "$hit" ] && err "${hit%:}: matches the pattern '$label'. Fix: delete it from the file (and from git history if committed), rotate the key, and read it from an environment variable named in .env.example."
    done < <(printf '%s\0' "${FILES[@]}" | xargs -0 grep -HnIoE -- "$re" 2>/dev/null | cut -d: -f1,2 | sort -u)
  done
}

# --- Checks to run, in order ------------------------------------------------------
# To add lint, types or tests when the stack is chosen: write a check_<name> function
# above and add its name here. The command stays ./verify.sh.
CHECKS=(
  check_agents_md
  check_links
  check_skills
  check_feature_list
  check_last_reviewed
  check_secrets
  # stack checks go here: check_lint check_types check_tests
)

for check in "${CHECKS[@]}"; do
  before=$ERRORS
  output=$("$check"; echo "__counts $ERRORS $WARNINGS")
  counts=$(echo "$output" | tail -n 1)
  ERRORS=$(echo "$counts" | cut -d' ' -f2); WARNINGS=$(echo "$counts" | cut -d' ' -f3)
  if [ "$ERRORS" -gt "$before" ]; then echo "FAIL $check"; else echo "ok   $check"; fi
  echo "$output" | sed '$d'
done

if [ "$ERRORS" -gt 0 ]; then
  echo "verify: FAILED with $ERRORS error(s), $WARNINGS warning(s). Fix the errors above and run ./verify.sh again."
  exit 1
fi
echo "verify: green ($WARNINGS warning(s))."
