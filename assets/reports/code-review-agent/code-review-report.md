# 代码审查 Agent 真实审查报告

> 本报告围绕代码审查场景，基于真实代码审查调用链路生成并人工整理，用于展示代码理解、问题定位、风险分级、修复建议和审查报告生成流程。正式使用时仍需接入真实仓库上下文并进行人工复核。

## 1. 审查目标

审查作品集样例文件中的常见工程问题：

```text
assets/reports/code-review-agent/code-review-sample.py
```

重点关注：

- SQL 字符串拼接风险
- 输入校验
- 硬编码配置
- 异常处理
- 资源释放
- 重复逻辑
- 命名和可维护性
- 人工复核要求

## 2. 待审查文件

```text
~/Documents/agent-portfolio-cases/assets/reports/code-review-agent/code-review-sample.py
```

该文件是作品集演示样例，不涉及真实业务系统，不包含真实密钥。

## 3. 运行方式

本次验证完成了 LLM 健康检查，并通过真实代码审查调用链路生成审查结果。

原始输出保存于：

```text
assets/reports/code-review-agent/code-review-real-output.md
```

说明：直接使用 CLI 参数 `--repo ~/Documents/agent-portfolio-cases` 时，当前实现会到目标仓库下寻找 `code_agent/prompts`，导致初始化失败。因此本次真实运行使用审查 Agent 的运行目录作为 Agent 根目录，并将目标文件内容传入审查任务。

## 4. 代码概览

样例代码模拟一个用户导出脚本，主要流程包括：

1. 连接本地 SQLite 数据库。
2. 根据用户状态查询用户列表。
3. 根据用户 ID 查询用户详情。
4. 解析用户 profile JSON。
5. 格式化用户信息并写入文本文件。

代码中保留了若干适合审查的常见问题，用于展示 Agent 的代码理解和审查输出能力。

## 5. 主要问题清单

| 编号 | 问题 | 风险等级 | 影响 |
| --- | --- | --- | --- |
| CR-001 | SQL 查询使用字符串拼接 | 高 | 用户输入直接进入 SQL 字符串，正式场景应使用参数化查询。 |
| CR-002 | 硬编码配置 | 中 | 数据库路径、环境名和占位邮箱写在代码中，不利于环境隔离。 |
| CR-003 | 重复格式化逻辑 | 中 | 两个格式化函数逻辑重复，维护成本较高。 |
| CR-004 | 文件写入未使用上下文管理器 | 中 | 写入异常时文件句柄可能无法及时释放，且未指定编码。 |
| CR-005 | 异常捕获过宽 | 中 | `except Exception` 只输出固定文本，掩盖真实错误原因。 |
| CR-006 | JSON 解析缺少异常处理 | 低 | 非法 JSON 会直接抛出异常，调用方缺少明确处理。 |
| CR-007 | 数据库连接未使用上下文管理器 | 低 | 查询异常时连接释放不够稳妥。 |

## 6. 风险等级

| 风险等级 | 数量 | 说明 |
| --- | ---: | --- |
| 高 | 1 | SQL 拼接风险应优先修复。 |
| 中 | 4 | 影响稳定性、可维护性和环境隔离。 |
| 低 | 2 | 主要影响防御性编码和长期维护。 |

## 7. 问题定位

### CR-001 SQL 查询使用字符串拼接

位置：

```text
load_users(status, limit)
load_user_detail(user_id)
```

说明：

`status`、`limit` 和 `user_id` 未经过校验就进入 SQL 字符串。正式代码应使用参数化查询，并对输入做白名单、类型和范围校验。本报告只说明风险和修复方向，不提供攻击 payload。

### CR-002 硬编码配置

位置：

```text
DATABASE_PATH = "demo_users.db"
DEFAULT_ENV = "production"
ADMIN_EMAIL = "admin@example.invalid"
```

说明：

配置写在代码中不利于本地、测试、演示环境隔离。`example.invalid` 是占位地址，不是真实邮箱；正式项目应使用配置文件或环境变量。

### CR-003 重复格式化逻辑

位置：

```text
format_active_user(row)
format_inactive_user(row)
```

说明：

两个函数逻辑基本一致，仅局部变量名不同。后续维护时如果字段格式变化，需要同时修改两处。

### CR-004 文件写入未使用上下文管理器

位置：

```text
export_users(status, limit, output_path)
```

说明：

当前使用手动 `open()` 和 `close()`，且未指定编码。建议改为上下文管理器，确保异常路径也能释放资源。

### CR-005 异常捕获过宽

位置：

```text
main()
```

说明：

`except Exception` 只打印 `export failed`，会掩盖数据库连接、SQL 执行、文件写入等具体错误。

## 8. 修复建议

| 问题编号 | 建议 |
| --- | --- |
| CR-001 | 使用 `cursor.execute(sql, params)` 参数化查询，并校验 `status`、`limit`、`user_id`。 |
| CR-002 | 从环境变量或配置文件读取数据库路径和环境名。 |
| CR-003 | 合并为统一的 `format_user(row)`，或使用 `sqlite3.Row` 按列名访问。 |
| CR-004 | 使用 `with open(output_path, "w", encoding="utf-8") as f:`。 |
| CR-005 | 捕获具体异常，至少记录异常类型和消息；正式场景接入结构化日志。 |
| CR-006 | 捕获 `json.JSONDecodeError`，返回默认值或抛出带上下文的异常。 |
| CR-007 | 使用 `with sqlite3.connect(...) as conn:` 管理连接生命周期。 |

## 9. 优化后代码片段

以下片段仅展示修复方向，不是完整替换文件：

```python
def load_users(status: str, limit: int) -> list[tuple]:
    if status not in {"active", "inactive", "pending"}:
        raise ValueError("unsupported status")
    if not isinstance(limit, int) or limit < 1 or limit > 500:
        raise ValueError("limit must be between 1 and 500")

    query = """
        SELECT id, name, email, status
        FROM users
        WHERE status = ?
        LIMIT ?
    """
    with sqlite3.connect(DATABASE_PATH) as conn:
        return conn.execute(query, (status, limit)).fetchall()
```

## 10. 人工复核说明

本次真实 Agent 输出已覆盖问题清单、风险等级、问题定位和修复建议。人工复核时仍需确认：

- Agent 是否基于正确文件内容生成结论。
- 风险等级是否与实际调用边界一致。
- 是否存在误报或漏报。
- 修复建议是否符合项目真实运行方式。
- 报告中是否出现敏感配置、账号、真实邮箱、内部路径等敏感信息。

## 11. 后续可扩展方向

- 修复 CLI `--repo` 指向外部仓库时的 prompts 路径问题。
- 增加只读审查模式和报告导出参数。
- 接入 ruff、mypy、bandit 等静态分析工具。
- 增加“审查-修复-复审”闭环。
- 增加 Git diff 审查模式。
