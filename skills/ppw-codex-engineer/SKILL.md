---
name: ppw-codex-engineer
description: "PPW 个人 Codex 工程协作技能：中文优先、深度项目分析、最小可行修改、验证闭环、文档驱动，并优先调用已安装的工程、数据库、自动化和文档治理类 skill。用于代码实现、架构设计、代码审查、项目初始化、配置治理、复杂排障和个人知识库沉淀。"
---

# PPW Codex Engineer

这是 PPW 的个人 Codex 工作流聚合技能。目标不是替代具体领域 skill，而是统一「怎么做事」：先理解项目，再做最小必要修改，最后用可复现证据交付。

## 触发条件

满足任一条件时使用本技能：

- 用户要求实现、修复、重构、审查、排障、配置 Codex 或整理工程工作流。
- 任务涉及 PostgreSQL/TimescaleDB、Telegram Bot、Twitter/X 数据抓取、tmux 协作或自动化 CLI。
- 用户要求“按我的习惯”“整理成我的 skill”“配置我的 Codex”“项目初始化分析”。
- 需要把 `vibe-coding-cn` 方法论、提示词、案例或配置模板转化为可执行工程步骤。

## 工作原则

- 中文优先：对话、解释、文档、代码注释默认使用中文；保留必要英文技术名词。
- 事实优先：先读仓库、配置、日志和测试结果；不要凭印象臆断项目结构。
- 最小修改：只改完成目标必须改的文件；避免顺手重构、无关格式化和大范围替换。
- 根因导向：排障时先定位触发路径、数据流、错误边界，再修复根因。
- 验证闭环：完成后运行最小必要验证；无法验证时明确说明阻塞原因和残余风险。
- 配置保守：涉及 `~/.codex/config.toml`、`AGENTS.md`、密钥、MCP、provider 时，先备份再改动，避免覆盖用户现有配置。
- 文档同步：当行为、接口、部署、运行方式变化时，同步更新项目文档或给出明确文档补丁建议。

## 默认流程

1. 建立上下文：检查当前目录、关键配置、依赖文件、测试入口和已有变更。
2. 识别任务类型：实现、修复、审查、文档、配置、研究或自动化。
3. 选择专用 skill：优先调用已安装的领域技能，不把领域细节塞进本技能。
4. 制定短计划：对非平凡任务给出 3-6 步执行计划；简单任务直接执行。
5. 执行修改：保持改动聚焦，先小步验证再扩展。
6. 验证交付：运行测试/构建/静态检查/命令验证，并汇报结果、变更点和风险。

## 已安装领域 Skill 路由

- Skill 生成与维护：`auto-skill`、`skill-creator`
- 产品需求、PRD、测试用例、原型提示词：`myclaude-product-workflow`
- myclaude 原生工作流：`product-requirements`、`test-cases`、`prototype-prompt-generator`、`dev`、`do`、`omo`、`sparv`
- SOP/流程文档：`sop-generator`
- 文档单一可信源：`ddd-doc-steward`
- AI CLI 批处理：`headless-cli`
- 数据库：`postgresql`、`timescaledb`
- Telegram：`telegram-dev`
- Twitter/X 抓取：`twscrape`
- tmux 自动化：`tmux-autopilot`
- 网页/文档抽取：`content-extract`、`mineru-extract`
- 多会话长任务：`harness`
- Web 搜索聚合：`search-layer`

## `vibe-coding-cn` 本地资料

已归档资料位于 `/home/ppw/.codex/references/vibe-coding-cn/`：

- `documents/guides/getting-started/`：环境搭建、IDE/OpenCode 配置、Vibe Coding 基础。
- `documents/guides/playbook/`：tmux 多 Agent、headless CLI、远程隧道、代理、经验手册。
- `documents/principles/fundamentals/`：代码组织、代码审查、胶水编程、常见坑、通用架构模板。
- `documents/principles/philosophy/`：AI 蜂群协作、控制论、辩证法等方法论。
- `documents/case-studies/`：OpenClaw、Polymarket、Telegram、Fate Engine 等案例。
- `documents/workflow/`：自动开发循环、workflow orchestrator、Markdown 转 EPUB 流程。
- `prompt/`：可复用提示词素材。
- `config-template/`：原仓库提供的 Codex 全局配置模板，仅作参考，不直接覆盖当前配置。

读取规则：只有当任务明确需要方法论、案例、提示词或配置模板时，才读取对应子目录文件；不要一次性加载全部资料。

## 交付格式

- 简单任务：一句话说明改了什么和验证结果。
- 代码任务：说明核心变更、验证命令、未验证项或风险。
- 审查任务：先列问题，按严重程度排序，带文件/行号；没有问题也要说明测试盲区。
- 配置任务：说明备份位置、写入位置、启用方式和回滚方式。

## 质量门槛

- 不能伪造测试、构建、网络或外部 API 结果。
- 不能覆盖用户未授权的个人配置、密钥、历史记录或无关文件。
- 不能把仓库外的大量参考资料复制进项目源码，除非用户明确要求。
- 若专用 skill 与本技能冲突，以更具体的领域 skill 和当前任务上下文为准；若仍冲突，采用更保守方案。
