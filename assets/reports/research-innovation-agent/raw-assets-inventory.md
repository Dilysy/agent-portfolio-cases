# 科研创新助手 Agent 原始素材清单

## 1. 原始素材目录

本地桌面录屏目录已完成扫描和归档。对外清单不展示桌面私有路径或原始窗口标题。

扫描时间：2026-06-10。

## 2. 原始素材扫描结果

| 文件名 | 文件类型 | 文件大小 | 分辨率 / 时长 | 可能用途判断 |
| --- | --- | --- | --- | --- |
| 科研创新助手Agent.mov.mov | 视频，QuickTime MOV，H.264 | 128 MB | 1900 x 990，约 250.0 秒 | 主录屏素材，可用于剪辑科研创新助手 Agent 演示视频 |

未发现独立图片文件。未发现其他可用素材文件。`.DS_Store` 未复制。

## 3. 已归档视频列表

| 归档文件 | 来源文件 | 文件大小 | 分辨率 / 时长 | 用途 |
| --- | --- | --- | --- | --- |
| `assets/demos/research-innovation-agent/raw/research-innovation-agent-raw-demo.mov` | `科研创新助手Agent.mov.mov` | 120 MB | 1900 x 990，约 250.0 秒 | 主录屏原始归档，后续用于剪辑 |

## 4. 已归档截图列表

当前未发现桌面原始素材目录中的独立截图文件，因此没有复制截图到 raw 截图目录。

目标截图目录已创建：

```text
assets/screenshots/research-innovation-agent/raw/
```

缺失的建议截图：

```text
01-homepage.png
02-agent-modules.png
03-hunter-search.png
04-miner-analysis.png
05-coach-writing.png
06-validator-citation.png
```

后续可以从录屏抽帧中挑选候选图，再另行整理到 `final/` 展示目录。

## 5. 报告文件列表

已有报告与预览文件：

```text
assets/reports/research-innovation-agent/research-workflow-sample.md
assets/reports/research-innovation-agent/research-innovation-run-result.md
assets/reports/research-innovation-agent/report-preview.html
assets/reports/research-innovation-agent/raw-assets-inventory.md
assets/reports/research-innovation-agent/frame-preview-index.md
assets/reports/research-innovation-agent/frame-preview/
```

`frame-preview/` 中包含每 5 秒抽取的预览帧，以及用于人工审阅的接触表图片。接触表只作为审阅辅助，不建议直接放入 README。

## 6. 推荐用于视频剪辑的素材

推荐使用主视频：

```text
assets/demos/research-innovation-agent/raw/research-innovation-agent-raw-demo.mov
```

建议保留的核心画面：

| 时间段 | 内容 | 剪辑建议 |
| --- | --- | --- |
| 0s-20s | 首页、Agent 模块总览、Hunter 搜索输入 | 保留，作为开场和能力总览 |
| 30s-40s | Hunter 论文搜索结果 | 保留，展示论文搜索能力 |
| 55s-60s | Miner 论文分析输入 | 保留，作为分析任务发起 |
| 110s-125s | Miner 结构化分析结果 | 保留，展示论文分析结果 |
| 220s-225s | Coach 写作建议结果 | 保留，展示写作辅助输出 |
| 240s-245s | Validator 引用校验和 BibTeX 结果 | 保留，作为结尾结果展示 |

## 7. 推荐用于 README 的截图

当前没有独立截图素材。可从抽帧中优先挑选以下候选帧生成 README 展示图：

| 候选帧 | 建议命名 | 内容 |
| --- | --- | --- |
| `frame-000s.png` | `01-homepage.png` | 首页和 Agent 模块总览 |
| `frame-035s.png` | `03-hunter-search.png` | Hunter 论文搜索结果 |
| `frame-125s.png` | `04-miner-analysis.png` | Miner 论文分析结果 |
| `frame-225s.png` | `05-coach-writing.png` | Coach 写作建议结果 |
| `frame-245s.png` | `06-validator-citation.png` | Validator 引用校验和 BibTeX 结果 |

## 8. 不建议使用的素材

| 素材 / 时间段 | 原因 |
| --- | --- |
| 45s-50s 外部 PDF / ArXiv 页面 | 属于公开论文页面，可作为过渡，但不是本地 Agent 主界面，不建议作为主展示画面 |
| 60s-105s Miner 等待画面 | 信息增量低，容易显得模型调用慢 |
| 145s-215s Coach 等待画面 | 等待时间长，最终视频中应删除或 3x-6x 加速 |
| 接触表 `_contact-sheet-*.jpg` | 仅用于审阅抽帧，不适合作为正式截图 |

## 9. 缺失素材提醒

- 未发现独立截图文件。
- 当前尚未归档最终展示截图。
- 当前尚未生成最终剪辑视频。
- 当前尚未生成字幕脚本。
- WebSocket / 任务队列链路不应作为已跑通能力展示。

## 10. 剪辑前注意事项

1. 不要让最终视频体现大模型调用过程非常漫长。
2. 对等待、加载、按钮点击后长时间无变化画面进行删除或 3x-6x 加速。
3. 保留结果展示画面，尤其是 Hunter 搜索结果、Miner 结构化分析、Coach 写作建议、Validator 引用校验 / BibTeX。
4. 不展示敏感配置文件、终端敏感变量、鉴权值、服务地址、模型标识、账号隐私或无关桌面内容。
5. 本案例只能表述为本地复现和流程演示，不写成真实科研结论。
