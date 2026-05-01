#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${MYCODEX_REPO_URL:-https://github.com/spw6893-ui/vibecoding_essential.git}"
REPO_REF="${MYCODEX_REF:-main}"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
INSTALL_DIR="${MYCODEX_INSTALL_DIR:-$CODEX_HOME/repos/vibecoding_essential}"
PRUNE=0
WITH_EXTERNAL_REPOS=0

usage() {
  cat >&2 <<'EOF'
用法: one-click-install.sh [--prune] [--with-external-repos]

环境变量:
  CODEX_HOME              Codex 主目录，默认 ~/.codex
  MYCODEX_REPO_URL         仓库地址，默认 https://github.com/spw6893-ui/vibecoding_essential.git
  MYCODEX_REF              分支/标签/commit，默认 main
  MYCODEX_INSTALL_DIR      本地安装仓库目录，默认 ~/.codex/repos/vibecoding_essential

说明:
  - 同步 skills/ 与 references/ 到 CODEX_HOME。
  - 不覆盖 ~/.codex/config.toml 或 ~/.codex/AGENTS.md。
  - --prune 会删除本仓库明确裁掉的旧 skill 残留。
EOF
}

for arg in "$@"; do
  case "$arg" in
    --prune)
      PRUNE=1
      ;;
    --with-external-repos)
      WITH_EXTERNAL_REPOS=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "未知参数: $arg" >&2
      usage
      exit 2
      ;;
  esac
done

command -v git >/dev/null 2>&1 || {
  echo "缺少 git，请先安装 git。" >&2
  exit 1
}

mkdir -p "$(dirname "$INSTALL_DIR")" "$CODEX_HOME"

if [[ -e "$INSTALL_DIR" && ! -d "$INSTALL_DIR/.git" ]]; then
  echo "安装目录已存在但不是 Git 仓库: $INSTALL_DIR" >&2
  exit 1
fi

if [[ ! -d "$INSTALL_DIR/.git" ]]; then
  git clone "$REPO_URL" "$INSTALL_DIR"
else
  git -C "$INSTALL_DIR" remote set-url origin "$REPO_URL"
fi

git -C "$INSTALL_DIR" fetch origin --tags --prune
git -C "$INSTALL_DIR" checkout "$REPO_REF"
git -C "$INSTALL_DIR" pull --ff-only origin "$REPO_REF" || true

install_args=()
if [[ "$PRUNE" -eq 1 ]]; then
  install_args+=(--prune)
fi

bash "$INSTALL_DIR/scripts/linux/install.sh" "${install_args[@]}"

if [[ "$WITH_EXTERNAL_REPOS" -eq 1 ]]; then
  bash "$INSTALL_DIR/scripts/linux/bootstrap-external-repos.sh"
fi

cat <<EOF
安装完成。

仓库目录: $INSTALL_DIR
Codex 目录: $CODEX_HOME

请重开 Codex 会话，让 skill 列表刷新。
EOF
