#!/usr/bin/env bash
set -euo pipefail

# Claude Code passes hook event JSON on stdin.
# This hook blocks obvious writes to local secrets, private key material,
# and local-only Claude/MCP configuration.

payload="$(cat || true)"

blocked_patterns=(
  ".env"
  ".env."
  ".mcp.json"
  "CLAUDE.local.md"
  ".claude/settings.local.json"
  "id_rsa"
  "id_ed25519"
  ".pem"
  ".p12"
  ".pfx"
  "secrets/"
  "credentials/"
)

for pattern in "${blocked_patterns[@]}"; do
  if printf '%s' "$payload" | grep -Fq "$pattern"; then
    echo "Blocked write: path appears to target a local-only or sensitive file: $pattern" >&2
    exit 2
  fi
done

exit 0
