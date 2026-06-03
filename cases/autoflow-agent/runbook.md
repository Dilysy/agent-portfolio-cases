# AutoFlow 流程图生成 Agent 本地复现步骤

## 环境准备

- Python 3.10+
- Node.js 18+
- npm 9+
- 本地参考目录：`~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow`

## 依赖安装

后端：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
pip install -r requirements.txt
```

前端：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/frontend
npm install
```

## 配置说明

在后端目录创建 `.env`：

```bash
cp .env.example .env
```

至少配置：

- `LLM_MODEL_ID`
- `LLM_API_KEY`
- `LLM_BASE_URL`
- `LLM_TIMEOUT`

前端如需修改 API 地址，可参考 `frontend/.env.example`。

## 启动方式

后端：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

前端：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/usernamedadad-AutoFlow/frontend
npm run dev
```

浏览器访问默认地址：

```text
http://localhost:5173
```

## 示例运行

1. 打开前端页面。
2. 在计划模式输入多行步骤。
3. 点击生成，观察右侧 Mermaid 预览。
4. 切换方向、缩放或导出 `.mmd`/SVG。

## 常见问题

- 后端跨域错误：源项目在非生产环境放宽 localhost/127.0.0.1 任意端口，可检查 CORS 配置。
- Mermaid 渲染错误：查看前端错误提示和 Validator 返回信息。
- LLM 超时：检查 `LLM_TIMEOUT`、模型服务和网络状态。
