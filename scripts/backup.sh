#!/bin/bash
# HANS workspace backup — auto-commit and push to GitHub
# Runs nightly at 01:00 Europe/Berlin

WORKSPACE="/Users/hans/.openclaw/workspace"
LOG="$WORKSPACE/logs/backup.log"

mkdir -p "$WORKSPACE/logs"

cd "$WORKSPACE" || exit 1

# Check if there's anything to commit
if git diff --quiet && git diff --cached --quiet; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Nothing to commit, skipping push." >> "$LOG"
  exit 0
fi

git add -A
git commit -m "nightly backup — $(date '+%Y-%m-%d %H:%M')" >> "$LOG" 2>&1
git push origin main >> "$LOG" 2>&1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup complete." >> "$LOG"
