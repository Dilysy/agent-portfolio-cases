# 自动化深度研究 Agent

## 1. 项目背景

本案例面向企业知识密集型研究任务，完成 `helloagents-deepresearch` 完整工程的本地化运行验证。用户输入开放式研究主题后，系统通过任务规划、公开资料检索、阶段总结、笔记沉淀和报告生成，把一次深度研究拆成可追踪的多阶段 Agent 工作流。

本案例不写成真实客户交付，展示重点是完整工程复现、LLM 接入、搜索工具接入、SSE 流式返回和多 Agent 协作链路。

## 2. 业务问题

深度研究任务通常存在以下问题：

1. 研究主题开放，人工需要反复拆解问题和搜索关键词。
2. 搜索结果分散，来源多、事实更新快，容易遗漏关键材料。
3. 信息需要去重、摘要、引用和结构化组织，整理成本高。
4. 最终报告需要保留来源和过程记录，不能只依赖模型自由生成。

## 3. 解决方案

工程采用前后端分离架构：

- 后端为 FastAPI + HelloAgents，提供 `/healthz`、`/research` 和 `/research/stream`。
- 前端为 Vue 3 + TypeScript + Vite，负责输入主题、展示任务清单、来源、工具调用和最终报告。
- Agent 层包含 TODO Planner、Task Summarizer 和 Report Writer。
- 工具层包含 SearchTool 和 NoteTool，用于公开资料检索与阶段性笔记记录。
- `/research/stream` 通过 SSE 将任务拆解、搜索来源、总结片段、工具调用和最终报告流式推送到前端。

## 4. Agent 设计

| 设计点 | 工程实现 | 当前状态 |
| --- | --- | --- |
| TODO Planner | `PlanningService` 调用研究规划 Agent，将开放主题拆成 TODO | 已验证 |
| SearchTool | 根据子任务 query 调用 Tavily 获取公开来源 | 已验证 |
| NoteTool | 记录任务笔记、工具调用和最终报告 | 已验证 |
| Task Summarizer | 基于搜索上下文生成阶段性 Markdown 总结 | 已验证 |
| Report Writer | 汇总任务总结和来源，生成最终研究报告 | 已验证 |
| SSE 流式输出 | `/research/stream` 推送 status、todo_list、sources、summary chunk、final_report、done | 已验证 |

## 5. 工具调用

| 工具名称 | 输入 | 输出 | 作用 | 当前可用状态 |
| --- | --- | --- | --- | --- |
| TODO Planner | 研究主题、当前日期 | 子任务列表，含 title / intent / query | 将开放主题拆为可执行研究任务 | 已验证 |
| SearchTool | 子任务 query、Tavily 后端、max_results | 标题、URL、摘要和来源内容 | 获取公开资料并保留来源 | 已验证 |
| NoteTool | 任务状态、摘要、报告内容 | 本地 Markdown 笔记 | 记录研究过程和报告结果 | 已验证 |
| Task Summarizer | 子任务信息、搜索上下文 | 子任务 Markdown 摘要 | 压缩搜索结果，形成阶段性结论 | 已验证 |
| Report Writer | 研究主题、任务摘要、来源概览 | 最终 Markdown 研究报告 | 汇总研究结论和参考来源 | 已验证 |
| FastAPI SSE | 研究请求 topic / search_api | text/event-stream 事件 | 实时推送进度和报告 | 已验证 |
| Vue 前端 | SSE 事件 | 任务列表、来源、总结、报告展示 | 提供可录屏演示界面 | 已验证 |

## 6. 实现流程

1. 用户在前端输入研究主题。
2. 前端向后端 `/research/stream` 发送 POST 请求。
3. 后端创建 `DeepResearchAgent` 和研究状态。
4. TODO Planner 生成子任务列表。
5. 每个子任务通过 SearchTool 获取公开信息。
6. Task Summarizer 基于检索上下文生成阶段总结。
7. NoteTool 记录任务笔记、来源和报告内容。
8. Report Writer 汇总全部任务生成 Markdown 报告。
9. 后端通过 SSE 推送状态、来源、总结片段和最终报告。
10. 前端展示任务进度、工具调用、来源列表和报告正文。

## 7. 输出结果

已完成输出：

- 完整工程复现：后端和前端均可运行。
- 后端接口：已验证 `/healthz`、`/research`、`/research/stream`。
- LLM 接入：TODO Planner、Task Summarizer、Report Writer 均已验证。
- 搜索工具接入：Tavily SearchTool 已验证。
- 笔记工具：NoteTool 已验证。
- 最终研究报告：`assets/reports/deep-research-agent/deep-research-report.md`。
- 原始录屏与关键截图：已归档到 `assets/demos/deep-research-agent/raw/` 与 `assets/screenshots/deep-research-agent/raw/`。
- 演示视频：`assets/demos/deep-research-agent/deep-research-agent-demo.mp4`。

## 8. 评估方式

- 工程可运行性：后端能否启动，前端能否访问，SSE 是否稳定返回事件。
- 规划质量：TODO 是否覆盖主题关键方面，查询是否具体可执行。
- 搜索质量：来源是否可靠、可访问、去重充分。
- 摘要质量：是否忠于来源，是否保留关键事实、时间和引用。
- 报告质量：结构是否清晰，是否区分事实、推断和建议。
- 可追溯性：观点是否能回到来源、任务总结或笔记记录。
- 安全性：录屏、日志和页面中不得出现 API Key、账号或隐私信息。

## 9. 可扩展方向

1. 增加来源可达性检查和引用编号。
2. 增加搜索缓存，降低重复查询成本。
3. 增加固定研究主题测试集和人工评分表。
4. 扩展企业内部知识库、文档库或数据库检索工具。
5. 增加中断恢复、任务重试和报告导出能力。
6. 后续可补充配音和更精细的字幕样式。

## 10. 演示材料

| 材料 | 路径 | 状态 |
| --- | --- | --- |
| 演示视频 | `assets/demos/deep-research-agent/deep-research-agent-demo.mp4` | 已完成 |
| 原始录屏 | `assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov` | 已归档 |
| 主题输入 / 总视图截图 | `assets/screenshots/deep-research-agent/raw/01-topic-input.png` | 已归档 |
| TODO 列表截图 | `assets/screenshots/deep-research-agent/raw/02-todo-list.png` | 待补充 |
| 搜索来源截图 | `assets/screenshots/deep-research-agent/raw/03-search-sources.png` | 已归档 |
| 任务总结截图 | `assets/screenshots/deep-research-agent/raw/04-task-summary.png` | 已归档 |
| 最终报告截图 | `assets/screenshots/deep-research-agent/raw/05-final-report.png` | 已归档 |
| 完成状态截图 | `assets/screenshots/deep-research-agent/raw/06-completed-status.png` | 待补充 |
| 运行验证结果 | `assets/reports/deep-research-agent/deep-research-run-result.md` | 已完成 |
| 最终研究报告 | `assets/reports/deep-research-agent/deep-research-report.md` | 已完成 |
| 素材清单 | `assets/reports/deep-research-agent/raw-assets-inventory.md` | 已完成 |
| 抽帧索引 | `assets/reports/deep-research-agent/frame-preview-index.md` | 已完成 |

当前演示视频为第一版视频成片，不处理配音；字幕和配音后续可继续优化。
