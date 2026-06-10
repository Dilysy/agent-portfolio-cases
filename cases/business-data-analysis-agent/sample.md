# 企业经营数据分析 Agent 示例运行记录

## 1. 示例输入

```text
请基于 2025 年模拟销售数据，分析企业全年经营表现，输出月度销售趋势、地区销售表现、商品类别贡献、客户类型差异、毛利率分析和经营建议。
```

示例数据：

```text
assets/reports/business-data-analysis-agent/sample-sales-data.csv
```

该数据为模拟销售数据，不包含真实企业、真实客户或真实订单。

实际演示输入为 2025 年模拟销售数据，字段包括订单日期、地区、客户类型、商品类别、商品名称、销售额、订单数和毛利率。当前演示口径为“模拟数据演示 / 本地验证”，用于说明分析链路和展示材料，不代表真实企业经营结论。

## 2. 执行过程

本阶段没有完整运行两个底层工程的端到端 LLM 链路，而是先完成代码理解、案例文档和演示补充材料生成。实际执行过程如下：

1. 阅读 `多 Agent 经营分析原型` 的 README、`main.py`、Agent 提示词、ReAct Agent 实现、数据探查工具和数据分析工具。
2. 阅读 `Notebook 表格分析原型` 的 README、`main.ipynb`、Excel 示例数据、ECharts 输出和 Markdown 报告输出。
3. 判断两个项目可以合并包装为“企业经营数据分析 Agent”：前者提供多 Agent 流水线，后者提供 Notebook 表格分析与图表报告输出。
4. 生成 320 行模拟销售数据，日期覆盖 2025 年 1 月至 12 月。
5. 使用 pandas 计算核心指标和分组聚合结果。
6. 使用 matplotlib 生成 4 张中文图表。
7. 生成经营分析报告样例和运行结果记录。
8. 基于 4 张图表和 2 张报告展示图，使用 ffmpeg 生成字幕版演示视频。

## 3. 工具调用记录

| 步骤 | 工具/模块 | 输入 | 输出 | 说明 |
| --- | --- | --- | --- | --- |
| 1 | 数据生成脚本 | 地区、客户类型、商品类别、月份权重、毛利率规则 | `sample-sales-data.csv` | 生成模拟经营数据，不使用真实企业数据。 |
| 2 | pandas | 模拟销售数据 CSV | 月度、地区、品类、客户类型聚合结果 | 计算销售额、订单数、客单价、加权毛利率。 |
| 3 | matplotlib | 聚合指标 | 4 张 PNG 图表 | 生成趋势、地区、品类、客户类型图表。 |
| 4 | 报告生成逻辑 | 指标和图表路径 | `business-data-analysis-report.md` | 输出 Markdown 经营分析报告样例。 |
| 5 | ffmpeg 剪辑脚本 | 图表截图、报告展示图、字幕文件 | `business-data-analysis-agent-demo.mp4` | 生成静音字幕版演示视频。 |
| 6 | `get_basic_metadata` | 底层工程 CSV 数据 | 行列数、字段、类型 | 多 Agent 原型 数据探查工具，代码中已实现。 |
| 7 | `assess_data_quality` | 底层工程 CSV 数据 | 缺失率、异常值、有效性 | 多 Agent 原型 数据质量工具，代码中已实现。 |
| 8 | `get_statistical_summary` | 数值字段 | 统计摘要 | 多 Agent 原型 统计摘要工具，代码中已实现。 |
| 9 | `DataCleaningTool` | Excel JSON | 清洗后 JSON | Notebook 原型 工具，代码中已实现。 |
| 10 | `DataStatisticsTool` | 清洗后 JSON | 描述性统计 | Notebook 原型 工具，代码中已实现，但需要补注册后再完整验证。 |

## 4. 示例输出

已生成：

- [sample-sales-data.csv](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/business-data-analysis-agent/sample-sales-data.csv)
- [business-data-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/business-data-analysis-agent/business-data-analysis-report.md)
- [business-data-analysis-run-result.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/business-data-analysis-agent/business-data-analysis-run-result.md)
- [01-sales-trend.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/01-sales-trend.png)
- [02-region-comparison.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/02-region-comparison.png)
- [03-category-contribution.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/03-category-contribution.png)
- [04-customer-type-analysis.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/04-customer-type-analysis.png)
- [05-report-overview.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/final/05-report-overview.png)
- [06-business-insights.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/final/06-business-insights.png)
- [business-data-analysis-agent-demo.mp4](/Users/wangyu/Documents/agent-portfolio-cases/assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4)

报告包含：

1. 分析目标
2. 数据概览
3. 核心指标
4. 月度销售趋势
5. 地区销售表现
6. 商品类别贡献
7. 客户类型差异
8. 毛利率分析
9. 经营问题识别
10. 经营建议
11. 人工复核说明
12. 后续可扩展方向

## 5. 人工复核结论

当前结论：

- 两个底层工程适合合并包装成一个“企业经营数据分析 Agent”案例。
- `多 Agent 原型` 更适合展示多 Agent 分工和 Plan-and-Solve 思路。
- `Notebook 原型` 更适合展示 Notebook 表格分析、ECharts 和 Markdown 报告输出。
- 本阶段生成的模拟数据、图表和报告适合作为第一版展示材料。
- 字幕版演示视频已经完成，展示模拟数据、核心指标、销售趋势、地区表现、品类贡献、客户类型差异和经营建议。
- 当前正式展示以模拟数据、图表、报告和最终视频为准，不写成真实企业数据端到端交付。
- Notebook 原型 中存在硬编码模型环境变量配置，不适合直接录屏展示。

## 6. 边界说明

1. 底层工程端到端 LLM 运行验证未纳入正式展示范围。
2. `多 Agent 原型` 分析函数与固定购物行为数据集绑定，迁移到企业经营数据需要字段映射。
3. `Notebook 原型` Notebook 需要清理硬编码模型配置。
4. `Notebook 原型` Notebook 需要确认 `DataStatisticsTool` 是否注册到工具表。
5. 当前报告基于模拟数据，不代表真实经营结论。
6. 当前视频为静态图表 + 报告展示图剪辑，不展示底层工程 Notebook 或主程序的实时执行过程。

## 7. 可改进方向

1. 将模拟销售数据接入底层工程 Agent 流水线，完成真实端到端运行验证。
2. 增加通用字段映射，让 Agent 可处理不同 CSV / Excel 表格。
3. 增加同比、环比、目标达成率、回款率和续费率等经营指标。
4. 增加图表自动选择和报告模板配置。
5. 增加人工复核表，检查数据口径、统计公式和结论边界。
6. 将 Notebook 原型封装为命令行或轻量 Web 展示入口。
7. 后续可补充真实端到端运行录屏，但必须先清理 Notebook 硬编码配置并脱敏数据。

## 8. 演示材料路径

- 模拟销售数据：`assets/reports/business-data-analysis-agent/sample-sales-data.csv`
- 经营分析报告：`assets/reports/business-data-analysis-agent/business-data-analysis-report.md`
- 运行结果记录：`assets/reports/business-data-analysis-agent/business-data-analysis-run-result.md`
- 图表目录：`assets/screenshots/business-data-analysis-agent/raw/`
- 报告展示图：`assets/screenshots/business-data-analysis-agent/final/05-report-overview.png`、`assets/screenshots/business-data-analysis-agent/final/06-business-insights.png`
- 演示视频：`assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`
