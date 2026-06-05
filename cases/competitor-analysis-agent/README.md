# 智能竞品分析 Agent

## 1. 项目背景

本案例围绕团队知识管理产品竞品分析场景进行工程化封装和流程编排整理，通过两个 Jupyter Notebook 展示快速工具调用 Agent 和 `PlanAndSolveAgent` 两种范式。

本作品集将其包装为“团队知识管理产品竞品分析”的企业知识工作流 Agent 案例，用于展示从业务问题输入、公开信息搜索、结构化整理到 Markdown 报告生成的自动化链路。该案例仅作为场景化构建和本地化运行验证展示，不写成真实客户交付项目。

## 2. 业务问题

产品、销售或市场团队在做竞品分析时，通常会遇到以下问题：

1. 竞品信息分散在官网、帮助中心、媒体报道和公开资料中，人工检索耗时。
2. 不同产品的定位、功能、协作能力、知识库能力和价格口径不统一，难以横向比较。
3. 从资料收集到报告整理存在大量重复劳动，输出格式不稳定。
4. 分析结论容易缺少来源复核，正式使用前需要人工校验。

## 3. 解决方案

Agent 接收竞品分析任务后，将用户输入拆解为竞品对象和分析维度，随后调用搜索工具获取公开信息，再通过数据处理工具抽取产品定位、核心功能、价格策略、优势和短板等字段，最后生成 Markdown 竞品分析报告。

作品集版本采用以下展示口径：

- `SimpleAgent` 适合作为快速原型和工具调用演示。
- `PlanAndSolveAgent` 更适合复杂竞品分析，因为它会先规划步骤，再逐步执行搜索、整理、对比和报告生成。
- 当前已通过临时本地验证脚本完成 LLM 与 Tavily 联动验证，并生成真实竞品分析报告。正式使用时仍必须对指定来源进行人工复核。

## 4. Agent 设计

| 设计点 | 当前实现 | 说明 |
| --- | --- | --- |
| SimpleAgent | 已包含 | 使用单轨/ReAct 风格工具调用，直接根据用户问题选择搜索、处理和报告工具。 |
| Plan-and-Solve | 已包含 | 使用 `PlanAndSolveAgent`，通过 Planner 生成步骤列表，再由 Executor 逐步执行。 |
| 任务拆解 | 已包含 | PlanSolve Notebook 中将竞品名称确认、逐个搜索、对比分析和报告生成拆成独立步骤。 |
| 搜索工具调用 | 已包含 | `CompetitiveInfoSearchTool` 封装 Tavily 搜索后端。 |
| 网页内容抽取 | 部分包含 | 当前实现依赖搜索工具返回的公开搜索片段，未单独实现完整网页正文抓取和引用管理。 |
| 内容清洗 | 部分包含 | SimpleAgent 版本为 PoC 占位；PlanSolve 版本 v2.0 使用规则和正则抽取结构化字段。 |
| 竞品对比分析 | 已包含 | 报告生成阶段输出对比矩阵、优势短板和建议。 |
| 报告生成 | 已包含 | `ReportGeneratorTool` 输出 Markdown 报告；PlanSolve 版本基于结构化字段渲染。 |

需要注意：SimpleAgent Notebook 中的 `DataProcessorTool` 和 `ReportGeneratorTool` 早期实现是固定字符串返回，不能夸大为完整数据处理能力。PlanSolve Notebook 已升级为 v2.0，但结构化抽取主要依赖规则和正则，正式使用仍需要来源引用、事实校验和人工复核。

## 5. 工具调用

| 工具名称 | 输入 | 输出 | 作用 | 当前可用状态 |
| --- | --- | --- | --- | --- |
| LLM 客户端 | 用户任务、系统提示词、工具执行上下文 | Agent 推理结果、工具调用决策 | 驱动 Agent 理解任务、规划步骤和生成文本 | 已完成本地化运行验证，需配置 LLM API Key 与模型参数 |
| `PlanAndSolveAgent` | 竞品分析问题、自定义 Planner/Executor 提示词 | 分步骤计划、逐步执行结果、最终报告 | 负责复杂任务拆解和执行编排 | Notebook 中已实现；原生命令行执行仍有导入兼容问题 |
| `SimpleAgent` | 竞品分析问题、工具列表、系统提示词 | 工具调用过程和分析结果 | 快速验证搜索与报告生成流程 | Notebook 中已实现，适合作为原型演示 |
| `CompetitiveInfoSearchTool` | 单个产品名称 | Tavily 搜索结果或失败提示 | 查询产品功能、定价、优缺点等公开信息 | 已完成 Tavily 搜索验证，需配置 `TAVILY_API_KEY` 和可用网络 |
| `DataProcessorTool` | 搜索返回文本 | 产品名称、定位、功能、定价、优势、劣势等结构化字段 | 清洗和结构化竞品信息 | PlanSolve v2.0 可用；SimpleAgent 版本为 PoC 占位 |
| `ReportGeneratorTool` | 结构化产品字段列表 | Markdown 竞品分析报告 | 生成对比表、分析结论和建议 | PlanSolve v2.0 可用；正式使用需人工复核 |
| 输出保存逻辑 | Agent 最终报告 | `outputs/demo_result_*.md` | 保存示例报告，便于归档和复盘 | 已有输出样例 |

## 6. 实现流程

1. 在工程目录安装依赖，并复制 `.env.example` 为 `.env`。
2. 配置 LLM API Key、模型、Base URL 和 Tavily API Key。
3. 通过 `jupyter lab` 打开 Notebook。
4. 优先运行 `ProductAnalysis_PlanSolveAgent.ipynb`，观察计划生成和逐步执行过程。
5. 输入竞品分析任务，例如“分析 Notion、飞书文档、语雀在团队知识管理场景下的差异”。
6. Agent 调用搜索工具获取公开信息，数据处理工具抽取结构化字段。
7. 报告生成工具输出 Markdown 报告，并保存到 `outputs/`。
8. 人工复核来源、事实口径、建议合理性和是否存在敏感信息。

## 7. 输出结果

本阶段已完成一次本地化运行验证，LLM 与 Tavily 均调用成功，并生成真实运行报告：

- [competitor-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-report.md)
- [competitor-analysis-run-result.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md)

该报告使用任务：

```text
请分析 Notion、飞书文档、语雀在团队知识管理场景下的差异，输出竞品对比表、优劣势分析和销售切入建议。
```

报告已调用 Tavily 搜索和 LLM 生成，用于说明 Agent 输出结构和案例包装方式。正式对外展示前仍需要结合指定来源复核，尤其是价格、套餐、AI 功能和企业版权限等易变化信息。

## 8. 评估方式

- 工具链有效性：检查搜索工具是否真正返回公开信息，数据处理工具是否消费搜索结果。
- 结构完整度：检查报告是否包含分析目标、竞品对象、定位对比、功能对比、协作能力、知识库能力、价格模式、优劣势和建议。
- 事实一致性：人工复核官网、帮助中心、价格页或公开资料，避免过期信息。
- 可追溯性：后续应补充来源链接、引用编号和检索时间。
- 风险检查：确认输出中没有 API Key、账号、邮箱、微信、浏览器隐私页或真实客户信息。

## 9. 可扩展方向

1. 后续可扩展 DuckDuckGo、SerpAPI 等多搜索后端，降低单一搜索 API 依赖。
2. 后续可加入搜索缓存、超时控制和重试机制，提升运行稳定性。
3. 后续可将规则抽取升级为 JSON Schema 约束的 LLM 结构化抽取。
4. 后续可加入来源引用、事实冲突检测和人工复核表。
5. 后续可增加图表输出，例如功能雷达图、价格对比表和销售切入优先级矩阵。

## 10. 演示材料

- 演示视频：已完成字幕版成片，路径为 `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`。
- 原始录屏：标准归档目录 `assets/demos/competitor-analysis-agent/raw/` 当前待补充；本次使用的桌面原始录屏位于 `/Users/wangyu/Desktop/案例视频录制/智能竞品分析 Agent /智能竞品.mov`。
- HTML 报告预览：已补充到 `assets/reports/competitor-analysis-agent/report-preview.html`。
- 竞品分析报告：已补充到 [competitor-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-report.md)。
- 运行验证结果：已补充到 [competitor-analysis-run-result.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md)。
- 素材清单：已补充到 `assets/reports/competitor-analysis-agent/raw-assets-inventory.md`。
