# 代码审查 Agent 运行手册

## 1. 项目来源

- 原项目路径：`~/Documents/hello-agents/Co-creation-projects/YYHDBL-HelloCodeAgentCli`
- 原项目 GitHub：`https://github.com/datawhalechina/hello-agents/tree/main/Co-creation-projects/YYHDBL-HelloCodeAgentCli`
- 作品集目录：`~/Documents/agent-portfolio-cases/cases/code-review-agent/`
- 资产目录：`~/Documents/agent-portfolio-cases/assets/reports/code-review-agent/`

## 2. 项目定位

`YYHDBL-HelloCodeAgentCli` 是一个本地代码仓库 Code Agent CLI，用于通过自然语言探索代码、解释代码、辅助审查、生成修改建议，并在用户确认后应用补丁。项目形态是 Python CLI 工具，不是 Notebook、API 服务或 Web 前端。

## 3. 代码结构

```text
YYHDBL-HelloCodeAgentCli/
├── README.md
├── requirement.txt
├── agents/
│   ├── react_agent.py
│   ├── plan_solve_agent.py
│   ├── reflection_agent.py
│   └── simple_agent.py
├── code_agent/
│   ├── hello_code_cli.py
│   ├── agentic/code_agent.py
│   ├── executors/apply_patch_executor.py
│   └── prompts/
├── context/
│   └── builder.py
├── core/
│   ├── config.py
│   ├── llm.py
│   └── message.py
├── tools/
│   ├── registry.py
│   └── builtin/
└── memory/
```

关键文件：

- `code_agent/hello_code_cli.py`：CLI 入口。
- `code_agent/agentic/code_agent.py`：CodeAgent 主逻辑，注册 ReAct、Terminal、ContextFetch、Plan、Todo、Note 等工具。
- `tools/builtin/terminal_tool.py`：白名单终端工具。
- `tools/builtin/context_fetch_tool.py`：代码和上下文检索工具。
- `code_agent/executors/apply_patch_executor.py`：补丁应用执行器。
- `core/llm.py`：OpenAI 兼容 LLM 客户端。

## 4. 环境准备

建议使用 Python 3.10 或更高版本。本次验证使用 Codex bundled Python 创建虚拟环境，版本为 Python 3.12.13。

```bash
cd ~/Documents/hello-agents/Co-creation-projects/YYHDBL-HelloCodeAgentCli
.venv/bin/python3 --version
```

如果本机默认 `python3` 低于 3.10，需要改用可用的 Python 3.10+ 创建虚拟环境：

```bash
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
```

## 5. 依赖安装

当前目录实际存在的依赖文件是 `requirement.txt`，不是 README 中写的 `requirements.txt`。

```bash
python3 -m pip install -r requirement.txt
```

本次验证中的最小修复：

- `requirement.txt` 中原本写有 `hello-agents[all]=0.2.7`，pip 无法解析，已修正为 `hello-agents[all]==0.2.7`。
- `hello-agents[all]` 全量 extras 安装会拉取大量训练、Gradio 和协议生态依赖，并在解析阶段长时间回溯。本次为完成代码审查 CLI 验证，改为安装主链路最小依赖：`openai`、`pydantic`、`python-dotenv`、`tiktoken`、`hello-agents==0.2.7`。
- `code_agent/README.md` 提到 `requirements-mvp.txt`，但当前项目目录未发现该文件。

## 6. 本地模型配置

不要提交或展示本地模型凭据。可在原项目根目录创建本地配置文件，只放本机私有配置；作品集文档不记录具体值。

需要配置的内容包括：

- 模型访问凭据。
- 模型名称。
- 模型服务地址。

可选配置：

```bash
HELLOAGENTS_DIR=.helloagents
CODE_AGENT_MAX_STEPS=8
CODE_AGENT_MAX_REACT_STEPS=20
LLM_TIMEOUT=60
```

源码中还包含搜索工具相关配置，但当前 CodeAgent CLI 主流程没有默认注册搜索工具，代码审查演示阶段不需要配置。

## 7. 启动方式

```bash
cd ~/Documents/hello-agents/Co-creation-projects/YYHDBL-HelloCodeAgentCli
source .venv/bin/activate
python -m code_agent.hello_code_cli --repo .
```

原项目自身 CLI 已验证可启动并退出。直接审查其他仓库的入口设计如下：

```bash
python -m code_agent.hello_code_cli --repo /path/to/target/repo
```

当前检查结果：

- `python3 -m py_compile ...`：核心文件语法检查通过。
- 原项目自身 CLI：可运行。
- `--repo ~/Documents/agent-portfolio-cases`：会通过 LLM 预检，但随后因 `CodeAgent` 到目标仓库查找 `code_agent/prompts/react.md` 而失败。该问题属于原项目路径设计限制。

## 8. CLI 使用方式

进入 CLI 后可以输入自然语言任务：

```text
请审查 assets/reports/code-review-agent/code-review-sample.py，关注异常处理、输入校验、硬编码配置、SQL 拼接风险和测试建议。
```

内置命令：

```text
:quit
:plan <目标>
```

Agent 可能调用的工具：

- `terminal`：读取文件、搜索关键词、查看目录。
- `context_fetch`：按关键词获取代码上下文。
- `plan`：生成审查计划。
- `todo`：记录多步骤任务。
- `note`：记录结论、阻塞或补丁结果。
- `ApplyPatchExecutor`：当模型输出补丁时执行安全落盘。

## 9. 示例运行方式

本次真实审查采用临时脚本调用原项目真实 Agent 链路：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/YYHDBL-HelloCodeAgentCli
.venv/bin/python3 run_code_review_real.py
```

审查任务：

```text
请审查 assets/reports/code-review-agent/code-review-sample.py，输出问题清单、风险等级、问题定位、修复建议和测试建议。只给审查报告，不要直接修改文件。
```

真实输出：

```text
assets/reports/code-review-agent/code-review-real-output.md
```

建议后续修复 prompts 路径限制后，再使用标准 CLI 方式审查作品集仓库。

## 10. 当前复现状态

- 已找到原项目。
- 已阅读 README、CLI 入口、Agent 主逻辑、工具实现、LLM 配置和提示词。
- 已确认项目是 Python CLI 工具。
- 已完成核心文件语法编译检查。
- 已创建 Python 3.12.13 虚拟环境。
- 已安装 CLI 主链路最小依赖。
- 已完成 LLM 健康检查，本地模型配置项完整。
- 原项目自身 CLI 可运行。
- 已通过真实 `CodeAgent.run_turn()` 调用链路生成代码审查输出。
- 已生成作品集阶段的代码样例、真实审查报告和 HTML 预览页。
- 已归档原始录屏和截图，完成抽帧预览。
- 已生成中文字幕版最终演示视频：`assets/demos/code-review-agent/code-review-agent-demo.mp4`。

## 11. 已知问题

1. 依赖文件命名与 README 不一致：实际为 `requirement.txt`。
2. `requirement.txt` 中原版本约束写法需要修正为 `==`。
3. `hello-agents[all]` 全量 extras 依赖较重，安装时间长且容易回溯。
4. 直接使用 `--repo` 指向作品集仓库时，prompt 路径会错误地绑定到目标仓库。
5. 原项目没有固定代码审查报告模板，作品集报告为补充整理。
6. 当前没有专用静态分析工具接入，审查主要依赖代码读取和 LLM 判断。

## 12. 下一步操作

1. 修复 `CodeAgentPaths.prompts_dir`，将 prompts 路径固定到原项目目录，而不是待审查 repo。
2. 增加只读审查模式，避免演示阶段触发补丁落盘。
3. 增加报告导出参数，直接输出 Markdown。
4. 接入 ruff、mypy、bandit 等静态分析工具。
5. 后续如需增强复现链路，可补充固定报告导出命令和自动化复审命令。
