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
    -h|--help)
      echo "用法: $0 [--prune]" >&2
      echo "说明: 本脚本只同步 skills/ 与 references/，不会覆盖 ~/.codex/config.toml 或 ~/.codex/AGENTS.md" >&2
      exit 0
      ;;
    *)
      echo "未知参数: $arg" >&2
      echo "用法: $0 [--prune]" >&2
      echo "说明: 本脚本只同步 skills/ 与 references/，不会覆盖 ~/.codex/config.toml 或 ~/.codex/AGENTS.md" >&2
      exit 2
      ;;
  esac
done

mkdir -p "$CODEX_HOME/skills" "$CODEX_HOME/references"

sync_dir_contents() {
  local src="$1"
  local dest="$2"

  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$src/" "$dest/"
  else
    mkdir -p "$dest"
    cp -a "$src/." "$dest/"
  fi
}

if [[ "$PRUNE" -eq 1 ]]; then
  for name in algorithmic-art auto-skill brand-guidelines browser canvas-design ccxt claude-code-guide claude-cookbooks code-guardrails codeagent coingecko cryptofeed dev do doc-coauthoring docx frontend-design gh-issue-implement gh-pr-review headless-cli hummingbot internal-comms markdown-to-epub mcp-builder myclaude-product-workflow omo pdf polymarket pptx product-requirements prototype-prompt-generator proxychains skill-install slack-gif-creator snapdom sparv test-cases theme-factory web-artifacts-builder webapp-testing xlsx; do
    rm -rf "$CODEX_HOME/skills/$name"
  done
fi

# 清理本仓库历史命名，避免重命名后本机同时出现新旧两个 skill。
rm -rf "$CODEX_HOME/skills/myclaude-product-workflow"
sync_dir_contents "$ROOT_DIR/skills" "$CODEX_HOME/skills"

# 仅清理本仓库管理的参考目录，避免删除用户自己的 references。
rm -rf "$CODEX_HOME/references/gh-flow" "$CODEX_HOME/references/vibe-coding-cn" "$CODEX_HOME/references/engineering-templates" "$CODEX_HOME/references/myclaude-skills"
sync_dir_contents "$ROOT_DIR/references" "$CODEX_HOME/references"

echo "mycodex 已安装到: $CODEX_HOME"
