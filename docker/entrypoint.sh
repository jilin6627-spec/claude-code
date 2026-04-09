#!/usr/bin/env bash
set -euo pipefail

# 转发环境变量
if [ -n "$CLAUDISH_VLLM_BASE_URL" ]; then
  export VLLM_BASE_URL="$CLAUDISH_VLLM_BASE_URL"
fi
if [ -n "$CLAUDISH_MODEL" ]; then
  export CLAUDISH_MODEL="$CLAUDISH_MODEL"
fi
if [ -n "$CLAUDISH_PORT" ]; then
  export CLAUDISH_PORT="$CLAUDISH_PORT"
fi
if [ -n "$CLAUDISH_SUMMARIZE_TOOLS" ]; then
  export CLAUDISH_SUMMARIZE_TOOLS="$CLAUDISH_SUMMARIZE_TOOLS"
fi

echo "[check] claude:"
claude --version || true

echo "[check] claudish:"
claudish --help >/dev/null 2>&1 || true

exec "$@"
