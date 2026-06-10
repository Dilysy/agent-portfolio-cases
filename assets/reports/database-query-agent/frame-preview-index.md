# 自然语言数据库查询 Agent 抽帧预览索引

原始视频：

```text
assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov
```

抽帧目录：

```text
assets/reports/database-query-agent/frame-preview/
```

抽帧策略：原始视频约 24.3 秒，每 3 秒抽取 1 张预览图。当前只做预览判断，未修改原始视频，未剪辑，未导出最终 MP4。

## 抽帧结果

| 时间点 | 图片路径 | 画面内容判断 | 是否适合进入剪辑 | 备注 |
| --- | --- | --- | --- | --- |
| `00:00` | `assets/reports/database-query-agent/frame-preview/frame-000s.png` | 自然语言问题 / Schema 示例 / SQL 生成总览 | 是 | 页面顶部清晰，适合作为主视频开头或总览段。 |
| `00:03` | `assets/reports/database-query-agent/frame-preview/frame-003s.png` | 自然语言问题 / Schema 示例 / SQL 生成总览 | 是 | 与 00:00 接近，可保留短段或后续用截图替代停留。 |
| `00:06` | `assets/reports/database-query-agent/frame-preview/frame-006s.png` | SQL 生成 / 查询结果 | 是 | SQL 区域和结果表格开始完整出现，适合进入剪辑。 |
| `00:09` | `assets/reports/database-query-agent/frame-preview/frame-009s.png` | SQL 生成 / 查询结果 / 结果解释 | 是 | SQL、结果表格和业务含义清楚，是关键保留点。 |
| `00:12` | `assets/reports/database-query-agent/frame-preview/frame-012s.png` | 查询结果 / 安全控制说明 | 是 | 安全控制区域开始出现，适合强调只读、审计和脱敏控制。 |
| `00:15` | `assets/reports/database-query-agent/frame-preview/frame-015s.png` | 查询结果 / 安全控制说明 | 是 | 结果表格、业务含义和安全控制完整，建议重点保留。 |
| `00:18` | `assets/reports/database-query-agent/frame-preview/frame-018s.png` | 自然语言问题 / Schema 示例 / SQL 生成 / 查询结果 | 可选 | 页面回滚到上半部分，信息有效但与前段重复。 |
| `00:21` | `assets/reports/database-query-agent/frame-preview/frame-021s.png` | 自然语言问题 / Schema 示例 / SQL 生成总览 | 可选 | 回到顶部总览，可作为结尾前回看，但建议优先用截图做结尾。 |
| `00:24` | `assets/reports/database-query-agent/frame-preview/frame-024s.png` | 自然语言问题 / Schema 示例 / SQL 生成总览 | 可选 | 接近视频末尾，内容与 00:00-00:03 重复。 |

## 推荐保留时间段

| 推荐时间段 | 内容 | 建议用途 |
| --- | --- | --- |
| `00:00-00:05` | 自然语言问题、Schema 和 SQL 总览 | 用作主体开头，配字幕“输入业务查询问题”。 |
| `00:05-00:10` | SQL 生成和查询结果逐步出现 | 用作 SQL 生成段，配字幕“生成 SQL 查询语句”。 |
| `00:10-00:16` | 查询结果、业务解释和安全控制说明 | 用作结果与安全控制段，配字幕“返回查询结果与解释”“增加只读、审计和脱敏控制”。 |

## 建议删除或弱化片段

| 时间段 | 原因 | 处理建议 |
| --- | --- | --- |
| `00:16-00:24` | 页面回滚，内容与开头和中段重复 | 不作为主素材；如需要补足时长，优先使用已归档截图静态停留。 |

## 剪辑脚本建议

1. 片头使用 `assets/screenshots/database-query-agent/raw/01-natural-language-question.png`，时长 3 秒。
2. 主体视频优先保留 `00:00-00:16`。
3. SQL 和结果段可保持原速，不建议过度加速，避免 SQL 和表格不可读。
4. 使用 `assets/screenshots/database-query-agent/raw/02-schema-example.png`、`03-generated-sql.png`、`04-query-result-security.png` 补充 3-5 秒关键停留。
5. 结尾使用 `04-query-result-security.png` 或 `03-generated-sql.png`，明确字幕“本地演示 Schema / 非真实企业数据”。
6. 成片目标仍控制在 35-45 秒。

## 是否可以进入剪辑脚本生成阶段

可以进入剪辑脚本生成阶段。当前抽帧未发现报错画面、终端画面、私密凭证、数据库账号、密码、连接串或真实企业数据；但正式导出前仍需人工复核字幕是否遮挡 SQL、表格和安全控制内容。
