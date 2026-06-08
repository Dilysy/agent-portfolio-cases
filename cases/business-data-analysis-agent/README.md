# 企业经营数据分析 Agent

## 1. 项目背景

本案例围绕企业经营表格分析场景进行工程化封装和流程编排整理，综合两个数据分析 Agent 项目的能力边界：

- `alexrunner-DataAnalysisAgent`：Python 主程序形态，包含 Plan / Analysis / Report 三段 Agent 流水线，面向商品销售数据做任务规划、数据分析、图表生成和报告汇总。
- `1zrj-DataAnalysisAgent`：Notebook 形态，使用 SimpleAgent 结合数据清洗、统计工具，对 Excel 表格生成 ECharts 图表和 Markdown 报告。

作品集版本将两者合并包装为“企业经营数据分析 Agent”，用于展示从经营数据输入、指标计算、分组对比、图表生成到经营报告输出的本地化运行验证链路。本案例不接入真实企业数据，不写成真实客户交付项目。

## 2. 业务问题

经营分析中常见的问题包括：

1. 销售、订单、毛利、地区和客户类型等字段分散在表格中，人工梳理耗时。
2. 业务人员需要同时查看趋势、贡献、分组差异和利润表现，分析口径容易不一致。
3. 图表和报告往往依赖人工制作，难以形成可重复的分析流程。
4. 模型生成的建议需要回到数据和指标做人工复核，避免脱离事实。

## 3. 解决方案

案例方案将两个项目的能力合并为一条经营分析工作流：

1. 数据读取：读取 CSV / Excel 表格。
2. 数据理解：识别字段、行列数、类型、缺失值和数值统计特征。
3. 任务规划：由 PlanningAgent 或 SimpleAgent 将经营问题拆成若干分析任务。
4. 指标计算：计算销售额、订单数、客单价、毛利率、地区/品类/客户类型聚合。
5. 图表生成：生成趋势图、地区对比图、品类贡献图和客户类型分析图。
6. 报告生成：输出 Markdown 经营分析报告，并保留人工复核说明。

当前已完成模拟销售数据演示、本地复现材料整理和字幕版演示视频剪辑。两个原项目的端到端 LLM 运行验证仍作为后续优化项保留，因此本案例展示口径为“模拟数据演示 / 本地复现”，不代表真实企业数据分析结果。

## 4. Agent 设计

| 设计点 | alexrunner 项目 | 1zrj 项目 | 作品集包装口径 |
| --- | --- | --- | --- |
| SimpleAgent | ReportAgent 使用 SimpleAgent 汇总结果 | 主体使用 SimpleAgent 调用工具并生成图表/报告 | 可用于报告汇总和轻量表格分析 |
| Plan-and-Solve | 已包含，Plan Agent 先规划子任务 | 未体现 | 适合包装为复杂经营分析的任务拆解能力 |
| ReAct | PlanningAgent 和 AnalysisAgent 使用重写 ReActAgent | 未体现 | 用于工具调用和逐步分析 |
| 任务拆解 | 已包含，规划 2-5 个分析任务 | 由提示词引导但不形成显式计划列表 | 已实现于 alexrunner，Notebook 版本为轻量补充 |
| 数据理解 | 数据探查工具读取形状、字段、类型、质量和统计摘要 | 读取 Excel 后交给清洗/统计工具 | 已包含 |
| 数据清洗 | 主要做质量评估，未提供通用清洗流水线 | DataCleaningTool 支持列筛选、空值处理 | 部分包含 |
| 指标计算 | 多个固定分析函数计算购物行为指标 | DataStatisticsTool 做描述性统计 | 已包含，但 alexrunner 与固定数据集强绑定 |
| 图表生成 | matplotlib 输出多张图表到 `out/figures/` | LLM 生成 ECharts option 并保存 HTML | 已包含 |
| 经营报告生成 | ReportAgent 生成 Markdown 报告 | Notebook 保存 Markdown 报告 | 已包含 |
| 多 Agent 分工 | PlanningAgent / AnalysisAgent / ReportAgent | 单 Agent 为主 | alexrunner 可作为多 Agent 分工展示 |

需要注意：`alexrunner` 的分析工具主要围绕 `shopping_behavior_updated.csv` 固定字段设计，泛化到任意经营表格需要改造。`1zrj` Notebook 中存在硬编码模型环境变量配置，展示前必须清理。

## 5. 工具调用

| 工具名称 | 输入 | 输出 | 作用 | 当前可用状态 |
| --- | --- | --- | --- | --- |
| `get_basic_metadata` | CSV 数据 | 行列数、字段名、数据类型、内存占用 | 数据理解和字段识别 | alexrunner 中已实现 |
| `assess_data_quality` | CSV 数据 | 缺失率、异常值、有效性检查 | 数据质量评估 | alexrunner 中已实现 |
| `get_statistical_summary` | 数值字段 | 均值、分位数、偏度、峰度、变异系数 | 统计摘要 | alexrunner 中已实现 |
| `Gender Preference Analysis` | 分析子任务 | 性别分布、平均消费、品类偏好和图表路径 | 客户分群分析 | alexrunner 中已实现，面向固定购物数据 |
| `Age Preference Analysis` | 分析子任务 | 年龄段分布、消费金额、品类偏好和图表路径 | 年龄分层分析 | alexrunner 中已实现，面向固定购物数据 |
| `Spending Differences Analysis` | 分析子任务 | 性别/年龄/品类交叉消费差异和图表路径 | 交叉对比分析 | alexrunner 中已实现，面向固定购物数据 |
| `Subscription Impact Analysis` | 分析子任务 | 订阅状态、消费金额、复购频率和图表路径 | 订阅影响分析 | alexrunner 中已实现，面向固定购物数据 |
| `Seasonal Preference Analysis` | 分析子任务 | 季节偏好、热销品类和图表路径 | 季节性分析 | alexrunner 中已实现，面向固定购物数据 |
| `Review Rating Impact Analysis` | 分析子任务 | 评分与购买金额/频率关系 | 评价影响分析 | alexrunner 中已实现，面向固定购物数据 |
| `Payment Method Impact Analysis` | 分析子任务 | 支付方式与购买金额关系 | 支付方式分析 | alexrunner 中已实现，面向固定购物数据 |
| `DataCleaningTool` | Excel JSON、空值策略、保留列 | 清洗后 JSON | Excel 表格清洗 | 1zrj Notebook 中已实现 |
| `DataStatisticsTool` | 清洗后 JSON | 数值统计、分类字段 Top 值 | 描述性统计 | 1zrj Notebook 中已实现，但当前注册表只注册了清洗工具，需补注册统计工具 |
| LLM 调用 | 提示词、工具上下文、分析任务 | 任务规划、分析结论、报告文本 | 驱动 Agent 推理和报告生成 | 需要配置模型 API Key 和 Base URL |

## 6. 实现流程

1. 阅读两个原项目 README、入口和工具代码。
2. 将 `alexrunner` 定位为多 Agent 经营分析流水线：Plan 规划、Analysis 调工具、Report 汇总。
3. 将 `1zrj` 定位为 Notebook 表格分析原型：Excel 读取、清洗、统计、ECharts、Markdown 报告。
4. 为作品集生成模拟销售数据 `sample-sales-data.csv`。
5. 使用 Python 对模拟数据做月度、地区、品类和客户类型分析。
6. 生成 4 张中文图表和一份经营分析报告样例。
7. 基于图表和报告展示图生成字幕版演示视频。
8. 在文档中标注当前状态：模拟数据、图表、报告样例和演示视频已完成，原项目端到端运行验证待继续。

## 7. 输出结果

本阶段已生成以下作品集材料：

- 演示视频：`assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`
- 模拟销售数据：`assets/reports/business-data-analysis-agent/sample-sales-data.csv`
- 经营分析报告：`assets/reports/business-data-analysis-agent/business-data-analysis-report.md`
- 运行结果记录：`assets/reports/business-data-analysis-agent/business-data-analysis-run-result.md`
- 月度销售趋势图：`assets/screenshots/business-data-analysis-agent/raw/01-sales-trend.png`
- 地区销售额对比图：`assets/screenshots/business-data-analysis-agent/raw/02-region-comparison.png`
- 商品类别销售贡献图：`assets/screenshots/business-data-analysis-agent/raw/03-category-contribution.png`
- 客户类型销售表现图：`assets/screenshots/business-data-analysis-agent/raw/04-customer-type-analysis.png`
- 报告概览图：`assets/screenshots/business-data-analysis-agent/final/05-report-overview.png`
- 经营建议图：`assets/screenshots/business-data-analysis-agent/final/06-business-insights.png`

报告明确标注为基于模拟数据生成，不代表真实企业经营结论。

## 8. 评估方式

- 数据完整性：检查日期范围、地区、客户类型、商品类别是否覆盖要求。
- 指标正确性：复核销售额、订单数、客单价、加权毛利率、分组聚合计算。
- 图表可读性：检查中文标题、坐标轴、图例和数值标注是否清晰。
- 结论边界：确认经营建议只基于模拟数据，不写成真实客户结论。
- 安全检查：确认报告和图表不包含 API Key、真实企业名称、客户名称、邮箱、电话或内部账号。

## 9. 可扩展方向

1. 将固定分析函数改为通用字段映射和指标配置。
2. 增加 CSV / Excel 文件上传或命令行参数输入。
3. 增加同比、环比、目标达成率、回款率、续费率和获客成本等指标。
4. 增加数据质量检查、异常订单识别和人工复核表。
5. 将 Notebook 原型封装为稳定 CLI 或轻量 Web 演示入口。
6. 清理 1zrj Notebook 中的硬编码敏感配置，改为 `.env` 加载。

## 10. 演示材料

- 演示视频：已完成字幕版成片，路径为 `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`。
- 模拟销售数据：已补充到 `assets/reports/business-data-analysis-agent/sample-sales-data.csv`。
- 销售趋势图：已补充到 `assets/screenshots/business-data-analysis-agent/raw/01-sales-trend.png`。
- 地区对比图：已补充到 `assets/screenshots/business-data-analysis-agent/raw/02-region-comparison.png`。
- 商品类别贡献图：已补充到 `assets/screenshots/business-data-analysis-agent/raw/03-category-contribution.png`。
- 客户类型分析图：已补充到 `assets/screenshots/business-data-analysis-agent/raw/04-customer-type-analysis.png`。
- 报告概览图：已补充到 `assets/screenshots/business-data-analysis-agent/final/05-report-overview.png`。
- 经营建议图：已补充到 `assets/screenshots/business-data-analysis-agent/final/06-business-insights.png`。
- 经营分析报告：已补充到 `assets/reports/business-data-analysis-agent/business-data-analysis-report.md`。
- 运行结果记录：已补充到 `assets/reports/business-data-analysis-agent/business-data-analysis-run-result.md`。

以上材料均为模拟数据演示 / 本地复现素材，不包含真实企业数据，不写成真实客户交付。
