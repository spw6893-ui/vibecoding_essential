# 来源

## vibe-coding-cn

- Source: `https://github.com/tukuaiai/vibe-coding-cn`
- Imported commit: `55d6d0a`
- Local repo: `repos/vibe-coding-cn` at `ee22d79`
- 用途：中文 Vibe Coding 方法论、部分工程/文档/自动化 skills。
- 当前保留：`auto-skill`、`ddd-doc-steward`、`headless-cli`、`postgresql`、`sop-generator`、`telegram-dev`、`timescaledb`、`tmux-autopilot`、`twscrape`。
- 项目模板摘录：`refs/vibe-coding-cn/project-templates.md`。

## myclaude

- Source: `https://github.com/stellarlinkco/myclaude`
- Imported commit: `c4a1567`
- License: AGPL-3.0
- 用途：PRD、需求确认、测试用例、UI/UX 原型提示词、BMAD/requirements 方法论。
- 当前活跃保留：`harness`、`product-spec-workflow`。
- 参考资料处理：不再保留上游原始 skill 副本；PRD、测试、BMAD/requirements、原型提示词等关键内容已收敛进 `skills/product-spec-workflow/references/`。
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

## candidate repos

- Source: `https://github.com/obra/superpowers.git`
- Local repo: `repos/superpowers` at `6efe32c`
- 用途：完整软件开发方法论 skills 候选，包括 brainstorm/spec、plans、TDD、systematic debugging、verification、subagent-driven-development 等。
- 当前决策：暂不活跃安装，能力盘点见 `docs/skills-capabilities.md`；优先吸收高价值原则进 `ppw-codex-engineer`。

- Source: `https://github.com/mineskystudio/code-guardrails-skill`
- Local repo: `repos/code-guardrails-skill` at `fd952e0`
- 用途：代码修改前的轻量工程护栏，防止架构漂移、范围蔓延、隐性 MVP 取舍和过早基础设施。
- 当前决策：暂不单独活跃安装，建议内置到 `ppw-codex-engineer`。

## cleanup policy

- `refs/` 只保留精选参考、索引和可复用模板。
- 原始仓库完整内容只放 ignored 的 `repos/` 本地缓存，不进入提交历史。
- 不保留 Claude 插件元数据、agents/hooks 脚手架、运行状态、历史 artifacts、安装时间戳。
- 不保留用户明确排除的交易/代理类资料与运行时。
