# 自然语言数据库查询 Agent ffmpeg 剪辑计划

## 1. 制作目标

基于已归档的原始录屏和 4 张关键截图，制作第一版字幕版演示视频，用于 GitHub 案例集、作品集展示和后续 PDF 素材。

当前案例为本地演示 Schema 和本地化运行验证，不是真实企业数据库接入，不展示真实企业数据、真实数据库账号、连接串或生产查询结果。

## 2. 输入素材

### 原始视频

| 素材 | 路径 | 信息 | 用途 |
| --- | --- | --- | --- |
| 主录屏 | `assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov` | 约 24.3 秒，1900x990，H.264 + AAC | 作为演示主体，展示自然语言问题、Schema、SQL、查询结果和安全控制。 |

### 已归档截图

| 素材 | 路径 | 用途 |
| --- | --- | --- |
| 自然语言问题 | `assets/screenshots/database-query-agent/raw/01-natural-language-question.png` | 片头后问题输入停留画面。 |
| Schema 示例 | `assets/screenshots/database-query-agent/raw/02-schema-example.png` | 展示数据库 Schema 和字段说明。 |
| 生成 SQL | `assets/screenshots/database-query-agent/raw/03-generated-sql.png` | 展示自然语言转 SQL 的关键结果。 |
| 查询结果与安全控制 | `assets/screenshots/database-query-agent/raw/04-query-result-security.png` | 展示查询结果、安全控制或人工复核说明。 |

### 报告素材

| 素材 | 路径 | 用途 |
| --- | --- | --- |
| Schema 示例 | `assets/reports/database-query-agent/database-schema-example.md` | 用于核对字段口径。 |
| SQL 示例 | `assets/reports/database-query-agent/database-query-sql-example.md` | 用于核对字幕和 SQL 展示。 |
| 查询结果样例 | `assets/reports/database-query-agent/database-query-result.md` | 用于核对结果说明。 |
| 运行记录 | `assets/reports/database-query-agent/database-query-run-result.md` | 用于核对当前运行状态。 |
| HTML 预览 | `assets/reports/database-query-agent/report-preview.html` | 当前录屏来源和后续 README 展示素材。 |

## 3. 输出规格

| 项目 | 规格 |
| --- | --- |
| 成片目标时长 | 35-45 秒 |
| 输出路径 | `assets/demos/database-query-agent/database-query-agent-demo.mp4` |
| 输出格式 | MP4 / H.264 |
| 分辨率 | 1920x1080 |
| 音频 | 第一版静音，不做配音 |
| 字幕 | 中文硬字幕，底部居中，白色字体，轻微黑色描边 |
| 表述口径 | 本地演示 Schema / 本地化运行验证 / 非真实企业数据库接入 |

## 4. 总体剪辑策略

1. 原始视频只有约 24.3 秒，可优先保留主体内容。
2. 使用 4 张截图补充片头、结尾和关键结果停留，使成片达到 35-45 秒。
3. 操作过程如有鼠标移动、页面滚动或等待，可加速到 1.25x 到 1.5x。
4. 关键画面不加速，保留 3-5 秒。
5. 不保留任何可能暴露 私密凭证、数据库账号、密码、连接串、真实客户名称、邮箱、微信或浏览器隐私的画面。
6. 不写成真实企业数据库接入；字幕和说明必须保持“本地演示 Schema”口径。

## 5. 建议视频结构

| 段落 | 素材 | 建议成片时长 | 处理策略 | 字幕 |
| --- | --- | ---: | --- | --- |
| 片头 | `01-natural-language-question.png` | 3 秒 | 截图转视频，轻微缩放或静态停留 | 自然语言数据库查询 Agent |
| 自然语言问题 | 主录屏 `00:00-00:05` 或 `01-natural-language-question.png` | 5 秒 | 展示问题输入区域，原速或截图停留 | 输入业务查询问题 |
| Schema 示例 | 主录屏参考 `00:05-00:10` + `02-schema-example.png` | 6 秒 | 保留 Schema 字段区域，关键画面停留 3-5 秒 | 读取数据库 Schema |
| SQL 生成 | 主录屏参考 `00:10-00:15` + `03-generated-sql.png` | 6 秒 | 展示 SQL 代码区域，保持清晰可读 | 生成 SQL 查询语句 |
| 查询结果 | 主录屏参考 `00:15-00:20` | 6 秒 | 保留查询结果与解释画面，不加速 | 返回查询结果与解释 |
| 安全控制说明 | 主录屏参考 `00:20-00:24` + `04-query-result-security.png` | 7 秒 | 展示只读、审计、脱敏等安全控制说明 | 增加只读、审计和脱敏控制 |
| 结尾 | `04-query-result-security.png` 或 `03-generated-sql.png` | 3-4 秒 | 截图转视频，作为能力总结停留 | 本地演示 Schema / 非真实企业数据 |

预估总时长：37-40 秒。

## 6. 推荐字幕时间轴

实际字幕时间可在抽帧确认后微调。

```text
00:00-00:03
自然语言数据库查询 Agent

00:03-00:08
输入业务查询问题

00:08-00:14
读取数据库 Schema

00:14-00:20
生成 SQL 查询语句

00:20-00:26
返回查询结果与解释

00:26-00:36
增加只读、审计和脱敏控制

00:36-00:40
本地演示 Schema / 非真实企业数据
```

字幕要求：

1. 短句为主，不遮挡 SQL、表格和安全控制文字。
2. 字幕底部居中，白色字体，轻微黑色描边。
3. 如字幕遮挡关键内容，可上移到画面底部上方 80-120 像素。

## 7. 推荐保留时间段

当前时间段为初步估算，正式剪辑前必须先抽帧确认真实画面内容。

| 原始视频时间段 | 初步判断 | 建议处理 |
| --- | --- | --- |
| `00:00-00:05` | 自然语言问题或报告开头区域 | 优先保留，必要时原速。 |
| `00:05-00:10` | Schema 或字段说明区域 | 优先保留，配合 `02-schema-example.png` 停留。 |
| `00:10-00:15` | SQL 生成区域 | 优先保留，配合 `03-generated-sql.png` 停留。 |
| `00:15-00:20` | 查询结果或解释区域 | 优先保留，不加速。 |
| `00:20-00:24` | 安全控制说明或结尾区域 | 优先保留，配合 `04-query-result-security.png`。 |

如抽帧发现主录屏内存在等待、无效鼠标移动或重复滚动，可删除对应秒段，并用截图补足停留。

## 8. 抽帧确认步骤

剪辑前建议先抽帧确认时间点。下一步不导出最终视频，只生成预览帧和索引。

建议目录：

```text
assets/reports/database-query-agent/frame-preview/
```

建议索引文件：

```text
assets/reports/database-query-agent/frame-preview-index.md
```

建议抽帧命令：

```bash
mkdir -p assets/reports/database-query-agent/frame-preview

ffmpeg -i assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov \
  -vf "fps=1/5,scale=1280:-1" \
  assets/reports/database-query-agent/frame-preview/frame-%03d.png
```

如果需要 `frame-000s.png`、`frame-005s.png` 这类时间点命名，可在后续脚本中按帧序号重命名。

抽帧索引建议包含：

| 字段 | 说明 |
| --- | --- |
| 时间点 | 例如 `00:00`、`00:05` |
| 图片路径 | 对应预览图路径 |
| 画面内容判断 | 自然语言问题 / Schema / SQL / 查询结果 / 安全控制 / 无效画面 |
| 是否适合进入剪辑 | 是 / 否 / 待确认 |
| 备注 | 是否需要加速、裁剪或用截图替代 |

## 9. 风险控制

1. 不修改原始视频。
2. 不覆盖原始截图。
3. 不生成最终 MP4，直到抽帧和时间点确认完成。
4. 不提交 Git。
5. 不展示真实企业数据库接入。
6. 不展示 私密凭证、数据库账号、密码、连接串、真实客户数据、邮箱、微信或浏览器隐私页。
7. 正式成片中必须明确“本地演示 Schema / 非真实企业数据”。

## 10. 下一步建议

1. 执行抽帧预览，每 5 秒抽取一帧。
2. 根据抽帧结果确认每段真实起止点。
3. 生成字幕文件 `assets/reports/database-query-agent/demo-subtitles.srt`。
4. 生成 ffmpeg 脚本 `scripts/database_query_video/build_demo.sh`。
5. 检查脚本输入路径、字幕滤镜和输出路径。
6. 经人工确认后，再导出 `assets/demos/database-query-agent/database-query-agent-demo.mp4`。

## 11. 完成状态

已完成演示视频剪辑，成片文件为：

```text
assets/demos/database-query-agent/database-query-agent-demo.mp4
```

当前成片为第一版字幕版演示视频，不处理配音。案例口径为本地演示 Schema 和本地化运行验证，不是真实企业数据库接入。
