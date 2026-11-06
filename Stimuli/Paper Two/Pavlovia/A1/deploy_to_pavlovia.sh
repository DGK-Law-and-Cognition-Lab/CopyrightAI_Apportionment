#!/bin/bash
# Push Paper A Study 1 (A1) to ONE Pavlovia project: copyright-apportionment/study-1.
#
# The project path is read from .pavlovia_project in this folder (preset to
# copyright-apportionment/study-1). The script clones
# https://gitlab.pavlovia.org/<PROJECT>.git, checks the clone points there,
# replaces the page files, shows what changes, and pushes only after you type
# the project's name (the part after the slash, study-1). It never pushes
# config.json (Pavlovia serves its own) and never touches the data/ folder.
#
# Files pushed: index.html config.js engine.js style.css captcha.png
#               open_rows.json stimuli/*.jpg (40 images)
# It stops if engine.js, style.css or captcha.png differ from ../engine
# (run ../tools/sync_engine.sh A1), or if any image in stimuli/ is missing or
# differs from Stimuli/Paper Two/setA/web/ (run ../tools/install_images.sh A1).
# Git asks for your Pavlovia GitLab username and password or token.

set -euo pipefail

PROJECT=""

SRC="$(cd "$(dirname "$0")" && pwd)"
ENGINE="$SRC/../engine"
SETA="$SRC/../../setA/web"
FILES=(index.html config.js engine.js style.css captcha.png open_rows.json)
SCENES="SA01 SA06 SA02 SA07 SA03 SA-R2 SA04 SA09 SA-R1 SA10"
KINDS="source small medium large"

if [ -z "$PROJECT" ] && [ -f "$SRC/.pavlovia_project" ]; then PROJECT="$(tr -d '[:space:]' < "$SRC/.pavlovia_project")"; fi
if [ -z "$PROJECT" ]; then
  read -r -p "Pavlovia project path for A1 (owner/name, as in gitlab.pavlovia.org/owner/name): " PROJECT
fi
[[ "$PROJECT" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || { echo "STOP: '$PROJECT' is not owner/name."; exit 1; }
NAME="${PROJECT#*/}"
TARGET="https://gitlab.pavlovia.org/$PROJECT.git"

echo "============================================================"
echo " A1 will be pushed to: https://gitlab.pavlovia.org/$PROJECT"
echo " Run link:             https://run.pavlovia.org/$PROJECT"
echo "============================================================"

for f in "${FILES[@]}"; do [ -f "$SRC/$f" ] || { echo "Missing $SRC/$f"; exit 1; }; done
for f in engine.js style.css captcha.png; do
  cmp -s "$SRC/$f" "$ENGINE/$f" || { echo "STOP: $f differs from ../engine/$f. Run ../tools/sync_engine.sh A1 first."; exit 1; }
done
n=0
for s in $SCENES; do for c in $KINDS; do
  f="${s}_${c}.jpg"
  [ -f "$SRC/stimuli/$f" ] || { echo "STOP: stimuli/$f is missing. Run ../tools/install_images.sh A1 first."; exit 1; }
  if [ -d "$SETA" ]; then
    cmp -s "$SRC/stimuli/$f" "$SETA/$f" || { echo "STOP: stimuli/$f differs from setA/web/$f. Run ../tools/install_images.sh A1 first."; exit 1; }
  fi
  n=$((n + 1))
done; done
[ "$n" = "40" ] || { echo "STOP: expected 40 images, found $n."; exit 1; }
if grep -q "var SONA_CREDIT_URL_BASE = '';" "$SRC/config.js"; then
  echo "WARNING: SONA_CREDIT_URL_BASE in config.js is empty, so SONA participants will not be"
  echo "         credited automatically. Set it before the SONA listing opens."
fi

WORK="$(mktemp -d)"
echo "Cloning into $WORK ..."
git clone --quiet "$TARGET" "$WORK/repo"
cd "$WORK/repo"
ORIGIN="$(git remote get-url origin)"
[ "$ORIGIN" = "$TARGET" ] || { echo "STOP: the clone points to $ORIGIN, not $TARGET. Nothing was pushed."; exit 1; }
if git rev-parse --verify --quiet HEAD > /dev/null; then
  BRANCH="$(git rev-parse --abbrev-ref HEAD)"
else
  echo "Note: the repository is empty (a new project). The first push creates branch master."
  BRANCH="master"
  git checkout --quiet -b master
fi
if [ -d data ] && [ -n "$(ls -A data 2>/dev/null)" ]; then
  echo "Note: data/ already holds $(ls data | wc -l | tr -d ' ') files; they are left untouched."
fi

mkdir -p stimuli
for f in "${FILES[@]}"; do cp "$SRC/$f" "./$f"; done
for s in $SCENES; do for c in $KINDS; do cp "$SRC/stimuli/${s}_${c}.jpg" stimuli/; done; done
git add "${FILES[@]}" stimuli
if git diff --cached --quiet; then echo "Nothing changed; nothing to push."; exit 0; fi
echo
echo "Files that will be added or changed in $PROJECT:"
git diff --cached --stat
echo
read -r -p "Type $NAME to push, or anything else to stop: " ok
[ "$ok" = "$NAME" ] || { echo "Not pushed. Clone left at $WORK"; exit 0; }
git commit --quiet -m "A1: page files and stimuli"
git push --quiet origin "HEAD:refs/heads/$BRANCH"
echo "$PROJECT" > "$SRC/.pavlovia_project"
echo
echo "Pushed to $PROJECT (branch $BRANCH)."
echo "Your own test run (no SONA, no credit):"
echo "  https://run.pavlovia.org/$PROJECT/index.html?participant=PILOT_DK1"
echo "Automatic test run (fills every answer):"
echo "  https://run.pavlovia.org/$PROJECT/index.html?test=1&code=12345"
