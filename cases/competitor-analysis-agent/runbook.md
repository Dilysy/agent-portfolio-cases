# 智能竞品分析 Agent 本地运行验证步骤

## 1. 工程入口

- 工程目录：`<local-competitor-analysis-source>`
- 案例目录：`cases/competitor-analysis-agent/`
- 实现形态：Jupyter Notebook 示例项目
- 主要入口：
  - `ProductAnalysis_SimpleAgent.ipynb`
  - `ProductAnalysis_PlanSolveAgent.ipynb`

## 2. 项目定位

该项目是智能竞品分析 Agent 示例，用于展示搜索工具调用、竞品信息结构化整理、对比分析和 Markdown 报告生成。

本案例将其定位为团队知识管理工具竞品分析案例，重点展示“公开信息搜索 → 结构化字段提取 → 对比矩阵 → 销售切入建议”的工作流。该案例基于演示环境和公开信息完成验证，不代表已上线运行。

## 3. 代码结构

```text
本地竞品分析工程/
├── README.md
├── requirements.txt
├── 本地配置模板
├── ProductAnalysis_SimpleAgent.ipynb
├── ProductAnalysis_PlanSolveAgent.ipynb
└── outputs/
    ├── demo_result_20260409_134543.md
    ├── demo_result_20260409_140100.md
    └── demo_result_20260409_142128.md
```

当前未发现前端界面目录、API 服务入口或独立 CLI 脚本。项目主要通过 Notebook 运行。

## 4. 环境准备

- Python 3.10+
- Jupyter Lab 或 Jupyter Notebook
- 可访问 LLM 服务和搜索 API 的网络环境
- 推荐使用虚拟环境，避免污染全局 Python 环境

## 5. 依赖安装

```bash
cd <local-competitor-analysis-source>
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
python3 -m pip install notebook nbconvert ipykernel
python3 -m ipykernel install --user --name competitor-analysis-agent --display-name "competitor-analysis-agent"
```

主要依赖包括：

- `Agent 运行依赖>=0.2.7`
- `openai`
- `anthropic`
- `pandas`
- `numpy`
- `requests`
- `beautifulsoup4`
- `tavily-python`
- `python-dotenv`
- `pydantic`

## 6. 环境变量配置

工程目录提供本地配置模板。本案例也保留了安全示例文件：

- 工程模板：`<local-competitor-analysis-source>/本地配置模板`
- 本案例模板：`本地配置模板`

运行前需要在工程目录中创建 `本地配置文件`：

```bash
cp 本地配置模板 本地配置文件
```

运行前需要配置模型服务和公开搜索服务的本地参数。不要把真实凭据、服务地址或模型配置写入公开仓库。

OpenAI 兼容模型配置注意事项：

1. 本地凭据、服务地址和模型配置需要同时匹配当前模型服务。
2. 如果更换模型，先用最小请求验证模型可用，再运行完整竞品分析任务。
3. 不要在 Notebook、日志、报告或公开文档中输出真实本地配置。

Tavily 配置注意事项：

1. 搜索服务参数需要配置在底层工程目录的本地配置文件中。
2. 搜索结果受网络、额度、限流和查询词影响，正式展示前需要复核来源。
3. 如果搜索失败，优先检查网络、服务权限和搜索服务状态。

Notebook 中曾设置 `HTTPS_PROXY=http://127.0.0.1:8800`，该值属于本地网络环境配置，正式运行验证时应按当前机器网络情况调整或删除。

## 7. 启动方式

```bash
cd <local-competitor-analysis-source>
source .venv/bin/activate
jupyter lab
```

启动后打开：

- 快速原型：`ProductAnalysis_SimpleAgent.ipynb`
- 推荐演示：`ProductAnalysis_PlanSolveAgent.ipynb`

运行入口说明：

- 底层工程的推荐入口仍是 `ProductAnalysis_PlanSolveAgent.ipynb`。
- Notebook 原生命令行执行当前存在导入兼容问题：计划执行类名与当前安装包中的可用类名不一致，且 Notebook 引用的内置搜索工具在当前安装包中不可用。
- 本次运行验证采用独立验证入口完成 LLM 与公开搜索服务联动验证，未把验证入口作为正式案例入口展示。

## 8. 示例运行方式

推荐使用 PlanSolve 版本运行以下任务：

```text
请分析 Notion、飞书文档、语雀在团队知识管理场景下的差异，输出竞品对比表、优劣势分析和销售切入建议。
```

预期执行过程：

1. 初始化 LLM 客户端。
2. 初始化 `PlanAndSolveAgent`。
3. Planner 生成竞品分析步骤。
4. Executor 按步骤调用搜索、结构化处理和报告生成工具。
5. 结果归档到 `assets/reports/competitor-analysis-agent/competitor-analysis-report.md`。

## 9. 当前验证状态

当前运行状态：已跑通。

本阶段已完成：

- 阅读工程 README、Notebook 和输出样例。
- 梳理项目定位、代码结构、Agent 设计和工具调用。
- 为本案例补充 README、runbook、sample 和报告样例。
- 创建安全的 `本地配置模板` 示例文件。
- 更新证据清单状态。
- 使用 Python 3.12.13 创建 `.venv`，并按 `requirements.txt` 安装依赖。
- 安装 `notebook`、`nbconvert`、`ipykernel`，并注册 `competitor-analysis-agent` kernel。
- 尝试使用 PlanSolve Notebook 的 Plan-and-Solve 逻辑运行 Notion / 飞书文档 / 语雀演示任务。
- 完成 LLM 与 Tavily 搜索工具的运行验证记录。
- 使用独立验证入口完成运行：公开搜索成功、LLM 调用成功、竞品分析报告已生成。
- 基于竞品分析报告生成 HTML 预览页。
- 基于最终录屏生成字幕版演示视频。

当前仍需注意：

- 原始 Notebook 仍未直接通过 `nbconvert` 跑通，原因是搜索工具导入路径与当前安装包不兼容。
- 已完成的字幕版成片位于 `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`；原始录屏素材不纳入公开展示路径。

因此当前状态是：已完成虚拟环境、依赖安装、Notebook 命令行执行检查、独立验证入口运行、报告生成、HTML 预览和字幕版演示视频制作；公开搜索与 LLM 均已成功。该案例可以作为已完成案例展示，但 Notebook 原生运行兼容问题仍作为后续工程优化项保留。

运行验证记录：

- [competitor-analysis-run-result.md](../../assets/reports/competitor-analysis-agent/competitor-analysis-run-result.md)
- [competitor-analysis-report.md](../../assets/reports/competitor-analysis-agent/competitor-analysis-report.md)
- `assets/reports/competitor-analysis-agent/report-preview.html`
- `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4`

## 10. 已知问题

1. 当前工程依赖模型服务和公开搜索服务，未配置本地运行参数时不能完整运行。
2. 搜索接口可能受网络、代理、超时或限流影响。
3. SimpleAgent 版本的数据处理和报告生成工具偏原型演示，不适合宣传为完整工具链。
4. PlanSolve 版本虽然升级了结构化处理，但主要依赖规则和正则，复杂网页文本仍需人工复核。
5. 当前没有前端界面和 API 服务，演示素材需要录制 Notebook 运行过程或后续改造为轻量界面。
6. 当前安装包中可用类名为 `PlanSolveAgent`，Notebook 中写的是 `PlanAndSolveAgent`，需要做兼容调整。
7. 当前安装包未提供 Notebook 引用的内置搜索工具，建议改用公开搜索 SDK 封装搜索工具。
8. Notebook 通过 `nbconvert` 命令行执行时，在导入内置搜索工具的 cell 失败。
9. 最近一次验证中，公开搜索已成功，获取到 Notion、飞书文档、语雀相关公开信息。
10. 最近一次验证中，LLM 调用已成功，并生成真实 Markdown 竞品分析报告。

## 11. 下一步操作

1. 人工复核报告中的来源、价格、功能描述和建议类内容。
2. 如需继续提高展示质量，可补充更短的公开视频版本或更多精选截图。
3. 如需录制 Notebook 原生执行过程，需要先将 Notebook 中的 `SearchTool` 替换为 `tavily-python` 封装，并把 `PlanAndSolveAgent` 兼容为当前可用的 `PlanSolveAgent`。
4. 如需继续迭代，可增加配音版或更短版本；当前字幕版演示视频已完成，本阶段不处理配音。
