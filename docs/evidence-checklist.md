# Evidence Checklist

## AutoFlow 流程图生成 Agent

| 材料 | 当前状态 | 说明 |
| --- | --- | --- |
| 字幕版演示视频 | 已完成 | `assets/demos/autoflow-agent/autoflow-agent-demo.mp4`，用于作品集展示。 |
| 截图 | 已完成 | `assets/screenshots/autoflow-agent/raw/` 下已归档灵感模式、标准模式、计划模式和 Mermaid 代码模式截图。 |
| 抽帧复核 | 已完成 | `assets/reports/autoflow-agent/frame-preview-index.md` 记录了原始视频抽帧判断和建议剪辑时间段。 |
| Mermaid 示例 | 已完成 | `assets/reports/autoflow-agent/` 下保留四模式 Mermaid 记录和测试总表。 |

## 智能竞品分析 Agent

| 材料 | 当前状态 | 说明 |
| --- | --- | --- |
| README | 已完成 | `cases/competitor-analysis-agent/README.md` 已整理项目定位、Agent 设计、工具调用、输出结果、评估方式和演示材料。 |
| runbook | 已完成 | `cases/competitor-analysis-agent/runbook.md` 已记录正确运行目录、虚拟环境、依赖安装、模型配置、Tavily 配置、运行入口和已知问题。 |
| sample | 已完成 | `cases/competitor-analysis-agent/sample.md` 已记录实际演示任务、执行过程、工具调用、输出结果和演示材料路径。 |
| 运行验证 | 已完成 | LLM 与 Tavily 均已调用成功，真实运行记录见 `assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md`。 |
| 输出报告 | 已完成 | 已生成真实竞品分析报告 `assets/reports/competitor-analysis-agent/competitor-analysis-report.md`。 |
| HTML 预览 | 已完成 | 已生成报告预览页 `assets/reports/competitor-analysis-agent/report-preview.html`。 |
| 原始录屏 | 已完成 | 桌面原始录屏已扫描并记录到 `assets/reports/competitor-analysis-agent/raw-assets-inventory.md`；标准 raw 归档目录当前待补充。 |
| 演示视频 | 已完成 | 已完成字幕版演示视频 `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`。 |
| 环境变量样例 | 已完成 | `cases/competitor-analysis-agent/.env.example` 仅包含占位符，不包含真实密钥。 |

当前状态：已完成。

## 企业经营数据分析 Agent

| 材料 | 当前状态 | 说明 |
| --- | --- | --- |
| README | 已完成 | `cases/business-data-analysis-agent/README.md` 已整理项目定位、Agent 设计、工具调用、输出结果、评估方式和演示材料。 |
| runbook | 已完成 | `cases/business-data-analysis-agent/runbook.md` 已记录模拟数据、图表、报告和视频生成方式，以及后续真实数据替换方式。 |
| sample | 已完成 | `cases/business-data-analysis-agent/sample.md` 已记录实际演示输入、模拟数据说明、图表生成结果、报告结果和演示视频路径。 |
| 模拟销售数据 | 已完成 | 已生成 `assets/reports/business-data-analysis-agent/sample-sales-data.csv`，共 320 行，覆盖 2025 年 1 月至 12 月。 |
| 图表 | 已完成 | 已生成 4 张中文图表到 `assets/screenshots/business-data-analysis-agent/raw/`。 |
| 经营分析报告 | 已完成 | 已生成 `assets/reports/business-data-analysis-agent/business-data-analysis-report.md`，明确标注基于模拟数据。 |
| 报告展示图 | 已完成 | 已生成 `assets/screenshots/business-data-analysis-agent/final/05-report-overview.png` 和 `assets/screenshots/business-data-analysis-agent/final/06-business-insights.png`。 |
| 运行结果记录 | 已完成 | 已生成 `assets/reports/business-data-analysis-agent/business-data-analysis-run-result.md`。 |
| 演示视频 | 已完成 | 已生成字幕版演示视频 `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`。 |
| 原项目运行验证 | 待运行验证 | 两个原项目尚未完成端到端 LLM 运行验证；当前采用模拟数据 + Python 分析脚本作为演示补充。 |

当前状态：已完成。

## 自动化深度研究 Agent

| 材料 | 当前状态 | 说明 |
| --- | --- | --- |
| README | 已完成 | `cases/deep-research-agent/README.md` 已更新为完整工程复现和演示材料口径。 |
| runbook | 已完成 | `cases/deep-research-agent/runbook.md` 已记录环境配置、启动方式、搜索 Provider、SSE 验证和修复记录。 |
| sample | 已完成 | `cases/deep-research-agent/sample.md` 已记录实际演示主题、任务拆解、搜索来源、任务总结和报告结果。 |
| 完整工程复现 | 已完成 | 已找到并验证 `~/Documents/hello-agents/code/chapter14/helloagents-deepresearch`，包含 `backend/` 和 `frontend/`。 |
| LLM 接入 | 已完成 | 已验证 TODO Planner、Task Summarizer 和 Report Writer 的 LLM 调用链路。 |
| 搜索工具接入 | 已完成 | 已验证 Tavily SearchTool 返回公开来源。 |
| SSE 流式返回 | 已完成 | `/research/stream` 已返回 status、todo_list、sources、task_summary_chunk、final_report 和 done。 |
| TODO Planner | 已完成 | 已生成研究任务拆解。 |
| SearchTool | 已完成 | 已返回搜索来源并进入前端来源区域。 |
| NoteTool | 已完成 | 已创建和更新任务笔记。 |
| Task Summarizer | 已完成 | 已生成阶段性任务总结。 |
| Report Writer | 已完成 | 已生成最终研究报告。 |
| 原始录屏 | 已完成 | 已归档 `assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov`。 |
| 关键截图 | 已完成 | 已归档 `01-topic-input.png`、`03-search-sources.png`、`04-task-summary.png`、`05-final-report.png`；`02` 和 `06` 独立截图待补充。 |
| 演示视频 | 已完成 | 已生成 `assets/demos/deep-research-agent/deep-research-agent-demo.mp4`。 |
| 最终研究报告 | 已完成 | 已生成 `assets/reports/deep-research-agent/deep-research-report.md`。 |

当前状态：已完成。

## 复核要求

- 截图和录屏素材进入作品集前，必须检查页面中是否出现 API Key、账号、微信、邮箱、桌面隐私或浏览器私人页面。
- 当前正式演示视频只作为工程化演示和本地化运行验证案例展示，不写成真实客户交付项目。
- 废弃目录中的素材仅用于临时追溯，不进入正式作品集展示。
