# 自动化深度研究 Agent ffmpeg 剪辑计划

## 剪辑目标

基于已归档原始录屏和截图，制作一版字幕版正式演示视频，用于 Agent 案例集、GitHub、PDF 和面试展示。

成片口径：

- 自主工程化实现、场景化构建、能力封装、流程编排和本地化运行验证。
- 不写成真实客户交付。
- 不展示 `.env`、API Key、账号、邮箱、微信、浏览器隐私页或终端敏感信息。

目标成片：

```text
assets/demos/deep-research-agent/deep-research-agent-demo.mp4
```

## 输入素材

### 原始视频

| 路径 | 时长 | 分辨率 | 编码 | 文件大小 | 用途 |
| --- | ---: | --- | --- | ---: | --- |
| `assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov` | 约 294.27 秒 | 1900x990 | H.264 + AAC，60 fps | 137,063,170 bytes | 主录屏素材，用于截取真实前端操作和运行过程。 |

### 已归档截图

| 路径 | 分辨率 | 用途 |
| --- | --- | --- |
| `assets/screenshots/deep-research-agent/raw/01-topic-input.png` | 1910x987 | 片头、主题输入、整体界面结构。 |
| `assets/screenshots/deep-research-agent/raw/03-search-sources.png` | 1207x590 | 搜索来源、工具调用或过程证据补帧。 |
| `assets/screenshots/deep-research-agent/raw/04-task-summary.png` | 1208x431 | 任务总结展示。 |
| `assets/screenshots/deep-research-agent/raw/05-final-report.png` | 1564x530 | 最终报告展示和结尾停留；用户本次未列出，但已归档，可作为备用。 |

## 输出规格

- 格式：MP4
- 视频编码：H.264
- 分辨率：1920x1080
- 帧率：30 fps 或沿用 60 fps 后统一转 30 fps
- 音频：本版先静音或保留极低音量环境音，建议静音字幕版
- 字幕：硬字幕
- 字幕样式：底部居中，白色字体，轻微黑色描边，不遮挡任务列表、来源链接、任务总结和报告正文
- 目标时长：70-90 秒

## 总体剪辑策略

1. 原始录屏约 294 秒，不建议直接作为正式成片。
2. 正式剪辑前必须先抽帧确认真实时间点。
3. 删除等待、重复操作、失败画面、无效停顿、鼠标乱动和隐私风险画面。
4. 操作过程可加速到 1.25x-1.75x。
5. 关键结果画面原速保留 3-5 秒。
6. 搜索来源、任务总结和最终报告画面优先保证清晰可读。
7. 截图可用于片头、转场补帧、关键结果停留和结尾。
8. 不使用夸张转场，优先简单淡入淡出。

## 推荐成片结构

| 段落 | 成片时长 | 画面素材 | 字幕文案 | 剪辑说明 |
| --- | ---: | --- | --- | --- |
| 片头 | 4 秒 | `01-topic-input.png` | 自动化深度研究 Agent | 使用整体界面截图作为背景，静态停留。 |
| 主题输入 | 8-10 秒 | 原始视频 + `01-topic-input.png` | 输入研究主题，启动深度研究 | 保留前端主题输入和开始研究动作；删除无效等待。 |
| TODO Planner | 10-12 秒 | 原始视频 | 自动拆解研究任务 | 展示任务列表生成、查询词和任务状态变化。 |
| SearchTool / 来源返回 | 12-15 秒 | 原始视频 + `03-search-sources.png` | Tavily 返回公开来源 | 保留来源列表、工具调用或最新来源区域；若录屏中来源闪过太快，使用截图补帧 3-5 秒。 |
| NoteTool / 工具调用 | 8-10 秒 | 原始视频 + `03-search-sources.png` | 记录工具调用与任务笔记 | 展示 note 路径、工具调用记录和过程证据。 |
| Task Summarizer | 12-15 秒 | 原始视频 + `04-task-summary.png` | 生成阶段性任务总结 | 关键总结画面原速保留 3-5 秒。 |
| Report Writer | 14-18 秒 | 原始视频 + `05-final-report.png` | 生成最终研究报告 | 展示最终报告区域，结尾可停留报告截图。 |
| 结尾 | 4 秒 | `05-final-report.png` 或 `01-topic-input.png` | LLM 接入 / Tavily 搜索 / SSE 流式展示 | 使用报告或整体界面截图收尾。 |

预计总时长：70-86 秒。

## 字幕草案

实际字幕时间需要根据抽帧后的片段长度微调。

```srt
1
00:00:00,000 --> 00:00:04,000
自动化深度研究 Agent

2
00:00:04,000 --> 00:00:13,000
输入主题，启动深度研究流程

3
00:00:13,000 --> 00:00:25,000
TODO Planner 自动拆解研究任务

4
00:00:25,000 --> 00:00:40,000
SearchTool 调用 Tavily 获取公开来源

5
00:00:40,000 --> 00:00:50,000
NoteTool 记录工具调用与任务笔记

6
00:00:50,000 --> 00:01:05,000
Task Summarizer 生成阶段性总结

7
00:01:05,000 --> 00:01:22,000
Report Writer 汇总生成最终研究报告

8
00:01:22,000 --> 00:01:26,000
本地化验证 / 搜索增强 / 流式展示
```

## 初始参考时间段

以下时间段仅作为抽帧前的初始参考，不能直接用于正式导出。

| 功能段落 | 原始视频参考时间 | 处理建议 |
| --- | --- | --- |
| 主题输入 / 启动 | 待抽帧确认 | 保留输入框、主题和点击开始研究。 |
| TODO Planner | 待抽帧确认 | 保留任务列表生成完成后的画面。 |
| 搜索来源 | 待抽帧确认 | 保留最新来源、工具调用和 Tavily 搜索证据。 |
| 任务总结 | 待抽帧确认 | 保留总结文本稳定后的画面。 |
| 最终报告 | 待抽帧确认 | 保留最终报告生成完成后的画面。 |
| 结尾 | 待抽帧确认 | 使用最终报告或整体界面截图静态停留。 |

## 下一步抽帧计划

下一步不要导出最终视频，先对原始录屏抽帧预览。

抽帧目录：

```text
assets/reports/deep-research-agent/frame-preview/
```

抽帧索引：

```text
assets/reports/deep-research-agent/frame-preview-index.md
```

抽帧要求：

- 每 5 秒抽取 1 张预览图。
- 文件名使用原始秒数，例如 `frame-000s.png`、`frame-005s.png`、`frame-010s.png`。
- 索引文件包含时间点、图片路径、画面内容初步判断、是否适合进入剪辑、备注。

建议命令：

```bash
mkdir -p assets/reports/deep-research-agent/frame-preview

ffmpeg -i assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov \
  -vf "fps=1/5,scale=1280:-1" \
  assets/reports/deep-research-agent/frame-preview/frame-%03d.png
```

如果需要生成 `frame-000s.png` 这种带秒数的文件名，建议后续使用脚本重命名，不在本计划阶段执行。

## 后续 ffmpeg 脚本方向

正式脚本建议创建：

```text
scripts/deep_research_video/build_demo.sh
```

配套字幕建议创建：

```text
assets/reports/deep-research-agent/deep-research-demo-subtitles.srt
```

脚本应完成：

1. 按确认后的时间点裁剪原始录屏片段。
2. 将截图转为静态视频片段。
3. 对等待和操作段加速。
4. 将所有片段统一缩放并填充到 1920x1080，避免拉伸变形。
5. 合并片段。
6. 添加硬字幕。
7. 静音处理。
8. 输出 MP4 / H.264。

## 风险控制

1. 不修改原始视频。
2. 不覆盖原始截图。
3. 不提交生成视频。
4. 不保留失败画面、报错画面、终端隐私、`.env`、API Key、账号、邮箱、微信或浏览器隐私内容。
5. 导出前必须人工检查抽帧结果并确认每段起止点。
6. 若原始视频中 DuckDuckGo 失败、任务 failed 或来源为空画面较多，应删除失败过程，只保留已验证的 Tavily sources、任务总结和最终报告画面。
7. 如任务总结画面停留不足，可使用 `04-task-summary.png` 补帧。
8. 如最终报告画面停留不足，可使用 `05-final-report.png` 补帧。

## 需要确认的问题

1. 是否接受使用已归档但本次未列出的 `05-final-report.png` 作为最终报告和结尾画面。
2. 是否要求成片严格控制在 75 秒以内，还是允许 70-90 秒。
3. 是否保留原始录屏音频；当前建议先做静音字幕版。
4. 是否需要后续补充 `02-todo-list.png` 和 `06-completed-status.png`，或直接从录屏中截取对应画面。

## 当前状态

已完成 ffmpeg 剪辑计划。尚未抽帧、尚未生成剪辑脚本、尚未导出最终视频、尚未提交 Git。

## 完成状态

已完成演示视频剪辑，成片文件为：

```text
assets/demos/deep-research-agent/deep-research-agent-demo.mp4
```

当前视频为第一版演示成片，不处理配音；字幕和配音后续可继续优化。剪辑过程中保留原始录屏和原始截图，不删除原始素材。
