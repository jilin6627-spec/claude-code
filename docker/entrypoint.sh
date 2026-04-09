#!/usr/bin/env bash
set -euo pipefail

echo "[check] claude:"
claude --version || true

echo "[check] claudish:"
claudish --help >/dev/null 2>&1 || true

exec "$@"
