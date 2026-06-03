# 自然语言数据库查询 Agent 示例运行记录

## 示例输入

- 数据库：本地 SQLite 样例库
- 问题：2025 年每个渠道的销售额是多少？
- 限制：只允许 SELECT 查询

## 执行过程

1. 读取 schema。
2. 识别时间范围、指标和分组维度。
3. 生成 SQL。
4. 执行安全校验。
5. 运行查询并解释结果。

## 工具调用记录

| 步骤 | 工具 | 输入 | 输出 |
| --- | --- | --- | --- |
| 1 | Schema 读取 | 数据库路径 | 表和字段 |
| 2 | SQL 生成 | 问题和 schema | SELECT 查询 |
| 3 | SQL 执行 | 校验后的 SQL | 查询结果 |
| 4 | Markdown 生成 | SQL 和结果 | 运行记录 |

## 示例输出

```sql
SELECT channel, SUM(sales_amount) AS total_sales
FROM orders
WHERE order_date >= '2025-01-01' AND order_date < '2026-01-01'
GROUP BY channel
ORDER BY total_sales DESC;
```

输出解释应说明各渠道销售额排序，并提示字段口径来自样例库。

## 人工复核结论

需要人工确认 `sales_amount` 是否代表销售额，`order_date` 是否为订单日期，渠道字段是否存在空值或归一化问题。

## 当前不足

- 尚未提供样例 SQLite 数据库。
- 尚未实现自动 SQL 语法检查。
- 复杂指标口径需要语义层支持。

## 可改进方向

- 增加本地样例库和测试问题集。
- 增加 SQL AST 安全校验。
- 增加字段说明和指标口径配置。
