# 自然语言数据库查询 Agent 本地化运行验证步骤

## 1. 项目来源

原项目路径：

```text
~/Documents/hello-agents/Co-creation-projects/939147533-DatabaseAgent
```

## 2. 项目定位

该工程是一个命令行自然语言数据库查询 Agent。用户输入中文查询需求后，Agent 按 ReAct 流程获取 Oracle Schema、生成 Oracle SQL、校验 SQL 并执行查询，最后返回格式化结果。

当前作品集阶段已完成工程理解、文档整理、模拟 Schema、SQL 示例、查询结果样例、HTML 预览页、原始录屏归档、抽帧复核和字幕版演示视频。尚未接入真实 Oracle 数据库运行。

## 3. 代码结构

```text
939147533-DatabaseAgent/
├── README.md
├── main.py
├── test.py
├── requirements.txt
├── setup_database.sql
├── .env.example
└── src/
    ├── config.py
    ├── react_agent.py
    └── tools.py
```

关键文件：

- `main.py`：命令行交互入口。
- `test.py`：数据库连接、SQL 生成和 Agent 查询测试入口。
- `src/react_agent.py`：`DatabaseAgent`、ReAct Prompt、工具注册和执行循环。
- `src/tools.py`：Oracle 查询工具、SQL 生成工具和结果格式化。
- `src/config.py`：数据库配置读取。
- `setup_database.sql`：Oracle 测试表和样例数据脚本。

## 4. 环境准备

要求：

- Python 3.10+
- Oracle 数据库或 Oracle 测试环境
- 可用 LLM API 服务

当前不强制接入真实 Oracle；作品集演示使用模拟销售业务 Schema。

## 5. 依赖安装

```bash
cd ~/Documents/hello-agents/Co-creation-projects/939147533-DatabaseAgent
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

主要依赖：

- `hello-agents`
- `openai`
- `oracledb`
- `python-dotenv`

## 6. 数据库配置

原项目依赖 Oracle 数据库，`setup_database.sql` 提供员工、部门和项目测试表。正式演示前可选择：

1. 使用 Oracle 测试库执行 `setup_database.sql`。
2. 改造为 SQLite / DuckDB 本地演示库。
3. 使用当前作品集的模拟 Schema 展示 Text-to-SQL 流程，不执行真实数据库查询。

当前阶段采用第 3 种方式，已生成：

- `assets/reports/database-query-agent/database-schema-example.md`
- `assets/reports/database-query-agent/database-query-sql-example.md`
- `assets/reports/database-query-agent/database-query-result.md`
- `assets/reports/database-query-agent/report-preview.html`

## 7. 环境变量配置

只读取 `.env.example` 和代码中的变量名，不读取真实 `.env`。

需要配置：

```text
LLM_MODEL_ID=
LLM_API_KEY=
LLM_BASE_URL=
DB_HOST=
DB_PORT=
DB_SERVICE_NAME=
DB_USERNAME=
DB_PASSWORD=
```

安全要求：

- `.env` 不允许提交。
- 不在文档、截图、录屏或日志中展示 API Key、数据库用户名或密码。
- 数据库账号必须使用只读账号，不使用管理员账号进行演示。

## 8. 启动方式

运行主程序：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/939147533-DatabaseAgent
source .venv/bin/activate
PYTHONPATH=src python main.py
```

运行测试：

```bash
PYTHONPATH=src python test.py
```

如果使用 Oracle 测试库，可先执行：

```bash
sqlplus <只读或测试用户>/<密码>@<主机>:1521/<服务名> @setup_database.sql
```

上面命令仅为格式示例，不写入真实账号或密码。

## 9. 示例运行方式

命令行输入示例：

```text
查询 2025 年各地区销售额排名前 5 的地区，并返回销售额和订单数。
```

预期流程：

1. `GetSchema` 获取表结构。
2. `GenerateSQL` 生成只读 SQL。
3. `validate_sql` 校验危险语句。
4. `ExecuteQuery` 执行 SQL。
5. `format_query_result` 格式化结果。

## 10. 当前本地化运行验证状态

已完成：

- 阅读原项目 README 和代码结构。
- 确认工程为 CLI + Oracle + ReAct Agent。
- 确认工具包含 GetSchema、GenerateSQL、ExecuteQuery。
- 确认已有基础 SQL 安全校验。
- 生成本地演示 Schema。
- 生成自然语言问题和 SQL 示例。
- 生成查询结果样例。
- 生成 HTML 预览页。
- 归档原始录屏和关键截图。
- 生成抽帧索引和 ffmpeg 剪辑计划。
- 生成字幕版演示视频。

未完成：

- 未接入真实 Oracle。
- 未运行真实 LLM + Oracle 查询链路。

## 11. 已知问题

1. 原项目依赖 Oracle，环境准备成本高于 SQLite / DuckDB。
2. `test.py` 会打印数据库连接串，真实演示时需避免展示账号和密码。
3. `DatabaseConfig` 默认用户名为 `system`，企业演示必须改为只读账号。
4. SQL 安全控制当前是字符串级校验，尚未做 SQL AST 校验。
5. 当前没有查询行数限制、超时限制、审计日志和字段脱敏。

## 12. 视频生成方式

当前演示视频路径：

```text
assets/demos/database-query-agent/database-query-agent-demo.mp4
```

生成过程：

1. 归档原始录屏到 `assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov`。
2. 归档 4 张关键截图到 `assets/screenshots/database-query-agent/raw/`。
3. 使用 `assets/reports/database-query-agent/frame-preview-index.md` 复核关键画面。
4. 使用 `scripts/database_query_video/build_demo.sh` 生成 1920x1080 MP4。
5. 第一版为字幕版演示，不处理配音。

## 13. 后续如何接入真实数据库

后续可按以下方向扩展：

1. Oracle：沿用原项目 `oracledb` 连接方式，使用只读账号和测试库。
2. MySQL：将连接工具改为 `pymysql` 或 SQLAlchemy，并适配 MySQL 方言。
3. PostgreSQL：将连接工具改为 `psycopg` 或 SQLAlchemy，并适配 PostgreSQL 方言。
4. SQLite / DuckDB：用于低成本本地演示和录屏，适合快速验证 Text-to-SQL 流程。

所有真实数据库接入都必须先完成权限、脱敏、审计和执行前确认设计。

## 14. 下一步操作

1. 准备本地 SQLite / DuckDB 演示库，降低 Oracle 依赖。
2. 或配置 Oracle 测试库和只读账号，执行 `setup_database.sql`。
3. 将样例问题跑通，记录 SQL 和查询结果。
4. 增加 SQL AST 校验、查询成本估算和审计日志。
5. 增加真实数据库版本的运行记录。

## 15. 企业落地安全控制

企业落地时必须加入：

1. 只读数据库账号。
2. SQL 白名单。
3. 禁止 `DROP` / `DELETE` / `UPDATE` / `INSERT` 等危险语句。
4. 查询行数限制。
5. 查询超时限制。
6. 敏感字段脱敏。
7. 查询审计日志。
8. 表级和字段级权限控制。
9. SQL 执行前确认机制。
