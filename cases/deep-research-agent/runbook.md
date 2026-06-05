# 自动化深度研究 Agent 本地化运行验证步骤

## 环境准备

- Python 3.10+
- Node.js 16+ 或更高
- npm 8+ 或更高
- 工程方案材料：`~/Documents/hello-agents/docs/chapter14/`

## 依赖安装

chapter14 描述的目标项目结构为 `helloagents-deepresearch/backend` 和 `helloagents-deepresearch/frontend`。如果按章节搭建：

```bash
cd helloagents-deepresearch/backend
uv sync
```

或：

```bash
pip install -e .
```

前端：

```bash
cd helloagents-deepresearch/frontend
npm install
```

## 配置说明

后端需要配置 `.env`，至少包括：

- `LLM_PROVIDER`
- `LLM_API_KEY`
- `SEARCH_API`

搜索后端可按章节方案选择 DuckDuckGo、Tavily 等。

## 启动方式

后端：

```bash
cd helloagents-deepresearch/backend
python src/main.py
```

前端：

```bash
cd helloagents-deepresearch/frontend
npm run dev
```

章节示例中的前端默认地址为：

```text
http://localhost:5174
```

## 示例运行

在前端输入研究主题，例如 `Datawhale 是一个什么样的组织？`，系统应展示任务列表、进度日志和最终 Markdown 报告。当前作品集未直接包含该完整应用源码，因此此 runbook 记录的是工程方案的本地化运行验证路径。

## 常见问题

- 搜索 API 不可用：切换搜索后端或降低结果数量。
- 报告缺少来源：检查 Task Summarizer 是否保留 URL 和摘要。
- 研究主题过大：要求 Planner 将主题限制为 3-5 个子任务。
- SSE 中断：检查后端日志、浏览器网络面板和代理配置。
