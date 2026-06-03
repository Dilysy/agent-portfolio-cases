# 自然语言数据库查询 Agent 本地复现步骤

## 环境准备

- Python 3.10+
- Oracle 数据库或可用的 Oracle 测试环境
- 本地参考目录：`~/Documents/hello-agents/Co-creation-projects/939147533-DatabaseAgent`

## 依赖安装

```bash
cd ~/Documents/hello-agents/Co-creation-projects/939147533-DatabaseAgent
pip install -r requirements.txt
```

主要依赖包括 HelloAgents、LLM 相关库、`oracledb` 和 `python-dotenv`。

## 配置说明

```bash
cp .env.example .env
```

需要配置：

- `LLM_MODEL_ID`
- `LLM_API_KEY`
- `LLM_BASE_URL`
- `DB_HOST`
- `DB_PORT`
- `DB_SERVICE_NAME`
- `DB_USERNAME`
- `DB_PASSWORD`

## 启动方式

先创建测试数据：

```bash
sqlplus 用户名/用户密码@数据库地址:1521/服务名称 @setup_database.sql
```

运行测试程序：

```bash
python test.py
```

运行主程序：

```bash
python main.py
```

## 示例运行

进入命令行后输入：

```text
查询所有员工信息
```

或：

```text
查询IT部门的员工平均工资
```

Agent 会按 ReAct 流程获取 schema、生成 SQL、执行查询并输出表格。

## 常见问题

- 数据库配置不完整：检查 `.env` 中 `DB_HOST`、端口、服务名、用户名和密码。
- Oracle 连接失败：确认数据库服务可访问，并检查 `oracledb` 客户端环境。
- SQL 被拒绝：检查是否生成了非 `SELECT`/`WITH` 查询或包含危险关键字。
- 查询结果不符合预期：回看实际 SQL 和 schema，修正字段口径。
