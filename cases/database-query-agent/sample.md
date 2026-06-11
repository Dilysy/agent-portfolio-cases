# 自然语言数据库查询 Agent 示例运行记录

## 1. 示例输入

```text
查询 2025 年各地区销售额排名前 5 的地区，并返回销售额和订单数。
```

当前实际演示问题基于本地演示 Schema，不连接真实企业数据库。

## 2. Schema 示例

本地演示 Schema 包含 3 张表：

- `orders`：订单事实表，包含日期、地区、客户类型、商品类别、销售额、订单数和毛利率。
- `customers`：客户维表，包含客户类型、地区和行业。
- `products`：商品维表，包含商品类别和价格。

完整 Schema 见：

```text
assets/reports/database-query-agent/database-schema-example.md
```

关键截图：

```text
assets/screenshots/database-query-agent/final/01-natural-language-query.png
```

## 3. SQL 生成过程

ReAct 过程示例：

```text
Thought: 用户需要按地区统计 2025 年销售额和订单数，并按销售额排序取前 5。
Action: GetSchema[]

Thought: 已获得 orders 表，字段包含 order_date、region、sales_amount、order_count。
Action: GenerateSQL[查询 2025 年各地区销售额排名前 5 的地区，并返回销售额和订单数。]
```

生成 SQL 示例：

```sql
SELECT
  region,
  SUM(sales_amount) AS total_sales,
  SUM(order_count) AS total_orders
FROM orders
WHERE order_date >= DATE '2025-01-01'
  AND order_date < DATE '2026-01-01'
GROUP BY region
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;
```

完整 SQL 示例见：

```text
assets/reports/database-query-agent/database-query-sql-example.md
```

## 4. SQL 执行过程

执行前需要校验：

- SQL 是否以 `SELECT` 或 `WITH` 开头。
- 是否包含 `DROP`、`DELETE`、`UPDATE`、`INSERT`、`TRUNCATE`、`ALTER`、`CREATE` 等危险关键字。
- 是否命中允许查询的表。
- 是否存在行数限制和超时限制。

通过校验后，`ExecuteQuery` 执行 SQL 并返回列名、行数据、行数和实际 SQL。

## 5. 查询结果

样例结果：

| region | total_sales | total_orders |
| --- | ---: | ---: |
| 华东 | 1,284,600 | 1,248 |
| 华南 | 1,063,800 | 1,016 |
| 华北 | 936,200 | 884 |
| 西南 | 742,500 | 691 |

完整结果样例见：

```text
assets/reports/database-query-agent/database-query-result.md
```

## 6. 结果解释

华东地区销售额最高，订单数也最高，说明该区域既有较高成交规模，也有较稳定的订单基础。华南排第二，可作为后续增长重点；西南销售额和订单数相对较低，需要结合客户结构和商品类别进一步分析。

## 7. 安全控制说明

当前演示只使用本地模拟 Schema。企业落地时必须补充：

1. 只读数据库账号。
2. SQL 白名单。
3. 危险语句拦截，包括 `DROP`、`DELETE`、`UPDATE`、`INSERT` 等。
4. 查询行数限制和查询超时限制。
5. 查询审计日志。
6. 敏感字段脱敏。
7. 表级和字段级权限控制。
8. SQL 执行前确认机制。

## 8. 人工复核结论

需要人工复核：

1. `sales_amount` 是否为含税销售额或不含税销售额。
2. `order_count` 是否为订单行数或真实订单数。
3. `region` 是否以订单地区、客户地区还是交付地区为准。
4. SQL 是否包含必要的时间范围和行数限制。
5. 查询结果是否需要脱敏或隐藏客户级信息。

## 9. 边界说明

- 当前未接入真实 Oracle 数据库。
- 当前结果基于模拟数据逻辑生成。
- 底层工程仅做基础字符串级 SQL 校验。
- SQL AST 校验、审计日志、字段脱敏和权限矩阵作为后续增强。

## 10. 可改进方向

1. 接入本地 SQLite / DuckDB 演示库。
2. 增加只读账号和表级白名单。
3. 增加 SQL AST 校验。
4. 增加查询结果解释模板和图表输出。
5. 增加 Text-to-SQL 测试集和人工评分表。

## 11. 演示材料路径

- Schema 示例：`assets/reports/database-query-agent/database-schema-example.md`
- SQL 示例：`assets/reports/database-query-agent/database-query-sql-example.md`
- 查询结果样例：`assets/reports/database-query-agent/database-query-result.md`
- 运行记录：`assets/reports/database-query-agent/database-query-run-result.md`
- HTML 预览页：`assets/reports/database-query-agent/report-preview.html`
- 演示视频：`assets/demos/database-query-agent/database-query-agent-demo.mp4`
- 自然语言查询截图：`assets/screenshots/database-query-agent/final/01-natural-language-query.png`
- SQL 生成截图：`assets/screenshots/database-query-agent/final/02-generated-sql.png`
- 查询结果与安全控制截图：`assets/screenshots/database-query-agent/final/03-query-result.png`
