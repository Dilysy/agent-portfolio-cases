# AutoFlow 流程图生成 Agent

## 1. 项目背景

本案例围绕流程图生成场景进行前后端分离的 Agent 应用工程化实现，目标是把自然语言想法、计划或 Mermaid 代码转换为可预览、可导出的 Mermaid 流程图。

## 2. 业务问题

流程图常用于需求梳理、方案沟通和教学表达，但手写 Mermaid 成本高，业务文本也容易缺少统一结构。该项目解决“文本到流程图转换效率低、语法容易出错、缺少可视化反馈”的问题。

## 3. 解决方案

系统提供四种模式：灵感模式、标准模式、计划模式和 Mermaid 代码模式。计划模式将按行输入转换为线性流程图；标准模式先优化提示词再生成 Mermaid；灵感模式补全想法并生成流程图；代码模式直接渲染用户输入的 Mermaid。前端实时预览并支持方向切换、缩放、拖拽和导出。

## 4. Agent 设计

- 后端使用 FastAPI，包含 `/api/plan` 和 `/api/agent/chat/stream` 路由。
- `MermaidAgentService` 负责流式状态输出，执行生成、校验和返回结果。
- `MermaidPipeline` 负责标准模式的提示词优化、代码生成、修复和后置校验。
- `build_agent` 使用工具调用 Agent，注册 `MermaidValidatorTool`，要求先校验、必要时修复，再输出 Mermaid 代码。
- 前端使用 React + Vite + Mermaid，负责模式切换、聊天输入、预览渲染和导出。

## 5. 工具调用

- `PlanConverter`：将按行计划或 `A -> B -> C` 格式转换为 `flowchart TD/LR`。
- `MermaidValidatorTool`：去除代码块、补齐 Mermaid 图类型声明、检查括号匹配和 flowchart 节点连线。
- LLM 服务：根据 `本地配置文件` 中的模型配置生成优化文本和 Mermaid 代码。
- Mermaid 前端渲染：使用 `mermaid.render` 将代码转换为 SVG。

## 6. 实现流程

1. 用户在前端选择模式并输入文本。
2. 计划模式调用 `/api/plan`，后端直接转换为 Mermaid。
3. 标准或灵感模式调用 `/api/agent/chat/stream`，后端通过 SSE 返回状态和结果。
4. Agent 生成 Mermaid 后，Validator 做结构校验。
5. 校验失败时最多进行有限修复。
6. 前端渲染 SVG，并支持 `.mmd` 和 SVG 导出。

## 7. 输出结果

输出为 Mermaid 代码和前端 SVG 预览。本案例已整理 AutoFlow 四模式截图，并完成一版 72 秒字幕版演示视频，用于展示 LLM 接入、四模式验证、本地运行验证、实时预览和导出能力。

## 演示材料

- 字幕版演示视频：[autoflow-agent-demo.mp4](../../assets/demos/autoflow-agent/autoflow-agent-demo.mp4)
- 标准模式截图：[04-standard-result.png](../../assets/screenshots/autoflow-agent/final/04-standard-result.png)
- 灵感模式截图：[03-inspiration-result.png](../../assets/screenshots/autoflow-agent/final/03-inspiration-result.png)
- 计划模式截图：[05-plan-result.png](../../assets/screenshots/autoflow-agent/final/05-plan-result.png)
- Mermaid 代码模式截图：[06-mermaid-code-mode.png](../../assets/screenshots/autoflow-agent/final/06-mermaid-code-mode.png)

## 8. 评估方式

- 语法结构评估：`MermaidValidatorTool` 检查图类型、括号和 flowchart 节点连线。
- 前端渲染评估：浏览器端 Mermaid 渲染失败会显示错误。
- 交互评估：人工检查方向切换、缩放、拖拽和导出是否可用。
- 当前未看到自动化测试或批量 Mermaid 样例评估，后续可补强。

## 9. 可扩展方向

- 后续可增加更细粒度的流程图风格控制。
- 后续可加入模板库、行业预设和更完整的 Mermaid 语法测试集。
- 后续可优化超时、降级和重试机制。
