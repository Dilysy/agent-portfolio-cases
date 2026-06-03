# 智能竞品分析 Agent

## 1. 项目背景

本案例基于 `~/Documents/hello-agents/Co-creation-projects/czxgg0630-ProductAnalysisAgent` 复现和改造整理。原项目是基于 HelloAgents 的竞品分析系统，提供 `ProductAnalysis_SimpleAgent.ipynb` 和 `ProductAnalysis_PlanSolveAgent.ipynb` 两种实现，用于自动收集竞品信息、做多维对比并生成 Markdown 报告。

## 2. 业务问题

竞品分析通常存在三个痛点：公开信息分散、不同产品维度难以横向比较、从资料到报告的整理时间长。原项目面向产品经理、市场调研和咨询分析等场景，但本作品集只将其写成开源复现案例，不写成真实客户交付。

## 3. 解决方案

Agent 接收竞品列表后，先搜索每个产品的公开信息，再抽取产品名称、定位、核心功能、定价、优势和劣势，最后生成包含竞品概览、对比矩阵、SWOT 和建议的 Markdown 报告。SimpleAgent 用于快速验证，PlanAndSolveAgent 用于显式规划和多步骤执行。

## 4. Agent 设计

- SimpleAgent 版本：单轨工具调用，直接根据用户问题调用搜索、处理和报告工具。
- PlanAndSolveAgent 版本：先生成分析计划，再按步骤执行搜索、解析、对比和报告生成。
- 系统提示词要求 Agent 对每个产品分别搜索，按产品定位、功能、价格、优劣势组织结果。
- 原 notebook 中包含两类范式的评估：SimpleAgent 响应快但上下文和容错弱；Plan-and-Solve 透明度和可控性更好。

## 5. 工具调用

- `CompetitiveInfoSearchTool`：封装 HelloAgents 内置 `SearchTool`，使用 Tavily 后端检索产品功能、定价、优缺点等公开信息。
- `DataProcessorTool`：SimpleAgent 版本早期为 PoC 占位；PlanSolve 版本记录为 v2.0，使用规则解析搜索文本并提取结构化字段。
- `ReportGeneratorTool`：SimpleAgent 版本早期为占位；PlanSolve 版本基于结构化产品数据生成 Markdown 报告和多产品对比矩阵。
- 输出保存：运行结果写入 `outputs/demo_result_*.md`。

## 6. 实现流程

1. 在 Jupyter Notebook 中初始化 `HelloAgentsLLM`。
2. 注册搜索、数据处理和报告生成工具。
3. 输入竞品分析任务，例如分析多款知识管理工具或生鲜零售品牌。
4. SimpleAgent 直接执行工具链；PlanAndSolveAgent 先列计划再逐步执行。
5. 生成 Markdown 报告并保存到 `outputs/`。
6. 对工具链进行人工评估，记录网络超时、工具占位、结构化解析等问题。

## 7. 输出结果

原项目已有输出文件，例如 `outputs/demo_result_20260409_142128.md`，包含盒马、叮咚买菜、盒马会员商店的竞品分析报告，结构包括报告摘要、基本信息回顾、核心特性对比、SWOT 分析和策略建议。该输出用于复现展示，不代表真实客户项目。

## 8. 评估方式

- 架构评估：对 SimpleAgent 和 PlanAndSolveAgent 从逻辑复杂度、Token 消耗、可控性和适用场景进行对比。
- 工具链评估：确认 Tavily 搜索已接入；检查数据处理和报告生成是否真正消费搜索结果。
- 运行风险记录：网络超时、搜索限流、同步阻塞会影响稳定性。
- 人工复核：公开信息、定价、公司归属和建议类内容需要逐项核对来源。

## 9. 可扩展方向

- 后续可扩展 DuckDuckGo 等多搜索后端和缓存机制。
- 后续可将结构化解析从正则升级为 JSON Schema 约束的 LLM 抽取。
- 后续可加入引用链接、来源快照、事实冲突检测和报告导出。
