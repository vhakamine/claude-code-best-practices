#!/usr/bin/env bash
set -euo pipefail

payload="$(cat || true)"

dangerous_patterns=(
  "rm -rf /"
  "rm -rf /*"
  "curl "
  "| sh"
  "| bash"
  "wget "
  "mkfs"
  "dd if="
  "dd of=/dev/"
  "chmod 777"
  "sudo "
  "git clean -fdx"
)

for pattern in "${dangerous_patterns[@]}"; do
  if printf '%s' "$payload" | grep -Fq "$pattern"; then
    echo "Blocked Bash command: potentially dangerous pattern detected: $pattern" >&2
    exit 2
  fi
done

exit 0
