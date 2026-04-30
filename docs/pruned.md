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
- `gh-issue-implement`（保留在 `references/gh-flow/`，依赖已裁剪的 `dev` 工作流，不活跃）
- `gh-pr-review`（保留在 `references/gh-flow/`，依赖已裁剪的 `codeagent` 工作流，不活跃）
- `hummingbot`
- `internal-comms`
- `markdown-to-epub`
- `mcp-builder`
- `omo`
- `pdf`
- `polymarket`
- `pptx`
- `proxychains`
- `product-requirements`（由 `product-spec-workflow` 聚合覆盖）
- `prototype-prompt-generator`（由 `product-spec-workflow` 聚合覆盖）
- `skill-install`（安装逻辑不作为活跃 skill 暴露）
- `slack-gif-creator`
- `snapdom`
- `sparv`
- `theme-factory`
- `test-cases`（由 `product-spec-workflow` 聚合覆盖）
- `web-artifacts-builder`
- `webapp-testing`
- `xlsx`

## 已清理的参考资料

- `references/myclaude-skills/`：原始 skill 副本已由 `product-spec-workflow` 聚合覆盖。
- `references/vibe-coding-cn/config-template/`：上游个人化 Codex 配置模板，容易污染当前全局配置。
- `references/vibe-coding-cn/documents/case-studies/polymarket-dev/`：用户明确不需要 Polymarket。
- `references/vibe-coding-cn/documents/case-studies/`：项目案例长文和一次性 prompt 复用价值低，不进入个人 Codex kit。
- `references/vibe-coding-cn/documents/guides/playbook/ProxyCast配置文档.md`：代理凭证转换运行时，不纳入个人 Codex 仓库。
- `references/vibe-coding-cn/documents/guides/`：入门配置、编辑器快捷键、远程隧道、frp、Auggie、Gemini Headless 等资料与现有 skill 或个人环境重复，整体裁掉。
- `references/vibe-coding-cn/documents/principles/philosophy/`：哲学长文和抽象方法论不直接支撑 Codex 执行，整体裁掉。
- `references/vibe-coding-cn/documents/workflow/`：auto-dev-loop/Kiro/Hook 实验流程和 Markdown 转 EPUB 低频流程已由 `ppw-codex-engineer`、`harness`、`product-spec-workflow` 与 `project-templates.md` 摘要覆盖。
- `references/vibe-coding-cn/fundamentals/`：泛化工程硬约束与现有 `AGENTS.md`、`ppw-codex-engineer` 重复，目录裁掉；仅保留数据服务模板为 `references/vibe-coding-cn/dataset-service-template.md`。
- `workflow_engine/artifacts/`、`workflow_engine/state/`、`.installed_at`、`install-manifest.md`：运行状态与历史安装记录。
- `AGENTS.md`、`.kiro/agents/`、`.claude-plugin/`、`agents/`、`hooks/` 类上游脚手架：不作为用户页面或运行入口暴露。

## 裁剪原则

- Claude 专用运行时不放进 Codex 活跃技能。
- 低频 Office/品牌/视觉/演示类不保留。
- 用户明确不需要的交易和代理类不保留。
- 和当前已有系统技能重复的，不重复安装。
- 可作为知识参考的内容放进 `references/` 或某个 skill 的 `references/`。
