# 裁剪记录

## 已裁剪

- `algorithmic-art`
- `brand-guidelines`
- `browser`
- `canvas-design`
- `ccxt`
- `claude-code-guide`
- `claude-cookbooks`
- `codeagent`
- `coingecko`
- `cryptofeed`
- `dev`
- `do`
- `doc-coauthoring`
- `docx`
- `frontend-design`
- `gh-issue-implement`（保留在 `refs/gh-flow/`，依赖已裁剪的 `dev` 工作流，不活跃）
- `gh-pr-review`（保留在 `refs/gh-flow/`，依赖已裁剪的 `codeagent` 工作流，不活跃）
- `hummingbot`
- `internal-comms`
- `markdown-to-epub`
- `mcp-builder`
- `omo`
- `pdf`
- `polymarket`
- `pptx`
- `proxychains`
- `product-requirements`（由 `myclaude-product-workflow` 聚合覆盖）
- `prototype-prompt-generator`（由 `myclaude-product-workflow` 聚合覆盖）
- `skill-install`（安装逻辑不作为活跃 skill 暴露）
- `slack-gif-creator`
- `snapdom`
- `sparv`
- `theme-factory`
- `test-cases`（由 `myclaude-product-workflow` 聚合覆盖）
- `web-artifacts-builder`
- `webapp-testing`
- `xlsx`

## 已清理的参考资料

- `refs/myclaude-skills/`：原始 skill 副本已由 `myclaude-product-workflow` 聚合覆盖。
- `refs/vibe-coding-cn/config-template/`：上游个人化 Codex 配置模板，容易污染当前全局配置。
- `refs/vibe-coding-cn/documents/case-studies/polymarket-dev/`：用户明确不需要 Polymarket。
- `refs/vibe-coding-cn/documents/guides/playbook/ProxyCast配置文档.md`：代理凭证转换运行时，不纳入个人 Codex 仓库。
- `workflow_engine/artifacts/`、`workflow_engine/state/`、`.installed_at`、`install-manifest.md`：运行状态与历史安装记录。
- `AGENTS.md`、`.kiro/agents/`、`.claude-plugin/`、`agents/`、`hooks/` 类上游脚手架：不作为用户页面或运行入口暴露。

## 裁剪原则

- Claude 专用运行时不放进 Codex 活跃技能。
- 低频 Office/品牌/视觉/演示类不保留。
- 用户明确不需要的交易和代理类不保留。
- 和当前已有系统技能重复的，不重复安装。
- 可作为知识参考的内容放进 `refs/` 或某个 skill 的 `references/`。
