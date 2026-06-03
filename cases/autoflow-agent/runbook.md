# AutoFlow 流程图生成 Agent 本地复现步骤

## 环境准备

- 源项目目录：`~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow`
- 项目要求：Python 3.10+、Node.js 18+、npm 9+
- 本次环境：
  - 系统 `python3`：3.8.7，不满足项目要求
  - Codex 打包 Python：3.12.13，可用于后端复现
  - Node.js：25.8.0
  - npm：11.11.0

## 依赖安装

后端原始安装命令：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
pip install -r requirements.txt
```

本次原样安装结果：失败。原因是 `backend/requirements.txt` 中存在非法依赖写法：

```text
hello-agents=1.0.0
```

pip 报错为：`= is not a valid operator. Did you mean == ?`

本次临时复现使用以下方式绕过，不修改源项目文件：

```bash
/Users/wangyu/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3 -m venv /tmp/autoflow-venv
/tmp/autoflow-venv/bin/pip install fastapi==0.115.0 "uvicorn[standard]==0.30.6" pydantic==2.9.2 python-dotenv==1.0.1 sse-starlette==2.1.3 "hello-agents[all]>=0.2.7"
```

前端依赖安装成功：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/frontend
npm install
```

安装后 `npm audit` 报告 12 个漏洞，本次未处理。

## 配置说明

源项目已提供：

- `backend/.env.example`
- `frontend/.env.example`

当前作品集也补充了 [cases/autoflow-agent/.env.example](/Users/wangyu/Documents/agent-portfolio-cases/cases/autoflow-agent/.env.example)，仅包含占位变量，不包含真实密钥。

后端至少需要：

```text
LLM_MODEL_ID=your-model-name
LLM_API_KEY=your-api-key
LLM_BASE_URL=your-api-base-url
LLM_TIMEOUT=60
```

如果不配置真实 LLM，`/health`、前端页面和 `/api/plan` 可运行，但标准模式和灵感模式会在 Agent 生成阶段失败。

## 启动方式

后端启动：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
/tmp/autoflow-venv/bin/uvicorn app.main:app --host 127.0.0.1 --port 8000
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

## 示例运行

演示输入：

```text
客户提交需求后，销售先进行需求确认。如果需求明确，进入方案编写阶段；如果需求不明确，返回客户补充信息。方案完成后提交客户评审，客户通过后进入合同流程，未通过则返回修改。
```

`/api/plan` 对单行文本返回单节点流程图，适合作为接口可用性验证，不适合作为复杂条件流程输出。

标准模式接口 `/api/agent/chat/stream` 能返回 SSE 状态，但因未配置真实 LLM，最终返回：

```text
生成失败: 必须提供模型名称（model参数或LLM_MODEL_ID环境变量）
```

替代演示方案：手工整理 Mermaid，并使用源项目 `MermaidValidatorTool` 校验为 `VALID`。示例文件见 [autoflow-mermaid-example.md](/Users/wangyu/Documents/agent-portfolio-cases/assets/reports/autoflow-mermaid-example.md)。

## 常见问题

- 后端依赖安装失败：修复 `hello-agents=1.0.0` 为合法版本约束。
- Python 版本过低：使用 Python 3.10+，本次用 Python 3.12.13 复现。
- 标准/灵感模式失败：检查 `LLM_MODEL_ID`、`LLM_API_KEY`、`LLM_BASE_URL`。
- 前端 API 不通：确认后端在 8000 端口运行；Vite 配置已将 `/api` 代理到 `http://127.0.0.1:8000`。
- Mermaid 渲染错误：先用 `MermaidValidatorTool` 检查结构，再在前端代码模式粘贴渲染。
