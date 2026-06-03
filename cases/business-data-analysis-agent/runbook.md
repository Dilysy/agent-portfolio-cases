# 企业经营数据分析 Agent 本地复现步骤

## 环境准备

- Python 3.10+
- Jupyter Lab 或 Notebook
- 本地参考目录：
  - `~/Documents/hello-agents/Co-creation-projects/alexrunner-DataAnalysisAgent`
  - `~/Documents/hello-agents/Co-creation-projects/1zrj-DataAnalysisAgent`

## 依赖安装

`alexrunner` 版本：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/alexrunner-DataAnalysisAgent
python3 -m venv venv
source ./venv/bin/activate
pip install -r requirements.txt
```

`1zrj` 版本：

```bash
cd ~/Documents/hello-agents/Co-creation-projects/1zrj-DataAnalysisAgent
pip install -r requirements.txt
```

## 配置说明

`alexrunner` 项目：

```bash
cp .env.example .env
```

配置 `OPENAI_API_KEY` 或 HelloAgents 支持的兼容模型服务。

`1zrj` 项目支持 `.env` 配置，也可在 Notebook 中设置 `LLM_MODEL_ID`、`LLM_API_KEY`、`LLM_BASE_URL`。

## 启动方式

`alexrunner` 版本：

```bash
python3 ./main.py
```

`1zrj` 版本：

```bash
jupyter lab
```

打开 `main.ipynb` 并运行。

## 示例运行

- `alexrunner` 输出：`out/analysis_report.md` 和 `out/figures/` 下的图表。
- `1zrj` 输出：`output/report.md` 和 `output/echarts.html`。

## 常见问题

- 报告没有图表：检查 `out/figures` 或 `output` 目录是否创建成功。
- 分析任务格式错误：检查 PlanningAgent 是否返回 Python 列表。
- Excel 读取失败：确认安装 `xlrd`，并检查文件路径。
- 结论过度推断：回到计算结果，改写为“基于样例数据的观察”。
