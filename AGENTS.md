# mycodex 协作规则

本仓库是 PPW 的个人 Codex 配置与技能仓库。

## 修改规则

- 默认中文说明和中文文档。
- 技能数量宁少勿多，新增前先判断是否可以并入现有 skill。
- 活跃 skill 放 `skills/<name>/SKILL.md`。
- 长参考资料放 `skills/<name>/references/` 或 `references/<source>/`。
- 常驻协作习惯、验证闭环、最小修改和仓库维护规则放 `AGENTS.md`；不要塞进某个总入口 skill。
- Skill 只放可触发的专项能力、领域流程、工具路由或模板导航；避免把普通编码规则包装成默认 skill。
- `ppw-codex-engineer` 只作为个人工程路由和项目脚手架入口，不作为普通实现、修复、审查的默认入口。
- 不提交 `auth.json`、`.env`、SQLite、日志、shell 快照。
- 修改后运行 `./scripts/verify.sh`。

## 提交规则

- 使用语义化提交信息。
- 一次提交只做一类变更：新增 skill、裁剪 skill、更新资料、脚本调整。
