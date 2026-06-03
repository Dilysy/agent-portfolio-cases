# 自然语言数据库查询 Agent

## 1. 项目背景

本案例基于 `~/Documents/hello-agents/Co-creation-projects/939147533-DatabaseAgent` 复现和改造整理。原项目是一个基于 HelloAgents ReAct 框架的数据库查询助手，支持将中文自然语言转换为 Oracle SQL，并执行查询返回格式化结果。

## 2. 业务问题

非技术用户查询数据库需要理解表结构和 SQL 语法，技术人员也常需要快速生成查询草案。Text-to-SQL 的风险在于字段误用、SQL 不安全和结果解释不可复核，因此本案例聚焦 schema 获取、SQL 生成、只读校验和结果格式化。

## 3. 解决方案

Agent 按 ReAct 流程执行：先获取数据库 schema，再根据用户问题生成 Oracle SQL，随后进行基础安全校验，最后执行 SQL 并将结果格式化为文本表格。当前只写成本地样例和测试数据库复现，不连接真实生产数据库。

## 4. Agent 设计

- `DatabaseAgent` 继承 HelloAgents `ReActAgent`。
- Prompt 要求使用 `Thought` 和 `Action` 格式，按照 `GetSchema -> GenerateSQL -> ExecuteQuery` 的顺序处理问题。
- `ToolRegistry` 注册三个工具函数：获取 schema、生成 SQL、执行查询。
- `schema_cache` 缓存表结构，避免重复读取。
- 主程序 `main.py` 提供命令行交互和示例查询入口。

## 5. 工具调用

- `GetSchema`：通过 Oracle `user_tables` 和 `user_tab_columns` 获取表名、字段名、数据类型和可空信息。
- `GenerateSQL`：调用 LLM，根据 schema 和自然语言生成 Oracle SQL。
- `ExecuteQuery`：使用 `oracledb` 执行查询，返回列名、行数据、行数和 SQL。
- `validate_sql`：只允许 `SELECT` 或 `WITH` 开头，拦截 `DROP`、`DELETE`、`UPDATE`、`INSERT`、`TRUNCATE`、`ALTER`、`CREATE` 等危险关键字。

## 6. 实现流程

1. 配置 LLM 和 Oracle 数据库连接参数。
2. 使用 `setup_database.sql` 创建测试表和样例数据。
3. 运行 `python main.py` 进入命令行交互。
4. 输入自然语言查询，例如“查询所有员工信息”。
5. Agent 获取 schema、生成 SQL、校验 SQL、执行查询。
6. 将查询结果格式化为文本表格输出。

## 7. 输出结果

原项目 README 展示了“查询所有员工信息”和“查询 IT 部门员工平均工资”等示例截图。代码中的输出结果为命令行文本表格。当前作品集不声明已接入企业生产数据库，也不展示未授权数据。

## 8. 评估方式

- SQL 安全评估：`validate_sql` 做基础只读限制和危险关键字拦截。
- 结果可复核：输出中保留实际执行 SQL 和查询结果。
- 配置校验：`DatabaseConfig.validate()` 检查数据库连接参数是否完整。
- 当前不足：未看到 SQL AST 级校验、字段语义层、自动化测试集或查询成本控制。

## 9. 可扩展方向

- 后续可增加 Plan-and-Solve 查询流程。
- 后续可支持更多数据库类型。
- 后续可加入 SQL AST 校验、最大返回行数限制和查询结果导出。
- 后续可加入字段说明、指标口径和测试问题集。
