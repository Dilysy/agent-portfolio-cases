# 部署与展示说明

## 当前状态

当前仓库已整理完成 8 个正式 Agent 作品集案例。每个案例均保留本地运行说明、样例输出或运行记录、最终演示视频和边界说明。仓库定位是作品集展示和本地化运行验证，不声明生产部署、真实客户交付或线上服务 SLA。

## 展示方式

第一版展示以 GitHub 仓库和本地演示材料为主：

1. 根 `README.md` 用作作品集首页。
2. `cases/<case>/README.md` 展示每个案例的问题、方案、Agent 设计和结果。
3. `cases/<case>/sample.md` 展示示例输入、输出和人工复核点。
4. `cases/<case>/runbook.md` 记录本地验证步骤和运行边界。
5. `assets/demos/<case>/` 存放最终演示视频。
6. `assets/reports/<case>/` 存放报告样例、运行结果、HTML 预览和剪辑说明。

## 8 个正式案例

| 案例 | 最终视频 |
| --- | --- |
| AutoFlow 流程图生成 Agent | `assets/demos/autoflow-agent/autoflow-agent-demo.mp4` |
| 智能竞品分析 Agent | `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4` |
| 企业经营数据分析 Agent | `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4` |
| 自动化深度研究 Agent | `assets/demos/deep-research-agent/deep-research-agent-demo.mp4` |
| 自然语言数据库查询 Agent | `assets/demos/database-query-agent/database-query-agent-demo.mp4` |
| 智能股票分析助手 Agent | `assets/demos/stock-insight-agent/stock-insight-agent-demo.mp4` |
| 代码审查 Agent | `assets/demos/code-review-agent/code-review-agent-demo.mp4` |
| 科研创新助手 Agent | `assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4` |

## 本地运行原则

- 优先按每个案例的 `runbook.md` 做本地验证。
- 私密配置只保存在本地配置文件或本机环境变量中，不进入仓库。
- 运行日志、截图和录屏发布前必须做敏感信息复核。
- 样例数据、公开信息和演示环境需要在文档中明确标注，不写成真实客户数据。

## 安全与边界

- 不声明任何案例已经部署到生产环境。
- 不展示未获授权的数据、账号、配置或内部材料。
- 股票分析不构成投资建议。
- 数据库查询案例不连接真实企业数据库。
- 科研辅助和代码审查结果均需人工复核。

## 后续方向

- 可扩展统一 smoke test 脚本，快速检查 8 个案例的关键文件和视频状态。
- 可扩展静态作品集站点，集中展示案例摘要、报告预览和视频入口。
- 可补充架构图、流程图和面试讲解稿，但仍保持工程化、克制和可验证口径。
