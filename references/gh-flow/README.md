# GitHub Flow 参考资料

来源：`/home/ppw/productivity/gh-flow-skill.zip`

## 当前决策

- 活跃安装：`skills/gh-create-issue`
- 活跃安装：`skills/gh-issue-implement`
- 活跃安装：`skills/gh-pr-review`

## 裁剪方式

`gh-issue-implement` 和 `gh-pr-review` 已重写成 Codex 原生流程：

- 不依赖上游 `dev`、`codeagent`、`AskUserQuestion`。
- issue 实现使用本仓库 `AGENTS.md`、代码检索、测试验证、`gh pr create`。
- PR review 使用 Codex 代码审查输出格式、CI 日志检查、最小修复闭环。
- 不生成 `agents/openai.yaml`，不暴露用户页面入口。
