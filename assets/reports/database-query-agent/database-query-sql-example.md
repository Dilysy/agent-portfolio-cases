# 自然语言数据库查询 SQL 示例

本文件基于本地演示 Schema 编写，用于展示自然语言数据库查询 Agent 的 Text-to-SQL 能力。示例 SQL 采用 Oracle 兼容写法，不连接真实企业数据库。

## 1. 各地区销售额排名

### 自然语言问题

查询 2025 年各地区销售额排名前 5 的地区，并返回销售额和订单数。

### SQL 示例

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

## 2. 客户类型销售表现

### 自然语言问题

查询不同客户类型的销售额、订单数和平均客单价。

### SQL 示例

```sql
SELECT
  customer_type,
  SUM(sales_amount) AS total_sales,
  SUM(order_count) AS total_orders,
  ROUND(SUM(sales_amount) / NULLIF(SUM(order_count), 0), 2) AS avg_order_value
FROM orders
WHERE order_date >= DATE '2025-01-01'
  AND order_date < DATE '2026-01-01'
GROUP BY customer_type
ORDER BY total_sales DESC;
```

## 3. 商品类别销售冠军

### 自然语言问题

查询 2025 年销售额最高的商品类别。

### SQL 示例

```sql
SELECT
  product_category,
  SUM(sales_amount) AS total_sales
FROM orders
WHERE order_date >= DATE '2025-01-01'
  AND order_date < DATE '2026-01-01'
GROUP BY product_category
ORDER BY total_sales DESC
FETCH FIRST 1 ROW ONLY;
```

## 4. 低毛利商品类别

### 自然语言问题

查询毛利率低于 20% 的商品类别。

### SQL 示例

```sql
SELECT
  product_category,
  ROUND(AVG(gross_margin), 4) AS avg_gross_margin,
  SUM(sales_amount) AS total_sales
FROM orders
WHERE order_date >= DATE '2025-01-01'
  AND order_date < DATE '2026-01-01'
GROUP BY product_category
HAVING AVG(gross_margin) < 0.20
ORDER BY avg_gross_margin ASC;
```

## 5. 华东地区月度销售趋势

### 自然语言问题

查询华东地区各月份销售趋势。

### SQL 示例

```sql
SELECT
  TO_CHAR(order_date, 'YYYY-MM') AS month,
  SUM(sales_amount) AS total_sales,
  SUM(order_count) AS total_orders
FROM orders
WHERE region = '华东'
  AND order_date >= DATE '2025-01-01'
  AND order_date < DATE '2026-01-01'
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month ASC;
```

## 6. SQL 安全校验建议

以上 SQL 在执行前仍应进入安全校验流程：

1. 仅允许 `SELECT` 或 `WITH` 查询。
2. 阻断 `DROP`、`DELETE`、`UPDATE`、`INSERT`、`TRUNCATE`、`ALTER`、`CREATE` 等危险语句。
3. 检查是否只访问允许的表和字段。
4. 强制限制返回行数。
5. 设置查询超时。
6. 记录查询审计日志。
