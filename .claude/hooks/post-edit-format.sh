#!/usr/bin/env bash
set -euo pipefail

# Safe starter post-edit hook.
# This intentionally does not run project formatters automatically because formatter
# commands vary by stack. Customize this file for your project after review.

cat >/dev/null || true
exit 0
