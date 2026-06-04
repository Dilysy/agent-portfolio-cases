# Agent 案例集制作 SOP

## 1. 项目定位

本仓库用于建设 GitHub 版 Agent 落地案例集，服务于求职、面试展示和轻量级接单沟通。案例来源于已复现和理解的开源 Agent 项目，通过业务场景重组、功能说明、运行记录、截图、演示视频和输出报告，将其包装为可展示、可复盘、可扩展的企业知识工作流 Agent 案例。

本案例集当前定位为：

```text
企业知识工作流 Agent 落地案例集
```

第一版优先制作 5 个案例：

```text
1. AutoFlow 流程图生成 Agent
2. 智能竞品分析 Agent
3. 企业经营数据分析 Agent
4. 自动化深度研究 Agent
5. 自然语言数据库查询 Agent
```

其中 AutoFlow 已作为首个完整案例完成闭环，后续案例按照本 SOP 快速复用。

---

## 2. 总体制作原则

每个案例都必须形成一条完整证据链：

```text
业务问题
↓
示例输入
↓
Agent 执行过程
↓
输出结果
↓
截图
↓
演示视频
↓
GitHub 文档展示
```

制作过程中遵守以下原则：

1. 所有案例均表述为“本地复现、理解和改造”，不得写成真实客户交付。
2. 不夸大项目能力，不展示未验证能力。
3. 如果某项能力只是规划，必须写成“后续可扩展”。
4. 不保留 API Key、账号、邮箱、微信、浏览器隐私页等敏感信息。
5. 不在正式展示中引用失败录屏、错误截图和废弃素材。
6. Codex 负责读代码、整理文档、生成脚本和辅助处理。
7. 人工负责项目运行、截图录屏、最终判断和成片检查。
8. 第一版演示视频统一采用 ffmpeg 字幕版，配音后置。
9. 先完成 GitHub 案例集闭环，再制作 PDF 案例集。

---

## 3. GitHub 仓库架构

当前仓库结构如下：

```text
agent-portfolio-cases/
├── README.md
├── AGENTS.md
├── assets/
│   ├── _discarded/
│   ├── architecture/
│   ├── demos/
│   ├── reports/
│   └── screenshots/
├── cases/
│   ├── autoflow-agent/
│   │   ├── README.md
│   │   ├── runbook.md
│   │   └── sample.md
│   ├── business-data-analysis-agent/
│   ├── competitor-analysis-agent/
│   ├── database-query-agent/
│   └── deep-research-agent/
├── docs/
│   ├── agent-design.md
│   ├── deployment.md
│   ├── evaluation.md
│   ├── evidence-checklist.md
│   ├── outreach.md
│   ├── portfolio-pdf-draft.md
│   └── tool-calling.md
└── scripts/
    ├── autoflow_video/
    ├── capture_screenshot.sh
    ├── README.md
    └── record_screen.sh
```

---

## 4. 根目录职责说明

### 4.1 README.md

GitHub 首页。用于展示案例集定位、案例总览、重点案例、演示材料、项目文档入口和后续计划。

README.md 面向外部读者，重点是让 HR、面试官和潜在客户快速理解：

```text
这个案例集是什么
有哪些案例
每个案例解决什么问题
有哪些演示视频和截图
当前完成到什么程度
```

### 4.2 AGENTS.md

Codex 项目规则文件。用于约束 Codex 的写作口径、案例范围、目录结构、安全要求和输出方式。

AGENTS.md 主要服务于后续自动化协作，避免 Codex 出现以下问题：

```text
虚构真实客户交付
误加入不熟悉的案例
乱放文件
输出营销化内容
提交 API Key 或敏感信息
```

### 4.3 cases/

每个 Agent 案例的文字说明目录。每个案例一个独立子目录。

### 4.4 assets/

所有展示资产目录，包括截图、视频、报告、架构图、废弃素材。

### 4.5 docs/

项目级通用文档目录，包括 Agent 设计、工具调用、评估、部署、SOP、外联话术、PDF 草稿等。

### 4.6 scripts/

工具脚本目录，包括截图录屏脚本、视频剪辑脚本、抽帧脚本、字幕合成脚本和后续自动化处理脚本。

---

## 5. cases 目录规范

每个案例目录必须包含：

```text
cases/案例名/
├── README.md
├── runbook.md
└── sample.md
```

### 5.1 README.md

用于 GitHub 展示。说明案例背景、业务问题、解决方案、Agent 设计、工具调用、实现流程、输出结果、评估方式、可扩展方向和演示材料。

固定结构：

```text
1. 项目背景
2. 业务问题
3. 解决方案
4. Agent 设计
5. 工具调用
6. 实现流程
7. 输出结果
8. 评估方式
9. 可扩展方向
10. 演示材料
```

### 5.2 runbook.md

用于复现和维护。记录项目来源、环境准备、依赖安装、环境变量、启动命令、运行步骤、已知问题、修复记录和当前复现状态。

固定结构：

```text
1. 项目来源
2. 项目定位
3. 环境准备
4. 依赖安装
5. 环境变量配置
6. 启动方式
7. 示例运行
8. 常见问题
9. 当前复现状态
10. 后续可扩展方向
```

### 5.3 sample.md

用于记录一次完整演示。包含示例输入、执行过程、工具调用记录、示例输出、人工复核结论、当前不足和优化方向。

固定结构：

```text
1. 示例输入
2. 执行过程
3. 工具调用记录
4. 示例输出
5. 人工复核结论
6. 当前不足
7. 可改进方向
8. 演示材料路径
```

---

## 6. assets 目录规范

assets 下按照资产类型分类，不按案例直接平铺。

### 6.1 assets/screenshots/

存放所有截图。

每个案例使用独立子目录：

```text
assets/screenshots/autoflow-agent/
assets/screenshots/competitor-analysis-agent/
assets/screenshots/business-data-analysis-agent/
assets/screenshots/deep-research-agent/
assets/screenshots/database-query-agent/
```

每个案例截图目录下建议区分：

```text
raw/     原始截图
final/   最终展示截图
```

常见截图命名：

```text
01-input.png
02-process.png
03-result.png
04-report-preview.png
05-export-result.png
```

### 6.2 assets/demos/

存放所有视频。

每个案例使用独立子目录：

```text
assets/demos/autoflow-agent/
assets/demos/competitor-analysis-agent/
assets/demos/business-data-analysis-agent/
assets/demos/deep-research-agent/
assets/demos/database-query-agent/
```

每个案例视频目录下建议包含：

```text
raw/       原始录屏
clips/     裁剪片段，可选
案例名-demo.mp4
```

原始视频命名：

```text
案例名-raw-demo.mov
```

最终视频命名：

```text
案例名-demo.mp4
```

### 6.3 assets/reports/

存放报告、剪辑计划、素材清单、抽帧索引、测试结果等文档资产。

每个案例使用独立子目录：

```text
assets/reports/autoflow-agent/
assets/reports/competitor-analysis-agent/
assets/reports/business-data-analysis-agent/
assets/reports/deep-research-agent/
assets/reports/database-query-agent/
```

常见文件包括：

```text
raw-assets-inventory.md
ffmpeg-edit-plan.md
frame-preview-index.md
xxx-report.md
xxx-result.md
xxx-test.md
demo-subtitles.srt
```

### 6.4 assets/architecture/

存放架构图。

建议每个案例一个 Markdown 或图片文件：

```text
autoflow-agent.md
competitor-analysis-agent.md
business-data-analysis-agent.md
deep-research-agent.md
database-query-agent.md
```

### 6.5 assets/_discarded/

存放废弃素材，例如失败录屏、重复截图、错误截图。该目录中的内容不用于 README、PDF 和正式展示。

---

## 7. docs 目录规范

docs 用于存放项目级通用文档。

当前文档职责如下：

### 7.1 agent-design.md

总结案例集中使用的 Agent 设计模式，例如 ReAct、Plan-and-Solve、多 Agent、结构化生成等。

### 7.2 tool-calling.md

总结工具调用模式，例如搜索、网页抽取、数据分析、数据库查询、Mermaid 渲染等。

### 7.3 evaluation.md

总结 Agent 案例评估方式，例如任务完成率、工具调用成功率、输出结构完整度、人工复核结论。

### 7.4 deployment.md

记录本地运行、前后端启动、API 服务化、可扩展部署方式。

### 7.5 evidence-checklist.md

记录每个案例的证据材料完成状态，包括 README、sample、runbook、截图、录屏、报告、成片。

案例状态至少包含：

```text
1. 待复现
2. 已复现
3. 已补证据材料
4. 已完成
```

AutoFlow 当前应标记为“已完成”。

### 7.6 outreach.md

用于简历、面试介绍、客户私信、朋友圈发布等外部沟通文案。

### 7.7 portfolio-pdf-draft.md

用于后续 PDF 案例集初稿。

### 7.8 case-production-sop.md

记录当前这套案例制作流程和仓库规范。

---

## 8. scripts 目录规范

scripts 用于自动化辅助，不用于存放业务代码。

### 8.1 capture_screenshot.sh

早期用于 macOS 截图，后续不作为主要截图方式，保留作为备用。

### 8.2 record_screen.sh

早期用于 macOS 录屏，后续不作为主要录屏方式，保留作为备用。

### 8.3 scripts/autoflow_video/

AutoFlow 视频处理脚本目录，包括抽帧、字幕、剪辑、合成等脚本。

### 8.4 后续案例脚本目录

后续每个案例如果需要视频剪辑，应建立独立脚本目录：

```text
scripts/competitor_analysis_video/
scripts/business_data_analysis_video/
scripts/deep_research_video/
scripts/database_query_video/
```

---

## 9. 文件命名规范

统一使用英文小写短横线命名。

案例目录命名：

```text
autoflow-agent
competitor-analysis-agent
business-data-analysis-agent
deep-research-agent
database-query-agent
```

原始视频命名：

```text
案例名-raw-demo.mov
```

最终视频命名：

```text
案例名-demo.mp4
```

截图命名：

```text
01-input.png
02-process.png
03-result.png
04-report-preview.png
```

报告文件命名：

```text
案例名-report.md
案例名-result.md
raw-assets-inventory.md
ffmpeg-edit-plan.md
frame-preview-index.md
```

---

## 10. 单个案例制作流程

### 阶段一：复现与理解

目标是先确认项目能否运行，并理解项目结构。

执行内容：

```text
1. 阅读开源项目 README
2. 阅读代码目录结构
3. 找出启动方式
4. 找出环境变量
5. 找出 Agent 设计方式
6. 找出工具调用链路
7. 尝试本地运行
8. 记录依赖问题、环境问题和修复方式
```

Codex 负责：

```text
阅读代码
整理依赖
生成 runbook
记录阻塞点
```

人工负责：

```text
确认项目是否真的能运行
判断哪些能力适合展示
判断哪些内容不能夸大
```

产出文件：

```text
cases/案例名/runbook.md
```

---

### 阶段二：案例包装与文档生成

目标是把开源项目包装成企业场景案例，而不是课程笔记。

产出文件：

```text
cases/案例名/README.md
cases/案例名/sample.md
```

写作原则：

```text
1. 不写真实客户交付
2. 不写“已为某企业上线”
3. 不夸大项目能力
4. 不使用营销化表达
5. 保持“复现、理解、改造、演示”的真实口径
6. 每个技术点都要能讲清楚
```

---

### 阶段三：准备演示输入和输出结果

每个案例必须准备一个业务化输入。

示例：

AutoFlow：

```text
客户提交需求后，销售进行需求确认。需求明确则进入方案编写，需求不明确则返回客户补充信息。方案完成后提交客户评审，客户通过后进入合同流程，未通过则返回修改。
```

竞品分析 Agent：

```text
请分析 Notion、飞书文档、语雀在团队知识管理场景下的差异，输出竞品对比表、优劣势分析和销售切入建议。
```

数据分析 Agent：

```text
请基于某电商企业销售数据，分析销售趋势、区域表现、商品类别贡献、客户类型差异和经营建议。
```

数据库查询 Agent：

```text
查询 2025 年各地区销售额排名前 5 的地区，并返回销售额和订单数。
```

每个案例至少产出一个结果文件：

```text
assets/reports/案例名/xxx-report.md
```

---

### 阶段四：人工截图与录屏

已确认 Codex 自动截图录屏不稳定，后续统一改为人工手动录制。

人工负责：

```text
1. 打开项目页面
2. 输入示例任务
3. 运行 Agent
4. 展示输出结果
5. 手动截图
6. 手动录屏
```

截图目录：

```text
assets/screenshots/案例名/raw/
```

录屏目录：

```text
assets/demos/案例名/raw/
```

录屏要求：

```text
1. 不录桌面
2. 不录 Codex
3. 不录终端报错
4. 不录 API Key
5. 不录微信、邮箱、浏览器隐私标签
6. 画面只展示产品界面、输入、生成过程和结果
7. 原始录屏可以偏长，但必须保证素材干净
```

---

### 阶段五：素材归档

手动录完后，不直接在桌面处理，先把素材复制到作品集标准目录。

标准目录：

```text
assets/demos/案例名/raw/
assets/screenshots/案例名/raw/
assets/reports/案例名/
```

归档后生成素材清单：

```text
assets/reports/案例名/raw-assets-inventory.md
```

素材清单包含：

```text
1. 原始素材目录
2. 视频文件列表
3. 图片文件列表
4. 推荐使用素材
5. 不建议使用素材
6. 缺失素材提醒
7. 剪辑前注意事项
```

---

### 阶段六：生成剪辑计划

每个案例剪辑前先生成剪辑计划，不直接导出。

剪辑计划文件：

```text
assets/reports/案例名/ffmpeg-edit-plan.md
```

剪辑计划包含：

```text
1. 原始视频信息
2. 输出规格
3. 成片目标时长
4. 视频结构
5. 推荐保留片段
6. 字幕文案
7. 加速策略
8. 抽帧预览计划
9. 风险控制
10. 需要人工确认的问题
```

成片时长建议：

```text
AutoFlow：60-75 秒
智能竞品分析 Agent：45-60 秒
企业经营数据分析 Agent：45-60 秒
自动化深度研究 Agent：40-50 秒
自然语言数据库查询 Agent：40-50 秒
```

第一版统一做字幕版，不做配音。

---

### 阶段七：ffmpeg 抽帧预览

不要直接按估算时间剪辑。先抽帧确认真实时间点。

抽帧目录：

```text
assets/reports/案例名/frame-preview/
```

索引文件：

```text
assets/reports/案例名/frame-preview-index.md
```

抽帧要求：

```text
每 5 秒抽 1 张图
标注画面内容
判断是否适合进入剪辑
```

索引字段：

```text
1. 时间点
2. 图片路径
3. 画面内容判断
4. 是否适合进入剪辑
5. 备注
```

人工检查后确认最终剪辑时间段。

---

### 阶段八：生成剪辑脚本并导出视频

确认时间段后，让 Codex 生成剪辑脚本。

脚本目录：

```text
scripts/案例名/build_demo.sh
```

字幕文件：

```text
assets/reports/案例名/demo-subtitles.srt
```

成片输出：

```text
assets/demos/案例名/案例名-demo.mp4
```

剪辑脚本执行内容：

```text
1. 裁剪原始片段
2. 图片转视频作为片头和结尾
3. 操作过程加速
4. 结果画面保留
5. 拼接片段
6. 静音处理
7. 添加硬字幕
8. 输出 MP4 / H.264
```

视频导出后，人工检查：

```text
1. 是否黑屏
2. 是否卡顿
3. 是否有报错
4. 是否有无关窗口
5. 是否有隐私信息
6. 字幕是否遮挡关键内容
7. 是否覆盖核心功能
8. 时长是否合适
9. 是否能看懂输入、处理、输出
```

---

### 阶段九：案例收尾

成片确认可用后，更新案例文档。

需要更新：

```text
cases/案例名/README.md
cases/案例名/sample.md
docs/evidence-checklist.md
README.md
```

README 中增加：

```text
## 演示材料

- 演示视频：assets/demos/案例名/案例名-demo.mp4
- 原始录屏：assets/demos/案例名/raw/xxx.mov
- 关键截图：assets/screenshots/案例名/raw/
- 输出报告：assets/reports/案例名/xxx-report.md
```

sample.md 中补充：

```text
1. 实际演示输入
2. 实际输出结果
3. 截图路径
4. 视频路径
5. 当前不足
6. 后续优化方向
```

---

### 阶段十：Git 提交

每完成一个案例，单独提交一次。

提交示例：

```bash
git add .
git commit -m "complete autoflow case evidence"
```

后续案例：

```bash
git commit -m "complete competitor analysis case evidence"
git commit -m "complete business data analysis case evidence"
git commit -m "complete deep research case evidence"
git commit -m "complete database query case evidence"
```

---

## 11. AutoFlow 已完成内容

AutoFlow 已完成：

```text
1. 原项目复现
2. 依赖修复
3. LLM 配置确认
4. Kimi-K2.6 接入
5. 灵感模式跑通
6. 标准模式跑通
7. 计划模式伪成功修复
8. Mermaid 代码模式跑通
9. 原始视频录制
10. 四模式截图
11. 原始素材归档
12. 素材清单生成
13. ffmpeg 剪辑计划生成
14. 抽帧预览
15. 剪辑脚本生成
16. 字幕版视频导出
17. README、sample、evidence-checklist、首页状态更新
```

AutoFlow 暂时不做配音，保留字幕版成片即可。

---

## 12. 后续案例制作顺序

后续案例按以下顺序制作：

```text
1. 智能竞品分析 Agent
2. 企业经营数据分析 Agent
3. 自动化深度研究 Agent
4. 自然语言数据库查询 Agent
```

优先制作智能竞品分析 Agent，因为它最适合接单和客户展示。

---

## 13. 后续案例视频结构参考

### 13.1 智能竞品分析 Agent

建议时长：45-60 秒。

结构：

```text
片头
输入竞品分析任务
Agent 执行过程
竞品对比表
SWOT 或差异化建议
输出报告
结尾
```

### 13.2 企业经营数据分析 Agent

建议时长：45-60 秒。

结构：

```text
片头
展示 CSV 数据
展示分析目标
展示图表
展示经营报告
展示结论建议
结尾
```

### 13.3 自动化深度研究 Agent

建议时长：40-50 秒。

结构：

```text
研究主题输入
任务拆解
搜索摘要
笔记沉淀
最终研究报告
结尾
```

### 13.4 自然语言数据库查询 Agent

建议时长：40-50 秒。

结构：

```text
自然语言问题
Schema 示例
SQL 生成
查询结果
安全控制说明
结尾
```

---

## 14. 当前工作原则

后续所有案例遵循以下原则：

1. Codex 负责读代码、写文档、整理 runbook、生成脚本。
2. 人工负责运行项目、截图、录屏和最终判断。
3. 不再让 Codex 自动录屏。
4. 不再优先使用 jianying-editor-skill。
5. 第一版全部采用 ffmpeg 字幕版视频。
6. 配音后置，不影响案例集主线。
7. 每个案例先完成闭环，再追求美化。
8. 不虚构客户交付。
9. 不展示自己讲不清的领域。
10. 先完成 GitHub 案例集，再制作 PDF。
