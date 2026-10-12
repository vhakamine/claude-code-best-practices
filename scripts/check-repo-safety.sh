#!/usr/bin/env bash
set -euo pipefail

FAILED=0

SECRET_FINDINGS="/tmp/repo-safety-secret-findings.txt"
RISKY_FINDINGS="/tmp/repo-safety-risky-shell-findings.txt"

rm -f "$SECRET_FINDINGS" "$RISKY_FINDINGS"

echo "Running repository safety checks..."

# Files that intentionally contain security patterns or dangerous-looking strings.
# These are control files, not findings.
EXCLUDES=(
  ':!.git'
  ':!check-repo-safety.sh'
  ':!.github/workflows/repository-safety.yml'
  ':!.claude/hooks/block-dangerous-bash.sh'
  ':!.claude/settings.json'
)

echo "Checking for secret-like content..."

SECRET_PATTERN='AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH|EC|DSA)? ?PRIVATE KEY|ghp_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]{20,}|GITHUB_TOKEN=|AWS_SECRET_ACCESS_KEY=|AWS_ACCESS_KEY_ID=|SLACK_BOT_TOKEN=|xox[baprs]-[A-Za-z0-9-]+'

if git grep -nE "$SECRET_PATTERN" -- . "${EXCLUDES[@]}" > "$SECRET_FINDINGS" 2>/dev/null; then
  echo "ERROR: Potential secret-like content found."
  cat "$SECRET_FINDINGS"
  FAILED=1
else
  echo "OK: No secret-like content found."
fi

echo "Checking for risky shell patterns..."

RISKY_PATTERN='rm -rf /|rm -rf /\*|chmod 777|curl .*\| *sh|curl .*\| *bash|wget .*\| *sh|wget .*\| *bash|sudo '

if git grep -nE "$RISKY_PATTERN" -- . "${EXCLUDES[@]}" > "$RISKY_FINDINGS" 2>/dev/null; then
  echo "ERROR: Risky shell pattern found outside approved safety-control files."
  cat "$RISKY_FINDINGS"
  FAILED=1
else
  echo "OK: No risky shell patterns found outside approved safety-control files."
fi

if [[ "$FAILED" -ne 0 ]]; then
  echo "Repository safety check failed."
  exit 1
fi

echo "Repository safety check passed."
exit 0
