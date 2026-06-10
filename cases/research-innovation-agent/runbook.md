# 科研创新助手 Agent 本地化运行验证步骤

## 1. 工程入口

本案例来自本地科研辅助类 Agent 工程本地验证，作品集目录为：

```text
cases/research-innovation-agent/
```

对外展示统一使用名称“科研创新助手 Agent”。本 runbook 不记录原始工程私有路径、鉴权值、服务地址、模型标识或敏感配置文件内容。

## 2. 项目定位

科研创新助手 Agent 面向论文搜索、论文分析、写作辅助和引用校验流程，采用 Hunter、Miner、Coach、Validator 四类 Agent 做分模块演示。

本案例用于科研辅助流程演示，正式研究结论仍需人工复核，不写成真实科研结论。

## 3. 环境准备

建议环境：

```text
Python 3.10+
FastAPI / Uvicorn
可联网访问公开论文元数据服务
OpenAI-compatible LLM 服务配置
```

本机验证结论：

```text
Python 3.12 虚拟环境可用
核心 Web/API 模式可启动
首页、健康检查和接口文档可访问
Redis / PostgreSQL / Qdrant 未作为本次演示主线
```

## 4. 依赖安装

本地验证时需安装 Web/API、论文搜索、PDF 解析、LLM 调用和可选持久层相关依赖。依赖安装在原始工程虚拟环境中完成，作品集只记录验证结果，不提交虚拟环境。

关键验证点：

- Web/API 服务依赖可导入。
- 论文搜索依赖可用。
- PDF 文本解析依赖可用。
- LLM 调用适配层可用。
- 原始工程主要入口和路由文件语法检查通过。

## 5. 环境变量配置

本案例需要在本地原始工程中配置 LLM 鉴权和服务参数。文档、截图、录屏和提交中均不记录具体配置名称、配置值、服务地址或模型标识。

验证结论：

```text
LLM health check 已通过
真实 LLM 写作辅助调用已通过
真实 LLM 论文分析调用已通过
```

为了录屏稳定，LLM 请求超时已调整为适合短输入演示的配置，写作助手提示词也增加了短输出约束。

## 6. 启动方式

本地验证采用原始工程的 FastAPI 应用入口启动 Web/API 模式。录屏阶段访问：

```text
http://localhost:8000
http://localhost:8000/health
http://localhost:8000/docs
```

验证完成后已停止本地服务进程。

## 7. 健康检查

已验证：

```text
GET /health -> HTTP 200
```

健康检查返回四类 Agent 的可用状态，可作为录屏前的服务状态确认。

## 8. API 文档入口

已验证：

```text
GET /docs -> HTTP 200
```

接口文档用于确认 Web/API 服务路由已加载，可作为运行证据之一。

## 9. 首页访问

已验证：

```text
GET / -> HTTP 200
```

首页可展示四类 Agent 模块，并作为最终录屏主界面。

## 10. 示例运行方式

推荐演示输入：

| 模块 | 输入 |
| --- | --- |
| 论文搜索 | `retrieval augmented generation` |
| 论文分析 | `https://arxiv.org/abs/1706.03762` |
| 写作辅助 | `请用三句话说明 RAG 评估的研究背景。` |
| 引用校验 | `arXiv:1706.03762` |

录屏采用分模块演示，不强行展示完整协调工作流。

## 11. 当前本地验证状态

已完成：

1. Web/API 模式验证。
2. 首页、健康检查和接口文档验证。
3. LLM health check 验证。
4. Hunter 论文搜索验证。
5. Miner 论文分析验证。
6. Coach 写作辅助验证。
7. Validator 引用校验验证。
8. 原始录屏归档。
9. 抽帧预览和剪辑计划。
10. 等待片段加速处理。
11. 中文字幕最终视频生成。

最终视频：

```text
assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4
```

## 12. 已知边界

1. 完整协调工作流存在搜索命中、任务状态和长任务响应时间等边界，因此最终录屏采用分模块稳定演示。
2. 长文本写作任务可能受模型响应时间影响，录屏建议使用短输入。
3. PDF 上传解析未作为本次最终录屏主线。
4. 长任务状态和流式任务链路仍需后续扩展验证。
5. 持久化和向量检索能力未作为本次成片主线，不夸大为完整生产能力。
6. 所有科研分析输出都需要人工复核。

## 13. 演示材料

```text
assets/reports/research-innovation-agent/research-innovation-run-result.md
assets/reports/research-innovation-agent/research-workflow-sample.md
assets/reports/research-innovation-agent/report-preview.html
assets/reports/research-innovation-agent/raw-assets-inventory.md
assets/reports/research-innovation-agent/ffmpeg-edit-plan.md
assets/reports/research-innovation-agent/frame-preview-index.md
assets/reports/research-innovation-agent/demo-subtitles.srt
assets/demos/research-innovation-agent/raw/
assets/demos/research-innovation-agent/research-innovation-agent-demo.mp4
```

## 14. 下一步可扩展

- 补充 PDF 上传解析演示。
- 优化完整协调工作流的任务状态和长任务反馈。
- 增加报告导出和引用复核清单。
- 将检索、分析、引用和报告生成串联为更稳定的端到端录屏流程。
