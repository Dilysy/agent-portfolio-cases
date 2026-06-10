# 智能股票分析助手 Agent 原始素材清单

## 1. 原始素材目录

```text
/Users/wangyu/Desktop/案例视频录制/智能股票分析助手Agent
```

处理原则：

- 仅复制素材到作品集标准目录。
- 不移动、不删除、不修改桌面原始素材。
- 不复制 `.DS_Store`。
- 不提交 Git，不执行剪辑和导出。

## 2. 原始素材扫描结果

### 视频文件

| 文件名 | 文件类型 | 文件大小 | 分辨率 / 时长 / 编码 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `录屏2026-06-09 18.00.20.mov` | QuickTime `.mov` 视频 | 12,237,928 bytes，约 11.7 MB | 1900x990，约 69.38 秒，H.264 + AAC | 适合作为正式演示视频主素材。可用于展示 Gradio 前端、股票查询、实时行情、技术指标和风险分析流程；剪辑前需抽帧确认是否包含等待、报错、终端或隐私信息。 |

### 图片文件

| 文件名 | 文件类型 | 文件大小 | 分辨率 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `整体界面.png` | PNG 图片 | 141,292 bytes，约 138 KB | 1506x647 | 适合作为 Gradio 首页 / 整体界面截图，可用于 README 或片头、结尾停留画面。 |

### 其他文件

| 文件名 | 文件类型 | 文件大小 | 可能用途判断 |
| --- | --- | ---: | --- |
| `.DS_Store` | macOS Finder 元数据 | 6,148 bytes，约 6 KB | 不适合用于正式演示或作品集，未复制。 |

## 3. 已归档视频列表

| 标准路径 | 来源文件 | 文件大小 | 说明 |
| --- | --- | ---: | --- |
| `assets/demos/stock-insight-agent/raw/stock-insight-agent-raw-demo.mov` | `录屏2026-06-09 18.00.20.mov` | 12,237,928 bytes | 主录屏素材，保留原 `.mov` 格式。 |

## 4. 已归档截图列表

| 标准路径 | 来源文件 | 文件大小 | 说明 |
| --- | --- | ---: | --- |
| `assets/screenshots/stock-insight-agent/raw/01-gradio-home.png` | `整体界面.png` | 141,292 bytes | Gradio 整体界面截图。 |

## 5. 报告文件列表

当前 `assets/reports/stock-insight-agent/` 下仅生成了本素材清单。

按本阶段检查要求，以下文件当前缺失：

| 文件 | 当前状态 |
| --- | --- |
| `assets/reports/stock-insight-agent/stock-insight-run-result.md` | 缺失，可选补充或从现有金融案例材料迁移时另行确认。 |
| `assets/reports/stock-insight-agent/stock-insight-report.md` | 缺失，可选补充真实运行报告或演示报告。 |
| `assets/reports/stock-insight-agent/report-preview.html` | 缺失，可选补充报告预览页。 |

## 6. Gradio 页面素材

已归档截图 `01-gradio-home.png` 可作为 Gradio 页面素材，适合展示：

- 页面整体结构。
- 模式选择区域。
- 输入区和输出区。
- 智能股票分析助手 Agent 的前端交互入口。

目前缺少更细分的页面截图，例如查询输入、实时行情结果、技术指标结果、风险分析结果和历史记录区域。

## 7. 推荐用于视频剪辑的素材

推荐使用：

1. `assets/demos/stock-insight-agent/raw/stock-insight-agent-raw-demo.mov`
   - 作为正式演示视频主素材。
   - 建议剪辑为 45-60 秒字幕版。
   - 保留 Gradio 前端输入、工具调用过程、实时行情结果、技术指标结果和风险因素归纳。

2. `assets/screenshots/stock-insight-agent/raw/01-gradio-home.png`
   - 可作为片头、结尾或 README 主展示图。
   - 也可在视频中作为静态补帧。

## 8. 推荐用于 README 的截图

推荐使用：

| 截图 | 用途 |
| --- | --- |
| `assets/screenshots/stock-insight-agent/raw/01-gradio-home.png` | README 的 Gradio 前端整体界面展示。 |

可选补充后可优先用于 README 的截图：

- `02-stock-query.png`：股票查询输入。
- `03-realtime-price.png`：实时行情结果。
- `04-technical-analysis.png`：技术指标分析结果。
- `05-risk-analysis.png`：风险因素归纳。
- `06-analysis-history.png`：分析历史或记忆能力。

## 9. 不建议使用的素材

| 素材 | 原因 |
| --- | --- |
| `.DS_Store` | 系统元数据，无展示价值，未复制。 |
| 原始录屏中的等待、报错、终端、桌面隐私或私密配置画面 | 不适合对外展示，剪辑前必须删除或避开。 |

## 10. 缺失素材提醒

当前仅发现 1 张截图，缺少以下标准截图：

- `assets/screenshots/stock-insight-agent/raw/02-stock-query.png`
- `assets/screenshots/stock-insight-agent/raw/03-realtime-price.png`
- `assets/screenshots/stock-insight-agent/raw/04-technical-analysis.png`
- `assets/screenshots/stock-insight-agent/raw/05-risk-analysis.png`
- `assets/screenshots/stock-insight-agent/raw/06-analysis-history.png`

当前案例目录文件也缺失：

- `cases/stock-insight-agent/README.md`
- `cases/stock-insight-agent/runbook.md`
- `cases/stock-insight-agent/sample.md`

## 11. 剪辑前注意事项

1. 对外展示名称统一使用“智能股票分析助手 Agent”。
2. 对外展示名称统一为“智能股票分析助手 Agent”。
3. 对外展示页不要出现底层工程名称。
4. 不要展示真实密钥、接口地址、本地私密配置文件、模型配置或账号信息。
5. 不要写成交易建议系统、真实金融服务或真实交易决策系统。
6. 必须保留边界说明：不构成投资建议，仅用于公开信息分析流程演示。
7. 剪辑前建议先抽帧，确认是否有报错、终端、隐私信息或无效等待。
8. 关键结果画面建议保留 3-5 秒；等待段和鼠标无效移动可删除或加速。
9. 不修改原始录屏和原始截图，剪辑只使用已归档素材。

## 12. 是否可进入下一阶段

可以进入抽帧和剪辑计划阶段。

建议下一步：

1. 对 `assets/demos/stock-insight-agent/raw/stock-insight-agent-raw-demo.mov` 每 3-5 秒抽帧。
2. 基于抽帧结果确认片头、查询输入、实时行情、技术指标、风险分析和结尾时间段。
3. 生成 `assets/reports/stock-insight-agent/ffmpeg-edit-plan.md`。
