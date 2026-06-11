# 自动化深度研究 Agent 示例运行记录

## 1. 实际演示主题

```text
企业如何落地 AI Agent 应用
```

该主题用于验证从开放式研究输入到任务拆解、公开来源检索、阶段总结和最终报告生成的完整链路。

## 2. 实际执行过程

1. 启动后端 FastAPI 服务。
2. 启动前端 Vue 3 + TypeScript + Vite 页面。
3. 在前端输入研究主题。
4. 前端调用 `/research/stream`。
5. 后端通过 SSE 返回任务拆解、工具调用、搜索来源、任务总结和最终报告。
6. 前端实时展示任务状态、来源列表、工具调用记录和报告正文。

## 3. TODO 任务拆解结果

运行中，TODO Planner 生成了 3 个研究任务：

| 任务 | 查询 |
| --- | --- |
| 技术架构选型 | 企业AI Agent技术架构 LLM选型 开发平台 系统集成 RAG |
| 场景与价值分析 | 企业AI Agent应用场景 落地案例 ROI 行业标杆 |
| 组织治理与合规 | AI Agent企业治理 数据安全合规 组织变革 风险管控 |

## 4. 搜索来源结果

SearchTool 使用 Tavily 获取公开来源，每个子任务返回 3 条来源。来源被写入任务状态，并通过 SSE `sources` 事件进入前端“最新来源”区域。

部分来源样例：

- 技术架构选型：飞书文档 AI Agent 构建形式、LLM 模型选型、云服务智能化架构材料。
- 场景与价值分析：企业应用案例、行业场景、ROI 和落地方向相关公开资料。
- 组织治理与合规：数据安全、权限控制、治理风险和合规要求相关公开资料。

## 5. 任务总结结果

Task Summarizer 已基于每个任务的检索上下文生成阶段性总结。总结内容用于前端任务详情展示，并作为 Report Writer 的输入材料。

已验证内容：

- 任务级 Markdown 总结可以生成。
- 总结与来源、查询词和任务目标关联。
- 任务总结过程通过 SSE `task_summary_chunk` 流式返回。

## 6. 最终研究报告结果

Report Writer 已生成最终 Markdown 研究报告：

```text
assets/reports/deep-research-agent/deep-research-report.md
```

报告内容基于 Tavily 返回的公开来源和 Agent 阶段总结整理，正式使用前仍需人工复核来源准确性。

## 7. 工具调用记录

| 步骤 | 工具 / 模块 | 输入 | 输出 | 状态 |
| --- | --- | --- | --- | --- |
| 1 | TODO Planner | 研究主题、当前日期 | 3 个研究子任务 | 已成功 |
| 2 | SearchTool | 子任务 query、Tavily 后端 | 来源标题、URL、摘要 | 已成功 |
| 3 | NoteTool | 任务状态、摘要、报告内容 | 本地 Markdown 笔记 | 已成功 |
| 4 | Task Summarizer | 搜索上下文、任务意图 | 子任务 Markdown 摘要 | 已成功 |
| 5 | Report Writer | 精简任务摘要和来源 | 最终 Markdown 研究报告 | 已成功 |
| 6 | SSE 接口 | 后端事件 | status、todo_list、sources、summary chunk、final_report、done | 已成功 |

## 8. 演示材料路径

| 材料 | 路径 | 状态 |
| --- | --- | --- |
| 演示视频 | `assets/demos/deep-research-agent/deep-research-agent-demo.mp4` | 已完成 |
| 主题输入截图 | `assets/screenshots/deep-research-agent/final/01-topic-input.png` | 已完成 |
| 来源摘要截图 | `assets/screenshots/deep-research-agent/final/02-source-summary.png` | 已完成 |
| 最终报告截图 | `assets/screenshots/deep-research-agent/final/03-final-report.png` | 已完成 |
| 运行结果记录 | `assets/reports/deep-research-agent/deep-research-run-result.md` | 已完成 |

当前视频为第一版演示成片，不处理配音；字幕和配音后续可继续优化。

## 9. 边界说明

1. 公开展示截图已整理到 `assets/screenshots/deep-research-agent/final/`。
2. 为降低 Report Writer 超时概率，当前演示采用较少任务数、较少搜索来源和精简上下文。
3. 前端依赖存在 `npm audit` 风险提示，后续可单独处理。
4. 当前视频作为后续维护项配音。

## 10. 后续优化方向

1. 补充独立 TODO 列表截图和完成状态截图。
2. 优化前端报告展示的引用编号和来源复核体验。
3. 增加固定研究主题测试集和人工评分记录。
4. 后续可补充配音版本和更精细的字幕样式。
