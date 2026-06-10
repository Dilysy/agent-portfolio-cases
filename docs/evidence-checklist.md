# Evidence Checklist

本清单只覆盖 8 个正式案例。所有案例均已完成 README、sample、runbook、样例输出或运行记录、最终演示视频和边界说明。8 个最终 demo MP4 均已统一为中文字幕演示视频。演示材料用于作品集展示，不写成真实客户交付或生产部署结果。

| 案例 | 文档状态 | 运行 / 样例状态 | 最终视频 | 边界说明 |
| --- | --- | --- | --- | --- |
| AutoFlow 流程图生成 Agent | 已完成 | 已完成四模式验证、截图、Mermaid 示例和导出链路说明 | `assets/demos/autoflow-agent/autoflow-agent-demo.mp4` | 演示环境验证，不声明生产可用性 |
| 智能竞品分析 Agent | 已完成 | 已完成公开信息分析、竞品报告、HTML 预览和运行记录 | `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4` | 基于公开信息，结论需人工复核 |
| 企业经营数据分析 Agent | 已完成 | 已完成本地样例销售数据、图表、经营分析报告和运行记录 | `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4` | 使用样例数据，不代表真实企业经营结果 |
| 自动化深度研究 Agent | 已完成 | 已完成主题研究流程、搜索来源、任务总结、最终报告和运行记录 | `assets/demos/deep-research-agent/deep-research-agent-demo.mp4` | 公开来源研究结果需人工复核 |
| 自然语言数据库查询 Agent | 已完成 | 已完成本地演示 Schema、SQL 示例、查询结果样例、HTML 预览和运行记录 | `assets/demos/database-query-agent/database-query-agent-demo.mp4` | 不连接真实企业数据库 |
| 智能股票分析助手 Agent | 已完成 | 已完成公开行情查询、技术指标和风险因素归纳的本地验证 | `assets/demos/stock-insight-agent/stock-insight-agent-demo.mp4` | 不构成投资建议或证券研究报告 |
| 代码审查 Agent | 已完成 | 已完成真实审查输出、审查报告、HTML 预览和运行记录 | `assets/demos/code-review-agent/code-review-agent-demo.mp4` | 审查结论和修复建议需人工复核 |
| 科研创新助手 Agent | 已完成 | 已完成论文搜索、论文分析、写作辅助、引用校验和工作流样例 | `assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4` | 科研结论和引用仍需人工复核 |

## 正式材料清单

每个正式案例目录均包含：

- `README.md`：案例说明、Agent 设计、工具调用、输出结果、评估方式和可扩展方向。
- `sample.md`：示例输入、运行或样例输出、人工复核结论。
- `runbook.md`：本地验证步骤、运行边界和排查记录。

作品集素材目录包含：

- `assets/demos/<case>/`：最终演示视频和必要原始素材。
- `assets/reports/<case>/`：报告样例、运行结果、HTML 预览、抽帧索引或剪辑说明。
- `assets/screenshots/<case>/`：关键截图或抽帧材料。

## 发布前复核要求

- 检查截图、录屏、HTML 预览和报告中是否出现账号、私密配置、浏览器隐私页或未授权数据。
- 确认最终展示只引用 8 个正式案例。
- 确认演示视频路径与仓库文件一致，且最终 demo MP4 非空。
- 确认股票、科研、数据库和代码审查案例均保留人工复核和使用边界。
- 确认本地配置文件、缓存、中间视频片段和系统临时文件不进入 Git 提交。
