# AutoFlow ffmpeg 剪辑计划

## 总体策略

- 剪辑路线：不使用 `jianying-editor-skill`，改用 `ffmpeg` 或 `moviepy`。
- 成片目标：60-75 秒的 AutoFlow 产品演示视频，用于 Agent 案例集展示。
- 输出格式：MP4 / H.264 / 1920x1080。
- 音频策略：暂时不做配音，先做静音字幕版；如保留原始录屏声音，也必须整体静音或降到不干扰观看。
- 字幕策略：使用中文硬字幕，底部居中，白色字体，轻微黑色描边，不遮挡输入框、流程图和导出按钮。
- 剪辑原则：删除等待、重复操作、鼠标乱动、无效停顿、报错画面和无关画面。
- 加速原则：操作过程可加速 1.25x 到 1.5x；关键结果画面不加速，保留 3-5 秒。
- 当前阶段：只生成剪辑计划，不抽帧，不导出最终视频。

## 执行前检查

- 当前 PATH 中未发现 `ffmpeg`。
- 当前 PATH 中未发现 `ffprobe`。
- 当前 Python 环境未安装 `moviepy`。
- Codex bundled Python 未安装 `moviepy`、`imageio`、`imageio_ffmpeg`、`opencv-python`。
- 结论：当前不能直接剪辑或导出视频；正式执行前需要先安装 `ffmpeg`，或安装 `moviepy` 及其 ffmpeg 依赖。

## 原始素材信息

### 原始视频

- 路径：`assets/demos/autoflow-agent/raw/autoflow-raw-demo.mov`
- 文件大小：21,776,401 bytes
- 时长：约 138.3 秒
- 分辨率：1907x990
- 编码：H.264
- 音频：MPEG-4 AAC

### 原始截图

- `assets/screenshots/autoflow-agent/raw/inspiration-mode.png`
- `assets/screenshots/autoflow-agent/raw/standard-mode.png`
- `assets/screenshots/autoflow-agent/raw/plan-mode.png`
- `assets/screenshots/autoflow-agent/raw/code-mode.png`

## 成片结构

| 段落 | 成片时长 | 画面来源 | 画面重点 | 处理策略 |
| --- | ---: | --- | --- | --- |
| 片头 | 3 秒 | `standard-mode.png` | 标题和案例定位。 | 静态图，叠加标题与副标题。 |
| 首页结构 | 4-5 秒 | 原始视频 | AutoFlow 页面整体结构、模式切换区、输入区和预览区。 | 删除无关鼠标移动，必要时 1.25x。 |
| 灵感模式 | 8-10 秒 | 原始视频 + `inspiration-mode.png` | 从初步想法生成可视化流程结构。 | 操作段可 1.25x-1.5x，结果截图停留 3-5 秒。 |
| 标准模式 | 10-12 秒 | 原始视频 + `standard-mode.png` | 清晰业务流程描述生成 Mermaid 流程图。 | 删除等待和重复操作，结果截图停留 3-5 秒。 |
| 计划模式 | 10-12 秒 | 原始视频 + `plan-mode.png` | 售前项目计划被拆解为推进流程。 | 操作段可 1.25x，结果截图停留 3-5 秒。 |
| Mermaid 代码模式 | 8-10 秒 | 原始视频 + `code-mode.png` | Mermaid 代码编辑和右侧实时预览。 | 编辑/粘贴过程可 1.25x-1.5x，预览结果停留。 |
| 导出能力 | 5-6 秒 | 原始视频优先；必要时用截图放大导出区域 | 展示 `.mmd` 与 SVG 导出按钮。 | 如果按钮不清晰，可用代码模式或标准模式截图放大右上角导出区域并配字幕说明。 |
| 结尾 | 3 秒 | `standard-mode.png` 或四模式截图拼接 | 总结本地复现、LLM 接入、四模式验证。 | 静态图，叠加简短结尾文案。 |

## 片头文案

- 主标题：`AutoFlow 流程图生成 Agent`
- 副标题：`自然语言生成流程图 / 四模式验证`

## 字幕文案

字幕必须短、清晰，并根据最终片段长度微调时间点。

| 初始时间 | 字幕 |
| --- | --- |
| 00:00-00:03 | AutoFlow 流程图生成 Agent |
| 00:03-00:08 | 自然语言生成流程图 |
| 00:08-00:18 | 灵感模式：想法转流程 |
| 00:18-00:30 | 标准模式：描述转图 |
| 00:30-00:42 | 计划模式：拆解项目流程 |
| 00:42-00:54 | 代码模式：实时预览 |
| 00:54-01:03 | 支持编辑与导出 |
| 01:03-01:08 | LLM 接入 / 四模式验证 |

## 时间点处理

当前原计划中的时间段只是估算，不能直接用于正式导出。正式剪辑前必须先抽帧确认时间点，再确定每个模式的真实起止点。

不要直接按以下估算时间段剪辑：

- `00:00-00:12`
- `00:12-00:35`
- `00:35-00:58`
- `00:58-01:18`
- `01:18-01:38`
- `01:38-01:53`

这些时间段只能作为初始参考。正式剪辑前需要通过抽帧预览判断：

- 哪些画面是首页结构。
- 哪些画面对应灵感模式、标准模式、计划模式和 Mermaid 代码模式。
- 哪些等待、重复操作、鼠标乱动和无效停顿需要删除。
- 是否存在报错、终端、Codex、桌面隐私、API Key、账号、邮箱、微信等画面。
- 导出 `.mmd` 和 SVG 的按钮区域是否足够清晰。

## 加速策略

- 首页结构、模式切换和普通操作：优先使用 1.25x。
- 长等待、重复输入、鼠标乱动：优先删除；如果保留上下文，最多使用 1.5x。
- 模式结果画面：不加速，停留 3-5 秒。
- 导出按钮区域：不加速，保证观众能看清按钮或字幕说明。
- 字幕段落不要切得太快，单条字幕建议至少保留 3 秒。

## 下一步执行计划

下一步不导出最终视频，而是先用 `ffmpeg` 抽帧预览，人工确认每段真实起止点。

### 抽帧要求

- 每 5 秒抽取 1 张预览图。
- 输出目录：`assets/reports/autoflow-agent/frame-preview/`
- 文件命名：
  - `frame-000s.png`
  - `frame-005s.png`
  - `frame-010s.png`
  - 依此类推。
- 生成索引文件：`assets/reports/autoflow-agent/frame-preview-index.md`

### 索引文件内容

`frame-preview-index.md` 需要包含：

- 时间点
- 图片路径
- 画面内容初步判断
- 是否适合进入剪辑
- 备注

建议索引表结构：

| 时间点 | 图片路径 | 画面内容初步判断 | 是否适合进入剪辑 | 备注 |
| --- | --- | --- | --- | --- |
| 00:00 | `assets/reports/autoflow-agent/frame-preview/frame-000s.png` | 待填写 | 待判断 | 待填写 |
| 00:05 | `assets/reports/autoflow-agent/frame-preview/frame-005s.png` | 待填写 | 待判断 | 待填写 |
| 00:10 | `assets/reports/autoflow-agent/frame-preview/frame-010s.png` | 待填写 | 待判断 | 待填写 |

### 抽帧命令示例

如果仅需先生成连续编号预览图，可执行：

```bash
mkdir -p assets/reports/autoflow-agent/frame-preview

ffmpeg -i assets/demos/autoflow-agent/raw/autoflow-raw-demo.mov \
  -vf "fps=1/5,scale=1280:-1" \
  assets/reports/autoflow-agent/frame-preview/frame-%03d.png
```

如果需要生成 `frame-000s.png`、`frame-005s.png`、`frame-010s.png` 这类带时间点的文件名，建议后续用脚本在抽帧后重命名，或按时间点逐帧抽取。

## 风险控制

- 不修改原始视频。
- 不覆盖原始截图。
- 不提交生成的视频。
- 不使用 `jianying-editor-skill`。
- 不保留报错、终端、Codex、桌面隐私、API Key、账号、邮箱、微信等画面。
- 导出前必须人工检查抽帧结果，并确认每段起止点。
- 导出前必须再次确认字幕不会遮挡输入框、流程图和导出按钮。

## 需要确认的问题

1. 是否允许下一步先安装 `ffmpeg`？
2. 是否按静音字幕版执行，不保留原始录屏声音？
3. 如果原视频中导出按钮不清晰，是否允许用 `standard-mode.png` 或 `code-mode.png` 放大右上角导出区域并配字幕说明？
4. 是否确认下一步只做抽帧预览和索引文件，不导出最终视频？

## 已完成字幕版成片

- 完成状态：已完成第一版字幕版演示视频。
- 成片路径：`assets/demos/autoflow-agent/autoflow-agent-demo.mp4`
- 成片时长：约 72 秒。
- 输出规格：MP4 / H.264 / 1920x1080。
- 音频状态：静音字幕版；配音不纳入本计划收尾范围。
- 使用素材：原始录屏、`standard-mode.png`、硬字幕 PNG 图层。
- 复核说明：本成片用于展示 AutoFlow 开源项目的本地复现、LLM 接入、四模式验证、实时预览和导出能力，不写成真实客户交付项目。
