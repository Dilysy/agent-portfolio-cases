# 代码审查 Agent 抽帧预览索引

## 1. 抽帧说明

- 原始视频：`assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov`
- 原始视频时长：约 79.58 秒
- 抽帧目录：`assets/reports/code-review-agent/frame-preview/`
- 抽帧间隔：每 5 秒 1 张
- 抽帧数量：16 张
- 当前阶段：仅抽帧预览，不剪辑、不导出最终 MP4

## 2. 安全检查重点

本轮逐帧检查重点：

- 敏感配置
- 模型配置
- 模型服务地址
- 本地配置文件
- 临时验证脚本
- Codex 对话
- 无关桌面内容
- 终端敏感信息

检查结论：未发现敏感配置、模型配置、模型服务地址、本地配置文件、临时验证脚本、Codex 对话、无关桌面内容或终端敏感信息。

## 3. 抽帧索引

| 时间点 | 图片路径 | 画面内容判断 | 是否适合进入剪辑 | 备注 |
| --- | --- | --- | --- | --- |
| 00:00 | `assets/reports/code-review-agent/frame-preview/frame-000s.png` | 待审查代码，展示文件开头、硬编码配置和 SQL 查询函数 | 是 | 适合作为“输入待审查代码”开场画面。 |
| 00:05 | `assets/reports/code-review-agent/frame-preview/frame-005s.png` | 待审查代码，聚焦 SQL 拼接、JSON 解析和格式化函数 | 是 | 适合展示潜在问题来源。 |
| 00:10 | `assets/reports/code-review-agent/frame-preview/frame-010s.png` | 待审查代码，展示重复逻辑、文件写入和异常捕获 | 是 | 适合接“定位问题代码位置”。 |
| 00:15 | `assets/reports/code-review-agent/frame-preview/frame-015s.png` | 待审查代码末尾，展示 `main()` 和异常捕获 | 可选 | 与 00:10 内容接近，可缩短或加速。 |
| 00:20 | `assets/reports/code-review-agent/frame-preview/frame-020s.png` | 真实 Agent 审查输出，展示代码审查报告、SQL 风险和硬编码配置问题 | 是 | 适合“识别潜在问题”。画面中有模型生成的审查日期，但不属于敏感信息。 |
| 00:25 | `assets/reports/code-review-agent/frame-preview/frame-025s.png` | 真实 Agent 审查输出，展示完整问题清单和风险等级 | 是 | 强烈推荐保留，用于“问题清单 / 风险等级”。 |
| 00:30 | `assets/reports/code-review-agent/frame-preview/frame-030s.png` | 真实 Agent 审查输出，展示 SQL、高中低风险、重复逻辑和文件写入问题 | 是 | 适合“定位问题代码位置”。 |
| 00:35 | `assets/reports/code-review-agent/frame-preview/frame-035s.png` | 真实 Agent 审查输出，展示低风险项、总结和优先修复顺序 | 是 | 适合“风险等级 / 优先级总结”。 |
| 00:40 | `assets/reports/code-review-agent/frame-preview/frame-040s.png` | 结构化审查报告 HTML 首页，展示报告标题、审查目标和问题清单 | 是 | 适合“输出结构化审查报告”。 |
| 00:45 | `assets/reports/code-review-agent/frame-preview/frame-045s.png` | 结构化审查报告 HTML 首页，内容与 00:40 接近 | 可选 | 与 00:40 重复，可压缩或裁掉一部分。 |
| 00:50 | `assets/reports/code-review-agent/frame-preview/frame-050s.png` | 结构化审查报告，展示问题清单和风险等级入口 | 是 | 适合“标注风险等级”。 |
| 00:55 | `assets/reports/code-review-agent/frame-preview/frame-055s.png` | 结构化审查报告，展示问题清单、风险等级和运行说明 | 是 | 适合过渡到风险等级段。 |
| 01:00 | `assets/reports/code-review-agent/frame-preview/frame-060s.png` | 结构化审查报告，展示风险等级和修复建议 | 是 | 适合“生成修复建议”。 |
| 01:05 | `assets/reports/code-review-agent/frame-preview/frame-065s.png` | 结构化审查报告，展示风险等级和修复建议，内容与 01:00 接近 | 可选 | 可作为 01:00 的延长镜头，也可压缩。 |
| 01:10 | `assets/reports/code-review-agent/frame-preview/frame-070s.png` | 结构化审查报告，展示修复建议、修复方向片段和人工复核说明 | 是 | 强烈推荐保留，用于“修复建议 / 人工复核说明”。 |
| 01:15 | `assets/reports/code-review-agent/frame-preview/frame-075s.png` | 结构化审查报告，展示修复方向片段、人工复核说明和当前状态 | 是 | 适合结尾，保留 3-5 秒即可。 |

## 4. 推荐保留时间段

推荐保留主线：

```text
00:00 - 00:15  待审查代码
00:20 - 00:35  真实 Agent 审查输出、问题清单、风险等级
00:40 - 00:43  HTML 报告首页过渡
00:50 - 01:00  问题清单与风险等级
01:00 - 01:15  修复建议与人工复核说明
```

推荐剪辑后再整体加速：

```text
1.25x - 1.35x
```

预计成片时长：

```text
45 - 60 秒
```

## 5. 建议删除或压缩的无效片段

未发现敏感信息 / 不建议使用画面。

建议压缩或裁短的重复片段：

| 时间段 | 原因 | 建议 |
| --- | --- | --- |
| 00:15 - 00:20 | 代码末尾到报告输出之间的过渡，信息增量较少 | 可裁短或加速。 |
| 00:40 - 00:50 | HTML 报告首页停留较长，00:40 和 00:45 内容接近 | 保留 3-5 秒即可。 |
| 01:00 - 01:05 | 与 01:05 风险和修复建议画面接近 | 可按节奏压缩。 |

## 6. 敏感信息检查结果

| 检查项 | 是否发现 | 说明 |
| --- | --- | --- |
| 敏感配置 | 否 | 未发现。 |
| 模型配置 | 否 | 未发现。 |
| 模型服务地址 | 否 | 未发现。 |
| 本地配置文件 | 否 | 未发现。 |
| 临时验证脚本 | 否 | 未发现。 |
| Codex 对话 | 否 | 未发现。 |
| 无关桌面内容 | 否 | 未发现。 |
| 终端敏感信息 | 否 | 未发现。 |

## 7. 是否可以进入剪辑脚本生成阶段

可以进入剪辑脚本生成阶段。

建议下一步：

1. 根据本索引创建 `assets/reports/code-review-agent/demo-subtitles.srt`。
2. 创建 ffmpeg 剪辑脚本或按 `ffmpeg-edit-plan.md` 手动执行。
3. 先生成中间片段，再统一加速和烧录字幕。
4. 导出最终视频后再次抽帧复核，确认无敏感信息。
