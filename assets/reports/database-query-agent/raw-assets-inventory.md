# 自然语言数据库查询 Agent 原始素材清单

## 1. 原始素材目录

```text
/Users/wangyu/Desktop/案例视频录制/自然语言数据库查询 Agent
```

本清单仅用于素材归档和剪辑前判断。已按标准目录复制视频和截图，没有移动、删除或修改桌面原始素材。

## 2. 原始素材扫描结果

### 视频文件

| 文件名 | 文件类型 | 文件大小 | 分辨率 / 时长 / 编码 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `自然语言数据库查询 Agent.mov` | QuickTime `.mov` 视频 | 5,364,721 bytes，约 5.1 MB | 1900x990，约 24.3 秒，H.264 + AAC | 适合作为正式演示视频主素材，展示 HTML 预览页中的自然语言问题、Schema、SQL、查询结果和安全控制说明；时长较短，可整体保留并补充片头字幕。 |

### 图片文件

| 文件名 | 文件类型 | 文件大小 | 分辨率 | 可能用途判断 |
| --- | --- | ---: | --- | --- |
| `自然语言问题区域.png` | PNG 图片 | 95,682 bytes，约 93 KB | 1144x490 | 适合用于 README 或视频片头，展示自然语言查询输入。 |
| `表结构和字段说明.png` | PNG 图片 | 55,997 bytes，约 55 KB | 1117x353 | 适合展示本地演示 Schema 和字段说明。 |
| `SQL.png` | PNG 图片 | 36,427 bytes，约 36 KB | 1078x346 | 适合展示生成 SQL，作为 Text-to-SQL 能力的关键截图。 |
| `安全控制.png` | PNG 图片 | 56,012 bytes，约 55 KB | 1158x277 | 适合展示查询结果、安全控制或执行前复核说明。 |

### 其他文件

| 文件名 | 文件类型 | 文件大小 | 可能用途判断 |
| --- | --- | ---: | --- |
| `.DS_Store` | macOS Finder 元数据 | 6,148 bytes，约 6 KB | 不适合用于正式演示、README 或剪辑工程，未复制到作品集标准目录。 |

## 3. 已归档视频列表

| 标准路径 | 来源文件 | 文件大小 | 说明 |
| --- | --- | ---: | --- |
| `assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov` | `自然语言数据库查询 Agent.mov` | 5,364,721 bytes，约 5.1 MB | 主录屏素材，后续用于 ffmpeg 字幕版演示视频。 |

## 4. 已归档截图列表

| 标准路径 | 来源文件 | 文件大小 | 分辨率 | 说明 |
| --- | --- | ---: | --- | --- |
| `assets/screenshots/database-query-agent/raw/01-natural-language-question.png` | `自然语言问题区域.png` | 95,682 bytes，约 93 KB | 1144x490 | 自然语言问题输入区域。 |
| `assets/screenshots/database-query-agent/raw/02-schema-example.png` | `表结构和字段说明.png` | 55,997 bytes，约 55 KB | 1117x353 | Schema 和字段说明。 |
| `assets/screenshots/database-query-agent/raw/03-generated-sql.png` | `SQL.png` | 36,427 bytes，约 36 KB | 1078x346 | 生成 SQL 展示。 |
| `assets/screenshots/database-query-agent/raw/04-query-result-security.png` | `安全控制.png` | 56,012 bytes，约 55 KB | 1158x277 | 查询结果、安全控制或复核说明展示。 |

## 5. 报告文件列表

| 文件 | 当前状态 | 用途 |
| --- | --- | --- |
| `assets/reports/database-query-agent/database-schema-example.md` | 已存在 | 本地演示 Schema 说明。 |
| `assets/reports/database-query-agent/database-query-sql-example.md` | 已存在 | 自然语言问题和 SQL 示例。 |
| `assets/reports/database-query-agent/database-query-result.md` | 已存在 | 查询结果样例和结果解释。 |
| `assets/reports/database-query-agent/database-query-run-result.md` | 已存在 | 当前运行验证状态和安全控制记录。 |

## 6. HTML 预览文件

| 文件 | 当前状态 | 用途 |
| --- | --- | --- |
| `assets/reports/database-query-agent/report-preview.html` | 已存在 | 适合录屏展示的白底卡片式报告预览页。 |

## 7. 推荐用于视频剪辑的素材

- `assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov`：作为主视频素材，优先整体保留，后续补充片头、字幕和必要的轻微裁剪。
- `assets/screenshots/database-query-agent/raw/01-natural-language-question.png`：可用于片头或问题输入停留画面。
- `assets/screenshots/database-query-agent/raw/02-schema-example.png`：可用于说明 Agent 先理解 Schema。
- `assets/screenshots/database-query-agent/raw/03-generated-sql.png`：可用于展示自然语言转 SQL。
- `assets/screenshots/database-query-agent/raw/04-query-result-security.png`：可用于展示查询结果、安全控制和人工复核。

## 8. 推荐用于 README 的截图

| 推荐顺序 | 截图路径 | 推荐用途 |
| --- | --- | --- |
| 1 | `assets/screenshots/database-query-agent/raw/01-natural-language-question.png` | 展示自然语言问题输入。 |
| 2 | `assets/screenshots/database-query-agent/raw/03-generated-sql.png` | 展示生成 SQL，是该案例的核心能力画面。 |
| 3 | `assets/screenshots/database-query-agent/raw/04-query-result-security.png` | 展示结果解释和安全控制。 |
| 4 | `assets/screenshots/database-query-agent/raw/02-schema-example.png` | 展示 Schema 理解过程。 |

## 9. 不建议使用的素材

- `.DS_Store`：系统元数据，无展示价值，未复制。
- 未经检查的完整录屏：虽然主视频较短，但正式剪辑前仍需检查是否出现终端隐私、浏览器隐私、账号、私密凭证、数据库账号或连接串。

## 10. 缺失素材提醒

当前素材已覆盖本案例第一版演示所需的关键画面：

1. 自然语言问题。
2. Schema 示例。
3. 生成 SQL。
4. 查询结果与安全控制。

仍可后续补充：

- CLI 实际运行画面。
- SQL 执行前确认机制画面。
- 查询审计日志或只读权限说明画面。
- 最终成片 `assets/demos/database-query-agent/database-query-agent-demo.mp4`。

## 11. 剪辑前注意事项

1. 不要移动、覆盖或删除桌面原始素材。
2. 不要导入 `.DS_Store`。
3. 剪辑前检查录屏是否出现 私密凭证、数据库账号、密码、连接串、真实客户名称、邮箱、微信或浏览器隐私页。
4. 本案例必须明确为本地演示 Schema 和本地化运行验证，不写成真实客户交付。
5. 如果展示 SQL 执行，必须强调只读账号、SQL 白名单、危险语句拦截、行数限制、超时限制、敏感字段脱敏、审计日志、权限控制和执行前确认。
6. 后续成片建议控制在 45-60 秒，重点展示自然语言问题、Schema 理解、SQL 生成、查询结果和安全控制。
