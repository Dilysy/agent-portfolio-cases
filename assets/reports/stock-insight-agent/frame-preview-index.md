# 智能股票分析助手 Agent 抽帧预览索引

## 1. 抽帧信息

- 原始视频：`assets/demos/stock-insight-agent/raw/stock-insight-agent-raw-demo.mov`
- 抽帧目录：`assets/reports/stock-insight-agent/frame-preview/`
- 抽帧策略：每 5 秒抽取 1 张预览图
- 抽帧数量：14 张
- 原始视频信息：约 69.38 秒，1900x990，H.264 + AAC

本次仅做抽帧预览和内容判断，未修改原始视频，未导出最终 MP4，未剪辑视频，未提交 Git。

## 2. 抽帧索引

| 时间点 | 图片路径 | 画面内容判断 | 是否适合进入剪辑 | 备注 |
| --- | --- | --- | --- | --- |
| 00:00 | `assets/reports/stock-insight-agent/frame-preview/frame-000s.png` | Gradio 首页，快速分析模式和输入区可见 | 是 | 适合作为片头或界面结构展示；页面顶部显示内部英文应用标题，最终可用字幕统一中文案例名。 |
| 00:05 | `assets/reports/stock-insight-agent/frame-preview/frame-005s.png` | 股票查询输入阶段，输入框已有查询文本 | 是 | 适合展示自然语言查询输入；无敏感信息。 |
| 00:10 | `assets/reports/stock-insight-agent/frame-preview/frame-010s.png` | 实时行情查询进行中，显示 ReAct 快路径和 `GetRealtimeQuote` 工具调用 | 是 | 适合展示工具调用过程；无敏感配置。 |
| 00:15 | `assets/reports/stock-insight-agent/frame-preview/frame-015s.png` | 实时行情结果开始展示 | 是 | 可作为实时行情展示段落。 |
| 00:20 | `assets/reports/stock-insight-agent/frame-preview/frame-020s.png` | 实时行情结果继续展示，包含价格、涨跌幅等公开行情字段 | 是 | 关键结果画面，建议保留 3-5 秒。 |
| 00:25 | `assets/reports/stock-insight-agent/frame-preview/frame-025s.png` | 实时行情结果停留，右侧输入区准备下一条问题 | 是 | 可用于结果停留或转场。 |
| 00:30 | `assets/reports/stock-insight-agent/frame-preview/frame-030s.png` | 技术指标分析结果开始展示，含 MA 均线等字段 | 是 | 适合展示技术指标分析能力。 |
| 00:35 | `assets/reports/stock-insight-agent/frame-preview/frame-035s.png` | 技术指标分析结果继续展示 | 是 | 可保留为技术分析结果停留。 |
| 00:40 | `assets/reports/stock-insight-agent/frame-preview/frame-040s.png` | 技术指标分析结果继续展示，滚动区域可见 | 是 | 可保留短段，避免与 00:35 重复太久。 |
| 00:45 | `assets/reports/stock-insight-agent/frame-preview/frame-045s.png` | 技术指标结果末尾，并准备进入风险分析输入 | 可选 | 属于技术段落到风险段落的过渡，若成片较短可删除或加速。 |
| 00:50 | `assets/reports/stock-insight-agent/frame-preview/frame-050s.png` | 技术分析结尾与风险分析输入/开始阶段 | 是 | 适合作为近期行情和风险分析段落的起点。 |
| 00:55 | `assets/reports/stock-insight-agent/frame-preview/frame-055s.png` | 风险分析进行中，显示工具调用 `GetRealtimeQuote` 和 `CalcIndicators` | 是 | 适合展示风险分析工具链；无敏感信息。 |
| 01:00 | `assets/reports/stock-insight-agent/frame-preview/frame-060s.png` | 风险分析结果开始展示，包含公开行情和技术指标摘要 | 是 | 适合展示主要风险分析结果。 |
| 01:05 | `assets/reports/stock-insight-agent/frame-preview/frame-065s.png` | 风险分析结果继续展示，包含 MACD、RSI、布林带、关键价位和风险因素 | 是 | 适合作为结尾前结果停留画面；包含“不构成投资建议”边界表述。 |

## 3. 敏感信息检查

| 检查项 | 是否发现 | 说明 |
| --- | --- | --- |
| 密钥 | 否 | 抽帧中未见密钥、Token 或类似内容。 |
| 模型配置 | 否 | 抽帧中未见模型配置或模型配置名称。 |
| 接口地址 | 否 | 抽帧中未见接口地址。 |
| 本地私密配置文件 | 否 | 抽帧中未见环境变量文件或配置内容。 |
| Codex 对话 | 否 | 抽帧中未见 Codex 或编辑器对话内容。 |
| 终端敏感信息 | 否 | 抽帧中未见终端窗口。 |
| 账户隐私信息 | 否 | 抽帧中未见账号、邮箱、微信或浏览器隐私信息。 |
| 与股票分析无关的桌面内容 | 否 | 抽帧均为 Gradio 应用页面。 |

注意：页面顶部显示内部英文应用标题，不是密钥或隐私信息，但如果最终展示口径要求完全使用“智能股票分析助手 Agent”，建议在剪辑时用片头、字幕或遮罩统一中文名称。

## 4. 推荐保留时间段

| 推荐时间段 | 内容 | 剪辑建议 |
| --- | --- | --- |
| 00:00-00:06 | Gradio 首页和问题输入 | 作为片头和交互入口，可保留 4-6 秒。 |
| 00:08-00:25 | 实时行情查询与结果 | 展示 `GetRealtimeQuote` 工具调用和公开行情结果，建议保留 10-14 秒。 |
| 00:28-00:42 | 技术指标分析结果 | 展示 MA、MACD、RSI、布林带等指标，建议保留 10-12 秒。 |
| 00:50-01:05 | 近期行情和主要风险分析 | 展示工具调用、指标摘要和风险因素，建议保留 12-15 秒。 |

## 5. 建议删除或加速片段

| 时间段 | 原因 | 处理建议 |
| --- | --- | --- |
| 00:06-00:08 | 输入后等待开始，信息增量较少 | 可删除或加速。 |
| 00:25-00:28 | 实时行情结果到技术指标输入之间的过渡 | 可删除或加速。 |
| 00:42-00:50 | 技术分析结果末尾与风险分析输入过渡，画面重复度较高 | 可按节奏压缩，保留 1-2 秒过渡即可。 |

## 6. 阶段判断

可以进入剪辑计划阶段。

建议下一步生成：

```text
assets/reports/stock-insight-agent/ffmpeg-edit-plan.md
```

剪辑计划建议目标：

- 成片时长：40-55 秒。
- 第一版：字幕版，不做配音。
- 输出规格：1920x1080，MP4，H.264。
- 重点展示：Gradio 首页、自然语言输入、实时行情、技术指标、风险因素归纳。
- 对外边界：不构成投资建议，仅用于公开信息分析流程演示。
