# 自然语言数据库查询 Agent

## 1. 项目背景

本案例围绕企业经营数据的自然语言查询场景，整理 `本地数据库查询工程` 工程并设计一套本地演示 Schema。底层工程基于 HelloAgents 的 ReAct 思路，将中文自然语言问题转换为 Oracle SQL，再执行查询并格式化返回结果。

当前案例为自然语言数据库查询流程演示，使用本地模拟销售业务 Schema，不是真实企业数据库，也不展示真实业务数据。底层工程依赖 Oracle 环境，当前作品集版本采用模拟 Schema 展示 Text-to-SQL 流程，覆盖自然语言问题、Schema 感知、SQL 生成、查询结果和结果解释。

## 2. 业务问题

业务人员经常需要查询销售额、订单数、客户类型、商品类别等经营数据，但直接编写 SQL 有门槛；技术人员也需要快速生成查询草案并复核字段口径。自然语言转 SQL 的主要风险包括：

1. 不理解数据库 Schema，字段或表名使用错误。
2. 生成危险 SQL，误触发写入、删除或结构变更。
3. 查询结果过大，影响数据库性能。
4. 敏感字段未脱敏，存在权限和合规风险。
5. 查询结果缺少解释，业务人员难以复核。

## 3. 解决方案

Agent 按 ReAct 流程执行：

1. 获取数据库 Schema。
2. 基于用户问题和 Schema 生成 SQL。
3. 对 SQL 做基础安全校验。
4. 执行只读查询。
5. 将结果格式化为表格，并给出业务解释。

底层工程面向 Oracle 数据库；作品集阶段使用模拟销售业务 Schema 和查询样例展示 Text-to-SQL 工作流，后续可接入只读 Oracle、MySQL 或 PostgreSQL 测试库完成真实运行验证。

## 4. Agent 设计

| 设计点 | 工程实现 | 当前状态 |
| --- | --- | --- |
| ReAct | `DatabaseAgent` 继承 `ReActAgent`，使用 Thought / Action 循环 | 已在代码中确认 |
| Schema 获取 | `GetSchema` 调用 `OracleQueryTool.get_schema_info()` | 已在代码中确认 |
| 自然语言转 SQL | `GenerateSQL` 调用 `SQLGeneratorTool.generate_sql()` | 已在代码中确认 |
| SQL 执行 | `ExecuteQuery` 调用 `OracleQueryTool.execute_query()` | 已在代码中确认 |
| 查询结果解释 | 底层工程主要输出格式化表格，业务解释能力可通过最终回答补充 | 部分实现，后续可增强 |
| 工具注册机制 | `ToolRegistry.register_function()` 注册 3 个工具 | 已在代码中确认 |
| 数据库连接工具 | `oracledb.connect()` 连接 Oracle | 已在代码中确认 |

## 5. 工具调用

| 工具名称 | 输入 | 输出 | 作用 | 当前可用状态 |
| --- | --- | --- | --- | --- |
| GetSchema | 查询上下文或空输入 | 表名、字段名、数据类型、可空信息 | 让 Agent 了解可查询表结构 | 代码存在，需 Oracle 连接验证 |
| GenerateSQL | 自然语言问题 + Schema | Oracle SQL | 将中文问题转换为 SQL | 代码存在，需 LLM 配置验证 |
| validate_sql | SQL 字符串 | 校验结果和错误说明 | 限制为 SELECT / WITH，拦截危险关键字 | 代码存在，基础可用 |
| ExecuteQuery | 校验后的 SQL | 列名、行数据、行数、执行 SQL | 执行 Oracle 查询 | 代码存在，需 Oracle 连接验证 |
| format_query_result | 查询结果字典 | 文本表格 | 将数据库结果格式化展示 | 代码存在 |
| DatabaseConfig | 环境变量 | Oracle 连接参数 | 管理数据库连接配置 | 代码存在 |

## 6. 实现流程

1. 配置 LLM 和 Oracle 数据库连接参数。
2. 使用测试库或模拟 Schema 准备表结构。
3. 用户输入自然语言查询。
4. Agent 调用 GetSchema 获取表结构。
5. Agent 调用 GenerateSQL 生成 SQL。
6. `validate_sql` 检查是否为只读查询并拦截危险语句。
7. Agent 调用 ExecuteQuery 执行查询。
8. 查询结果以表格形式返回，并由人工复核 SQL 和业务口径。

## 7. 输出结果

本案例已生成以下本地演示材料：

- Schema 示例：`assets/reports/database-query-agent/database-schema-example.md`
- 自然语言问题与 SQL 示例：`assets/reports/database-query-agent/database-query-sql-example.md`
- 查询结果样例：`assets/reports/database-query-agent/database-query-result.md`
- 运行验证记录：`assets/reports/database-query-agent/database-query-run-result.md`
- HTML 预览页：`assets/reports/database-query-agent/report-preview.html`
- 字幕版演示视频：`assets/demos/database-query-agent/database-query-agent-demo.mp4`
- 原始录屏：`assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov`

这些材料基于模拟销售业务数据逻辑，不代表真实企业数据或真实生产数据库查询结果。

## 8. 安全控制

企业落地时必须加入以下控制：

1. 使用只读数据库账号。
2. 建立 SQL 白名单或表级白名单。
3. 禁止 `DROP`、`DELETE`、`UPDATE`、`INSERT`、`TRUNCATE`、`ALTER`、`CREATE` 等危险语句。
4. 限制返回行数，例如强制 `FETCH FIRST n ROWS ONLY` 或数据库方言对应写法。
5. 设置查询超时，避免长时间占用数据库资源。
6. 对手机号、邮箱、证件号、客户名称等敏感字段脱敏。
7. 记录查询审计日志，包括用户、问题、SQL、时间和结果行数。
8. 做表级和字段级权限控制。
9. SQL 执行前增加人工确认机制，尤其是高成本查询或跨敏感表查询。

底层工程已有基础字符串级 SQL 校验，完整 SQL AST 校验、权限矩阵、审计日志和脱敏策略作为后续增强。

## 9. 评估方式

- Schema 正确性：表名、字段名、类型和业务口径是否准确。
- SQL 正确性：过滤条件、聚合逻辑、排序和时间范围是否符合问题。
- 安全性：是否只读、是否限制行数、是否避开敏感字段。
- 结果可复核：输出中是否保留 SQL 和结果表。
- 业务解释：是否能说明结果含义和适用边界。
- 稳定性：同一问题多次运行是否生成一致且可执行的 SQL。

## 10. 可扩展方向

1. 接入 SQLite 或 DuckDB 本地演示库，降低 Oracle 环境依赖。
2. 增加 SQL AST 校验和查询成本估算。
3. 增加字段字典、指标口径和业务同义词映射。
4. 支持多轮追问和查询条件补全。
5. 支持图表输出和结果导出。
6. 增加 Text-to-SQL 测试集和人工评分表。

## 11. 演示材料

| 材料 | 路径 | 当前状态 |
| --- | --- | --- |
| 演示视频 | `assets/demos/database-query-agent/database-query-agent-demo.mp4` | 已完成 |
| 自然语言查询截图 | `assets/screenshots/database-query-agent/final/01-natural-language-query.png` | 已完成 |
| SQL 生成截图 | `assets/screenshots/database-query-agent/final/02-generated-sql.png` | 已完成 |
| 查询结果与安全控制截图 | `assets/screenshots/database-query-agent/final/03-query-result.png` | 已完成 |
| Schema 示例 | `assets/reports/database-query-agent/database-schema-example.md` | 已完成 |
| SQL 示例 | `assets/reports/database-query-agent/database-query-sql-example.md` | 已完成 |
| 查询结果样例 | `assets/reports/database-query-agent/database-query-result.md` | 已完成 |
| 运行验证记录 | `assets/reports/database-query-agent/database-query-run-result.md` | 已完成 |
| HTML 预览页 | `assets/reports/database-query-agent/report-preview.html` | 已完成 |
| 素材清单 | `assets/reports/database-query-agent/raw-assets-inventory.md` | 已完成 |
| 抽帧索引 | `assets/reports/database-query-agent/frame-preview-index.md` | 已完成 |
