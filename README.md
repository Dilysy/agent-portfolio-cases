# Agent 作品集案例集

## 项目定位

本仓库是企业知识工作流 Agent 落地案例集，用于求职作品集和轻量级接单展示。案例均基于本地 `~/Documents/hello-agents` 中的开源项目复现、理解和改造整理，不写成真实客户交付项目，不虚构企业名称、客户结果、上线效果或生产部署。

## 案例总览

| 案例 | 参考项目 | 解决的问题 | Agent 与工具设计 | 当前产出 |
| --- | --- | --- | --- | --- |
| [智能竞品分析 Agent](cases/competitor-analysis-agent/README.md) | `czxgg0630-ProductAnalysisAgent` | 竞品信息收集慢、对比维度不统一、报告整理成本高 | SimpleAgent 与 PlanAndSolveAgent；Tavily Search、结构化解析、Markdown 报告生成 | Notebook 示例、`outputs/demo_result_*.md`、架构评估记录 |
| [企业经营数据分析 Agent](cases/business-data-analysis-agent/README.md) | `alexrunner-DataAnalysisAgent`、`1zrj-DataAnalysisAgent` | 表格数据分析门槛高、图表和报告生成耗时 | Plan-and-Solve + ReAct 多智能体流水线；SimpleAgent 表格清洗与统计；pandas、matplotlib、ECharts | Markdown 报告、图表路径、Notebook 和 Python 主程序 |
| [AutoFlow 流程图生成 Agent](cases/autoflow-agent/README.md) | `usernamedadad-AutoFlow` | 自然语言转 Mermaid 成本高、流程缺少可视反馈 | FastAPI + React/Vite；SimpleAgent 生成 Mermaid；Validator 校验与修复；SSE 流式返回 | 已完成字幕版演示视频、四模式截图、实时预览、`.mmd`/SVG 导出 |
| [自动化深度研究 Agent](cases/deep-research-agent/README.md) | `docs/chapter14/` | 研究任务信息发散、来源分散、总结难追溯 | TODO Planner、Task Summarizer、Report Writer；SearchTool、NoteTool；FastAPI + Vue + SSE 方案 | 教程级架构、流程说明、可复现方向 |
| [自然语言数据库查询 Agent](cases/database-query-agent/README.md) | `939147533-DatabaseAgent` | 非技术用户难以直接编写 SQL 查询数据库 | ReAct Agent；GetSchema、GenerateSQL、ExecuteQuery；Oracle 连接与只读 SQL 校验 | 命令行交互、测试 SQL 脚本、查询结果表格化输出 |

## 技术能力地图

- Agent 编排：SimpleAgent、ReAct、Plan-and-Solve、多阶段研究流水线。
- 工具调用：搜索、网页信息提取、数据探查、统计分析、图表生成、Mermaid 校验、SQL 生成与执行。
- 结构化输出：Markdown 报告、对比矩阵、图表引用、Mermaid 流程图、SQL 查询结果表格。
- 工程化封装：Notebook 原型、Python CLI、FastAPI 后端、React/Vite 或 Vue 前端、SSE 流式状态。
- 评估意识：工具链有效性、规划质量、数据口径、SQL 安全、Mermaid 可渲染性、人工复核清单。

## 重点案例

### 智能竞品分析 Agent

该案例对比了 SimpleAgent 和 PlanAndSolveAgent 两种范式。SimpleAgent 适合作为快速调试脚手架；Plan-and-Solve 将竞品分析拆成规划、搜索、结构化解析和报告生成，执行过程更白盒。原项目记录了工具链评估：搜索工具已接入 Tavily，数据处理和报告工具在 PlanSolve 版本中升级为基于结构化数据输出。

### 企业经营数据分析 Agent

该案例融合两个数据分析项目：一个采用 Plan-and-Solve + ReAct，把数据探查、任务规划、任务执行和报告生成拆开；另一个使用 SimpleAgent 和 Notebook 完成 Excel 数据清洗、统计、ECharts 图表和 Markdown 报告生成。作品集版本重点展示“从表格到报告”的自动化链路，而不是声称接入真实企业数据。

### AutoFlow 流程图生成 Agent

该案例是前后端分离应用，包含计划模式、灵感模式、标准模式和 Mermaid 代码模式。后端通过 HelloAgents 构建 Mermaid 生成 Agent，并用 MermaidValidatorTool 做结构校验和有限修复；前端提供实时渲染、方向切换、缩放、拖拽和导出能力。当前已完成字幕版演示视频，可用于展示本地复现、LLM 接入、四模式验证和导出链路。

- 演示视频：[autoflow-agent-demo.mp4](/Users/wangyu/Documents/agent-portfolio-cases/assets/demos/autoflow-agent/autoflow-agent-demo.mp4)
- 关键截图：[standard-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/standard-mode.png)、[inspiration-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/inspiration-mode.png)、[plan-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/plan-mode.png)、[code-mode.png](/Users/wangyu/Documents/agent-portfolio-cases/assets/screenshots/autoflow-agent/raw/code-mode.png)

## 演示材料

- AutoFlow：已完成字幕版演示视频 `assets/demos/autoflow-agent/autoflow-agent-demo.mp4`，并整理四模式截图到 `assets/screenshots/autoflow-agent/raw/`。
- 截图：其他案例仍需继续整理正式展示截图。
- 架构图：计划放置在 `assets/architecture/`，当前尚未补充。
- 录屏或交互演示：AutoFlow 已完成，其他案例仍需补充。
- 报告样例：计划从源项目输出中筛选后放置在 `assets/reports/`，当前尚未补充。

以上材料在生成和整理前均不写成已完成交付。

## 项目文档

- [案例制作 SOP](docs/case-production-sop.md)

## 后续计划

1. 将 5 个案例整理为统一可运行入口或最小复现脚本。
2. 为每个案例补充固定示例输入、输出和人工复核表。
3. 整理截图、架构图和报告样例，放入 `assets/`。
4. 建立统一评估清单，覆盖事实一致性、工具调用有效性和输出可复核性。
5. 提炼 PDF 作品集和简历话术，保持克制，不写真实客户交付。
