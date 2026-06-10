# 代码审查 Agent ffmpeg 剪辑计划

## 1. 目标

- 成片路径：`assets/demos/code-review-agent/code-review-agent-demo.mp4`
- 原始视频：`assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov`
- 成片目标时长：45-60 秒
- 第一版形式：字幕版，不做配音
- 剪辑方式：先抽帧确认时间点，再按确认后的时间段裁剪、加速、加字幕
- 当前阶段：仅生成剪辑计划，不导出最终视频

## 2. 素材信息

| 素材 | 路径 | 信息 | 用途 |
| --- | --- | --- | --- |
| 原始录屏 | `assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov` | 1900 x 990，79.58 秒，H.264 + AAC | 主视频素材 |
| 待审查代码截图 | `assets/screenshots/code-review-agent/raw/01-code-sample.png` | 922 x 972 | 片头或代码样例展示 |
| 真实输出截图 | `assets/screenshots/code-review-agent/raw/02-real-output.png` | 1063 x 935 | 展示真实 Agent 审查输出 |
| 风险清单截图 | `assets/screenshots/code-review-agent/raw/03-risk-list.png` | 1084 x 754 | 展示问题清单和风险等级 |
| 报告预览截图 | `assets/screenshots/code-review-agent/raw/04-report-preview.png` | 573 x 991 | 展示 HTML 报告预览 |

## 3. 剪辑前抽帧建议

剪辑前先抽帧确认原始视频时间点，重点检查是否出现：

- 敏感配置、本地配置文件、模型配置、模型服务地址、临时验证脚本。
- 终端长时间等待或重复操作。
- 不适合对外展示的私人路径、账号、邮箱、聊天窗口或浏览器隐私内容。

建议抽帧命令：

```bash
mkdir -p assets/reports/code-review-agent/frame-preview
ffmpeg -y \
  -i assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov \
  -vf "fps=1/5,scale=1280:-1" \
  assets/reports/code-review-agent/frame-preview/frame-%03d.jpg
```

抽帧后建议生成或手工补充：

```text
assets/reports/code-review-agent/frame-preview-index.md
```

## 4. 推荐剪辑结构

| 段落 | 建议原始时间段 | 成片时长 | 画面重点 | 字幕 |
| --- | --- | ---: | --- | --- |
| 片头 | 00:00-00:04 | 3-4 秒 | 项目标题或报告页面开头 | 代码审查 Agent |
| 待审查代码 | 00:04-00:14 | 6-8 秒 | `01-code-sample.png` 或视频中的代码样例画面 | 输入待审查代码 |
| 真实 Agent 审查输出 | 00:14-00:30 | 10-12 秒 | `02-real-output.png` 或真实输出区域 | 识别潜在问题 |
| 问题清单 | 00:30-00:42 | 8-10 秒 | 问题列表区域 | 定位问题代码位置 |
| 风险等级 | 00:42-00:52 | 6-8 秒 | 风险等级或 `03-risk-list.png` | 标注风险等级 |
| 修复建议 | 00:52-01:05 | 8-10 秒 | 修复建议区域 | 生成修复建议 |
| 人工复核说明 | 01:05-01:13 | 4-5 秒 | 人工复核说明区域 | 保留人工复核 |
| 结尾 | 01:13-01:19.5 | 4-5 秒 | `04-report-preview.png` 或报告预览页 | 输出结构化审查报告 |

说明：

- 原始视频总长约 79.58 秒。
- 若保留 70-75 秒有效内容，可用 `setpts=PTS/1.35` 加速到约 52-56 秒。
- 若确认原始视频中有等待或敏感片段，应优先裁掉，再在剩余操作片段上使用 1.25x-1.5x 加速。
- 报告结果画面建议保留 3-5 秒，避免观众来不及看清结论。

## 5. 推荐字幕文案

建议字幕保持短句，避免遮挡代码和报告内容：

| 时间点 | 字幕 |
| --- | --- |
| 00:00-00:04 | 代码审查 Agent |
| 00:04-00:10 | 输入待审查代码 |
| 00:10-00:18 | 真实代码审查调用链路 |
| 00:18-00:26 | 识别潜在问题 |
| 00:26-00:34 | 定位问题代码位置 |
| 00:34-00:42 | 标注风险等级 |
| 00:42-00:50 | 生成修复建议 |
| 00:50-00:55 | 保留人工复核 |
| 00:55-00:60 | 输出结构化审查报告 |

## 6. 字幕文件草案

建议后续创建：

```text
assets/reports/code-review-agent/demo-subtitles.srt
```

字幕草案：

```srt
1
00:00:00,000 --> 00:00:04,000
代码审查 Agent

2
00:00:04,000 --> 00:00:10,000
输入待审查代码

3
00:00:10,000 --> 00:00:18,000
真实代码审查调用链路

4
00:00:18,000 --> 00:00:26,000
识别潜在问题

5
00:00:26,000 --> 00:00:34,000
定位问题代码位置

6
00:00:34,000 --> 00:00:42,000
标注风险等级

7
00:00:42,000 --> 00:00:50,000
生成修复建议

8
00:00:50,000 --> 00:00:55,000
保留人工复核

9
00:00:55,000 --> 00:01:00,000
输出结构化审查报告
```

## 7. ffmpeg 命令草案

以下命令仅作为后续执行参考，本阶段不执行。

### 7.1 抽取有效片段并加速

如果抽帧确认全程干净，可先裁剪 00:00-01:15 并 1.35x 加速：

```bash
ffmpeg -y \
  -ss 00:00:00 -to 00:01:15 \
  -i assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov \
  -filter:v "setpts=PTS/1.35,scale=1920:-2,fps=30" \
  -filter:a "atempo=1.35" \
  assets/demos/code-review-agent/clips/code-review-agent-main-speed.mp4
```

预计时长：约 55.6 秒。

### 7.2 烧录字幕

```bash
ffmpeg -y \
  -i assets/demos/code-review-agent/clips/code-review-agent-main-speed.mp4 \
  -vf "subtitles=assets/reports/code-review-agent/demo-subtitles.srt:force_style='FontName=PingFang SC,FontSize=24,PrimaryColour=&HFFFFFF&,OutlineColour=&H000000&,BorderStyle=1,Outline=1,Shadow=0,Alignment=2,MarginV=36'" \
  -c:v libx264 -pix_fmt yuv420p -crf 20 -preset medium \
  -c:a aac -b:a 128k \
  assets/demos/code-review-agent/code-review-agent-demo.mp4
```

### 7.3 如果需要裁掉敏感片段

如果抽帧发现敏感信息，先切多个干净片段，再 concat：

```bash
ffmpeg -y -ss 00:00:00 -to 00:00:20 -i assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov -c copy assets/demos/code-review-agent/clips/part-01.mov
ffmpeg -y -ss 00:00:25 -to 00:00:55 -i assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov -c copy assets/demos/code-review-agent/clips/part-02.mov
ffmpeg -y -ss 00:01:00 -to 00:01:19 -i assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov -c copy assets/demos/code-review-agent/clips/part-03.mov
```

然后创建 `assets/demos/code-review-agent/clips/concat.txt`：

```text
file 'part-01.mov'
file 'part-02.mov'
file 'part-03.mov'
```

再合并、加速、加字幕。

## 8. 推荐保留时间段

初版建议优先尝试保留：

```text
00:00:00 - 00:01:15
```

原因：

- 原始视频总长 79.58 秒。
- 保留 75 秒并 1.35x 加速后约 55.6 秒，符合 45-60 秒目标。
- 片尾仍可留出 3-5 秒展示报告结果。

需要抽帧后再确认是否要裁掉：

- LLM 健康检查或终端启动阶段中出现模型配置、模型服务地址、本地配置文件、临时脚本名的画面。
- 长时间等待或重复滚动片段。
- 不适合对外展示的桌面或私人信息。

## 9. 下一步建议

1. 执行抽帧命令，生成 `frame-preview/`。
2. 人工检查抽帧，标记可用时间段和需裁掉片段。
3. 补充 `frame-preview-index.md`。
4. 创建 `demo-subtitles.srt`。
5. 按确认后的时间段执行 ffmpeg 剪辑。
6. 生成 `assets/demos/code-review-agent/code-review-agent-demo.mp4` 后，再复核成片是否出现敏感信息。

## 10. 安全与展示限制

- 不展示敏感配置、模型配置、模型服务地址、本地配置文件或临时验证脚本。
- 不写成真实客户交付。
- 不夸大自动审查能力，保留人工复核说明。
- 当前计划不导出最终视频，不生成最终 MP4。
