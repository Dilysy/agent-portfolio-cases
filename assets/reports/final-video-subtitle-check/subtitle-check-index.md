# 最终 Demo 视频中文字幕可视化检查

检查方式：对 8 个最终 demo MP4 分别抽取视频 20%、50%、80% 位置关键帧，人工查看画面底部是否存在独立于网页正文的中文硬字幕。

总览拼图：`assets/reports/final-video-subtitle-check/contact-sheet.png`

| 案例名称 | 视频路径 | 抽帧图片路径 | 是否明显可见中文字幕 | 判断依据 | 是否建议补字幕 |
| --- | --- | --- | --- | --- | --- |
| AutoFlow 流程图生成 Agent | `assets/demos/autoflow-agent/autoflow-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/autoflow-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/autoflow-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/autoflow-agent/frame-80.png` | 是 | 三张抽帧底部均可见白色中文硬字幕，例如“灵感模式：想法转流程”“标准模式：描述转图”“计划模式：拆解项目流程”。 | 否 |
| 智能竞品分析 Agent | `assets/demos/competitor-analysis-agent/competitor-analysis-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/competitor-analysis-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/competitor-analysis-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/competitor-analysis-agent/frame-80.png` | 是 | 三张抽帧底部均可见中文硬字幕，字幕覆盖在报告预览页面之上，不是网页原生正文。 | 否 |
| 企业经营数据分析 Agent | `assets/demos/business-data-analysis-agent/business-data-analysis-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/business-data-analysis-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/business-data-analysis-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/business-data-analysis-agent/frame-80.png` | 是 | 三张抽帧底部均可见中文硬字幕，例如“计算核心经营指标”“对比地区销售表现”“识别客户类型差异”。 | 否 |
| 自动化深度研究 Agent | `assets/demos/deep-research-agent/deep-research-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/deep-research-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/deep-research-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/deep-research-agent/frame-80.png` | 是 | 已补充底部居中的中文硬字幕，抽帧可见“搜索公开资料来源”“汇总任务执行结果”“生成结构化研究报告”。 | 否 |
| 自然语言数据库查询 Agent | `assets/demos/database-query-agent/database-query-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/database-query-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/database-query-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/database-query-agent/frame-80.png` | 是 | 已补充底部居中的中文硬字幕，抽帧可见“输入自然语言查询问题”“生成 SQL 查询逻辑”“展示查询结果与风险边界”。 | 否 |
| 智能股票分析助手 Agent | `assets/demos/stock-insight-agent/stock-insight-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/stock-insight-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/stock-insight-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/stock-insight-agent/frame-80.png` | 是 | 三张抽帧底部均可见大号中文硬字幕，例如“查询实时行情与基础指标”“生成技术指标分析结果”“分析近期行情与主要风险”。 | 否 |
| 代码审查 Agent | `assets/demos/code-review-agent/code-review-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/code-review-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/code-review-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/code-review-agent/frame-80.png` | 是 | 抽帧底部可见中文硬字幕，80% 位置可见“标注问题清单与风险等级”，字幕叠加在页面之上。 | 否 |
| 科研创新助手 Agent | `assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4` | `assets/reports/final-video-subtitle-check/research-innovation-agent/frame-20.png`<br>`assets/reports/final-video-subtitle-check/research-innovation-agent/frame-50.png`<br>`assets/reports/final-video-subtitle-check/research-innovation-agent/frame-80.png` | 是 | 抽帧底部可见中文硬字幕，例如“Miner 生成论文结构化分析”“Coach：输出学术写作建议”，字幕独立于网页正文。 | 否 |

## 结论

- 有明显中文硬字幕：8 个最终 demo 视频均已确认。
- 疑似没有剪辑字幕：无。
- 建议补字幕：无。
