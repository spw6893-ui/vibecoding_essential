---
name: ppw-codex-engineer
description: "PPW 个人 Codex 工程路由与项目脚手架技能。仅在用户明确提到按 PPW 习惯、mycodex、Codex 配置治理、个人 skill 整理、项目初始化、代码框架建议、scaffold/boilerplate、工程模板或数据服务模板时使用；不要作为普通实现、修复或代码审查的默认入口。"
---

# PPW Codex Engineer

这是 PPW 的个人 Codex 工程路由与脚手架技能。它不替代全局 `AGENTS.md`，也不作为普通编码任务的默认入口；只在需要 PPW 个人配置、项目骨架、上游方法论裁剪或数据服务模板时加载。

## 触发条件

满足任一条件时使用本技能：

- 用户要求“按我的习惯”“整理成我的 skill”“配置我的 Codex”“项目初始化分析”。
- 用户要求“代码框架建议”“项目模板”“初始化仓库结构”“scaffold”“boilerplate”。
- 需要把本仓库精选工程模板转化为可执行工程步骤。
- 需要为长期运行的数据采集/补数/巡检服务选择 dataset-first 结构。

不触发：普通 bug 修复、常规功能实现、一般代码审查、单库 API 查询。遇到这些任务时直接按全局 `AGENTS.md` 工作，或选择更具体的领域 skill。

## Skill 路由

- Skill 生成与维护：系统 `skill-creator`
- 产品需求、PRD、测试用例、原型提示词：`product-spec-workflow`
- SOP/流程文档：`sop-generator`
- 文档单一可信源：`ddd-doc-steward`
- 数据库：`postgresql`、`timescaledb`
- Telegram：`telegram-dev`
- Twitter/X 抓取：`twscrape`
- tmux 自动化：`tmux-autopilot`
- 网页/文档抽取：`content-extract`、`mineru-extract`
- 多会话长任务：`harness`
- Web 搜索聚合：`search-layer`

## 本地参考资料

已归档资料位于 `/home/ppw/.codex/references/engineering-templates/`：

- `project-templates.md`：项目目录结构、`.gitignore`、GitHub issue/PR 模板、Codex 配置基线和自动开发闭环摘录。
- `dataset-service-template.md`：以 dataset/contract/registry/runtime 为核心的数据服务架构模板。

读取规则：只有当任务明确需要工程模板、项目骨架或数据服务模板时，才读取对应文件；不要一次性加载全部资料。

项目初始化规则：当用户要求“代码框架建议”“项目模板”“初始化仓库结构”“scaffold/boilerplate”时，优先读取 `/home/ppw/.codex/references/engineering-templates/project-templates.md`，按项目类型选择最小骨架，不复制上游个人路径、极端人格提示、上游配置模板或已裁剪技能。

数据服务规则：当用户要新建或重排长期运行的数据采集服务、补数服务、巡检服务或数据质量治理服务时，读取 `/home/ppw/.codex/references/engineering-templates/dataset-service-template.md`，只采纳 dataset-first、contract-first、registry 和 runtime 控制面结构。

## 项目框架路由

当用户要求新建、整理或评估项目框架时，先判断项目类型，再给最小可落地骨架。不要一次性铺满所有目录；只创建当前阶段会用到的文件夹。

### 类型选择

- Python Web/API：FastAPI、Flask、REST API、后台服务。建议骨架：`README.md`、`pyproject.toml`、`.env.example`、`.gitignore`、`AGENTS.md`、`docs/`、`scripts/`、`tests/`、`src/api/`、`src/core/`、`src/data/`、`src/external/`。
- 数据科学/AI/研究：数据采集、分析、回测、模型训练。建议骨架：`configs/`、`notebooks/`、`scripts/`、`tests/`、`src/data/`、`src/models/`、`src/core/`、`src/utils/`，并默认忽略 `data/`、`models/`、`logs/`。
- Monorepo/微服务：多服务、多应用、多语言。建议骨架：`docs/`、`scripts/`、`services/`、`packages/` 或 `assets/common/`、`infrastructure/`、`monitoring/`。每个服务内部保留自己的依赖、测试和 Dockerfile。
- Full-stack Web：前后端分离、SaaS、管理后台、Dashboard。建议骨架：`frontend/`、`backend/`、`docs/`、`docker-compose.yml`、`AGENTS.md`。如前端要 HeroUI/NextUI，路由到 `heroui-pro`；如需要视觉方向或设计系统，路由到 `ui-ux-pro-max`。

### 默认工程文件

- `.gitignore` 必须覆盖：`.env*`、虚拟环境、`node_modules/`、构建产物、日志、SQLite/DuckDB、数据目录、模型目录、Python cache、系统垃圾文件。
- `README.md` 必须说明：项目目标、安装、运行、测试、关键目录。
- `AGENTS.md` 必须说明：项目约束、常用命令、架构说明、验证方式。
- `.env.example` 只写变量名和占位示例，不写真实密钥。
- `docs/architecture.md` 记录模块边界、数据流、外部依赖和关键决策。
- `tests/` 至少覆盖核心路径的最小测试，不要只创建空目录。

### 采纳原则

- 对新项目：先生成最小骨架，等需求明确后再扩展目录。
- 对已有项目：先映射现状，再补缺失文档/测试，不强行重排目录。
- 对上游模板：只采纳结构和检查清单；不复制个人路径、激进人格提示、Claude 专用运行时或已裁剪 skill。
- 对用户明确不要的运行时：不要主动引入 `ccxt`、`coingecko`、`cryptofeed`、`hummingbot`、`polymarket`、`proxychains`。
- 需要完整模板时，再读取 `/home/ppw/.codex/references/engineering-templates/project-templates.md`。
