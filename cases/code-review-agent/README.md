# 代码审查 Agent

当前状态：已完成。已完成真实 LLM 调用验证、真实代码审查输出整理、HTML 报告预览和字幕版最终演示视频。

## 1. 项目背景

代码审查 Agent 围绕代码审查场景进行本地验证整理，用于展示面向本地代码仓库的智能审查流程。该流程通过 CLI 与本地仓库交互，按需读取代码、检索文件、生成解释、给出修改建议，并在用户确认后以补丁方式落盘。

本案例用于作品集展示“代码理解、问题识别、风险分级、修复建议和审查报告生成”的流程，不写成真实客户交付项目。

## 2. 业务问题

企业知识工作流中的内部工具、自动化脚本和数据处理代码通常存在以下问题：

- 代码质量参差不齐，人工审查耗时。
- 审查意见容易停留在风格层面，缺少可定位、可复核的问题清单。
- 小型团队难以及时发现异常处理、输入校验、SQL 拼接、硬编码配置等常见风险。
- 审查结论缺少统一报告格式，不便于后续整改和复盘。

## 3. 解决方案

本案例将代码审查能力包装为 Agent 演示流程：

1. 使用 CLI 指定待审查仓库或文件目录。
2. Agent 通过 ReAct 循环按需调用工具读取文件、搜索上下文、记录任务进度。
3. LLM 根据代码片段生成审查意见，包括问题定位、风险等级和修复建议。
4. 对需要修改的内容，Agent 可生成 Codex 风格补丁，并由 CLI 执行确认与落盘。
5. 作品集阶段生成 Markdown 审查报告和 HTML 预览页，便于录屏展示。

本案例已完成真实 LLM 调用验证，并通过真实代码审查调用链路生成审查输出。当前定位是本地验证与演示验证，不写成生产级代码审计平台或真实客户交付。

## 4. Agent 设计

| 设计点 | 当前项目实现情况 | 说明 |
| --- | --- | --- |
| ReAct | 已实现 | `CodeAgent` 使用 `ReActAgent`，提示词要求 Thought / Action / Observation / Finish 循环。 |
| 任务拆解 | 部分实现 | `PlanTool` 可生成计划，`TodoTool` 可跟踪多步骤任务；是否使用由用户命令或模型判断。 |
| 代码读取 | 已实现 | `TerminalTool` 支持 `ls`、`rg`、`sed`、`cat` 等只读命令；`ContextFetchTool` 支持按关键词检索代码文件。 |
| 静态分析 | 未形成专用分析器 | 当前主要依赖命令行检索和 LLM 判断，未看到 ruff、mypy、bandit 等专用静态分析工具集成。 |
| LLM 代码审查 | 已具备基础能力 | 通过 OpenAI 兼容接口调用模型，由提示词和工具结果驱动审查结论。 |
| 多轮修复建议 | 部分实现 | CLI 支持多轮对话、历史记录和补丁生成；没有独立的“审查-修复-复审”工作流封装。 |
| CLI 交互 | 已实现 | `python -m code_agent.hello_code_cli --repo <path>` 启动交互式 CLI。 |
| 文件级审查 | 可支持 | 可通过用户指令和工具读取指定文件完成文件级审查。 |
| 片段级审查 | 可支持 | 可让 Agent 聚焦某段函数或指定行附近内容，但当前没有专门的片段选择 UI。 |
| 报告生成 | 可由 LLM 生成 | 当前审查流程没有固定报告模板；本作品集补充了 Markdown 与 HTML 样例。 |

## 5. 工具调用

| 工具名称 | 输入 | 输出 | 作用 | 当前可用状态 |
| --- | --- | --- | --- | --- |
| CLI 入口 `hello_code_cli.py` | `--repo` 指定仓库路径，自然语言指令 | 交互式回答、工具执行过程、可选补丁 | 启动 Code Agent 并管理一轮轮对话 | 已完成本地启动验证；跨仓库直接运行存在 prompts 路径限制 |
| `ReActAgent` | 拼接后的上下文、工具注册表 | Thought / Action / Observation / Finish | 负责推理和工具选择 | 已实现 |
| `TerminalTool` | 白名单命令，如 `rg`、`sed`、`cat` | 命令输出或安全拦截信息 | 文件扫描、代码读取、日志查看 | 已实现 |
| `ContextFetchTool` | `sources`、`query`、可选 `paths` | 结构化上下文片段 | 按需搜索文件、笔记、测试信息 | 已实现；memory 未在 CodeAgent 中启用 |
| `PlanTool` | 目标和约束 | 分步计划 | 复杂审查任务拆解 | 已实现，需要 LLM |
| `TodoTool` | add / list / update | 待办状态列表 | 跟踪多步骤审查过程 | 已实现 |
| `NoteTool` | action、title、content、tags | 结构化笔记文件 | 记录结论、阻塞和补丁结果 | 已实现 |
| `ApplyPatchExecutor` | Codex 风格 patch | 修改文件、备份路径 | 安全应用补丁，包含路径限制、备份和规模限制 | 已实现 |
| `HelloAgentsLLM` | 本地模型配置和消息 | 模型回复 | 生成代码解释、审查结论和修复建议 | 已完成真实调用验证；配置内容不进入作品集 |

## 6. 实现流程

1. 阅读工程 README、CLI 入口、Agent 主逻辑、工具实现和 LLM 配置。
2. 判断项目形态为 Python CLI 工具，不是 Notebook、API 服务或 Web 前端。
3. 梳理 ReAct、工具注册、上下文检索、补丁执行和状态记录链路。
4. 设计一个不涉及真实业务系统的 Python 待审查样例。
5. 基于样例生成代码审查流程演示报告。
6. 将报告转换为本地 HTML 预览页，作为后续录屏展示材料。
7. 归档原始录屏和截图，完成抽帧复核。
8. 基于剪辑脚本生成中文字幕版最终演示视频。

## 7. 输出结果

当前阶段已输出：

- 案例说明：`cases/code-review-agent/README.md`
- 运行手册：`cases/code-review-agent/runbook.md`
- 示例记录：`cases/code-review-agent/sample.md`
- 待审查代码样例：`assets/reports/code-review-agent/code-review-sample.py`
- 审查报告样例：`assets/reports/code-review-agent/code-review-report.md`
- 运行结果记录：`assets/reports/code-review-agent/code-review-run-result.md`
- HTML 预览页：`assets/reports/code-review-agent/report-preview.html`
- 真实审查输出：`assets/reports/code-review-agent/code-review-real-output.md`
- 字幕版最终演示视频：`assets/demos/code-review-agent/code-review-agent-demo.mp4`

## 8. 评估方式

后续真实运行时建议从以下维度评估：

- 能否按需读取指定文件，而不是无边界扫描全仓。
- 能否定位具体函数、变量或代码片段。
- 问题分类是否覆盖异常处理、输入校验、配置管理、安全风险、可维护性和测试建议。
- 风险等级是否克制，是否能区分高风险和一般优化项。
- 修复建议是否可执行，是否避免引入新的行为风险。
- 补丁是否经过人工确认，是否只修改用户允许的文件。
- 审查报告是否明确标注需要人工复核。

## 9. 可扩展方向

- 接入 ruff、mypy、bandit 等静态分析工具，将规则检查结果作为 Agent 证据。
- 增加固定审查模板，输出统一 Markdown / HTML 报告。
- 增加“审查-修复-复审”多轮流程。
- 增加只读模式，避免审查演示时误触发补丁落盘。
- 增加文件白名单和敏感信息扫描，避免报告中暴露密钥、账号或内部路径。
- 增加 Git diff 审查模式，用于 Pull Request 前的变更审查。

## 10. 演示材料

- 最终演示视频：`assets/demos/code-review-agent/code-review-agent-demo.mp4`
- HTML 报告预览：`assets/reports/code-review-agent/report-preview.html`
- 真实审查输出：`assets/reports/code-review-agent/code-review-real-output.md`
- 原始录屏：`assets/demos/code-review-agent/raw/`
- 原始截图：`assets/screenshots/code-review-agent/raw/`
- HTML 预览：`assets/reports/code-review-agent/report-preview.html`
- 审查报告样例：`assets/reports/code-review-agent/code-review-report.md`

当前演示材料用于展示本地验证、真实调用验证和报告整理流程，不代表真实客户交付结果。
