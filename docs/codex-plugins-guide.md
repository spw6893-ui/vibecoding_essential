# Codex Plugins 安装指南

本文记录 PPW 当前值得关注的 Codex plugins。原则：plugin 用来接外部工具、平台 API、MCP 或复杂产品工作流；普通工程纪律继续放 `AGENTS.md`，不要靠 plugin 堆流程。

## 安装策略

- 优先安装官方或一方维护的 plugin：OpenAI、Figma、Cloudflare、Expo、GitHub、Vercel、Netlify、Stripe、Hugging Face。
- 需要登录授权、能读写外部数据的 plugin，按项目需要安装，不做全局默认。
- 已经被 `mycodex` skills 覆盖的能力，不重复装 plugin。
- 纯流程类 plugin 谨慎安装，避免强制 TDD、worktree、subagent 等流程污染日常任务。
- 交易、代理和低频垂直工具不装：继续排除 `binance`、交易所、代理链路和用户明确不要的 crypto 运行时。

## 推荐分层

| 等级 | Plugin | 建议 | 理由 |
|---|---|---|---|
| A | `github` | 值得装 | PR、issue、CI、review 是高频工程入口，比本地脚本更适合 plugin 连接器。 |
| A | `figma` | 做 UI/前端时装 | 设计到代码、design parity、Code Connect 和设计系统规则，和 `ui-ux-pro-max`/`heroui-pro` 互补。 |
| A | `build-web-apps` | 做 Web app 时装 | React/shadcn/Supabase/Stripe/browser testing 组合能力强；但不要替代本仓库的前端设计 skill。 |
| A | `codex-security` | 安全审计时装 | 适合 diff/codebase scan、threat model、AppSec 检查；有写能力，按需开启。 |
| B | `cloudflare` | 用 Workers/Pages/R2/D1 时装 | 官方 MCP + Wrangler/Workers/Agents SDK 指南，适合部署到 Cloudflare 的项目。 |
| B | `vercel` / `netlify` | 用对应平台时装 | 平台部署、环境变量、构建日志和站点排障；二选一按项目选。 |
| B | `stripe` | 做支付时装 | 支付/订阅/checkout/webhook 高风险，plugin 比通用记忆更可靠；仅在项目需要时授权。 |
| B | `expo` | 做 React Native/Expo 时装 | Expo Router、EAS、SDK upgrade、native module、移动端发布流程。 |
| B | `chatgpt-apps` | 做 ChatGPT Apps/MCP widget 时装 | Apps SDK、MCP server、submission artifact 检查，和系统 `openai-docs` 互补。 |
| B | `hugging-face` | 做模型/数据集/Spaces 时装 | 连接 HF Hub，适合模型选择、dataset、Spaces 管理；非 ML 项目不用装。 |
| C | `build-ios-apps` / `build-macos-apps` | 只在 Apple 原生项目装 | SwiftUI、Xcode、simulator、profiling、codesign；非 macOS/iOS 项目无价值。 |
| C | `game-studio` | 浏览器游戏项目再装 | Phaser/Three/R3F/WebGL/asset pipeline；和普通 Web app 不要混用。 |
| C | `superpowers` | 默认不装 | 流程纪律强但触发面过宽；本仓库已吸收系统排障和验证前置到 `AGENTS.md`。 |

## 当前建议安装组合

### 默认个人工程组合

只建议保留：

- `github`
- `figma`（如果你近期做前端/UI）
- `codex-security`（需要安全扫 diff/codebase 时）

这三类覆盖工程协作、设计输入和安全检查，不会和 `mycodex` active skills 大面积重复。

### Web/SaaS 项目组合

- `build-web-apps`
- `github`
- `figma`
- `stripe`（有支付再装）
- `vercel` 或 `netlify`（按部署平台选）
- `codex-security`

### Cloudflare 项目组合

- `cloudflare`
- `github`
- `codex-security`
- `build-web-apps`（如果前端也在同仓库）

### Mobile 项目组合

- `expo`：React Native/Expo
- `build-ios-apps`：原生 iOS
- `build-macos-apps`：原生 macOS
- `github`

## 暂不建议安装

- `superpowers`：完整 workflow 太重，容易和 `AGENTS.md`、Codex 内置 subagent 规则、当前协作风格冲突。
- Productivity 全家桶：`gmail`、`google-calendar`、`slack`、`teams`、`sharepoint`、`outlook-*` 等需要外部账号授权，除非明确要让 Codex 读写工作流数据。
- 交易/金融/增长工具：`binance`、CRM、marketing、sales intelligence 等与当前 mycodex 目标不匹配。
- 语言类 plugin/skill：Python/Rust/Go 最佳实践大多应由项目配置、`AGENTS.md` 和真实工具链决定，不装全局 plugin。

## 安装与验证

Codex App 可在 Plugins 页面搜索并安装。CLI 的 marketplace 命令仍在快速演进，优先以当前 Codex 客户端内置 UI 为准。

安装后检查：

- 重开 Codex 会话，确认 plugin skills 出现在可用技能列表。
- 对需要授权的 plugin，只授予当前项目必要权限。
- 对有写能力的 plugin，先用只读问题测试，例如列 PR、读设计、查部署状态，再让它改动。
- 若 plugin 和本仓库 skill 都会触发，优先使用更具体的工具型 plugin；普通工程纪律仍按 `AGENTS.md`。

## 本仓库关系

- `skills/`：保留 PPW 高频、无需外部授权或已裁剪好的专项能力。
- `AGENTS.md`：保留所有项目都应遵守的默认工程纪律。
- `docs/codex-plugins-guide.md`：只做安装决策，不把 plugin 内容搬进仓库。
- `repos/superpowers/`：当前仅作本地参考；如不再评估完整 workflow，可删除本地 ignored 缓存。

## 来源

- OpenAI Academy: Plugins and skills
- OpenAI Codex official plugin cache: `/home/ppw/.codex/.tmp/plugins`
- Local plugin cache: `/home/ppw/.codex/plugins/cache/openai-curated`
- Superpowers local reference: `/home/ppw/mycodex/repos/superpowers`
