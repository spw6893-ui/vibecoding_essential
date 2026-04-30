# vibe-coding-cn 本地归档索引

来源：`https://github.com/tukuaiai/vibe-coding-cn`

本目录保存从 `vibe-coding-cn` 导入到本机 Codex 环境的非运行时参考资料。运行时 skill 已安装到 `/home/ppw/.codex/skills/`，本目录只作为资料库使用。

## 目录

- `documents/`：方法论、案例、工作流、开发经验和 playbook。
- `prompt/`：提示词素材。
- `config-template/`：原仓库提供的 `.codex` 配置模板，只作参考。
- `project-templates.md`：从上游提炼的项目目录、GitHub 模板、Codex 配置基线和自动开发闭环建议。
- `.installed_at`：最近一次导入时间戳。

## 使用规则

- 需要方法论时优先读取 `documents/principles/`。
- 需要操作流程时优先读取 `documents/guides/playbook/` 或 `documents/workflow/`。
- 需要案例参考时读取 `documents/case-studies/`。
- 需要 Codex 配置参考时读取 `config-template/`，不要直接覆盖当前 `/home/ppw/.codex/config.toml`。
- 需要项目初始化、目录结构、GitHub 模板或工程框架建议时读取 `project-templates.md`。
- 需要个人工作流时使用 `$ppw-codex-engineer`。
