# 代码审查 Agent 示例运行记录

## 1. 示例输入

输入样例是一段用于演示的待审查 Python 代码，位置如下：

```text
assets/reports/code-review-agent/code-review-sample.py
```

```text
请审查 assets/reports/code-review-agent/code-review-sample.py，关注异常处理、输入校验、硬编码配置、SQL 拼接风险、重复逻辑、命名清晰度和测试建议。只输出审查报告，不要直接修改文件。
```

## 2. 待审查代码片段

示例文件：`assets/reports/code-review-agent/code-review-sample.py`

该文件是为作品集演示生成的 Python 代码样例，不涉及真实业务系统，不包含真实密钥。样例中故意保留了若干适合审查的问题，包括硬编码配置、输入校验不足、字符串拼接 SQL、异常处理不足、重复逻辑和命名不清晰。

## 3. 执行过程

当前已完成真实 LLM 和真实代码审查调用链路验证。执行过程如下：

1. 在审查 Agent 运行目录创建 Python 3.12.13 虚拟环境。
2. 安装 CLI 主链路最小依赖。
3. 使用临时健康检查脚本验证 LLM 可用，且本地模型配置完整。
4. 验证审查 Agent CLI 可启动并退出。
5. 由于直接 `--repo` 指向作品集仓库存在 prompts 路径限制，改用真实代码审查调用链路。
6. 将待审查文件内容传入 Agent，执行只读审查。
7. Agent 输出结构化审查报告，不直接修改文件。
8. 保存真实输出到 `assets/reports/code-review-agent/code-review-real-output.md`。

## 4. 工具调用记录

真实运行记录如下：

| 步骤 | 工具 | 输入 | 预期输出 | 状态 |
| --- | --- | --- | --- | --- |
| 1 | `HelloAgentsLLM` | 健康检查提示 | 返回中文健康检查文本 | 已完成 |
| 2 | `hello_code_cli.py` | `--repo .` 与 `:quit` | CLI 启动并退出 | 已完成 |
| 3 | `hello_code_cli.py` | `--repo ~/Documents/agent-portfolio-cases` | 初始化失败，缺少目标仓库下的 prompts | 已记录 |
| 4 | 真实代码审查调用链路 | 内联待审查代码和只读审查任务 | 真实审查报告 | 已完成 |

原始输出：`assets/reports/code-review-agent/code-review-real-output.md`。

## 5. 审查结果

真实 Agent 输出包括问题清单、风险等级、问题定位、修复建议和人工复核说明。主要审查结果如下：

| 问题 | 风险等级 | 说明 |
| --- | --- | --- |
| SQL 使用字符串拼接 | 高 | 用户输入直接拼入 SQL 字符串，正式场景应改为参数化查询。 |
| 硬编码配置 | 中 | 数据库地址、用户名和环境名写在代码中，不利于环境隔离。 |
| 重复格式化逻辑 | 中 | `format_active_user` 和 `format_inactive_user` 基本重复。 |
| 文件写入未使用上下文管理器 | 中 | 手动 `open` / `close`，异常路径下资源释放不稳妥。 |
| 异常捕获过宽 | 中 | `except Exception` 掩盖具体错误原因。 |
| JSON 解析缺少异常处理 | 低 | 非法 JSON 会直接抛出异常。 |
| 数据库连接未使用上下文管理器 | 低 | 查询异常时连接释放不够稳妥。 |

## 6. 修复建议

- 使用参数化查询替代 SQL 字符串拼接，不提供攻击 payload。
- 将数据库配置移入环境变量或配置文件，并使用占位值。
- 对输入参数做白名单、类型和范围校验。
- 对文件读取、JSON 解析和数据库连接增加可预期异常处理。
- 抽取重复格式化逻辑。
- 增加类型标注和单元测试。

## 7. 人工复核结论

当前审查报告已基于真实 Agent 输出整理。正式使用时仍需要人工复核以下内容：

- 问题定位是否准确。
- 风险等级是否克制。
- 修复建议是否符合项目上下文。
- 报告中是否出现敏感信息。
- 是否误报安全问题或夸大能力。

## 8. 当前不足

- 直接 `--repo` 指向作品集仓库存在 prompts 路径限制。
- 未完成 `hello-agents[all]` 全量可选依赖安装。
- 本次为单轮只读审查，未执行修复和复审。
- 尚未接入专用静态分析工具。
- 尚未形成自动报告生成命令。
- 尚未截图、录屏或剪辑视频。

## 9. 可改进方向

- 增加只读审查模式提示词。
- 接入 ruff、mypy、bandit 等工具作为审查证据。
- 增加固定报告模板和 HTML 导出脚本。
- 增加 Git diff 审查任务，用于展示 PR 级审查。
- 在真实录屏前准备干净终端环境，避免显示敏感配置、账号或私人路径。

## 10. 演示材料路径

- 待审查代码样例：`assets/reports/code-review-agent/code-review-sample.py`
- 真实 Agent 输出：`assets/reports/code-review-agent/code-review-real-output.md`
- 审查报告：`assets/reports/code-review-agent/code-review-report.md`
- HTML 预览页：`assets/reports/code-review-agent/report-preview.html`
- 运行结果记录：`assets/reports/code-review-agent/code-review-run-result.md`
- 原始截图目录：`assets/screenshots/code-review-agent/raw/`
- 原始录屏目录：`assets/demos/code-review-agent/raw/`
- 最终演示视频：`assets/demos/code-review-agent/code-review-agent-demo.mp4`
