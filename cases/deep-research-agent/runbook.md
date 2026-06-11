# 自动化深度研究 Agent 本地运行验证步骤

## 1. 工程入口

- 本地工程目录：`<local-deep-research-source>`
- 案例目录：`cases/deep-research-agent/`
- 展示素材目录：`assets/reports/deep-research-agent/`

## 2. 项目定位

该工程是一个自动化深度研究助手，面向开放研究主题，通过多阶段 Agent 协作完成任务拆解、搜索、摘要、笔记记录和报告生成。当前已确认代码目录存在，且包含完整后端、前端和 Agent 服务结构。

当前状态：已完成工程结构评估、依赖安装、基础导入检查和运行验证。LLM、公开搜索、任务拆解、搜索、笔记、阶段总结和最终 Report Writer 均已完成验证，已生成运行报告。

## 3. 前后端结构

```text
本地深度研究工程/
├── backend/
│   ├── 本地配置模板
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

后端要求 Python 3.10+。如果本机默认 `python3` 版本过低，需改用可用的 Python 3.10+ 创建虚拟环境：

```bash
cd <local-deep-research-source>
python3 -m venv backend/.venv
backend/.venv/bin/python -m pip install --upgrade pip
```

前端环境：

```text
Node.js v25.8.0
npm 11.11.0
```

## 5. 依赖安装

底层工程声明了后端依赖，但本次验证中可编辑安装路径存在包目录解析问题。为避免修改底层工程代码，本次按依赖列表直接安装运行依赖：

```bash
backend/.venv/bin/python -m pip install \
  'fastapi>=0.115.0' \
  '<agent-runtime-dependency>' \
  'tavily-python>=0.5.0' \
  'python-dotenv==1.0.1' \
  'requests>=2.31.0' \
  'openai>=1.12.0' \
  'uvicorn[standard]>=0.32.0' \
  'ddgs>=9.6.1' \
  'loguru>=0.7.3'
```

导入检查时 Agent 运行依赖触发附加依赖缺失，已补充：

```bash
backend/.venv/bin/python -m pip install huggingface_hub
```

前端依赖：

```bash
cd <local-deep-research-source>/frontend
npm install
npm run build
```

前端 build 已通过。`npm audit` 当前提示 8 个依赖漏洞，本阶段未自动升级，后续可在不影响演示的前提下单独处理。

## 6. 环境变量配置

只读取 `本地配置模板` 和代码中的变量名，不读取真实 `本地配置文件`。

项目根目录只有 `backend/` 和 `frontend/`，没有根目录 `本地配置模板`。原因是该工程采用前后端分离配置：后端读取 Python 运行环境变量，前端只读取 Vite 暴露给浏览器的变量。因此配置样例分别放在：

```text
backend/本地配置模板
frontend/本地配置模板
```

用户需要手动复制：

```bash
cd <local-deep-research-source>/backend
cp 本地配置模板 本地配置文件
```

如需覆盖前端后端地址，再复制：

```bash
cd <local-deep-research-source>/frontend
cp 本地配置模板 本地配置文件
```

本地配置文件不允许提交。当前已在后端和前端忽略真实环境文件，并保留配置模板可提交。检查时只确认配置文件的存在性和 Git 跟踪状态，不读取其内容。

后端 `本地配置模板` 字段说明：

```text
模型服务参数=
搜索服务参数=
前端服务参数=
运行控制参数=
HOST=
PORT=
CORS_ORIGINS=
LOG_LEVEL=
模型服务配置=
搜索服务配置=
SEARXNG_URL=
LOCAL_LLM=
LMSTUDIO_BASE_URL=
OLLAMA_BASE_URL=
MAX_WEB_RESEARCH_LOOPS=
FETCH_FULL_PAGE=
ENABLE_NOTES=
NOTES_WORKSPACE=
运行控制配置=
USE_TOOL_CALLING=
```

推荐配置方式：

- 使用兼容模型服务时，在本地配置文件中填写模型服务参数。
- 使用公开搜索服务时，在本地配置文件中填写搜索服务参数。
- 使用无需凭据的搜索后端时，可用性取决于网络环境。
- 未被当前工程代码读取的配置项不建议写入。

前端 `本地配置模板` 字段说明：

```text
VITE_API_BASE_URL=
```

前端代码实际只读取 `VITE_API_BASE_URL`。如果不配置，默认请求 `http://localhost:8000`。当前代码没有读取 `VITE_API_URL` 或 `API_BASE_URL`。

## 7. 后端启动方式

建议在底层工程根目录启动：

```bash
cd <local-deep-research-source>
PYTHONPATH=backend/src backend/.venv/bin/python backend/src/main.py
```

也可使用 Uvicorn：

```bash
cd <local-deep-research-source>
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
cd <local-deep-research-source>/frontend
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

运行验证结果：

1. 后端已启动并通过 `/healthz` 检查。
2. 前端已启动，地址为 `http://localhost:5174/`。
3. `/research/stream` 已返回 SSE 事件。
4. TODO Planner 已生成 3 个研究任务。
5. 公开搜索服务已返回 3 组公开来源。
6. NoteTool 已创建和更新任务笔记。
7. Task Summarizer 已生成 3 个阶段总结。
8. Report Writer 已生成最终研究报告。
9. SSE 已返回 `final_report` 和 `done`。

## 10. 当前本地验证状态

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

未纳入正式展示范围：

- 未读取真实 `本地配置文件`。
- 未截图、未录屏、未剪辑视频。

## 11. 已知问题和修复记录

1. 本机系统默认 `python3` 是 3.8.7，低于项目要求；已改用 本地 Python 运行环境 3.12.13。
2. 可编辑安装失败，原因是后端包目录配置解析异常；本阶段未修改底层工程代码，改为直接安装依赖。
3. Agent 运行依赖导入链需要 `huggingface_hub`，已单独安装。
4. 后端导入时提示外部搜索配置未设置；这属于外部搜索配置未纳入正式展示范围，不是代码导入失败。
5. 前端 `npm audit` 提示 8 个漏洞，未自动升级依赖。
6. 代码原先没有在入口自动加载本地配置文件，直接执行后端入口时容易回落到默认本地配置；已在底层工程中补充启动时加载本地配置文件，且加载发生在 Agent 模块导入之前。
7. 本地配置文件中若存在空字符串形式的可选字段，会导致配置解析失败；本次通过启动命令临时覆盖非密钥默认值。
8. 修复前运行验证中，Planner、公开搜索、NoteTool 和 Summarizer 已完成，但 Report Writer 因 LLM 请求超时未纳入正式展示范围。
9. 已修复 Report Writer 超时问题：提高 LLM timeout，限制任务数和搜索来源，压缩传入 Report Writer 的上下文，并移除最终报告阶段的笔记读取。
10. 修复后运行验证已返回 `final_report` 和 `done`，最终报告保存到 `assets/reports/deep-research-agent/deep-research-report.md`。
11. 2026-06-08 排查前端连接错误：原因是后端直接启动时未正确加载本地配置文件，导致 LLM 配置回落到默认本地模型地址；已修复加载路径和加载顺序。
12. 修复本地配置文件加载后，`/healthz` 正常，`/research/stream` 能接收请求；当前 LLM 健康检查返回服务侧权限或额度错误，需人工检查本地模型服务配置。
13. 2026-06-08 排查前端“最新来源”和“任务总结”为空：后端可返回 `sources`，前端也能解析当前来源格式；主要问题是失败任务没有携带已收集的 `sources_summary` / 部分 `summary`，前端也没有专门处理 `failed` 状态。已补充后端失败事件字段、前端失败状态展示和失败原因提示。
14. 当客户端请求超时或浏览器断开时，后端 generator 清理阶段可能出现 `cannot join current thread`；已修复为清理线程时跳过当前线程。
15. 2026-06-08 排查仍使用默认搜索后端：已补充搜索后端推断逻辑，同时建议在本地配置文件中显式指定搜索服务。

## 13. LLM 健康检查

健康检查脚本位于底层工程目录：

```text
<local-deep-research-source>/check_llm_health.py
```

运行方式：

```bash
cd <local-deep-research-source>
backend/.venv/bin/python check_llm_health.py
```

脚本会读取后端配置并发起最小 LLM 请求：

```text
请只返回 OK
```

安全约束：

- 不打印本地配置。
- 不打印完整响应。
- 只输出是否成功、endpoint/model 是否为空、HTTP 状态码或错误类型、响应耗时、返回文本前 20 个字符和错误摘要。

当前排查结果：

- `endpoint` 非空。
- `model` 非空。
- HTTP 状态码为 `403`。
- 错误类型为 `PermissionDeniedError`。
- 结论：当前不是前端请求错误，也不是本地模型配置为空；主要需要检查模型服务账户状态、服务权限或更换可用模型服务配置。

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
搜索后端=tavily
MAX_WEB_RESEARCH_LOOPS=1
最大研究任务数=1
SEARCH_MAX_RESULTS=2
FETCH_FULL_PAGE=False
报告生成超时=180
REPORT_MAX_WORDS=800
REPORT_SUMMARY_CHAR_LIMIT=600
REPORT_SOURCES_PER_TASK=2
```

## 15. 搜索后端配置

搜索后端选择规则：

- 前端若选择“沿用后端配置”，由后端本地配置决定。
- 前端若显式选择 `duckduckgo`，会覆盖后端配置并使用 DuckDuckGo。
- 后端推荐使用稳定的公开搜索服务。
- 如果没有显式搜索后端配置，但存在搜索服务参数，当前代码会自动推断可用搜索后端。

建议 `本地配置文件` 字段：

```text
搜索后端=tavily
搜索服务参数：在真实本地配置文件中手动填写，不要提交。
```

注意：

- 不要只修改搜索服务参数后继续运行旧后端进程，配置修改后必须重启后端。
- 搜索服务返回的 `sources_summary` 会通过 SSE `sources` 事件进入前端“最新来源”区域。
- 如果 DuckDuckGo 返回 `No results found`，任务没有可用检索上下文，任务总结为空属于预期结果。

## 16. 下一步操作

1. 在底层工程后端 `本地配置文件` 中把可选字段补为合法默认值，不要留空字符串。
2. 建议配置：
   - `搜索后端=tavily`
   - `MAX_WEB_RESEARCH_LOOPS=1`
   - `FETCH_FULL_PAGE=False`
   - `ENABLE_NOTES=True`
   - `启用阶段总结=True`
   - `USE_TOOL_CALLING=False`
   - `报告生成超时=180`
   - `最大研究任务数=3`
   - `SEARCH_MAX_RESULTS=3`
   - `REPORT_MAX_SECTIONS=6`
   - `REPORT_MAX_WORDS=1500`
   - `REPORT_SUMMARY_CHAR_LIMIT=1200`
   - `REPORT_SOURCES_PER_TASK=3`
3. 当前需先处理 LLM 服务 HTTP 403 或模型响应过慢问题：检查模型服务账户状态，必要时更换可用模型或降低任务规模。
4. 修改 `本地配置文件` 后重新启动后端，并运行 `check_llm_health.py`。
5. 健康检查成功后，使用推荐短主题进行前端验证，确认详情区能展示来源、失败原因和任务总结。
6. 前端仍显示旧状态时，重启后端和前端，确保浏览器连接的是修复后的后端进程。
7. 录屏前检查终端、浏览器、日志和页面中没有本地配置、账号或隐私信息。

## 17. 最终收尾状态

当前运行状态：完整链路已跑通。

已完成验证：

- 后端 FastAPI 服务可启动。
- 前端 Vue 3 + TypeScript + Vite 页面可启动。
- `/healthz` 健康检查通过。
- `/research/stream` SSE 流式返回可用。
- LLM 已接入并验证 TODO Planner、Task Summarizer 和 Report Writer。
- SearchTool 已接入公开搜索服务并返回公开来源。
- NoteTool 已创建和更新任务笔记。
- 最终研究报告已生成。
- 原始录屏、关键截图、抽帧索引和演示视频已归档。

推荐启动方式：

```bash
cd <local-deep-research-source>
PYTHONPATH=backend/src backend/.venv/bin/python backend/src/main.py
```

前端启动方式：

```bash
cd <local-deep-research-source>/frontend
npm run dev
```

推荐演示配置：

```text
搜索后端=tavily
MAX_WEB_RESEARCH_LOOPS=1
最大研究任务数=3
SEARCH_MAX_RESULTS=3
FETCH_FULL_PAGE=False
ENABLE_NOTES=True
启用阶段总结=True
USE_TOOL_CALLING=False
报告生成超时=180
REPORT_MAX_SECTIONS=6
REPORT_MAX_WORDS=1500
REPORT_SUMMARY_CHAR_LIMIT=1200
REPORT_SOURCES_PER_TASK=3
```

搜索 Provider 配置说明：

- 推荐使用稳定的公开搜索服务。
- 配置搜索服务参数后必须重启后端。
- 如果前端搜索下拉框选择“沿用后端配置”，则以后端本地配置为准。
- 如果前端显式选择 `duckduckgo`，会覆盖后端配置。

Report Writer 超时修复记录：

- 增加报告生成超时配置。
- 限制任务数量和每个任务的搜索来源数量。
- 压缩传入 Report Writer 的阶段总结和来源上下文。
- 移除最终报告阶段额外读取全部笔记的要求。

最终成片：

```text
assets/demos/deep-research-agent/deep-research-agent-demo.mp4
```

边界说明和后续优化：

1. 公开展示截图已整理到 `assets/screenshots/deep-research-agent/final/`。
2. 当前视频以硬字幕演示为主，后续可增加更短版本或配音版。
3. 前端依赖的 `npm audit` 风险提示暂未单独处理。
4. 后续可增强引用编号、来源复核和导出能力。
