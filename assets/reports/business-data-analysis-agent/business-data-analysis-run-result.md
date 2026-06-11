# 企业经营数据分析 Agent 运行结果记录

## 当前状态

| 检查项 | 结果 | 说明 |
| --- | --- | --- |
| 底层工程完整运行验证 | 未完整运行 | 本阶段完成代码阅读、结构梳理和演示材料生成，未纳入正式展示范围；当前展示采用样例数据演示链路。 |
| 模拟数据生成 | 成功 | 已生成 `assets/reports/business-data-analysis-agent/sample-sales-data.csv`，共 320 行。 |
| 图表生成 | 成功 | 已生成 4 张中文图表到 `assets/screenshots/business-data-analysis-agent/raw/`。 |
| 经营分析报告生成 | 成功 | 已生成 `assets/reports/business-data-analysis-agent/business-data-analysis-report.md`。 |
| 展示材料状态 | 文档初版完成 | 当前为模拟数据 + Python 分析脚本生成的演示补充材料，待后续录屏与剪辑。 |

## 底层工程运行验证说明

- `多 Agent 经营分析原型`：项目包含 `main.py`、Plan/Analysis/Report 三段 Agent 流水线、数据探查工具和多个固定数据分析工具。需要配置 LLM 环境变量后运行 `python3 ./main.py`。
- `Notebook 表格分析原型`：项目包含 `main.ipynb`、Excel 样例数据、ECharts 输出和 Markdown 报告输出。Notebook 中存在硬编码模型环境变量，展示前必须清理或改为 `本地配置文件` 加载。

本阶段没有读取或记录真实 私密凭证，也没有执行截图、录屏或视频剪辑。

## 本阶段采用的演示补充方式

由于当前阶段目标是第一阶段文档整理和演示材料准备，且底层工程端到端运行验证未纳入正式展示范围，本次采用模拟经营数据和 Python 分析脚本生成：

1. 模拟销售数据 CSV。
2. 月度销售趋势图。
3. 地区销售额对比图。
4. 商品类别销售贡献图。
5. 客户类型销售表现图。
6. 经营数据分析报告样例。

这些材料只用于企业经营数据分析 Agent 的本地演示，不代表实际企业经营数据或实际客户结论。

## 后续如何接入真实 CSV / Excel 数据

1. 明确真实数据字段口径，例如订单日期、地区、客户类型、商品类别、销售额、订单数、毛利率。
2. 将真实 CSV / Excel 放入本地工程 `data/` 或案例约定的安全数据目录。
3. 在运行前进行脱敏，删除客户名称、联系人、邮箱、电话、合同编号和内部账号。
4. 复用当前指标逻辑，按月份、地区、商品类别和客户类型做聚合。
5. 运行 Agent 或分析脚本后，由人工复核统计公式、异常值处理和经营建议。

## 需要继续验证的问题

1. `多 Agent 原型` 端到端 LLM 运行是否能稳定返回 Python 列表格式的任务规划。
2. `Notebook 原型` Notebook 是否可以清理硬编码配置后稳定生成 ECharts 和 Markdown 报告。
3. 两个项目是否需要统一为一个可重复运行的命令行入口。

## 完成状态

已完成字幕版演示视频剪辑，成片文件为：

```text
assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4
```

当前成片基于模拟销售数据、图表截图和报告展示图生成，用于模拟数据演示，不代表真实企业经营分析交付。
