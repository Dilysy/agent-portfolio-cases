# 自然语言数据库查询 Agent 运行验证记录

## 1. 当前状态

本阶段已完成底层工程阅读、工程结构理解、Agent 设计梳理、工具调用梳理、模拟 Schema、SQL 示例、查询结果样例和 HTML 预览页生成。

当前正式展示不接入真实 Oracle 数据库，也未执行真实 LLM + Oracle 查询链路。本阶段使用模拟销售业务 Schema 展示自然语言转 SQL 的流程演示。

## 2. 底层工程本地化运行验证状态

| 项目 | 状态 | 说明 |
| --- | --- | --- |
| README 阅读 | 已完成 | 底层工程为 CLI 自然语言数据库查询助手。 |
| 代码结构阅读 | 已完成 | 已确认 `main.py`、`src/react_agent.py`、`src/tools.py`、`src/config.py` 和 `setup_database.sql`。 |
| LLM 接入 | 代码已确认，演示版已完成 | 代码通过 `HelloAgentsLLM` 调用模型，需要配置 LLM 环境变量。 |
| 数据库接入 | 代码已确认，演示版已完成 | 底层工程依赖 Oracle，需要测试库、连接串和只读账号。 |
| Schema 获取 | 代码存在，需人工复核 | `GetSchema` 查询 Oracle 用户表结构。 |
| SQL 生成 | 代码存在，需人工复核 | `GenerateSQL` 基于自然语言和 Schema 生成 Oracle SQL。 |
| SQL 执行 | 代码存在，需人工复核 | `ExecuteQuery` 执行只读 SQL 并格式化结果。 |

## 3. 是否接入真实数据库

当前未接入真实数据库。

原因：

1. 底层工程默认依赖 Oracle 数据库。
2. 本阶段目标是案例第一阶段，不强制连接真实数据库。
3. 为避免泄露数据库账号、密码或真实业务数据，当前先使用本地演示 Schema 和模拟查询结果。

## 4. 是否使用模拟 Schema

已使用模拟销售业务 Schema。

模拟 Schema 文件：

```text
assets/reports/database-query-agent/database-schema-example.md
```

该 Schema 包含：

- `orders`
- `customers`
- `products`

## 5. 自然语言转 SQL 流程演示

已完成 5 个自然语言问题和 SQL 示例：

```text
assets/reports/database-query-agent/database-query-sql-example.md
```

覆盖内容包括：

1. 地区销售排名。
2. 客户类型销售表现。
3. 商品类别销售冠军。
4. 低毛利商品类别。
5. 华东地区月度销售趋势。

## 6. 查询结果样例

已生成查询结果样例：

```text
assets/reports/database-query-agent/database-query-result.md
```

结果为模拟数据逻辑生成，仅用于作品集演示，不代表真实企业数据库查询结果。

## 7. 当前安全控制说明

底层工程已有基础 SQL 安全校验：

- 只允许 `SELECT` 或 `WITH` 开头的 SQL。
- 阻断 `DROP`、`DELETE`、`UPDATE`、`INSERT`、`TRUNCATE`、`ALTER`、`CREATE` 等危险关键字。

企业落地时必须补充：

1. 只读数据库账号。
2. SQL 白名单。
3. 禁止 `DROP` / `DELETE` / `UPDATE` / `INSERT` 等危险语句。
4. 查询行数限制。
5. 查询超时限制。
6. 敏感字段脱敏。
7. 查询审计日志。
8. 表级和字段级权限控制。
9. SQL 执行前确认机制。

## 8. 后续如何接入真实数据库

建议后续按以下步骤进入真实运行验证：

1. 准备 Oracle 测试库或改造为 SQLite / DuckDB 演示库。
2. 创建只读数据库账号。
3. 使用 `本地配置模板` 中的变量名创建本地 `本地配置文件`，不要提交真实配置。
4. 执行或导入测试数据。
5. 运行 `python main.py` 发起自然语言查询。
6. 记录生成 SQL、执行结果和人工复核结论。
7. 录屏前确认终端和日志中不出现 私密凭证、数据库账号、密码或连接串。
