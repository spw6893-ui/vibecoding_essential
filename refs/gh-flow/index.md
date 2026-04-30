# GitHub Flow 参考资料

来源：`/home/ppw/productivity/gh-flow-skill.zip`

## 当前决策

- 活跃安装：`skills/gh-create-issue`
- 不活跃参考：`gh-issue-implement`、`gh-pr-review`

## 为什么不激活全部

`gh-issue-implement` 和 `gh-pr-review` 的上游设计依赖 `dev`、`codeagent`、`AskUserQuestion` 等 Claude 生态工作流。当前个人 Codex 仓库的目标是少而精，且已裁剪 `dev` / `codeagent`，所以这两个流程先保留原文参考，不进入 `skills/`。

如果后续要恢复，应先重写成 Codex 原生流程：

- issue 实现：使用本仓库的工程协作规则、代码检索、测试验证、`gh pr create`
- PR review：使用 Codex 代码审查输出格式、CI 日志检查、最小修复闭环
- 不依赖隐藏的子 skill 名称，也不生成 `agents/openai.yaml`
