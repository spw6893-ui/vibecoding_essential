---
name: product-spec-workflow
description: "产品规格与研发交付文档技能：用于 PRD/产品需求、需求确认、验收标准、测试用例、QA 计划、UI/UX 原型提示词、BMAD/requirements 工作流裁剪版。触发于用户要求写 PRD、整理需求、生成测试用例、设计原型提示词、把想法变成可执行规格或做产品到研发交付计划。"
---

# Product Spec Workflow

本技能把产品研发文档相关内容转换为 Codex 可用流程。其参考资料来自 `stellarlinkco/myclaude` 的裁剪版，但不安装 Claude 专用运行时，不调用 `codeagent-wrapper`，只保留可迁移的方法论、评分门槛和文档模板。

来源与许可证信息见 `references/source.md`。

## 适用场景

- 用户要求写 PRD、产品需求文档、功能规格、需求确认文档。
- 用户给出零散想法，需要整理成用户故事、验收标准、MVP、边界和交付计划。
- 用户要求根据 PRD/需求生成测试用例、测试矩阵、QA 计划。
- 用户要求生成 UI/UX 原型提示词、页面规格、设计系统约束。
- 用户希望使用轻量 requirements workflow 或较完整 BMAD 流程做需求到研发计划。

## 核心流程

1. 先读项目上下文：README、依赖配置、现有 docs、相关代码目录；如果只是纯文档任务，可跳过代码扫描。
2. 判断交付类型：`PRD`、`需求确认`、`测试用例`、`原型提示词`、`BMAD 计划` 或组合交付。
3. 对需求质量打分；未达到门槛时，只问 2-3 个最高价值澄清问题。
4. 每轮用户补充后重新评分，并说明哪个维度从 X 提升到 Y；不要只说“更清楚了”。
5. 生成结构化文档；优先写到项目内 `docs/` 或用户指定路径。
6. 做一致性检查：每个需求必须能映射到验收标准；测试用例必须能追踪到需求。

## 需求质量评分

PRD/需求默认使用 100 分制，建议 90 分以上再进入详细实现计划：

- 业务价值与目标：30 分，关注问题、收益、成功指标。
- 功能需求：25 分，关注用户故事、主流程、边界和错误处理。
- 用户体验：20 分，关注用户画像、用户旅程、交互约束。
- 技术约束：15 分，关注性能、安全、集成、兼容性。
- 范围与优先级：10 分，关注 MVP、分期、取舍和不做什么。

轻量 requirements workflow 可改用 100 分制：功能清晰 30、技术具体 25、实现完整 25、业务上下文 20。

## 澄清问题策略

当总分低于 90 时，不要泛泛追问。先找最低分维度，再一次只问 2-3 个最高价值问题：

- 业务价值不足：问具体业务问题、成功指标、如果不做会怎样。
- 功能需求不足：问主用户流程、must-have vs nice-to-have、关键边界/异常场景。
- 用户体验不足：问主要用户、用户目标/痛点、理想交互体验或设计约束。
- 技术约束不足：问性能期望、安全/合规要求、需要集成的系统。
- 范围优先级不足：问 MVP 最小价值闭环、分期方式、Top 3 优先级。

如果用户只要快速草稿，可以跳过追问，但必须在文档中标注“草稿版”和关键假设。

## 输出约定

- PRD：`docs/{feature-name}-prd.md`
- 需求确认：`docs/{feature-name}-requirements.md`
- 测试用例：`tests/{feature-name}-test-cases.md` 或 `docs/{feature-name}-test-cases.md`
- 原型提示词：`docs/{feature-name}-prototype-prompt.md`
- BMAD 计划：`docs/{feature-name}-bmad-plan.md`

如果项目已有文档目录规范，优先遵循现有规范。

## PRD 骨架

```markdown
# Product Requirements Document: [Feature Name]

**Version**: 1.0
**Date**: [YYYY-MM-DD]
**Quality Score**: [score]/100

## Executive Summary
## Problem Statement
## Success Metrics
## User Personas
## User Stories & Acceptance Criteria
## Functional Requirements
## Technical Constraints
## Non-Goals / Out of Scope
## MVP Scope
## Phased Delivery Plan
## Risk Assessment
## Dependencies & Blockers
## Open Questions
## Glossary
## References
```

风险建议使用表格：`Risk | Probability | Impact | Mitigation`。依赖建议标注 owner、状态和解除条件。Glossary 只放会影响理解的业务/技术术语，不要为了凑章节而填充。

## 测试用例骨架

```markdown
# Test Cases: [Feature Name]

## Overview
## Functional Tests
## Edge Case Tests
## Error Handling Tests
## State Transition Tests
## Test Coverage Matrix
## Assumptions / Gaps
```

每个测试用例使用 `TC-F-*`、`TC-E-*`、`TC-ERR-*`、`TC-ST-*` 编号，并标注需求来源、前置条件、步骤、预期结果和优先级。

## 原型提示词要求

生成 UI/UX 原型提示词时，必须包含：

- 应用类型、目标用户、平台和视口。
- 设计系统选择：WeChat Work、iOS Native、Material Design、Ant Design Mobile 或自定义。
- 颜色、字体、间距、卡片、按钮、列表、导航等明确规格。
- 页面结构树、真实文案和样例数据，避免 lorem ipsum。
- 交互状态、空状态、错误状态、加载状态和可访问性要求。
- 输出格式：HTML/CSS/React/Vue/设计稿说明，由用户或项目上下文决定。

## 何时读取 References

- 需要完整 PRD 模板和评分细节：读 `references/product-requirements.md`。
- 需要完整测试用例规范：读 `references/test-cases.md` 和 `references/testing-principles.md`。
- 需要 UI/UX 原型提示词：读 `references/prototype-prompt-generator.md`，必要时再读 `prototype-design-systems.md` 和 `prototype-prompt-structure.md`。
- 需要完整企业级流程：读 `references/bmad-readme.md` 和 `references/bmad-workflow.md`。
- 需要轻量需求到代码流程：读 `references/requirements-readme.md` 和 `references/requirements-workflow.md`。
- 需要参考 myclaude 的日常开发命令语义：读 `references/development-commands.md`。

## 限制

- 不使用 myclaude 的 Claude Code 专用命令、hooks、browser 自动化或 codeagent-wrapper 运行时。
- 不为了达到 90 分而臆造业务指标；未知项必须标注“待确认”。
- 生成文档前先检查项目已有命名、目录和模板，避免破坏现有文档体系。
- 如果用户只要快速草稿，可以跳过 90 分门槛，但必须明确“草稿版”。
