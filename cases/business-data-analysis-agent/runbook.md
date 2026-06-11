# 企业经营数据分析 Agent 本地化运行验证步骤

## 1. 项目来源

本案例综合两个底层工程进行场景化整理：

1. `<local-business-analysis-source-a>`
2. `<local-business-analysis-source-b>`

作品集目录：

```text
cases/business-data-analysis-agent/
```

资产目录：

```text
assets/reports/business-data-analysis-agent/
assets/screenshots/business-data-analysis-agent/
assets/demos/business-data-analysis-agent/
```

## 2. 项目定位

`多 Agent 经营分析原型` 适合作为多 Agent 经营分析流水线参考：PlanningAgent 负责数据探查和任务规划，AnalysisAgent 负责调用分析工具，ReportAgent 负责汇总 Markdown 报告。

`Notebook 表格分析原型` 适合作为 Notebook 表格分析原型参考：读取 Excel 数据，调用清洗工具，生成 ECharts 配置和 Markdown 报告。

作品集版本定位为“企业经营数据分析 Agent”，用于展示模拟经营数据到指标分析、图表和报告的链路。本阶段不接入真实企业数据，不写成真实客户交付。

## 3. 代码结构

### 多 Agent 经营分析原型

```text
多 Agent 经营分析原型/
├── README.md
├── requirements.txt
├── 本地配置模板
├── main.py
├── data/
│   └── shopping_behavior_updated.csv
├── agents/
│   ├── react_agent.py
│   ├── agent_prompts.py
│   ├── test_planning_agent.py
│   ├── test_analysis_agent.py
│   └── test_report_agent.py
└── tools/
    ├── data_exploration.py
    └── data_analysis.py
```

实现形态：Python 主程序 + 工具模块 + Agent 测试脚本。

### Notebook 表格分析原型

```text
Notebook 表格分析原型/
├── README.md
├── requirements.txt
├── main.ipynb
├── data/
│   └── simple_data.xls
└── output/
    ├── echarts.html
    └── report.md
```

实现形态：Jupyter Notebook + Excel 样例数据 + HTML 图表和 Markdown 报告输出。

## 4. 环境准备

推荐环境：

- Python 3.10+
- Jupyter Lab 或 Notebook
- 可访问 LLM 服务的网络环境
- matplotlib / pandas / xlrd 等数据分析依赖

注意：不要读取、打印或提交 `本地配置文件`。如果 Notebook 中存在硬编码 私密凭证，展示前必须清理。

## 5. 依赖安装

### 多 Agent 原型 版本

```bash
cd <local-business-analysis-source-a>
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

### Notebook 原型 版本

```bash
cd <local-business-analysis-source-b>
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

如果读取 `.xls` 文件失败，优先确认是否安装 `xlrd`。

## 6. 数据准备

### 底层工程数据

- `多 Agent 原型` 使用 `data/shopping_behavior_updated.csv`，约 3900 行，字段包含年龄、性别、商品类别、购买金额、季节、订阅状态、支付方式等。
- `Notebook 原型` 使用 `data/simple_data.xls`，用于 Notebook 表格分析和 ECharts 输出。

### 作品集模拟数据

本阶段已生成模拟销售数据：

```text
assets/reports/business-data-analysis-agent/sample-sales-data.csv
```

字段：

```text
订单日期, 地区, 客户类型, 商品类别, 商品名称, 销售额, 订单数, 毛利率
```

该数据为人工构造的模拟经营数据，不包含真实企业、真实客户或真实订单。

## 7. 启动方式

### 多 Agent 原型 版本

```bash
cd <local-business-analysis-source-a>
source .venv/bin/activate
cp 本地配置模板 本地配置文件
python3 ./main.py
```

需要配置：

```text
本地私密凭证=
本地私密凭证=
本地私密凭证=
本地私密凭证=
```

输出路径：

```text
out/analysis_report.md
out/figures/
```

### Notebook 原型 版本

```bash
cd <local-business-analysis-source-b>
source .venv/bin/activate
jupyter lab
```

打开并运行：

```text
main.ipynb
```

输出路径：

```text
output/report.md
output/echarts.html
```

注意：Notebook 中存在硬编码模型环境变量配置，正式展示前应改为 `本地配置文件` 加载或脱敏后的占位符。

## 8. 示例运行方式

作品集演示任务：

```text
请基于 2025 年模拟销售数据，分析企业全年经营表现，输出月度销售趋势、地区销售表现、商品类别贡献、客户类型差异、毛利率分析和经营建议。
```

当前演示补充材料生成方式：

1. 生成 2025 年 1 月至 12 月的模拟销售数据。
2. 使用 pandas 计算销售额、订单数、平均订单金额、加权毛利率。
3. 按月份、地区、商品类别、客户类型做分组聚合。
4. 使用 matplotlib 生成 4 张中文图表。
5. 生成 Markdown 经营分析报告和运行结果记录。
6. 使用报告内容生成 2 张报告展示图。
7. 使用 ffmpeg 将图表、报告展示图和硬字幕合成为静音字幕版演示视频。

## 9. 当前运行验证状态

当前运行状态：已完成演示样例。

当前演示口径为“模拟数据演示 / 本地验证”。本案例未接入真实企业数据，所有销售数据、经营问题和建议均基于模拟数据生成，不代表真实企业经营结论。

已完成：

- 阅读两个底层工程 README、requirements、代码结构和主要入口。
- 梳理两个项目的定位、技术栈、启动方式和 Agent 设计。
- 梳理数据探查、数据分析、数据清洗、统计、图表和报告工具。
- 生成模拟销售数据 `sample-sales-data.csv`。
- 生成 4 张中文图表。
- 生成经营数据分析报告样例。
- 生成运行结果记录。
- 生成 2 张报告展示图。
- 生成字幕版演示视频 `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`。

未纳入正式展示范围：

- 未在 `多 Agent 原型` 中完整运行 `python3 ./main.py`。
- 未在 `Notebook 原型` 中清理硬编码配置并重新执行 Notebook。
- 未接入真实 CSV / Excel 业务数据。

### 模拟数据生成方式

- 数据文件：`assets/reports/business-data-analysis-agent/sample-sales-data.csv`
- 生成方式：使用 Python 构造 2025 年全年模拟销售记录，字段包括订单日期、地区、客户类型、商品类别、商品名称、销售额、订单数和毛利率。
- 数据边界：仅用于案例演示，不包含真实企业、真实客户或真实订单。

### 图表生成方式

- 使用 pandas 完成月度、地区、商品类别和客户类型聚合。
- 使用 matplotlib 输出 4 张中文 PNG 图表。
- 图表路径：
  - `assets/screenshots/business-data-analysis-agent/final/01-sales-trend.png`
  - `assets/screenshots/business-data-analysis-agent/final/02-region-comparison.png`
  - `assets/screenshots/business-data-analysis-agent/final/03-category-contribution.png`
  - `assets/screenshots/business-data-analysis-agent/final/04-customer-type-analysis.png`

### 报告生成方式

- 报告文件：`assets/reports/business-data-analysis-agent/business-data-analysis-report.md`
- 报告内容基于模拟数据聚合指标生成，包含分析目标、数据概览、核心指标、趋势、地区、品类、客户类型、毛利率、经营问题、经营建议和人工复核说明。
- 报告展示图：
  - `assets/screenshots/business-data-analysis-agent/final/05-report-overview.png`
  - `assets/screenshots/business-data-analysis-agent/final/06-business-insights.png`

### 视频生成方式

- 输入素材：4 张图表 + 2 张报告展示图。
- 输出成片：`assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4`
- 处理方式：ffmpeg 将静态图片转为 1920x1080 H.264 MP4，并叠加底部硬字幕；当前不处理配音。

### 后续替换为真实 CSV / Excel 数据

1. 先对真实业务数据做脱敏，删除客户名称、联系人、邮箱、电话、合同编号、内部账号等敏感字段。
2. 将真实数据字段映射到订单日期、地区、客户类型、商品类别、销售额、订单数、毛利率等分析口径。
3. 复用 pandas 聚合逻辑生成图表和报告。
4. 接入底层工程 Agent 流水线前，先验证字段口径、统计公式和异常值处理方式。
5. 正式展示前由人工复核所有经营建议，避免把模型输出当作真实经营结论。

## 10. 已知问题

1. `多 Agent 原型` 分析工具与 `shopping_behavior_updated.csv` 固定字段强绑定，迁移到企业经营销售数据需要字段映射改造。
2. `多 Agent 原型` 的 PlanningAgent 依赖 LLM 输出 Python 列表格式，稳定性需要后续运行验证。
3. `Notebook 原型` Notebook 中存在硬编码模型环境变量配置，不适合直接录屏或对外展示。
4. `Notebook 原型` Notebook 的 README 提到 `本地配置模板`，但当前目录未发现该文件。
5. `Notebook 原型` Notebook 注册了 `DataCleaningTool`，但系统提示词要求使用 `DataStatisticsTool`，当前代码需要补注册统计工具后再验证完整链路。
6. `Notebook 原型` 输出的 `echarts.html` 引入外部 ECharts CDN，离线展示时可能无法加载。

## 11. 下一步操作

1. 配置安全的 LLM 环境变量，不在文档或 Notebook 中写真实私密凭证。
2. 优先验证 `多 Agent 原型` 的 `python3 ./main.py` 是否能稳定生成 `out/analysis_report.md` 和图表。
3. 清理 `Notebook 原型` Notebook 中的硬编码模型配置，并补注册 `DataStatisticsTool`。
4. 为录屏准备展示顺序：模拟数据 CSV、四张图表、经营分析报告、运行结果记录。
5. 后续进入截图、录屏和 ffmpeg 字幕版剪辑阶段。
