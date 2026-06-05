# 企业经营数据分析 Agent 示例运行记录

## 示例输入

- 工程入口一：`alexrunner-DataAnalysisAgent`
- 数据文件：`data/shopping_behavior_updated.csv`
- 工程入口二：`1zrj-DataAnalysisAgent`
- 数据文件：`data/simple_data.xls`
- 分析目标：从样例购物行为或 CPI 表格中生成结构化分析报告和图表。

## 执行过程

1. `alexrunner` 版本运行 `python3 ./main.py`。
2. PlanningAgent 依次调用元数据、数据质量和统计摘要工具，生成分析任务列表。
3. AnalysisAgent 针对每个任务调用分群、偏好、消费差异或订阅影响工具。
4. 工具将图表保存到 `out/figures/`，并返回结论与图表相对路径。
5. ReportAgent 整合任务结果，生成 `out/analysis_report.md`。
6. `1zrj` 版本运行 `main.ipynb`，输出 `output/echarts.html` 和 `output/report.md`。

## 工具调用记录

| 步骤 | 工具 | 输入 | 输出 |
| --- | --- | --- | --- |
| 1 | get_basic_metadata | CSV 数据 | 行列数、字段、类型 |
| 2 | assess_data_quality | CSV 数据 | 缺失率、异常值、有效性检查 |
| 3 | get_statistical_summary | 数值字段 | 均值、分位数、偏度、峰度 |
| 4 | analyze_* 工具 | 分析子任务 | 结论字典和图表路径 |
| 5 | ReportAgent | 子任务结果 JSON | Markdown 分析报告 |
| 6 | ECharts/Notebook 流程 | Excel 样例数据 | HTML 图表和 Markdown 报告 |

## 示例输出

`alexrunner` 报告示例包含执行摘要、详细分析和结论建议，并在正文中引用图表路径，例如 `figures/average_spending_by_age_group.png`。`1zrj` 报告示例包含 CPI 趋势、统计计算、异常检测、对比分析和结论。

## 人工复核结论

需要人工复核字段含义、分析口径、图表是否正确生成，以及模型生成的业务建议是否超出样例数据支持范围。对于 CPI 或商品销售样例，不写成真实企业经营诊断。

## 当前不足

- `alexrunner` 的分析工具与 `shopping_behavior_updated.csv` 强绑定，泛化到其他数据集需要改造。
- `1zrj` 项目主要通过 Notebook 演示，工程化入口较弱。
- 当前工程未提供完整自动化评估基准。

## 可改进方向

- 增加通用字段映射和指标配置。
- 增加固定样例数据和预期结果断言。
- 增加图表文件存在性检查和报告结构检查。
- 增加脱敏数据输入规范。
