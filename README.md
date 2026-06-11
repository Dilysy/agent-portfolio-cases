# 企业级 Agent 应用案例集

## 项目定位

本仓库沉淀了一组面向企业知识工作流的 Agent 落地案例，覆盖流程生成、市场与竞品分析、经营数据分析、自然语言数据库查询、代码审查、深度研究、科研辅助和公开信息分析等典型场景。每个案例均围绕明确业务问题展开，包含场景背景、Agent 工作流设计、工具调用方式、样例输出、运行记录和演示视频，用于呈现从业务需求到可运行智能体方案的完整实现过程。

这些案例主要面向企业内部知识处理、信息分析、数据查询、辅助决策和效率提升场景，强调 Agent 在任务拆解、外部工具调用、多源信息整合、结构化输出和人工复核闭环中的应用价值。案例均基于公开信息、本地样例数据或演示环境完成验证，不涉及未授权企业内部数据，不声明已上线运行；涉及金融分析、代码审查、科研辅助等场景时，输出结果均需结合人工判断后使用。

## 在线展示

为便于快速查看各案例的运行效果，本仓库提供了在线展示页面，集中呈现各 Agent 案例的演示视频、场景简介和能力标签。

👉 [查看在线演示页面](https://dilysy.github.io/agent-portfolio-cases/)

在线展示页面基于 GitHub Pages 发布。

如需了解每个案例的设计说明、样例输出和运行记录，可继续浏览下方案例目录。

## 案例总览

| 案例 | 场景 | 实现形态 | 核心能力 | 当前状态 |
| --- | --- | --- | --- | --- |
| [AutoFlow 流程图生成 Agent](cases/autoflow-agent/README.md) | 自然语言生成流程图 | FastAPI + React/Vite | Mermaid 生成、结构校验、实时预览、导出 | 已完成 |
| [智能竞品分析 Agent](cases/competitor-analysis-agent/README.md) | 公开竞品信息分析 | Notebook + 多工具分析链路 | 搜索、结构化对比、报告生成 | 已完成 |
| [企业经营数据分析 Agent](cases/business-data-analysis-agent/README.md) | 销售与经营数据分析 | Python + Notebook 分析链路 | 数据清洗、统计分析、图表和报告 | 已完成 |
| [自动化深度研究 Agent](cases/deep-research-agent/README.md) | 主题研究和报告生成 | FastAPI + Vue + SSE | 任务拆解、搜索、笔记、阶段总结、最终报告 | 已完成 |
| [自然语言数据库查询 Agent](cases/database-query-agent/README.md) | Text-to-SQL 查询演示 | Python CLI + 本地演示 Schema | Schema 理解、SQL 生成、只读查询、安全边界 | 已完成 |
| [智能股票分析助手 Agent](cases/stock-insight-agent/README.md) | 公开股票信息分析 | Gradio Web 应用 | 公开行情查询、技术指标、风险因素归纳 | 已完成 |
| [代码审查 Agent](cases/code-review-agent/README.md) | 本地代码审查 | Python CLI | 代码理解、问题识别、风险分级、修复建议 | 已完成 |
| [科研创新助手 Agent](cases/research-innovation-agent/README.md) | 科研辅助工作流 | FastAPI + Web 前端 | 论文搜索、论文分析、写作辅助、引用校验 | 已完成 |

## Agent 能力路径

- 任务理解与规划：将自然语言目标拆解为可执行步骤、查询条件或分析子任务。
- 工具调用：调用搜索、数据处理、图表生成、SQL 生成、代码审查、论文检索等工具。
- 结构化输出：生成 Markdown 报告、对比表、SQL 示例、Mermaid 流程图、审查清单和研究摘要。
- 过程可视化：通过 Web 前端、CLI、HTML 预览、截图和演示视频展示关键链路。
- 评估与边界：记录数据口径、工具有效性、安全限制、人工复核点和可扩展方向。

## 落地案例总览

### AutoFlow 流程图生成 Agent

面向业务流程梳理场景，将自然语言描述转为 Mermaid 流程图，并提供四种交互模式、实时预览和导出能力。

- 案例文档：[README](cases/autoflow-agent/README.md)
- 示例记录：[sample.md](cases/autoflow-agent/sample.md)
- 运行说明：[runbook.md](cases/autoflow-agent/runbook.md)

### 智能竞品分析 Agent

面向公开竞品调研场景，完成信息搜索、结构化解析、竞品对比和报告生成。

- 案例文档：[README](cases/competitor-analysis-agent/README.md)
- 示例记录：[sample.md](cases/competitor-analysis-agent/sample.md)
- 运行说明：[runbook.md](cases/competitor-analysis-agent/runbook.md)

### 企业经营数据分析 Agent

面向经营分析和销售复盘场景，使用本地模拟销售数据生成趋势图、地区对比、品类贡献和经营分析报告。

- 案例文档：[README](cases/business-data-analysis-agent/README.md)
- 示例记录：[sample.md](cases/business-data-analysis-agent/sample.md)
- 运行说明：[runbook.md](cases/business-data-analysis-agent/runbook.md)

### 自动化深度研究 Agent

面向开放主题研究场景，完成任务拆解、公开来源检索、阶段总结和最终研究报告生成。

- 案例文档：[README](cases/deep-research-agent/README.md)
- 示例记录：[sample.md](cases/deep-research-agent/sample.md)
- 运行说明：[runbook.md](cases/deep-research-agent/runbook.md)

### 自然语言数据库查询 Agent

面向业务人员查询数据场景，基于本地演示 Schema 展示自然语言到 SQL、查询结果和安全控制说明。

- 案例文档：[README](cases/database-query-agent/README.md)
- 示例记录：[sample.md](cases/database-query-agent/sample.md)
- 运行说明：[runbook.md](cases/database-query-agent/runbook.md)

### 智能股票分析助手 Agent

面向公开股票信息整理场景，展示公开行情查询、技术指标计算和主要风险因素归纳。输出仅用于流程演示，不构成投资建议。

- 案例文档：[README](cases/stock-insight-agent/README.md)
- 示例记录：[sample.md](cases/stock-insight-agent/sample.md)
- 运行说明：[runbook.md](cases/stock-insight-agent/runbook.md)

### 代码审查 Agent

面向本地代码审查场景，展示代码理解、问题定位、风险分级、修复建议和审查报告生成。

- 案例文档：[README](cases/code-review-agent/README.md)
- 示例记录：[sample.md](cases/code-review-agent/sample.md)
- 运行说明：[runbook.md](cases/code-review-agent/runbook.md)

### 科研创新助手 Agent

面向科研辅助工作流，展示论文搜索、论文分析、写作辅助、引用校验和综述样例生成。结果仍需人工复核。

- 案例文档：[README](cases/research-innovation-agent/README.md)
- 示例记录：[sample.md](cases/research-innovation-agent/sample.md)
- 运行说明：[runbook.md](cases/research-innovation-agent/runbook.md)

## 演示视频入口

所有案例演示视频已集中整理到在线展示页面，可直接在网页中播放，无需逐个打开仓库中的 MP4 文件。

- 在线演示页面：[https://dilysy.github.io/agent-portfolio-cases/](https://dilysy.github.io/agent-portfolio-cases/)
- 视频素材目录：`assets/demos/`
- 每个案例目录下仍保留对应的设计说明、样例输出和运行记录。

GitHub 仓库中的 MP4 文件在文件预览页可能受浏览器或平台加载策略影响，建议优先通过在线展示页面查看。

## 本地运行说明

每个案例目录均包含独立运行说明：

```text
cases/<case-name>/README.md
cases/<case-name>/sample.md
cases/<case-name>/runbook.md
```

建议阅读顺序：

1. 先阅读案例 `README.md`，理解场景、Agent 设计、工具调用和边界。
2. 再阅读 `sample.md`，查看示例输入、输出结果和人工复核点。
3. 如需本地验证，按 `runbook.md` 执行依赖安装、启动和 smoke test。

真实私密配置只应保存在本地配置文件中，不应提交到仓库、日志、截图或录屏。

## 仓库目录说明

```text
README.md
.gitignore
index.html
styles.css

cases/
  autoflow-agent/
  business-data-analysis-agent/
  code-review-agent/
  competitor-analysis-agent/
  database-query-agent/
  deep-research-agent/
  research-innovation-agent/
  stock-insight-agent/

assets/
  demos/
  reports/
  screenshots/
  architecture/

docs/
  index.html
  styles.css
```

根目录：

- `README.md`：仓库首页说明，包含项目定位、案例总览、在线展示入口、目录说明和边界说明。
- `.gitignore`：忽略本地配置、内部工作文件、过程素材和临时构建文件。
- `index.html`：在线展示页面入口。
- `styles.css`：在线展示页面样式。

`cases/` 存放各 Agent 案例的文字说明与运行记录。每个案例目录通常包含：

- `README.md`：案例背景、业务问题、方案设计、Agent 工作流和输出结果说明。
- `sample.md`：样例输入、样例输出和关键结果记录。
- `runbook.md`：本地运行验证过程、运行边界和复核说明。

正式案例目录包括：

- `cases/autoflow-agent/`
- `cases/competitor-analysis-agent/`
- `cases/business-data-analysis-agent/`
- `cases/deep-research-agent/`
- `cases/database-query-agent/`
- `cases/stock-insight-agent/`
- `cases/code-review-agent/`
- `cases/research-innovation-agent/`

`assets/` 存放公开展示所需的演示视频、报告预览、截图和架构素材：

- `assets/demos/`：存放各案例最终演示视频。公开仓库中仅保留对外展示用的最终 demo MP4。
- `assets/reports/`：存放案例报告、运行结果和 HTML 预览页面，用于展示结构化输出结果。
- `assets/screenshots/`：存放各案例精选截图。公开仓库中优先保留 `final/` 下的正式展示截图。
- `assets/architecture/`：用于后续补充正式架构图和流程图素材。

`docs/` 保留在线展示页面的镜像文件：

- `docs/index.html`：在线展示页面镜像入口。
- `docs/styles.css`：在线展示页面镜像样式。

本地制作过程中使用的内部指令、制作脚本、原始素材、过程检查和临时构建文件不纳入公开仓库，仅保留正式案例文档、最终演示视频、报告预览和精选截图。

## 安全与边界说明

- 本仓库不包含实际客户项目记录，不声明已上线运行。
- 企业经营数据分析使用本地样例数据，不代表真实企业经营结果。
- 自然语言数据库查询使用本地演示 Schema，不连接真实企业数据库。
- 智能股票分析助手仅用于公开信息分析流程演示，不构成投资建议、证券研究报告或交易依据。
- 科研创新助手生成的研究摘要、引用校验和写作建议仍需人工复核。
- 代码审查 Agent 输出用于辅助定位风险，正式修复前仍需人工确认、测试和评审。
- 演示材料发布前应复核是否包含账号、私密配置、浏览器隐私页或未授权数据。

## 后续扩展方向

1. 统一各案例的运行入口、配置方式和文档结构，提升整体可维护性。
2. 补充关键场景的架构图和流程说明，增强案例表达的完整性。
3. 增加自动化敏感信息扫描和素材发布前检查脚本，降低公开展示前的安全风险。
4. 持续扩展更多企业知识处理场景，形成更完整的 Agent 应用案例矩阵。
