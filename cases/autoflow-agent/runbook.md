# AutoFlow 流程图生成 Agent 本地复现步骤

## 环境准备

- 准备 Python 或 Node.js 运行环境。
- 准备用于演示的流程文本。
- 安装可选的 Mermaid 渲染工具。

## 依赖安装

当前仓库尚未固定依赖。后续可根据实现选择安装 Mermaid CLI 或 Markdown 渲染工具。

## 配置说明

- 配置输入文本路径。
- 配置输出 Markdown 或 Mermaid 文件路径。
- 如使用模型 API，需要通过环境变量配置密钥。

## 启动方式

当前为案例骨架，尚未提供统一启动命令。后续可扩展为：

```bash
python run.py --case autoflow --input flow.txt
```

## 示例运行

输入一段流程描述，输出 Mermaid 流程图和待确认问题。当前可通过 `sample.md` 查看预期记录结构。

## 常见问题

- 条件分支缺失：补充更明确的流程文本。
- Mermaid 无法渲染：检查节点文本和特殊字符。
- 流程边界不清：在输出中保留待确认问题。
