# 自动化深度研究 Agent 本地化运行验证步骤

## 1. 项目来源

完整工程代码路径：

```text
~/Documents/hello-agents/code/chapter14/helloagents-deepresearch
```

讲解文档路径：

```text
~/Documents/hello-agents/docs/chapter14/第十四章 自动化深度研究智能体.md
```

## 2. 项目定位

该工程是一个自动化深度研究助手，面向开放研究主题，通过多阶段 Agent 协作完成任务拆解、搜索、摘要、笔记记录和报告生成。当前已确认代码目录存在，且包含完整后端、前端和 Agent 服务结构。

当前状态：已完成工程结构评估、依赖安装、基础导入检查和真实运行验证。LLM、Tavily、任务拆解、搜索、笔记、阶段总结和最终 Report Writer 均已跑通，已生成真实运行报告。

## 3. 前后端结构

```text
helloagents-deepresearch/
├── backend/
│   ├── .env.example
│   ├── pyproject.toml
│   ├── uv.lock
│   └── src/
│       ├── agent.py
│       ├── config.py
│       ├── main.py
│       ├── models.py
│       ├── prompts.py
│       ├── utils.py
│       └── services/
│           ├── planner.py
│           ├── reporter.py
│           ├── search.py
│           ├── summarizer.py
│           └── tool_events.py
└── frontend/
    ├── package.json
    ├── vite.config.ts
    └── src/
        ├── App.vue
        ├── main.ts
        ├── services/api.ts
        └── style.css
```

## 4. 环境准备

后端要求 Python 3.10+。本机系统默认 `python3` 为 3.8.7，不满足要求；本次使用 Codex 自带 Python 3.12.13 创建虚拟环境：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch
/Users/wangyu/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3 -m venv backend/.venv
backend/.venv/bin/python -m pip install --upgrade pip
```

前端环境：

```text
Node.js v25.8.0
npm 11.11.0
```

## 5. 依赖安装

原项目 `pyproject.toml` 声明后端依赖，但 `pip install -e backend` 当前会失败，原因是打包配置将包目录解析为不存在的 `src/src`，同时 `backend/README.md` 缺失。为避免修改原项目代码，本次按依赖列表直接安装运行依赖：

```bash
backend/.venv/bin/python -m pip install \
  'fastapi>=0.115.0' \
  'hello-agents==0.2.9' \
  'tavily-python>=0.5.0' \
  'python-dotenv==1.0.1' \
  'requests>=2.31.0' \
  'openai>=1.12.0' \
  'uvicorn[standard]>=0.32.0' \
  'ddgs>=9.6.1' \
  'loguru>=0.7.3'
```

导入检查时 `hello-agents` 触发附加依赖缺失，已补充：

```bash
backend/.venv/bin/python -m pip install huggingface_hub
```

前端依赖：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch/frontend
npm install
npm run build
```

前端 build 已通过。`npm audit` 当前提示 8 个依赖漏洞，本阶段未自动升级，后续可在不影响演示的前提下单独处理。

## 6. 环境变量配置

只读取 `.env.example` 和代码中的变量名，不读取真实 `.env`。

项目根目录只有 `backend/` 和 `frontend/`，没有根目录 `.env.example`。原因是该工程采用前后端分离配置：后端读取 Python 运行环境变量，前端只读取 Vite 暴露给浏览器的变量。因此配置样例分别放在：

```text
backend/.env.example
frontend/.env.example
```

用户需要手动复制：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch/backend
cp .env.example .env
```

如需覆盖前端后端地址，再复制：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch/frontend
cp .env.example .env
```

真实 `.env`、`.env.local` 和其他 `.env.*` 文件不允许提交。当前已在 `backend/.gitignore` 和 `frontend/.gitignore` 中忽略真实环境文件，并保留 `.env.example` 可提交。检查时发现 `frontend/.env.local` 已存在且曾被 Git 跟踪，本次只将其从 Git 索引移除，文件仍保留在本地，未读取其内容。

后端 `.env.example` 字段说明：

```text
SEARCH_API=
LLM_PROVIDER=
LLM_MODEL_ID=
LLM_API_KEY=
LLM_BASE_URL=
LLM_TIMEOUT=
HOST=
PORT=
CORS_ORIGINS=
LOG_LEVEL=
TAVILY_API_KEY=
PERPLEXITY_API_KEY=
SEARXNG_URL=
LOCAL_LLM=
LMSTUDIO_BASE_URL=
OLLAMA_BASE_URL=
MAX_WEB_RESEARCH_LOOPS=
FETCH_FULL_PAGE=
ENABLE_NOTES=
NOTES_WORKSPACE=
STRIP_THINKING_TOKENS=
USE_TOOL_CALLING=
```

推荐配置方式：

- 使用 OpenAI-compatible 服务时，配置 `LLM_PROVIDER=custom`、`LLM_MODEL_ID`、`LLM_API_KEY`、`LLM_BASE_URL`。
- 使用 Tavily 搜索时，配置 `SEARCH_API=tavily` 和 `TAVILY_API_KEY`。
- 使用 DuckDuckGo 搜索时，可配置 `SEARCH_API=duckduckgo`，通常不需要搜索 API Key，但可用性取决于网络环境。
- `SEARCH_API_KEY` 没有在当前工程代码中被读取，不建议写入。

前端 `.env.example` 字段说明：

```text
VITE_API_BASE_URL=
```

前端代码实际只读取 `VITE_API_BASE_URL`。如果不配置，默认请求 `http://localhost:8000`。当前代码没有读取 `VITE_API_URL` 或 `API_BASE_URL`。

## 7. 后端启动方式

建议在原项目根目录启动：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch
PYTHONPATH=backend/src backend/.venv/bin/python backend/src/main.py
```

也可使用 Uvicorn：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch
PYTHONPATH=backend/src backend/.venv/bin/uvicorn main:app --app-dir backend/src --host 0.0.0.0 --port 8000 --reload
```

健康检查地址：

```text
http://localhost:8000/healthz
```

研究接口：

```text
POST http://localhost:8000/research
POST http://localhost:8000/research/stream
```

其中 `/research/stream` 返回 `text/event-stream`，用于前端实时展示研究过程。

## 8. 前端启动方式

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch/frontend
npm run dev
```

前端默认访问地址：

```text
http://localhost:5174
```

如果后端不是默认地址，可在前端环境中配置：

```text
VITE_API_BASE_URL=http://localhost:8000
```

## 9. 示例运行方式

计划演示主题：

```text
企业如何落地 AI Agent 应用
```

真实运行验证结果：

1. 后端已启动并通过 `/healthz` 检查。
2. 前端已启动，地址为 `http://localhost:5174/`。
3. `/research/stream` 已返回 SSE 事件。
4. TODO Planner 已生成 3 个研究任务。
5. Tavily 已返回 3 组公开来源。
6. NoteTool 已创建和更新任务笔记。
7. Task Summarizer 已生成 3 个阶段总结。
8. Report Writer 已生成最终研究报告。
9. SSE 已返回 `final_report` 和 `done`。

## 10. 当前复现状态

已完成：

- 找到完整工程代码。
- 确认后端 FastAPI 入口、SSE 接口和 Agent 服务结构。
- 确认前端 Vue 入口和流式 API 调用。
- 创建后端虚拟环境。
- 安装后端运行依赖。
- 安装前端依赖。
- 前端 `npm run build` 通过。
- 后端导入检查通过，并确认路由包含 `/healthz`、`/research`、`/research/stream`。
- 后端真实启动成功。
- 前端真实启动成功，地址为 `http://localhost:5174/`。
- `/healthz` 返回 `{"status":"ok"}`。
- `/research/stream` 能够返回 SSE 流式事件。
- LLM 调用成功，已验证 TODO Planner、Task Summarizer 和 Report Writer。
- Tavily 调用成功，3 个子任务均返回搜索来源。
- NoteTool 成功创建和更新任务笔记。
- 3 个任务的阶段总结均已生成。
- 最终研究报告已生成。

未完成：

- 未读取真实 `.env`。
- 未截图、未录屏、未剪辑视频。

## 11. 已知问题和修复记录

1. 本机系统默认 `python3` 是 3.8.7，低于项目要求；已改用 Codex Python 3.12.13。
2. `pip install -e backend` 失败，原因是 `pyproject.toml` 包目录配置解析为 `src/src`，且 `backend/README.md` 缺失；本阶段未修改原项目代码，改为直接安装依赖。
3. `hello-agents==0.2.9` 导入链需要 `huggingface_hub`，已单独安装。
4. 后端导入时提示 Tavily / SerpApi Key 未设置；这属于外部搜索配置未完成，不是代码导入失败。
5. 前端 `npm audit` 提示 8 个漏洞，未自动升级依赖。
6. 代码原先没有在入口自动加载 `.env`，直接执行 `backend/src/main.py` 时容易回落到默认本地 LLM 配置；已在原项目 `backend/src/main.py` 中补充启动时加载 `backend/.env`，且加载发生在本地 Agent 模块导入之前。
7. `.env` 中若存在空字符串形式的可选字段，会导致配置解析失败；本次通过启动命令临时覆盖非密钥默认值。
8. 修复前真实运行验证中，Planner、Tavily、NoteTool 和 Summarizer 已跑通，但 Report Writer 因 LLM 请求超时未完成。
9. 已修复 Report Writer 超时问题：提高 LLM timeout，限制任务数和搜索来源，压缩传入 Report Writer 的上下文，并移除最终报告阶段的笔记读取。
10. 修复后真实运行验证已返回 `final_report` 和 `done`，最终报告保存到 `assets/reports/deep-research-agent/deep-research-report.md`。
11. 2026-06-08 排查前端 `LLM调用失败: Connection error.`：原因是后端直接启动时未正确加载 `backend/.env`，导致 LLM 配置回落到默认本地模型地址；已修复加载路径和加载顺序。
12. 修复 `.env` 加载后，`/healthz` 正常，`/research/stream` 能接收请求；当前 LLM 健康检查返回 HTTP 403，错误摘要为模型服务账户余额不足，需人工检查 `LLM_API_KEY` 对应账户额度或更换可用模型账号。
13. 2026-06-08 排查前端“最新来源”和“任务总结”为空：后端可返回 `sources`，前端也能解析当前来源格式；主要问题是失败任务没有携带已收集的 `sources_summary` / 部分 `summary`，前端也没有专门处理 `failed` 状态。已补充后端失败事件字段、前端失败状态展示和失败原因提示。
14. 当客户端请求超时或浏览器断开时，后端 generator 清理阶段可能出现 `cannot join current thread`；已修复为清理线程时跳过当前线程。
15. 2026-06-08 排查仍使用 DuckDuckGo：原配置默认搜索后端为 `duckduckgo`，仅配置 `TAVILY_API_KEY` 不会自动选择 Tavily；已修复为未显式设置 `SEARCH_API` 且存在 Tavily Key 时自动推断 `search_api=tavily`。同时建议 `.env` 中明确写入 `SEARCH_API=tavily`。

## 13. LLM 健康检查

临时健康检查脚本位于原项目目录：

```text
/Users/wangyu/Documents/hello-agents/code/chapter14/helloagents-deepresearch/check_llm_health.py
```

运行方式：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch
backend/.venv/bin/python check_llm_health.py
```

脚本会读取后端配置并发起最小 LLM 请求：

```text
请只返回 OK
```

安全约束：

- 不打印 API Key。
- 不打印完整响应。
- 只输出是否成功、base_url/model 是否为空、HTTP 状态码或错误类型、响应耗时、返回文本前 20 个字符和错误摘要。

当前排查结果：

- `base_url` 非空。
- `model` 非空。
- HTTP 状态码为 `403`。
- 错误类型为 `PermissionDeniedError`。
- 结论：当前不是前端请求错误，也不是 `LLM_BASE_URL` 为空或 `LLM_MODEL_ID` 为空；主要需要检查模型服务账户额度、Key 对应账号状态，必要时更换 `LLM_API_KEY` 或模型服务配置。

## 14. 来源和任务总结展示检查

SSE 事件格式：

- `todo_list`：任务清单。
- `sources`：任务搜索来源，字段包含 `task_id`、`latest_sources`、`raw_context`、`backend`。
- `task_summary_chunk`：任务总结流式片段，字段包含 `task_id`、`content`。
- `task_status`：任务状态，完成时携带 `summary` 和 `sources_summary`，失败时已补充携带已有的 `summary` 和 `sources_summary`。
- `final_report`：最终报告。
- `error`：整体流程错误。
- `done`：流程完成。

本次判断：

- 搜索工具不是完全无返回，本次采样已看到 `sources`。
- 如果“最新来源”仍为空，优先确认当前选中的任务是否在搜索前失败，或前端是否仍连接旧后端进程。
- 如果“任务总结”仍为空，优先确认是否已收到 `task_summary_chunk`；短主题采样中 120 秒内未收到总结片段，说明 Summarizer 可能仍偏慢。
- 录屏时建议使用较短主题和 1 个子任务，减少等待和失败概率。

推荐录屏主题：

```text
AI Agent 在客服场景的试点路径
```

推荐录屏配置：

```text
SEARCH_API=tavily
MAX_WEB_RESEARCH_LOOPS=1
MAX_TODO_ITEMS=1
SEARCH_MAX_RESULTS=2
FETCH_FULL_PAGE=False
LLM_TIMEOUT=180
REPORT_MAX_WORDS=800
REPORT_SUMMARY_CHAR_LIMIT=600
REPORT_SOURCES_PER_TASK=2
```

## 15. Tavily 搜索后端配置

搜索后端选择规则：

- 前端若选择“沿用后端配置”，由后端 `SEARCH_API` 决定。
- 前端若显式选择 `duckduckgo`，会覆盖后端配置并使用 DuckDuckGo。
- 后端推荐配置为 `SEARCH_API=tavily`。
- 如果没有显式 `SEARCH_API`，但存在 Tavily Key，当前代码会自动推断使用 Tavily。

建议 `.env` 字段：

```text
SEARCH_API=tavily
Tavily Key：在真实 `.env` 中手动填写，不要提交。
```

注意：

- 不要只配置 Tavily Key 后继续运行旧后端进程，配置修改后必须重启后端。
- Tavily 返回的 `sources_summary` 会通过 SSE `sources` 事件进入前端“最新来源”区域。
- 如果 DuckDuckGo 返回 `No results found`，任务没有可用检索上下文，任务总结为空属于预期结果。

## 16. 下一步操作

1. 在原项目后端 `.env` 中把可选字段补为合法默认值，不要留空字符串。
2. 建议配置：
   - `SEARCH_API=tavily`
   - `MAX_WEB_RESEARCH_LOOPS=1`
   - `FETCH_FULL_PAGE=False`
   - `ENABLE_NOTES=True`
   - `STRIP_THINKING_TOKENS=True`
   - `USE_TOOL_CALLING=False`
   - `LLM_TIMEOUT=180`
   - `MAX_TODO_ITEMS=3`
   - `SEARCH_MAX_RESULTS=3`
   - `REPORT_MAX_SECTIONS=6`
   - `REPORT_MAX_WORDS=1500`
   - `REPORT_SUMMARY_CHAR_LIMIT=1200`
   - `REPORT_SOURCES_PER_TASK=3`
3. 当前需先处理 LLM 服务 HTTP 403 或模型响应过慢问题：检查 `LLM_API_KEY` 对应账户余额，必要时更换可用模型或降低任务规模。
4. 修改 `.env` 后重新启动后端，并运行 `check_llm_health.py`。
5. 健康检查成功后，使用推荐短主题进行前端验证，确认详情区能展示来源、失败原因和任务总结。
6. 前端仍显示旧状态时，重启后端和前端，确保浏览器连接的是修复后的后端进程。
7. 录屏前检查终端、浏览器、日志和页面中没有 API Key、账号或隐私信息。

## 17. 最终收尾状态

当前运行状态：完整链路已跑通。

已完成验证：

- 后端 FastAPI 服务可启动。
- 前端 Vue 3 + TypeScript + Vite 页面可启动。
- `/healthz` 健康检查通过。
- `/research/stream` SSE 流式返回可用。
- LLM 已接入并验证 TODO Planner、Task Summarizer 和 Report Writer。
- Tavily SearchTool 已接入并返回公开来源。
- NoteTool 已创建和更新任务笔记。
- 最终研究报告已生成。
- 原始录屏、关键截图、抽帧索引和演示视频已归档。

推荐启动方式：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch
PYTHONPATH=backend/src backend/.venv/bin/python backend/src/main.py
```

前端启动方式：

```bash
cd ~/Documents/hello-agents/code/chapter14/helloagents-deepresearch/frontend
npm run dev
```

推荐演示配置：

```text
SEARCH_API=tavily
MAX_WEB_RESEARCH_LOOPS=1
MAX_TODO_ITEMS=3
SEARCH_MAX_RESULTS=3
FETCH_FULL_PAGE=False
ENABLE_NOTES=True
STRIP_THINKING_TOKENS=True
USE_TOOL_CALLING=False
LLM_TIMEOUT=180
REPORT_MAX_SECTIONS=6
REPORT_MAX_WORDS=1500
REPORT_SUMMARY_CHAR_LIMIT=1200
REPORT_SOURCES_PER_TASK=3
```

搜索 Provider 配置说明：

- 推荐使用 `SEARCH_API=tavily`。
- 配置 Tavily Key 后必须重启后端。
- 如果前端搜索下拉框选择“沿用后端配置”，则以后端 `SEARCH_API` 为准。
- 如果前端显式选择 `duckduckgo`，会覆盖后端配置。

Report Writer 超时修复记录：

- 增加 `LLM_TIMEOUT`。
- 限制任务数量和每个任务的搜索来源数量。
- 压缩传入 Report Writer 的阶段总结和来源上下文。
- 移除最终报告阶段额外读取全部笔记的要求。

最终成片：

```text
assets/demos/deep-research-agent/deep-research-agent-demo.mp4
```

当前不足和后续优化：

1. `02-todo-list.png` 和 `06-completed-status.png` 两张独立截图仍待补充。
2. 当前视频不处理配音，后续可增加配音版。
3. 前端依赖的 `npm audit` 风险提示尚未单独处理。
4. 后续可增强引用编号、来源复核和导出能力。
