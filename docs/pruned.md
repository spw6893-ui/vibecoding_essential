# 裁剪记录

## 已裁剪

- `algorithmic-art`
- `brand-guidelines`
- `browser`（保留在 `refs/myclaude-skills/`，不活跃）
- `canvas-design`
- `ccxt`
- `claude-code-guide`
- `claude-cookbooks`
- `codeagent`（保留在 `refs/myclaude-skills/`，不活跃）
- `coingecko`
- `cryptofeed`
- `dev`（保留在 `refs/myclaude-skills/`，不活跃）
- `do`（保留在 `refs/myclaude-skills/`，不活跃）
- `doc-coauthoring`
- `docx`
- `frontend-design`
- `hummingbot`
- `internal-comms`
- `markdown-to-epub`
- `mcp-builder`
- `omo`（保留在 `refs/myclaude-skills/`，不活跃）
- `pdf`
- `polymarket`
- `pptx`
- `proxychains`
- `product-requirements`（由 `myclaude-product-workflow` 聚合覆盖）
- `prototype-prompt-generator`（由 `myclaude-product-workflow` 聚合覆盖）
- `skill-install`（安装逻辑不作为活跃 skill 暴露）
- `slack-gif-creator`
- `snapdom`
- `sparv`（保留在 `refs/myclaude-skills/`，不活跃）
- `theme-factory`
- `test-cases`（由 `myclaude-product-workflow` 聚合覆盖）
- `web-artifacts-builder`
- `webapp-testing`
- `xlsx`

## 裁剪原则

- Claude 专用运行时不放进 Codex 活跃技能。
- 低频 Office/品牌/视觉/演示类不保留。
- 用户明确不需要的交易和代理类不保留。
- 和当前已有系统技能重复的，不重复安装。
- 可作为知识参考的内容放进 `refs/` 或某个 skill 的 `references/`。
