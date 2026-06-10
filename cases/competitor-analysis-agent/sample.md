# 智能竞品分析 Agent 示例运行记录

## 1. 示例输入

```text
请分析 Notion、飞书文档、语雀在团队知识管理场景下的差异，输出竞品对比表、优劣势分析和销售切入建议。
```

示例场景：产品或销售团队希望快速了解三类团队知识管理工具的定位差异、协作能力、知识库能力和销售切入点，为后续方案准备提供初步材料。

## 2. 执行过程

本阶段已尝试运行 PlanSolve Notebook 的 Plan-and-Solve 逻辑。Notebook 原生命令行执行仍有导入兼容问题，因此本次真实验证采用临时本地验证脚本完成 LLM + Tavily 联动。以下为本次实际验证过程：

1. 检查系统默认 Python，发现为 Python 3.8.7，低于项目要求。
2. 使用 Python 3.12.13 创建 `.venv`。
3. 按 `requirements.txt` 安装依赖，主依赖安装完成。
4. 检查 PlanSolve Notebook，确认推荐入口是 `ProductAnalysis_PlanSolveAgent.ipynb`。
5. 发现当前安装包中可用类名为 `PlanSolveAgent`，Notebook 中的 `PlanAndSolveAgent` 需要兼容调整。
6. 发现当前安装包未提供 Notebook 引用的内置 `SearchTool` 模块，因此改用 `tavily-python` 做搜索烟测。
7. 安装 `notebook`、`nbconvert`、`ipykernel`，并注册 `competitor-analysis-agent` kernel。
8. 使用 `nbconvert` 执行 `ProductAnalysis_PlanSolveAgent.ipynb`，在导入 `hello_agents.tools.builtin.search_tool.SearchTool` 时失败。
9. 使用临时本地验证脚本运行 Notion / 飞书文档 / 语雀任务。
10. Tavily 搜索调用成功，获取到 Notion、飞书文档、语雀相关公开信息。
11. LLM 调用成功，基于搜索结果生成 Markdown 竞品分析报告。
12. 真实运行结果已写入 `assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md` 和 `assets/reports/competitor-analysis-agent/competitor-analysis-report.md`。

## 3. 工具调用记录

| 步骤 | 工具 | 输入 | 输出 | 说明 |
| --- | --- | --- | --- | --- |
| 1 | Tavily 搜索 | Notion / 飞书文档 / 语雀相关查询 | 成功获取公开信息 | 共获取 15 条搜索结果。 |
| 2 | LLM 调用 | 搜索结果 + 竞品分析任务 | 成功生成 Markdown 报告 | 报告包含定位对比、功能对比、知识库能力、价格模式、优劣势和销售切入建议。 |
| 3 | 临时本地验证脚本 | Tavily 结果 + LLM 输出 | 写入运行记录和报告文件 | 用于规避 Notebook 搜索工具导入不兼容问题。 |
| 4 | 人工复核 | 真实运行报告 | 待复核 | 正式展示前需核对来源、价格、功能和建议口径。 |

## 4. 示例输出

已整理本次真实运行输出：

- [competitor-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-report.md)
- [competitor-analysis-run-result.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md)

真实竞品分析报告包含：

1. 分析目标
2. 竞品对象
3. 信息来源说明
4. 产品定位对比
5. 核心功能对比
6. 协作能力对比
7. 知识库能力对比
8. 价格与商业模式对比
9. 优势与短板分析
10. 销售切入建议
11. 人工复核说明
12. 后续可扩展方向

`competitor-analysis-report.md` 为本次真实运行生成的 Markdown 报告，正式展示前仍需人工复核来源、价格和功能口径。`competitor-analysis-run-result.md` 记录了搜索来源、运行入口和 Notebook 兼容性说明。HTML 预览页已生成到 `assets/reports/competitor-analysis-agent/report-preview.html`，字幕版演示视频已生成到 `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`。

## 5. 人工复核结论

当前结论：

- 文档结构适合作为竞品分析 Agent 的作品集样例。
- 报告样例可以展示“输入任务 → 分析维度 → 对比表 → 建议”的输出形态。
- 本次已成功调用 Tavily 搜索工具，并获取公开信息。
- 本次已成功调用 LLM，并生成真实联网竞品分析报告。
- 虚拟环境、依赖安装、Jupyter kernel 注册已经完成。
- 原始 Notebook 仍存在搜索工具导入不兼容问题，因此本次真实运行使用临时本地验证脚本完成。
- 正式对外展示前，需要人工核对 Notion、飞书文档、语雀官网、帮助中心、价格页和公开资料。

## 6. 边界说明

1. 原始 Notebook 不能直接通过 `nbconvert` 执行，需要修复搜索工具导入路径。
2. 搜索来源已归档，但部分来源为第三方文章，正式展示前需要优先复核官网和价格页。
3. 价格与套餐信息变化较快，需要正式展示前重新核对。
4. 当前没有前端界面，后续录屏可能需要展示 VS Code 中的运行记录和报告文件，或改造轻量演示入口。
5. SimpleAgent 版本工具链存在 PoC 占位，展示时应优先使用真实运行报告或兼容后的 PlanSolve 版本。
6. 当前字幕版演示视频展示的是报告预览页和结果链路，不展示 Notebook 原生执行过程。

## 7. 可改进方向

1. 接入真实搜索后，将来源链接写入报告脚注。
2. 增加“事实复核表”，标注每个结论的来源和可信度。
3. 将 `DataProcessorTool` 升级为 JSON Schema 约束的 LLM 结构化抽取。
4. 增加缓存和重试，降低 Tavily 或 LLM 超时影响。
5. 后续可修复 Notebook 原生导入兼容问题，录制更完整的执行过程。
6. 后续可补充配音版或更短版本，但当前字幕版视频已满足作品集演示需要。

## 8. 演示材料路径

- 真实竞品分析报告：[competitor-analysis-report.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-report.md)
- 运行验证记录：[competitor-analysis-run-result.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md)
- HTML 预览页：`assets/reports/competitor-analysis-agent/report-preview.html`
- 字幕版演示视频：`assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`
- 原始录屏：最终展示以字幕版 demo MP4 和素材清单为准，桌面录屏路径不进入对外文档。
- 输出样例：已整理到作品集报告目录。
