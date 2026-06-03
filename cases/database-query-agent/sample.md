# 自然语言数据库查询 Agent 示例运行记录

## 示例输入

- 参考项目：`939147533-DatabaseAgent`
- 数据库：Oracle 测试库
- 测试数据：`setup_database.sql`
- 示例问题：
  - 查询所有员工信息
  - 查询工资大于 5000 的员工
  - 统计各部门的员工数量
  - 查询最近入职的 5 名员工

## 执行过程

1. 运行 `python main.py`。
2. 主程序加载 `.env`，初始化 `HelloAgentsLLM` 和 `DatabaseConfig`。
3. `DatabaseAgent` 注册 `GetSchema`、`GenerateSQL`、`ExecuteQuery`。
4. 用户输入自然语言查询。
5. Agent 按 ReAct 格式输出思考和行动。
6. 工具读取 schema，生成并校验 SQL。
7. 执行查询并返回格式化表格。

## 工具调用记录

| 步骤 | 工具 | 输入 | 输出 |
| --- | --- | --- | --- |
| 1 | GetSchema | 查询需求上下文 | Oracle 表结构说明 |
| 2 | GenerateSQL | 自然语言问题 + schema | Oracle SQL |
| 3 | validate_sql | SQL 字符串 | 是否只读、是否包含危险关键字 |
| 4 | ExecuteQuery | 校验后的 SQL | 列名、行数据、行数 |
| 5 | format_query_result | 查询结果字典 | 文本表格 |

## 示例输出

用户问题：

```text
查询 IT 部门的员工平均工资
```

可能生成的 SQL 形态：

```sql
SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT = 'IT'
```

最终输出为命令行表格。具体字段名以 `setup_database.sql` 创建的测试表为准。

## 人工复核结论

需要人工确认生成 SQL 是否使用正确表名、字段名、过滤条件和聚合逻辑。对于平均工资、部门名称等指标，需核对测试数据 schema 和字段口径。

## 当前不足

- 仅做基础字符串级 SQL 安全校验。
- 未加入最大返回行数、查询超时和成本控制。
- 未提供批量测试问题集和期望 SQL。
- 当前是 Oracle 版本，其他数据库尚未支持。

## 可改进方向

- 增加 SQL AST 校验。
- 增加只读连接用户和白名单表配置。
- 增加查询结果导出。
- 增加 Text-to-SQL 测试集和人工评分表。
