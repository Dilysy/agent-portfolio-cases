# 企业经营数据分析 Agent

## 1. 项目背景

本案例围绕企业经营表格分析场景进行工程化封装和流程编排整理，包含两类实现形态：一类面向商品销售数据，采用 Plan-and-Solve + ReAct 多智能体流水线；另一类使用 Notebook 对 Excel 表格做清洗、统计、ECharts 可视化和 Markdown 报告生成。

## 2. 业务问题

业务表格分析常见问题包括字段多、口径不清、分析任务需要人工拆解、图表和报告产出慢。该案例聚焦“样例经营数据到分析报告”的自动化链路，不接入真实企业数据，也不把样例结果写成真实经营结论。

## 3. 解决方案

Agent 先探查数据规模、字段、数据质量和数值统计特征，再自动规划 2-5 个分析任务。执行 Agent 调用数据分析工具完成客户分群、商品偏好、消费差异和订阅影响分析，最后由报告 Agent 汇总为带图表引用的 Markdown 报告。Notebook 版本补充了 Excel 数据清洗、统计和 ECharts 输出能力。

## 4. Agent 设计

- `PlanningAgent`：基于重写的 ReAct Agent，调用数据探查工具，生成分析任务列表。
- `AnalysisAgent`：基于重写的 ReAct Agent，按子任务调用数据分析工具，返回结论和图表路径。
- `ReportAgent`：使用 SimpleAgent，不启用工具调用，整合所有任务结果，生成总分总结构报告。
- Notebook SimpleAgent 版本：通过数据清洗工具和统计工具支持表格分析、图表代码和报告生成。

## 5. 工具调用

- `get_basic_metadata`：返回数据形状、列名、数据类型和内存占用。
- `assess_data_quality`：检查缺失率、异常值和有效性。
- `get_statistical_summary`：输出数值列基础统计和偏度、峰度、变异系数等指标。
- `analyze_gender_preferences`、`analyze_age_preferences`、`analyze_spending_differences`、`analyze_subscription_impact`：对购物行为数据做分群、偏好、消费和订阅影响分析，并生成 matplotlib 图表。
- Notebook 项目中的 `DataCleaningTool` 和 `DataStatisticsTool`：用于 Excel 数据清洗和描述性统计。

## 6. 实现流程

1. `alexrunner` 项目运行 `main.py`，清空并创建 `out/figures`。
2. PlanningAgent 调用数据探查工具，生成任务规划。
3. AnalysisAgent 遍历任务，调用对应分析函数并保存图表。
4. ReportAgent 汇总任务结果，生成 `out/analysis_report.md`。
5. `1zrj` 项目通过 `main.ipynb` 读取 `data/simple_data.xls`，输出 `output/echarts.html` 和 `output/report.md`。

## 7. 输出结果

已有输出包括 `alexrunner` 项目的 Markdown 报告结构示例和图表路径，以及 `1zrj` 项目的 `output/report.md`。其中 `1zrj` 报告分析了 2025 年 6 月至 10 月居民消费价格指数变化，包含趋势、异常检测、对比分析和结论。以上均为样例数据分析输出，不代表真实企业经营结果。

## 8. 评估方式

- 代码层评估：`alexrunner` 项目提供 `agents/test_planning_agent.py`、`test_analysis_agent.py`、`test_report_agent.py` 用于单 Agent 调试。
- 数据口径评估：人工检查字段含义、时间范围、分组逻辑和统计公式。
- 输出评估：检查报告是否引用图表、图表路径是否存在、结论是否能回到计算结果。
- 当前未看到完整自动化评估基准，后续需要补充固定测试集和指标校验。

## 9. 可扩展方向

- 后续可将固定数据分析函数改为更通用的字段映射和指标配置。
- 后续可增加 SQL 数据库读取作为输入，但不能写成已完成能力。
- 后续可增加图表快照、报告模板、单元测试和人工复核表。
