# Agent 作品集案例集

## 项目定位

本仓库是企业知识工作流 Agent 落地案例集，用于求职作品集和轻量级接单展示。案例围绕竞品分析、经营数据分析、流程图生成、深度研究和自然语言数据库查询等场景，进行自主工程化实现、能力封装、流程编排和本地化验证；不写成真实客户交付项目，不虚构企业名称、客户结果、上线效果或生产部署。

## 案例总览

| 案例 | 实现形态 | 解决的问题 | Agent 与工具设计 | 当前产出 |
| --- | --- | --- | --- | --- |
| [智能竞品分析 Agent](cases/competitor-analysis-agent/README.md) | Notebook 多工具分析链路 | 竞品信息收集慢、对比维度不统一、报告整理成本高 | 快速工具调用 Agent 与 Plan-and-Solve；Tavily Search、结构化解析、Markdown 报告生成 | 已完成本地运行验证、真实竞品报告、HTML 预览和字幕版演示视频 |
| [企业经营数据分析 Agent](cases/business-data-analysis-agent/README.md) | Python 主程序 + Notebook 分析链路 | 表格数据分析门槛高、图表和报告生成耗时 | Plan-and-Solve + ReAct 多智能体流水线；表格清洗与统计；pandas、matplotlib、ECharts | 已完成模拟销售数据、图表、经营分析报告和字幕版演示视频 |
| [AutoFlow 流程图生成 Agent](cases/autoflow-agent/README.md) | FastAPI + React/Vite 产品化界面 | 自然语言转 Mermaid 成本高、流程缺少可视反馈 | 流程图生成 Agent；Validator 校验与修复；SSE 流式返回 | 已完成字幕版演示视频、四模式截图、实时预览、`.mmd`/SVG 导出 |
| [自动化深度研究 Agent](cases/deep-research-agent/README.md) | FastAPI + Vue + SSE 研究工作流方案 | 研究任务信息发散、来源分散、总结难追溯 | TODO Planner、Task Summarizer、Report Writer；SearchTool、NoteTool；流式进度返回 | 架构方案、流程说明、可运行验证方向 |
| [自然语言数据库查询 Agent](cases/database-query-agent/README.md) | Python CLI + Oracle 查询链路 | 非技术用户难以直接编写 SQL 查询数据库 | ReAct Agent；GetSchema、GenerateSQL、ExecuteQuery；Oracle 连接与只读 SQL 校验 | 命令行交互、测试 SQL 脚本、查询结果表格化输出 |

## 技术能力地图

- Agent 编排：SimpleAgent、ReAct、Plan-and-Solve、多阶段研究流水线。
- 工具调用：搜索、网页信息提取、数据探查、统计分析、图表生成、Mermaid 校验、SQL 生成与执行。
- 结构化输出：Markdown 报告、对比矩阵、图表引用、Mermaid 流程图、SQL 查询结果表格。
- 工程化封装：Notebook 原型、Python CLI、FastAPI 后端、React/Vite 或 Vue 前端、SSE 流式状态。
- 评估意识：工具链有效性、规划质量、数据口径、SQL 安全、Mermaid 可渲染性、人工复核清单。

## 重点案例

### 智能竞品分析 Agent

该案例对比了快速工具调用 Agent 和 Plan-and-Solve 两种范式。快速工具调用链路适合作为调试脚手架；Plan-and-Solve 将竞品分析拆成规划、搜索、结构化解析和报告生成，执行过程更白盒。智能竞品分析 Agent 已完成本地运行验证，支持通过 LLM 与 Tavily 搜索获取公开信息，并生成竞品对比、优劣势分析和销售切入建议。

- 演示视频：[competitor-analysis-agent-demo.mp4](/Users/wangyu/Documents/agent-portfolio-cases/assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4)
- HTML 预览：[report-preview.html](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/report-preview.html)
- 运行报告：[competitor-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-report.md)

### 企业经营数据分析 Agent

该案例融合两个数据分析项目：一个采用 Plan-and-Solve + ReAct，把数据探查、任务规划、任务执行和报告生成拆开；另一个使用 SimpleAgent 和 Notebook 完成 Excel 数据清洗、统计、ECharts 图表和 Markdown 报告生成。企业经营数据分析 Agent 已完成模拟销售数据分析演示，支持销售趋势、地区表现、商品类别贡献、客户类型差异和经营建议输出。

- 演示视频：[business-data-analysis-agent-demo.mp4](/Users/wangyu/Documents/agent-portfolio-cases/assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4)
- 经营分析报告：[business-data-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/business-data-analysis-agent/business-data-analysis-report.md)
- 关键图表：[01-sales-trend.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/01-sales-trend.png)、[02-region-comparison.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/02-region-comparison.png)、[03-category-contribution.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/03-category-contribution.png)、[04-customer-type-analysis.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/business-data-analysis-agent/raw/04-customer-type-analysis.png)

### AutoFlow 流程图生成 Agent

该案例是前后端分离应用，包含计划模式、灵感模式、标准模式和 Mermaid 代码模式。后端封装 Mermaid 生成 Agent，并用 MermaidValidatorTool 做结构校验和有限修复；前端提供实时渲染、方向切换、缩放、拖拽和导出能力。当前已完成字幕版演示视频，可用于展示 LLM 接入、四模式验证、本地化运行验证和导出链路。

- 演示视频：[autoflow-agent-demo.mp4](/Users/wangyu/Documents/agent-portfolio-cases/assets/demos/autoflow-agent/autoflow-agent-demo.mp4)
- 关键截图：[standard-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/standard-mode.png)、[inspiration-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/inspiration-mode.png)、[plan-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/plan-mode.png)、[code-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/code-mode.png)

## 演示材料

- AutoFlow：已完成字幕版演示视频 `assets/demos/autoflow-agent/autoflow-agent-demo.mp4`，并整理四模式截图到 `assets/screenshots/autoflow-agent/raw/`。
- 智能竞品分析 Agent：已完成字幕版演示视频 `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`，并整理真实运行报告与 HTML 预览到 `assets/reports/competitor-analysis-agent/`。
- 企业经营数据分析 Agent：已完成字幕版演示视频 `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`，并整理模拟销售数据、4 张图表和经营分析报告到 `assets/reports/business-data-analysis-agent/` 与 `assets/screenshots/business-data-analysis-agent/`。
- 截图：其余案例仍需继续整理正式展示截图。
- 架构图：计划放置在 `assets/architecture/`，当前尚未补充。
- 录屏或交互演示：AutoFlow、智能竞品分析 Agent 和企业经营数据分析 Agent 已完成，其他案例仍需补充。
- 报告样例：AutoFlow、智能竞品分析 Agent 和企业经营数据分析 Agent 已补充，其他案例后续继续整理到 `assets/reports/`。

以上材料在生成和整理前均不写成已完成交付。

## 项目文档

- [案例制作 SOP](docs/case-production-sop.md)

## 后续计划

1. 将 5 个案例整理为统一可运行入口或最小验证脚本。
2. 为每个案例补充固定示例输入、输出和人工复核表。
3. 整理截图、架构图和报告样例，放入 `assets/`。
4. 建立统一评估清单，覆盖事实一致性、工具调用有效性和输出可复核性。
5. 提炼 PDF 作品集和简历话术，保持克制，不写真实客户交付。

## 依赖与合规说明

项目开发过程中使用了若干开源框架、模型接口和第三方工具库，相关依赖按其原始许可证要求保留必要声明。仓库中的案例实现重点面向企业知识工作流场景进行工程化封装、流程编排和应用验证。
