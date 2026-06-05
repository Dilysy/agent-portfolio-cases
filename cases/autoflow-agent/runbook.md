# AutoFlow 流程图生成 Agent 本地化运行验证步骤

## 环境准备

- 工程目录：`~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow`
- 项目要求：Python 3.10+、Node.js 18+、npm 9+
- 本次验证环境：
  - 系统 `python3`：3.8.7，不满足项目要求
  - Codex 打包 Python：3.12.13，可用于后端运行验证
  - Node.js：25.8.0
  - npm：11.11.0

## 依赖安装

后端原始安装命令：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
pip install -r requirements.txt
```

历史阻塞点：此前 `backend/requirements.txt` 中存在非法依赖写法：

```text
hello-agents=1.0.0
```

pip 报错为：`= is not a valid operator. Did you mean == ?`

前置修复记录：已将工程目录中的 `backend/requirements.txt` 修复为合法 pip 依赖写法：

```text
hello-agents==1.0.0
```

修复后可重新使用标准安装命令：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
pip install -r requirements.txt
```

前端依赖安装：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/frontend
npm install
```

本次前端依赖可安装成功，但 `npm audit` 报告 12 个漏洞，尚未处理。

## 配置说明

工程配置文件：

- `backend/.env.example`
- `frontend/.env.example`
- `backend/app/config.py`
- `backend/app/services/llm_service.py`

前置修复记录：已更新工程目录中的 `backend/.env.example`，其中 LLM 字段为占位空值：

```env
LLM_MODEL_ID=
LLM_API_KEY=
LLM_BASE_URL=
```

`backend/app/config.py` 会从 `backend/.env` 读取环境变量。`backend/app/services/llm_service.py` 将配置传给 LLM 客户端：

```python
LLMClient(
    model=settings.llm_model_id,
    api_key=settings.llm_api_key,
    base_url=settings.llm_base_url,
    timeout=settings.llm_timeout,
    temperature=0.3,
)
```

需要配置的环境变量清单：

| 变量 | 必需 | 作用 |
| --- | --- | --- |
| `APP_NAME` | 否 | FastAPI 应用名称，默认 `AutoFlow API` |
| `APP_ENV` | 否 | 环境标识，非生产环境会放宽 localhost CORS |
| `APP_HOST` | 否 | 后端监听地址 |
| `APP_PORT` | 否 | 后端监听端口 |
| `CORS_ORIGINS` | 否 | 允许的前端来源 |
| `LLM_MODEL_ID` | 是 | 模型名称 |
| `LLM_API_KEY` | 是 | 模型服务 API Key |
| `LLM_BASE_URL` | 是 | 模型服务 base URL |
| `LLM_TIMEOUT` | 否 | LLM 请求超时时间 |
| `AGENT_MAX_STEPS` | 否 | Agent 最大步骤数配置，当前代码中未直接用于 `SimpleAgent` 构造 |
| `VALIDATOR_MAX_RETRIES` | 否 | Mermaid 后置校验最多修复次数，实际代码会限制为最多 1 次修复 |
| `VITE_API_BASE_URL` | 前端可选 | 前端请求后端 API 的 base URL |

`.env.example` 应包含的占位字段：

```env
APP_NAME=AutoFlow API
APP_ENV=dev
APP_HOST=0.0.0.0
APP_PORT=8000
CORS_ORIGINS=http://localhost:5173

LLM_MODEL_ID=
LLM_API_KEY=
LLM_BASE_URL=
LLM_TIMEOUT=120

AGENT_MAX_STEPS=6
VALIDATOR_MAX_RETRIES=2

VITE_API_BASE_URL=http://localhost:8000
```

不要把真实 API Key 写入仓库。当前作品集中的 [cases/autoflow-agent/.env.example](/Users/wangyu/Documents/agent-portfolio-cases/cases/autoflow-agent/.env.example) 仅保留占位字段。

`.env` 提交规则：

- 工程根目录 `.gitignore` 已包含 `.env`，因此 `backend/.env` 不应提交。
- 本轮验证未读取、输出、创建或修改真实 `backend/.env`。
- 如果本地尚未配置真实 LLM 参数，需要用户手动执行：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
cp .env.example .env
```

然后只在本地 `.env` 中填入真实 `LLM_MODEL_ID`、`LLM_API_KEY`、`LLM_BASE_URL`。已经配置过 `.env` 时，不需要重复复制。不要把真实 Key 复制到作品集、日志、截图或录屏中。

## LLM 配置检查

LLM 调用相关代码路径：

- `backend/app/config.py`：读取 `.env` 中的 `LLM_MODEL_ID`、`LLM_API_KEY`、`LLM_BASE_URL`、`LLM_TIMEOUT`。
- `backend/app/services/llm_service.py`：创建 LLM 客户端。
- `backend/app/agents/mermaid/agent_factory.py`：为灵感模式、标准代码生成模式构建 `SimpleAgent`。
- `backend/app/services/rule_flow_converter.py`：规则优先的快速路径，覆盖销售条件流程和线性计划拆解。
- `backend/app/agents/mermaid/pipeline.py`：灵感模式、标准模式先尝试规则快速路径；规则不命中时，标准模式使用一次 LLM 直接生成 Mermaid，不再默认走“文本优化 + 代码生成”的两段式调用。
- `backend/app/agents/mermaid_agent_service.py`：编排流式生成、超时控制、校验和结果返回。

OpenAI-compatible API 支持判断：

- 支持自定义 `base_url`、`api_key`、`model`。
- LLM 客户端构造函数接收 `model`、`api_key`、`base_url`、`timeout`。
- 本次检查到模型适配逻辑为：`anthropic.com` 使用 AnthropicAdapter，`googleapis.com` 或 `generativelanguage` 使用 GeminiAdapter，其他 base_url 默认使用 OpenAIAdapter。
- 因此，AutoFlow 可接入 OpenAI-compatible API，前提是模型服务兼容 OpenAI Chat Completions 风格，并正确配置 `LLM_BASE_URL`、`LLM_API_KEY`、`LLM_MODEL_ID`。

未配置真实 LLM 时的表现：

- `/health` 可用。
- 前端页面可用。
- 计划模式可用。
- Mermaid 代码模式可用。
- 灵感模式和标准模式若命中规则快速路径，可不依赖 LLM 生成；若输入未命中规则并进入 LLM 兜底，则需要配置 `LLM_MODEL_ID`、`LLM_API_KEY` 和 `LLM_BASE_URL`。

已配置真实 LLM 后的本轮测试结果：

- `/health` 可用，前端可访问。
- 用户更换模型后，LLM 健康检查可用；新增规则优先快速路径后，本轮四模式严格复测均成功。
- 本轮判定不再只看“是否渲染成功”，还检查 Mermaid 是否具有有效流程结构。
- 灵感模式：命中 `rule-linear-plan`，未调用 LLM，结构校验和前端渲染均通过，耗时约 0.087 秒。
- 标准模式：命中 `rule-sales-process`，未调用 LLM，结构校验和前端渲染均通过，耗时约 0.007 秒。
- 计划模式：命中 `rule-linear-plan`，未调用 LLM，规则拆解生成结构化 Mermaid，结构校验和前端渲染均通过，耗时约 0.024 秒。
- Mermaid 代码模式：不依赖 LLM，手工 Mermaid 示例通过结构校验和前端渲染。
- 测试报告见 [autoflow-four-modes-test.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/autoflow-agent/autoflow-four-modes-test.md)。

最小修复记录：

- 已定位超时配置在 `backend/app/config.py`、`backend/app/services/llm_service.py` 和 `backend/app/agents/mermaid_agent_service.py`。
- 已将 `backend/app/config.py` 中 `LLM_TIMEOUT` 默认值从 60 调整为 120。
- 已将 `backend/app/agents/mermaid_agent_service.py` 中运行时最低 `llm_timeout` 从 30 调整为 120。
- 已将工程目录 `backend/.env.example` 中 `LLM_TIMEOUT=60` 更新为 `LLM_TIMEOUT=120`。
- 已修复计划模式伪成功问题：原实现位于 `backend/app/services/plan_converter.py`，只按换行或 `A -> B -> C` 拆分文本；单段自然语言会被当成一个大节点渲染。
- 已增强 `backend/app/tools/mermaid_validator_tool.py`，补充结构校验：图声明、节点数量、连接数量、整段输入节点检测、条件分支判断节点检测。
- 已增强 `backend/app/services/plan_converter.py`，对“包含 A、B、C...”类单段输入先做规则拆解，生成 `Start -> N1 -> ... -> End` 结构；规则结果不合格时，再使用已有 `LLMService` 作为最小 LLM 兜底分支。
- 已更新 `backend/app/routers/plan.py`，当规则和 LLM 都无法生成合格结构时返回明确 422 错误，不再把不合格 Mermaid 标记为成功。
- 已新增 `backend/app/services/rule_flow_converter.py`，将销售跟进条件流程和线性计划拆解抽成统一规则模块。
- 已更新 `backend/app/agents/mermaid/pipeline.py` 和 `backend/app/agents/mermaid_agent_service.py`：灵感模式、标准模式先走规则快速路径；标准模式规则不命中时，改为一次 LLM 直接生成 Mermaid，减少默认两段式调用耗时。
- 不读取、不修改真实 `backend/.env`。

修复后复测结果：

- 灵感模式：成功，未调用 LLM，生成来源 `rule-linear-plan`，6 个节点、4 条连接，结构校验和前端渲染通过。
- 标准模式：成功，未调用 LLM，生成来源 `rule-sales-process`，12 个节点、13 条连接，包含判断节点，结构校验和前端渲染通过。
- 计划模式：成功，未调用 LLM，生成来源 `rule-linear-plan`，8 个节点、7 条连接，结构校验和前端渲染通过。
- Mermaid 代码模式：成功，未调用 LLM，10 个节点、11 条连接，包含判断节点，结构校验和前端渲染通过。

若后续再次出现超时，排查优先级：

1. `LLM_BASE_URL` 是否可从本机访问，是否为 OpenAI-compatible 接口地址。
2. `LLM_MODEL_ID` 是否与模型服务端实际模型名一致。
3. 模型服务是否响应过慢；当前演示输入已命中规则快速路径，不依赖 LLM。若输入未命中规则并进入 LLM 兜底，必要时继续提高 `LLM_TIMEOUT` 或换用更快模型。
4. 是否存在代理或网络问题。
5. 若服务快速返回但仍失败，再检查模型服务是否支持当前响应格式、依赖版本和 LLM 返回内容是否为合法 Mermaid。

## 启动方式

后端启动：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
uvicorn app.main:app --host 127.0.0.1 --port 8000
```

健康检查：

```bash
curl http://127.0.0.1:8000/health
```

本次返回：

```json
{"status":"ok","service":"AutoFlow API"}
```

前端启动：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/frontend
npm run dev -- --host 127.0.0.1 --port 5173
```

本地访问地址：

```text
http://127.0.0.1:5173/
```

## 四个模式

| 模式 | 前端入口 | 前端函数 | 后端接口 | 是否依赖 LLM | 演示方式 |
| --- | --- | --- | --- | --- | --- |
| 灵感模式 | `frontend/src/App.jsx` 中 `mode === "inspire"` 的聊天输入 | `runAgentMode()` -> `streamAgentChat()` | `POST /api/agent/chat/stream`，payload `mode: "inspire"` | 规则命中时否；否则是 | 先用规则解析阶段型输入，未命中时由 Agent 补全并生成 Mermaid |
| 标准模式 | `frontend/src/App.jsx` 中 `mode === "standard"` 的聊天输入 | `runAgentMode()` -> `streamAgentChat()` | `POST /api/agent/chat/stream`，payload `mode: "standard"` | 规则命中时否；否则是 | 先用规则解析常见条件流程，未命中时一次 LLM 直接生成 Mermaid |
| 计划模式 | `frontend/src/App.jsx` 中 `mode === "plan"` 的编辑器 | `runPlanMode()` -> `buildPlan()` | `POST /api/plan` | 当前测试输入否；规则失败时会调用 LLM 兜底 | 按行输入步骤，或输入“包含 A、B、C...”类单段计划，后端 `PlanConverter` 生成结构化线性 `flowchart` |
| Mermaid 代码模式 | `frontend/src/App.jsx` 中 `mode === "code"` 的编辑器 | `runCodeMode()`，前端直接更新 `mermaidCode` | 无后端生成接口 | 否 | 粘贴 `assets/reports/autoflow-mermaid-example.md` 中的 Mermaid 示例，前端实时渲染 |

模式实现说明：

- 灵感模式和标准模式共用 `/api/agent/chat/stream`，后端通过 SSE 返回 `status`、`result`、`error` 和 `done` 事件。
- `AgentChatRequest` 的后端 schema 只允许 `mode: "standard"` 或 `mode: "inspire"`。
- 灵感模式、标准模式会先调用 `RuleFlowConverter`；规则命中时不调用 LLM，直接进入结构校验和渲染。
- 计划模式只接受 `{ text, direction }`。原始实现不走 LLM，只做模板/规则转换；本次修复后先规则拆解，规则结果不合格时再用已有 LLM adapter 兜底生成 Mermaid。
- Mermaid 代码模式完全在前端渲染，使用 `frontend/src/services/mermaid.js` 中的 `mermaid.render()`。
- 右侧方向切换由前端 `applyDirectionToCode()` 修改 `flowchart TD/LR`，不依赖 LLM。

## Mermaid 结构校验

本次复测已修复“能渲染即成功”的伪成功问题。合格 Mermaid 至少需要满足：

1. 包含 `flowchart` 或 `graph` 声明。
2. 至少包含 4 个业务节点。
3. 至少包含 3 条连接关系。
4. 不能只把完整输入文本作为单个节点。
5. 输入包含条件分支时，必须体现 Mermaid 判断节点。

这套校验位于 `backend/app/tools/mermaid_validator_tool.py`，灵感模式、标准模式和计划模式都会使用；测试脚本也按同一口径重新记录节点数、连接数、判断节点、渲染结果和是否可用于演示。

## 示例运行

演示输入：

```text
客户提交需求后，销售先进行需求确认。如果需求明确，进入方案编写阶段；如果需求不明确，返回客户补充信息。方案完成后提交客户评审，客户通过后进入合同流程，未通过则返回修改。
```

建议优先使用标准模式完成主演示；当前示例会命中规则快速路径，通常可在 1 秒内完成：

1. 打开 `http://127.0.0.1:5173/`。
2. 切换到标准模式。
3. 输入上方演示文本。
4. 等待 Mermaid 返回后，检查右侧流程图是否覆盖需求确认、信息补充、客户评审和退回修改。

未配置真实 LLM 或模型服务临时不可用时，可使用 Mermaid 代码模式作为替代演示：

1. 打开 `http://127.0.0.1:5173/`。
2. 切换到 Mermaid 代码模式。
3. 粘贴 [autoflow-mermaid-example.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/autoflow-mermaid-example.md) 中的 Mermaid 示例。
4. 观察右侧实时预览，切换上到下/左到右方向，按需导出 `.mmd` 或 SVG。

计划模式演示输入：

```text
请为企业客户项目售前流程生成计划流程图，包含需求收集、方案设计、内部评审、客户评审、合同流程和后续交付启动。
```

本轮计划模式会生成开始、需求收集、方案设计、内部评审、客户评审、合同流程、后续交付启动、结束节点，不再把完整输入作为一个大节点。

## 常见问题

- 后端依赖安装失败：确认 `backend/requirements.txt` 中为 `hello-agents==1.0.0`，不是 `hello-agents=1.0.0`。
- Python 版本过低：使用 Python 3.10+，本次用 Python 3.12.13 完成运行验证。
- 标准/灵感模式慢或失败：检查 `LLM_MODEL_ID`、`LLM_API_KEY`、`LLM_BASE_URL`、`LLM_TIMEOUT`，不要把真实 Key 写入仓库。
- OpenAI-compatible 服务无法调用：确认 `LLM_BASE_URL` 是否为兼容 OpenAI 的接口地址，模型名是否与服务端一致。
- 前端 API 不通：确认后端在 8000 端口运行；Vite 配置已将 `/api` 代理到 `http://127.0.0.1:8000`。
- 计划模式输出过于简单：该模式已支持多行步骤、`A -> B -> C` 和“包含 A、B、C...”类线性计划；复杂条件流程仍建议使用标准模式或 Mermaid 代码模式。
- Mermaid 渲染错误：先用 `MermaidValidatorTool` 检查结构，再在前端代码模式粘贴渲染。
