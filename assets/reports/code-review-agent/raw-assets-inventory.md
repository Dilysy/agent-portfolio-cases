# 代码审查 Agent 原始素材清单

## 1. 原始素材目录

```text
/Users/wangyu/Desktop/案例视频录制/代码审查Agent
```

扫描时间：2026-06-10

## 2. 原始素材扫描结果

| 文件名 | 文件类型 | 文件大小 | 分辨率 / 时长 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `演示视频.mov` | 视频，QuickTime MOV，H.264 + AAC | 21M | 1900 x 990，79.58 秒 | 主原始录屏，可用于后续剪辑代码审查 Agent 演示视频。 |
| `code-sample.png` | 图片，PNG | 136K | 922 x 972 | 展示待审查代码样例，适合 README 或视频开头使用。 |
| `real-output.png` | 图片，PNG | 284K | 1063 x 935 | 展示真实 Agent 审查输出，适合说明真实运行结果。 |
| `risk.png` | 图片，PNG | 100K | 1084 x 754 | 展示问题清单或风险等级区域，适合用于 README 重点截图。 |
| `HTML报告预览.png` | 图片，PNG | 108K | 573 x 991 | 展示 HTML 报告预览页，适合视频结尾或 README 展示。 |

其他文件：未发现需要归档的其他文件；`.DS_Store` 未复制。

## 3. 已归档视频列表

| 原始文件 | 归档路径 | 文件大小 | 分辨率 / 时长 | 说明 |
| --- | --- | ---: | --- | --- |
| `演示视频.mov` | `assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov` | 21M | 1900 x 990，79.58 秒 | 主原始录屏，保留 MOV 格式，未剪辑、未转码。 |

## 4. 已归档截图列表

| 原始文件 | 归档路径 | 文件大小 | 分辨率 | 推荐用途 |
| --- | --- | ---: | --- | --- |
| `code-sample.png` | `assets/screenshots/code-review-agent/raw/01-code-sample.png` | 136K | 922 x 972 | 展示待审查代码样例。 |
| `real-output.png` | `assets/screenshots/code-review-agent/raw/02-real-output.png` | 284K | 1063 x 935 | 展示真实代码审查输出。 |
| `risk.png` | `assets/screenshots/code-review-agent/raw/03-risk-list.png` | 100K | 1084 x 754 | 展示问题清单和风险等级。 |
| `HTML报告预览.png` | `assets/screenshots/code-review-agent/raw/04-report-preview.png` | 108K | 573 x 991 | 展示 HTML 报告预览页。 |

## 5. 报告文件列表

以下报告素材已存在，可用于 README、视频说明和后续剪辑脚本引用：

| 文件 | 当前状态 | 说明 |
| --- | --- | --- |
| `assets/reports/code-review-agent/code-review-sample.py` | 已存在 | 待审查 Python 代码样例。 |
| `assets/reports/code-review-agent/code-review-real-output.md` | 已存在 | 真实代码审查调用链路生成的原始输出。 |
| `assets/reports/code-review-agent/code-review-report.md` | 已存在 | 基于真实输出整理的审查报告。 |
| `assets/reports/code-review-agent/code-review-run-result.md` | 已存在 | 运行验证记录，包含 LLM 健康检查和当前限制。 |

## 6. HTML 预览文件

| 文件 | 当前状态 | 说明 |
| --- | --- | --- |
| `assets/reports/code-review-agent/report-preview.html` | 已存在 | 简洁 HTML 报告预览页，适合录屏展示。 |

## 7. 推荐用于视频剪辑的素材

推荐主线：

1. `assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov`
2. `assets/screenshots/code-review-agent/raw/01-code-sample.png`
3. `assets/screenshots/code-review-agent/raw/02-real-output.png`
4. `assets/screenshots/code-review-agent/raw/03-risk-list.png`
5. `assets/screenshots/code-review-agent/raw/04-report-preview.png`

建议剪辑结构：

1. 开头展示待审查代码样例。
2. 中段展示真实审查输出。
3. 强调问题清单和风险等级。
4. 结尾展示 HTML 报告预览页。

## 8. 推荐用于 README 的截图

优先推荐：

1. `assets/screenshots/code-review-agent/raw/03-risk-list.png`：最能体现问题识别和风险分级。
2. `assets/screenshots/code-review-agent/raw/04-report-preview.png`：适合展示最终报告形态。
3. `assets/screenshots/code-review-agent/raw/02-real-output.png`：适合补充真实 Agent 输出证据。

可选：

- `assets/screenshots/code-review-agent/raw/01-code-sample.png`：适合作为“示例输入 / 待审查代码”说明图。

## 9. 不建议使用的素材

当前未发现需要废弃的素材。

剪辑前仍需人工复核：

- 录屏画面中是否出现敏感配置、账号、私人路径、微信、邮箱或浏览器隐私内容。
- 终端是否展示模型服务地址、本地配置文件路径或其他敏感配置。
- 原始视频是否包含等待时间过长、重复操作或不适合对外展示的片段。

## 10. 缺失素材提醒

当前 4 张关键截图均已归档：

- `01-code-sample.png`
- `02-real-output.png`
- `03-risk-list.png`
- `04-report-preview.png`

暂无关键截图缺失。后续如需更完整的 README 展示，可额外补充：

- CLI 启动成功截图。
- LLM 健康检查成功截图。
- 报告 Markdown 文件局部截图。

## 11. 剪辑前注意事项

1. 不直接使用未复核的原始录屏作为最终演示视频。
2. 不展示本地配置文件、敏感配置、账号、邮箱、微信或浏览器私人页面。
3. 不写成真实客户交付项目，只作为本地化运行验证和作品集案例展示。
4. 保留“人工复核”说明，避免夸大自动代码审查能力。
5. 后续剪辑前建议先抽帧检查视频中是否有敏感信息或长时间无动作片段。
