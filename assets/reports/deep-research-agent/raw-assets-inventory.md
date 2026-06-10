# 自动化深度研究 Agent 原始素材清单

## 原始素材目录

```text
/Users/wangyu/Desktop/案例视频录制/自动化深度研究Agent
```

本清单仅用于素材归档和剪辑前判断。未移动、删除或修改桌面原始素材；未开始剪辑；未生成最终 MP4。

## 原始素材扫描结果

### 视频文件

| 文件名 | 文件类型 | 文件大小 | 分辨率 / 时长 / 编码 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `自动化深度研究Agent演示.mov` | QuickTime `.mov` 视频 | 137,063,170 bytes，约 131 MB | 1900x990，约 294.27 秒，H.264，60 fps，音频 AAC | 适合作为正式演示视频的主素材。可从中截取主题输入、任务拆解、工具调用、来源返回、任务总结、最终报告等片段；原片约 4 分 54 秒，需要剪辑压缩。 |

### 图片文件

| 文件名 | 文件类型 | 文件大小 | 分辨率 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `总视图.png` | PNG 图片 | 489,254 bytes，约 478 KB | 1910x987 | 适合用于 README 主截图、片头背景或展示整体界面结构；可覆盖主题输入、左侧流程和右侧详情区域。 |
| `工具调用.png` | PNG 图片 | 107,951 bytes，约 105 KB | 1207x590 | 适合用于展示工具调用、搜索过程或过程证据；可作为“最新来源 / 工具调用”段落补帧。 |
| `任务总结.png` | PNG 图片 | 182,688 bytes，约 178 KB | 1208x431 | 适合用于展示 Task Summarizer 输出和阶段总结结果。 |
| `最终报告.png` | PNG 图片 | 246,519 bytes，约 241 KB | 1564x530 | 适合用于展示最终研究报告和结尾停留画面。 |

### 其他文件

| 文件名 | 文件类型 | 文件大小 | 可能用途判断 |
| --- | --- | ---: | --- |
| `.DS_Store` | macOS Finder 元数据 | 未归档 | 不适合用于正式演示或作品集，已跳过复制。 |

## 已归档视频列表

| 标准路径 | 来源文件 | 文件大小 | 用途 |
| --- | --- | ---: | --- |
| `assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov` | `自动化深度研究Agent演示.mov` | 137,063,170 bytes | 原始录屏母版，用于后续 ffmpeg 剪辑计划和字幕版成片。 |

## 已归档截图列表

| 标准路径 | 来源文件 | 文件大小 | 用途 |
| --- | --- | ---: | --- |
| `assets/screenshots/deep-research-agent/raw/01-topic-input.png` | `总视图.png` | 489,254 bytes | 整体界面和主题输入展示。 |
| `assets/screenshots/deep-research-agent/raw/03-search-sources.png` | `工具调用.png` | 107,951 bytes | 工具调用、搜索过程或来源返回展示。 |
| `assets/screenshots/deep-research-agent/raw/04-task-summary.png` | `任务总结.png` | 182,688 bytes | 阶段性任务总结展示。 |
| `assets/screenshots/deep-research-agent/raw/05-final-report.png` | `最终报告.png` | 246,519 bytes | 最终报告展示和结尾画面。 |

## 报告文件列表

| 文件路径 | 当前状态 | 用途 |
| --- | --- | --- |
| `assets/reports/deep-research-agent/deep-research-run-result.md` | 已存在 | 记录真实运行验证、问题排查和修复记录。 |
| `assets/reports/deep-research-agent/deep-research-report.md` | 已存在 | 最终研究报告素材，可用于 README、视频字幕和报告展示。 |
| `assets/reports/deep-research-agent/deep-research-plan.md` | 已存在 | 研究计划样例，可作为案例背景材料。 |
| `assets/reports/deep-research-agent/report-preview.html` | 已存在 | HTML 报告预览页，可作为截图或录屏展示辅助材料。 |

## 推荐用于视频剪辑的素材

- `assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov`：主剪辑素材，用于保留真实前端操作、SSE 流式过程、任务拆解、工具调用、来源返回、任务总结和最终报告。
- `assets/screenshots/deep-research-agent/raw/01-topic-input.png`：适合片头、整体界面说明和开场停留。
- `assets/screenshots/deep-research-agent/raw/03-search-sources.png`：适合补充搜索工具和来源返回画面。
- `assets/screenshots/deep-research-agent/raw/04-task-summary.png`：适合保留 3-5 秒，突出 Task Summarizer 输出。
- `assets/screenshots/deep-research-agent/raw/05-final-report.png`：适合结尾停留或 README 主结果展示。

## 推荐用于 README 的截图

优先推荐：

1. `assets/screenshots/deep-research-agent/raw/01-topic-input.png`
2. `assets/screenshots/deep-research-agent/raw/05-final-report.png`
3. `assets/screenshots/deep-research-agent/raw/04-task-summary.png`

辅助推荐：

- `assets/screenshots/deep-research-agent/raw/03-search-sources.png`

## 不建议使用的素材

- `.DS_Store`：系统元数据，无展示价值，不应进入剪辑工程或 README。
- 未剪辑的完整 `deep-research-agent-raw-demo.mov`：可作为母版保留，但不建议直接作为正式成片，原片约 294 秒，超过作品集演示视频的理想长度。
- 含报错、等待时间、重复操作、鼠标乱动、终端隐私、私密凭证、账号信息或浏览器隐私内容的录屏片段：正式剪辑时必须删除。

## 缺失素材提醒

当前截图数量为 4 张，缺少以下独立截图：

- `02-todo-list.png`：独立任务拆解 / TODO 列表截图。
- `06-completed-status.png`：任务完成状态或最终完成态截图。

当前已有 `01-topic-input.png` 可部分覆盖整体结构和任务列表，`05-final-report.png` 可部分覆盖最终结果，但后续 README 若要更完整展示流程，建议补充独立 TODO 列表和完成状态截图。

## 剪辑前注意事项

1. 不要移动、覆盖或删除 `/Users/wangyu/Desktop/案例视频录制/自动化深度研究Agent` 下的原始素材。
2. 后续剪辑只使用作品集标准目录中的已归档素材。
3. 正式剪辑前先抽帧确认时间点，不要直接按主观估算剪辑。
4. 删除等待、重复操作、失败画面、无效停顿和鼠标乱动。
5. 检查画面中是否出现 `本地配置文件`、私密凭证、账号、邮箱、微信、浏览器隐私页或终端敏感信息。
6. 保留关键画面：研究主题输入、TODO Planner、SearchTool / Tavily sources、NoteTool 或工具调用、Task Summarizer、Report Writer 最终报告。
7. 搜索来源和任务总结画面建议原速保留 3-5 秒；等待和流式输出过长片段可加速或裁剪。
8. 成片口径统一为本地化运行验证和案例演示，不写成真实客户交付。

## 是否可以进入剪辑计划阶段

可以进入剪辑计划阶段。当前已有 1 个主录屏、4 张关键截图、真实运行记录和最终研究报告。剪辑计划阶段建议先对主录屏每 5-10 秒抽帧，确认片头、主题输入、任务列表、来源返回、任务总结、最终报告和结尾画面的准确时间点。
