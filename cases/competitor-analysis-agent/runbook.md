# 智能竞品分析 Agent 本地复现步骤

## 环境准备

- Python 3.10+
- Jupyter Lab 或 Notebook
- 可访问 Tavily 和 LLM 服务的网络环境
- 本地参考目录：`~/Documents/hello-agents/Co-creation-projects/czxgg0630-ProductAnalysisAgent`

## 依赖安装

```bash
cd ~/Documents/hello-agents/Co-creation-projects/czxgg0630-ProductAnalysisAgent
pip install -r requirements.txt
```

主要依赖包括 `hello-agents[all]`、`openai`、`anthropic`、`pandas`、`requests`、`beautifulsoup4`、`tavily-python`、`python-dotenv`。

## 配置说明

```bash
cp .env.example .env
```

需要配置 LLM API Key 和 Tavily API Key。不同模型服务可通过 HelloAgents 兼容配置接入。

## 启动方式

```bash
jupyter lab
```

打开以下任一 Notebook：

- `ProductAnalysis_SimpleAgent.ipynb`
- `ProductAnalysis_PlanSolveAgent.ipynb`

## 示例运行

推荐先运行 PlanSolve 版本，观察“生成计划、逐步执行、保存报告”的完整链路。运行完成后查看：

```bash
ls outputs/
```

示例输出为 `demo_result_*.md`。

## 常见问题

- Tavily 超时或限流：记录为外部服务问题，可重试或后续接入 DuckDuckGo。
- LLM 响应慢：Notebook 同步执行会表现为卡顿，需要增加超时控制或异步化。
- 搜索结果无法结构化：保留原始文本和失败原因，不强行生成确定结论。
