# 自动化深度研究 Agent 真实运行验证记录

## 当前结论

Report Writer 超时问题已通过最小修复规避，自动化深度研究 Agent 已完成一次端到端真实运行验证。

已跑通链路：

- 后端启动成功。
- 前端启动成功。
- `/healthz` 健康检查成功。
- `/research/stream` SSE 接口返回 200。
- TODO Planner 成功生成 3 个研究任务。
- Tavily 搜索成功，每个子任务返回 3 条公开来源。
- NoteTool 成功创建和更新任务笔记。
- Task Summarizer 成功生成 3 个阶段性总结。
- Report Writer 成功生成最终研究报告。
- SSE 返回 `final_report` 和 `done` 事件。

本记录不包含任何 私密凭证，也未读取或记录真实 `本地配置文件` 内容。

## 修复前问题

修复前真实运行验证中，Planner、Tavily、NoteTool 和 Summarizer 均已成功，但最终 Report Writer 阶段失败：

```text
LLM调用失败: Request timed out.
```

判断原因：

- Report Writer 输入过长：每个任务的长阶段总结和来源信息直接进入最终 Prompt。
- Report Writer 还要求读取所有任务笔记，增加了额外工具调用和上下文。
- 搜索来源和阶段总结数量偏多。
- `本地私密凭证=60` 对最终报告生成偏短。
- 最终报告 Prompt 未明确限制报告长度。

## 修复方式

代码层修复：

1. `backend/src/config.py`
   - 增加 `llm_timeout`，支持 `本地私密凭证`。
   - 增加 `max_todo_items`，支持 `本地私密凭证`。
   - 增加 `search_max_results`，支持 `SEARCH_MAX_RESULTS`。
   - 增加 `report_max_sections`、`report_max_words`、`report_summary_char_limit`、`report_sources_per_task`。
   - 忽略空字符串环境变量，避免 `本地配置文件` 中空值导致 Pydantic 解析失败。

2. `backend/src/agent.py`
   - 将 `self.config.llm_timeout` 传给 `HelloAgentsLLM(timeout=...)`。

3. `backend/src/services/planner.py`
   - 按 `本地私密凭证` 限制实际执行任务数量。

4. `backend/src/services/search.py`
   - 按 `SEARCH_MAX_RESULTS` 限制每个任务搜索结果数量。

5. `backend/src/services/reporter.py`
   - Report Writer 不再读取任务笔记。
   - 只使用研究主题、TODO 列表、阶段总结和精简来源。
   - 截断每个任务传入 Report Writer 的总结文本。
   - 每个任务只保留前 2-3 条来源。
   - 明确最终报告长度和小节数量要求。

环境样例更新：

```text
本地私密凭证=180
本地私密凭证=3
SEARCH_MAX_RESULTS=3
REPORT_MAX_SECTIONS=6
REPORT_MAX_WORDS=1500
REPORT_SUMMARY_CHAR_LIMIT=1200
REPORT_SOURCES_PER_TASK=3
```

## 修复后验证

验证主题：

```text
企业如何落地 AI Agent 应用
```

本次验证使用轻量运行参数：

```text
本地私密凭证=tavily
MAX_WEB_RESEARCH_LOOPS=1
本地私密凭证=3
SEARCH_MAX_RESULTS=3
FETCH_FULL_PAGE=False
ENABLE_NOTES=True
本地私密凭证=True
USE_TOOL_CALLING=False
本地私密凭证=180
REPORT_MAX_SECTIONS=6
REPORT_MAX_WORDS=1500
REPORT_SUMMARY_CHAR_LIMIT=900
REPORT_SOURCES_PER_TASK=3
```

SSE 事件统计：

| 事件类型 | 数量 |
| --- | ---: |
| status | 1 |
| tool_call | 10 |
| todo_list | 1 |
| task_status | 6 |
| sources | 3 |
| task_summary_chunk | 8626 |
| report_note | 1 |
| final_report | 1 |
| done | 1 |

## 任务拆解结果

| 任务 ID | 任务标题 | 检索 Query |
| --- | --- | --- |
| 1 | 技术架构选型 | 企业AI Agent技术架构 LLM选型 开发平台 系统集成 RAG |
| 2 | 场景与价值分析 | 企业AI Agent应用场景 落地案例 ROI 行业标杆 |
| 3 | 组织治理与合规 | AI Agent企业治理 数据安全合规 组织变革 风险管控 |

## 搜索和阶段总结结果

| 任务 | 搜索结果 | 阶段总结 |
| --- | --- | --- |
| 技术架构选型 | Tavily 返回 3 条来源 | 已完成 |
| 场景与价值分析 | Tavily 返回 3 条来源 | 已完成 |
| 组织治理与合规 | Tavily 返回 3 条来源 | 已完成 |

部分来源样例：

- 技术架构选型：飞书文档 AI Agent 构建形式、BetterYeah LLM 模型选型、腾讯云四层智能跃迁。
- 场景与价值分析：BetterYeah 成功案例、LargitData 企业应用场景、腾讯云落地方向。
- 组织治理与合规：中伦律师事务所合规红线、实在智能数据安全与合规、安全内参企业部署风险提示。

## 最终报告生成结果

最终报告已生成，保存路径：

```text
assets/reports/deep-research-agent/deep-research-report.md
```

报告状态：

- Report Writer 成功。
- `final_report` 事件已返回。
- `done` 事件已返回。
- 前端代码已确认会接收 `final_report` 并展示到报告区域。

## 当前本地验证状态

当前状态：已完成真实运行验证，最终报告生成已跑通，后续可以进入截图和录屏阶段。

录屏前仍需检查：

- 页面、终端和日志中不要展示 私密凭证。
- 不展示真实 `本地配置文件`。
- 不展示浏览器私人信息、账号或隐私页面。
- 正式作品集表述为本地运行验证和案例演示，不写成真实客户交付。

## 2026-06-08 前端 LLM Connection error 排查

问题现象：

- 后端和前端均可启动，前端页面可访问。
- 点击“开始研究”后，前端显示 `LLM调用失败: Connection error.`。

排查结论：

1. 当前后端若直接使用 `PYTHONPATH=backend/src backend/.venv/bin/python backend/src/main.py` 启动，原入口没有在本地模块导入前自动加载 `backend/本地配置文件`。
2. 未加载 `本地配置文件` 时，LLM 配置会回落到默认 `ollama` 和本地地址，导致前端看到 `Connection error`。
3. 已将 `backend/src/main.py` 调整为在导入本地 Agent 模块前加载 `backend/本地配置文件`，并将启动日志中的 私密凭证 显示方式改为仅显示 `set/unset`。
4. 修复加载路径后，后端 `/healthz` 正常，Tavily 初始化成功。
5. 重新调用 `/research/stream` 后，错误从 `Connection error` 变为模型服务返回的 HTTP 403：账户余额不足。

临时 LLM 健康检查：

- 临时脚本路径：`/Users/wangyu/Documents/hello-agents/code/chapter14/helloagents-deepresearch/check_llm_health.py`
- 脚本只输出成功状态、endpoint/model 是否为空、HTTP 状态码或错误类型、耗时、返回文本前 20 个字符和错误摘要。
- 健康检查结果：LLM 请求未成功，`endpoint` 非空，`model` 非空，错误类型为 `PermissionDeniedError`，HTTP 状态码为 `403`。

当前判断：

- 后端 `本地配置文件` 路径加载问题：已修复。
- 前端请求路径问题：未发现，前端请求能够到达 `/research/stream`。
- Tavily 搜索配置：已能初始化。
- 当前阻塞点：LLM 账号额度或 Key 对应账户状态，需要人工检查模型服务账户余额、套餐或可用额度。

建议下一步：

1. 检查后端 `本地配置文件` 中的 `本地私密凭证` 对应账户是否仍有可用额度。
2. 如更换模型服务或账号，重点检查 `本地私密凭证`、`本地私密凭证`、`本地私密凭证` 三个字段。
3. 修改 `本地配置文件` 后重新启动后端，再运行 `check_llm_health.py` 做最小验证。
4. 健康检查返回成功后，再通过前端点击“开始研究”验证完整流程。

## 2026-06-08 前端来源和任务总结为空排查

问题现象：

- 前端可以启动研究任务。
- 多个任务显示 `failed`。
- 右侧详情区“最新来源”显示“暂无可用来源”。
- “任务总结”显示“暂无可用信息”。
- 部分任务能看到查询词和 note 路径，但没有展示 sources 和 summary。

SSE 事件检查：

- 后端 `/research/stream` 支持并返回 `todo_list`、`sources`、`task_summary_chunk`、`final_report`、`error`、`done` 等事件。
- 最近一次成功记录中，SSE 曾返回 `sources=3`、`task_summary_chunk=8626`、`final_report=1`、`done=1`。
- 本次短主题采样中，后端返回了 `todo_list` 和 `sources`，来源内容格式为 `* 标题 : URL`，前端解析函数可识别该格式。
- 本次采样在 120 秒内未收到 `task_summary_chunk`，说明任务总结为空主要与 Summarizer 未及时产出、请求被中断或任务失败有关。

根因判断：

1. 不是单纯的搜索工具无返回：采样中后端已返回 `sources`。
2. 不是前端完全没有解析 `sources`：前端 `parseSources()` 支持当前后端来源格式。
3. 存在前端失败状态映射缺口：前端原先没有专门处理 `failed` 任务状态，失败原因不会进入任务详情。
4. 存在后端失败事件字段缺口：任务失败时，后端原先只返回 `detail`、标题、意图和 note 元数据，没有带回任务已经收集到的 `sources_summary` 或部分 `summary`。
5. 存在客户端中断清理问题：当浏览器或 curl 超时断开时，后端 generator 清理阶段可能触发 `cannot join current thread`，影响后续状态收尾。

本次最小修复：

1. `backend/src/agent.py`
   - 任务失败事件新增 `query`、`summary`、`sources_summary` 字段。
   - 流式总结过程中将已产生的 chunk 同步累积到 `task.summary`，即使后续失败也能保留部分总结。
   - generator 清理线程时跳过当前线程，避免客户端断开后触发 `cannot join current thread`。

2. `frontend/src/App.vue`
   - 任务状态标签新增 `failed: 失败`。
   - 前端收到 `task_status=failed` 时，会保留并展示 `summary`、`sources_summary`。
   - 失败原因会进入当前任务“系统提示”，避免详情区只有空白占位。

验证结果：

- 后端 Python 编译检查通过。
- 前端 `npm run build` 通过。
- 临时 SSE 采样确认后端可返回 `sources`。
- 本次采样仍未在 120 秒内收到 `task_summary_chunk`，说明录屏时应使用更短主题、更少任务、更少搜索来源，降低 Summarizer 等待时间。

推荐录屏配置：

```text
本地私密凭证=tavily
MAX_WEB_RESEARCH_LOOPS=1
本地私密凭证=1
SEARCH_MAX_RESULTS=2
FETCH_FULL_PAGE=False
本地私密凭证=180
REPORT_MAX_WORDS=800
REPORT_SUMMARY_CHAR_LIMIT=600
REPORT_SOURCES_PER_TASK=2
```

推荐短主题：

```text
AI Agent 在客服场景的试点路径
```

该主题范围更小，适合在录屏中展示任务拆解、来源返回、任务总结和最终报告，减少多任务并发和长总结造成的等待。

## 2026-06-08 DuckDuckGo / Tavily 搜索后端排查

问题现象：

- 前端研究任务可以生成最终报告，但任务状态显示 `failed`。
- 系统提示包含 `DuckDuckGo 搜索失败: No results found.`。
- 用户已配置 搜索服务私密凭证，希望优先使用 Tavily。

排查结论：

1. 后端搜索后端由 `Configuration.search_api` 决定，默认值原为 `duckduckgo`。
2. 前端搜索引擎下拉框默认是“沿用后端配置”，如果用户没有在前端显式选择 `tavily`，前端不会覆盖后端配置。
3. 原逻辑中，仅配置 `本地私密凭证` 不会自动把 `search_api` 切换为 `tavily`；必须同时配置 `本地私密凭证=tavily`，否则可能继续使用默认 DuckDuckGo。
4. 本次安全检查显示当前本地配置加载后 `search_api=tavily`，搜索服务私密凭证 状态为 set；如果页面仍提示 DuckDuckGo，通常说明后端没有重启到新配置，或前端下拉框显式选择了 `duckduckgo`。

本次最小修复：

- `backend/src/config.py`：当没有显式 `本地私密凭证`，但检测到 `本地私密凭证` 时，自动推断 `search_api=tavily`。
- 若没有 搜索服务私密凭证，但存在 `本地私密凭证` 或 `SEARXNG_URL`，也会按对应搜索后端推断。
- 显式设置仍优先，例如 `本地私密凭证=duckduckgo` 会继续尊重用户选择。
- `backend/本地配置模板`：将推荐搜索后端写为 `本地私密凭证=tavily`。

验证结果：

- 模拟无 `本地私密凭证`、有 搜索服务私密凭证 时，配置推断结果为 `tavily`。
- 显式设置 `本地私密凭证=duckduckgo` 时，仍使用 `duckduckgo`。
- 直接调用搜索工具验证 Tavily 成功返回 2 条结果。
- Tavily 返回的 `sources_summary` 格式为 `* 标题 : URL`，前端 `parseSources()` 可以解析并进入“最新来源”区域。

任务总结为空判断：

- 如果 DuckDuckGo 搜索失败且没有返回 sources，后端会将任务标记为 `skipped` 或后续失败，Summarizer 没有可用上下文，因此任务总结为空与搜索失败直接相关。
- 切换到 Tavily 并返回 sources 后，Summarizer 才有上下文生成任务总结。

下一步：

1. 后端 `本地配置文件` 建议明确配置 `本地私密凭证=tavily`。
2. 前端下拉框不要选择 `duckduckgo`；可选择“沿用后端配置”或显式选择 `tavily`。
3. 修改配置或代码后必须重启后端。
4. 重新运行时建议使用短主题：`AI Agent 在客服场景的试点路径`。
