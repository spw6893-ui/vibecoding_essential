#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
PRUNE=0

for arg in "$@"; do
  case "$arg" in
    --prune)
      PRUNE=1
      ;;
    *)
      echo "未知参数: $arg" >&2
      echo "用法: $0 [--prune]" >&2
      exit 2
      ;;
  esac
done

mkdir -p "$CODEX_HOME/skills" "$CODEX_HOME/references"

if [[ "$PRUNE" -eq 1 ]]; then
  for name in algorithmic-art brand-guidelines canvas-design ccxt claude-code-guide claude-cookbooks coingecko cryptofeed doc-coauthoring docx frontend-design hummingbot internal-comms markdown-to-epub mcp-builder pdf polymarket pptx proxychains slack-gif-creator snapdom theme-factory web-artifacts-builder webapp-testing xlsx; do
    rm -rf "$CODEX_HOME/skills/$name"
  done
fi

rsync -a "$ROOT_DIR/skills/" "$CODEX_HOME/skills/"
rsync -a "$ROOT_DIR/refs/" "$CODEX_HOME/references/"

echo "mycodex 已安装到: $CODEX_HOME"
