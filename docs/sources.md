# 来源

## vibe-coding-cn

- Source: `https://github.com/tukuaiai/vibe-coding-cn`
- Imported commit: `55d6d0a`
- 用途：中文 Vibe Coding 方法论、部分工程/文档/自动化 skills。
- 当前保留：`auto-skill`、`ddd-doc-steward`、`headless-cli`、`postgresql`、`sop-generator`、`telegram-dev`、`timescaledb`、`tmux-autopilot`、`twscrape`。

## myclaude

- Source: `https://github.com/stellarlinkco/myclaude`
- Imported commit: `c4a1567`
- License: AGPL-3.0
- 用途：PRD、需求确认、测试用例、UI/UX 原型提示词、BMAD/requirements 方法论。
- 当前活跃保留：`harness`、`myclaude-product-workflow`。
- 参考资料保留：`browser`、`codeagent`、`dev`、`do`、`omo`、`product-requirements`、`prototype-prompt-generator`、`skill-install`、`sparv`、`test-cases` 位于 `refs/myclaude-skills/`，不作为活跃 skill 暴露。
- 兼容处理：上游 skill 中 `~/.claude/skills` 与 `.claude/...` 路径已改为 `~/.codex/skills` 与 `.codex/...`。

## local

- `ppw-codex-engineer`：本地个人工作流聚合 skill。

## productivity local archives

- Source: `/home/ppw/productivity/gh-flow-skill.zip`
- 当前活跃保留：`gh-create-issue`。
- 参考资料保留：`gh-issue-implement`、`gh-pr-review` 位于 `refs/gh-flow/`，不作为活跃 skill 暴露。
- 裁剪理由：后两者依赖上游 `dev` / `codeagent` 工作流，当前个人 Codex 仓库已裁剪这些 Claude 专用或重运行时依赖，直接激活会制造不稳定触发。

- Source: `/home/ppw/productivity/heroui-pro.zip`
- 当前活跃保留：`heroui-pro`。
- 兼容处理：删除 macOS 垃圾文件、`CLAUDE.md`、`.claude/settings.local.json`，并将 `~/.claude/skills` 路径改为 `~/.codex/skills`。

- Source: `/home/ppw/productivity/.codex/skills/ui-ux-pro-max`
- 当前活跃保留：`ui-ux-pro-max`。
- 兼容处理：删除 `scripts/__pycache__/`，保留 CSV 数据库和 Python 检索脚本。
