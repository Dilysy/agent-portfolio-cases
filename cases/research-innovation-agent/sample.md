# 科研创新助手 Agent 示例运行记录

## 1. 示例输入

本案例采用分模块稳定演示，输入样例如下：

| 模块 | 示例输入 |
| --- | --- |
| 论文搜索 | `retrieval augmented generation` |
| 论文分析 | `https://arxiv.org/abs/1706.03762` |
| 写作辅助 | `请用三句话说明 RAG 评估的研究背景。` |
| 引用校验 | `arXiv:1706.03762` |

示例主题：

```text
面向企业知识库问答的 RAG 评估方法研究
```

本记录用于科研辅助流程演示，正式研究结论仍需人工复核。

## 2. 科研工作流

| 步骤 | Agent | 任务 | 输入 | 输出 |
| --- | --- | --- | --- | --- |
| 1 | Hunter | 论文搜索 | 检索关键词 | 候选论文元数据 |
| 2 | Miner | 论文分析 | 论文链接或 PDF 文本 | 结构化论文分析 |
| 3 | Coach | 写作辅助 | 短文本和任务类型 | 学术写作建议 |
| 4 | Validator | 引用校验 | 论文编号或引用文本 | 元数据和 BibTeX |
| 5 | 人工复核 | 事实校验 | Agent 输出和原论文 | 保留、修改或删除结论 |

## 3. Agent 分工

| Agent | 分工 | 人工复核重点 |
| --- | --- | --- |
| Hunter | 检索候选论文并返回标题、作者、摘要和链接 | 检查论文是否与主题相关 |
| Miner | 生成摘要、方法、贡献、实验结果和局限性等结构化分析 | 对照原文确认事实和解释 |
| Coach | 生成学术表达和结构建议 | 判断是否符合真实研究语境 |
| Validator | 校验引用元数据并生成 BibTeX | 检查格式和元数据准确性 |

## 4. 工具调用记录

| 顺序 | 工具 / 接口 | 输入摘要 | 输出样例 | 当前状态 |
| --- | --- | --- | --- | --- |
| 1 | 首页 | GET | Web 前端页面 | 已验证 |
| 2 | 健康检查 | GET | 四类 Agent 状态 | 已验证 |
| 3 | API 文档 | GET | 接口文档页面 | 已验证 |
| 4 | 论文搜索 | `retrieval augmented generation` | 论文元数据列表 | 已验证 |
| 5 | 论文分析 | `https://arxiv.org/abs/1706.03762` | 结构化论文分析 | 已验证 |
| 6 | 写作辅助 | `请用三句话说明 RAG 评估的研究背景。` | 学术写作建议 | 已验证 |
| 7 | 引用校验 | `arXiv:1706.03762` | 引用校验结果和 BibTeX 信息 | 已验证 |

完整协调工作流仍存在长任务响应时间、任务状态接线和稳定录屏节奏等边界，因此最终录屏采用分模块稳定演示。

## 5. 示例输出

### 论文元数据

输出包括论文标题、作者、年份、摘要、论文编号和公开链接等字段。演示中用于确认 Hunter 能根据关键词返回可复核的候选论文。

### 论文结构化分析

输出包括：

- 研究问题与背景
- 方法概述
- 核心贡献
- 实验结果
- 局限性和后续可扩展方向

### 学术写作建议

输出包括对研究背景表达的润色建议、逻辑结构建议和术语表达建议。录屏采用短输入，避免生成长篇综述。

### 引用校验结果

输出包括论文元数据、校验状态和标准化引用信息。

### BibTeX 信息

输出展示 BibTeX 条目，用于说明 Validator 可以辅助引用格式化。正式论文写作仍需人工核对元数据和格式规范。

## 6. 人工复核结论

1. Web/API 模式已完成本地验证。
2. 真实 LLM 调用链路已完成验证。
3. Hunter 论文搜索、Miner 论文分析、Coach 写作辅助和 Validator 引用校验已完成演示验证。
4. 等待片段已在最终视频中压缩处理，视频重点展示操作和结果。
5. 输出内容用于科研辅助流程演示，正式研究结论仍需人工复核。

## 7. 当前不足

- PDF 上传解析未作为本次最终录屏主线。
- 长任务状态和流式任务链路仍需后续扩展验证。
- 完整协调工作流不作为本次最终成片主线，避免等待时间影响展示节奏。
- 引用和论文分析结果需要结合原论文进行人工复核。

## 8. 可改进方向

- 补充 PDF 上传解析和批量论文处理演示。
- 优化完整工作流的任务状态和长任务反馈。
- 增加引用复核清单和报告导出流程。
- 对论文分析结果增加来源段落定位，提升可复核性。

## 9. 演示材料路径

```text
assets/reports/research-innovation-agent/research-innovation-run-result.md
assets/reports/research-innovation-agent/report-preview.html
assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4
assets/reports/research-innovation-agent/research-workflow-sample.md
assets/reports/research-innovation-agent/raw-assets-inventory.md
assets/reports/research-innovation-agent/frame-preview-index.md
```
