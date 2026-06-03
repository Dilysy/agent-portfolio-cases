# 智能竞品分析 Agent 示例运行记录

## 示例输入

- 参考项目：`czxgg0630-ProductAnalysisAgent`
- 运行入口：`ProductAnalysis_PlanSolveAgent.ipynb`
- 示例任务：分析盒马、叮咚买菜、盒马会员商店三类生鲜零售相关品牌
- 输出路径：`outputs/demo_result_20260409_142128.md`

## 执行过程

1. 初始化 `HelloAgentsLLM` 和 `PlanAndSolveAgent`。
2. Agent 生成分析计划，包含竞品名称确认、逐个搜索、对比分析和报告生成。
3. 调用 `CompetitiveInfoSearchTool` 检索公开信息。
4. 使用 `DataProcessorTool v2.0` 抽取产品定位、功能、定价、优势、劣势等字段。
5. 使用 `ReportGeneratorTool v2.0` 生成 Markdown 报告。
6. 将报告保存到 `outputs/demo_result_*.md`。

## 工具调用记录

| 步骤 | 工具 | 输入 | 输出 |
| --- | --- | --- | --- |
| 1 | PlanAndSolveAgent | 竞品分析任务 | 分步骤执行计划 |
| 2 | CompetitiveInfoSearchTool | 产品名 + 功能/定价/优缺点关键词 | Tavily 搜索结果或失败反馈 |
| 3 | DataProcessorTool | 搜索文本 | 结构化产品字段 |
| 4 | ReportGeneratorTool | 结构化字段列表 | Markdown 竞品报告 |

## 示例输出

示例报告包含以下模块：

- 报告摘要
- 竞品基本信息回顾
- 核心特性对比表
- 盒马、叮咚买菜、盒马会员商店的 SWOT 分析
- 针对各品牌的策略建议

## 人工复核结论

需要人工复核公司归属、配送时效、SKU 数量、定价和策略建议是否有可靠来源支持。报告中的建议属于分析草案，不能写成真实咨询交付结论。

## 当前不足

- 搜索依赖 Tavily 和网络状态，存在超时或限流风险。
- SimpleAgent 版本中的数据处理和报告工具曾是 PoC 占位，需要避免引用为完整能力。
- PlanSolve 版本的结构化抽取以规则和正则为主，对复杂网页文本的泛化能力有限。

## 可改进方向

- 增加来源链接和引用编号。
- 增加缓存与重试。
- 增加事实冲突检测和人工复核表。
- 将报告生成改为模板化渲染，减少模型自由发挥。
