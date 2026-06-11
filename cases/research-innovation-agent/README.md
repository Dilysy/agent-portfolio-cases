# 科研创新助手 Agent

当前状态：已完成。

本案例展示一个面向科研辅助流程的多智能体应用：通过 Hunter、Miner、Coach、Validator 四类 Agent，将论文搜索、论文分析、写作辅助和引用校验串联为可演示的 Web/API 工作流。案例用于科研辅助流程演示，正式研究结论仍需人工复核。

## 1. 项目背景

科研资料整理通常涉及检索论文、阅读摘要或 PDF、提炼创新点、撰写综述段落、校验引用格式等多个环节。若这些步骤分散在不同工具中，研究人员需要频繁切换上下文，且输出结果难以统一复核。

本案例围绕“企业知识库问答中的 RAG 评估方法研究”这一示例主题，构建一个本地可运行、可录屏展示的科研创新助手 Agent 流程。

## 2. 业务问题

- 论文搜索、筛选、分析和引用格式化链路分散。
- 摘要整理和创新点提取缺少统一结构。
- 写作建议、术语优化和引用校验需要人工反复处理。
- 综述草稿需要保留来源、推断和人工复核边界。

## 3. 解决方案

案例采用 FastAPI + Web 前端 + REST API 的演示形态，按模块稳定展示：

1. Hunter Agent 检索论文并返回元数据。
2. Miner Agent 对论文进行结构化分析。
3. Coach Agent 根据短输入生成学术写作建议。
4. Validator Agent 校验引用并生成 BibTeX。
5. 结果作为科研辅助材料，进入人工复核流程。

已完成 Web/API 模式验证、真实 LLM 调用验证、四类 Agent 能力演示验证，并生成中文字幕演示视频。

## 4. Agent 设计

| Agent | 输入 | 输出 | 当前演示状态 |
| --- | --- | --- | --- |
| Hunter | 检索关键词、来源、返回数量 | 论文标题、作者、摘要、编号、链接等元数据 | 已验证论文搜索演示 |
| Miner | 论文链接或 PDF 文本、分析类型 | 摘要、方法、贡献、实验结果、局限性等结构化分析 | 已验证论文分析演示 |
| Coach | 写作任务、文本、目标风格 | 学术写作建议、表达优化和结构建议 | 已验证短输入写作辅助演示 |
| Validator | 论文编号或引用文本、输出格式 | 引用元数据、校验结果、BibTeX 信息 | 已验证引用校验演示 |

## 5. 工具调用

| 工具 | 输入 | 输出 | 作用 | 演示状态 |
| --- | --- | --- | --- | --- |
| 论文搜索 | `retrieval augmented generation` | 候选论文元数据 | 检索候选文献 | 已验证 |
| 论文分析 | `https://arxiv.org/abs/1706.03762` | 结构化论文分析 | 提炼方法、贡献和实验信息 | 已验证 |
| 写作辅助 | `请用三句话说明 RAG 评估的研究背景。` | 学术写作建议 | 生成可复核的写作辅助输出 | 已验证 |
| 引用校验 | `arXiv:1706.03762` | 元数据和 BibTeX | 校验引用并生成标准格式 | 已验证 |
| Web/API 服务 | 首页、`/health`、`/docs` | 前端页面、健康状态、接口文档 | 支撑录屏演示与接口验证 | 已验证 |

## 6. 系统架构

| 层级 | 内容 | 验证状态 |
| --- | --- | --- |
| 前端界面层 | 本地 Web 页面，展示四类 Agent 操作区和结果区 | 已验证首页访问 |
| API 接口层 | REST API、健康检查和接口文档 | 已验证 `/health`、`/docs` |
| 智能体编排层 | Hunter / Miner / Coach / Validator 分模块协作 | 已采用分模块稳定演示 |
| 核心服务层 | 论文搜索、PDF 文本处理、LLM 调用、引用格式化 | 核心演示链路已验证 |
| 数据与扩展层 | 本地文件、可选持久层和向量检索扩展 | 完整持久层未作为本次成片主线 |

## 7. 实现流程

1. 梳理原始工程的 Web/API 入口、Agent 模块、工具调用和运行边界。
2. 建立案例文档、运行记录、流程样例和 HTML 报告预览。
3. 完成本地 Web/API 模式验证，包括首页、健康检查和接口文档。
4. 完成真实 LLM 调用验证，并优化写作助手超时与短输出策略。
5. 录制分模块演示素材，归档原始录屏并完成抽帧复核。
6. 对等待片段进行加速和删减，生成中文字幕最终演示视频。

## 8. 输出结果

- 案例说明：`cases/research-innovation-agent/README.md`
- 运行手册：`cases/research-innovation-agent/runbook.md`
- 示例记录：`cases/research-innovation-agent/sample.md`
- 运行结果：`assets/reports/research-innovation-agent/research-innovation-run-result.md`
- HTML 报告预览：`assets/reports/research-innovation-agent/report-preview.html`
- 中文字幕演示视频：`assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4`

## 9. 评估方式

- Web/API 服务是否可访问，首页、健康检查和接口文档是否正常。
- 论文搜索是否返回可复核的候选论文元数据。
- 论文分析是否输出结构化、可阅读、可复核的内容。
- 写作辅助是否遵循短输出约束，避免生成长篇不可控文本。
- 引用校验是否返回明确的元数据和 BibTeX。
- 演示视频是否避免长时间等待画面，并保留人工复核边界。

## 10. 可扩展方向

- 补充 PDF 上传解析的录屏级验证。
- 修复长任务状态和流式任务链路，使完整协调工作流更适合演示。
- 接入更稳定的论文搜索来源和引用元数据源。
- 增加批量论文分析、报告导出和引用复核清单。
- 将检索与向量库能力从演示路径扩展为可本地验证实验路径。

## 11. 演示材料

- 最终视频：`assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4`
- 报告预览：`assets/reports/research-innovation-agent/report-preview.html`
- 运行结果：`assets/reports/research-innovation-agent/research-innovation-run-result.md`

用于科研辅助流程演示，正式研究结论仍需人工复核。
