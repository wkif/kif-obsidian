# 🤖 AI - 人工智能技术

> LLM、Agent、RAG、机器学习 | AI 时代的技术探索

## 📚 涵盖内容

这里记录所有 **AI 相关**的技术知识：
- 🧠 **大语言模型 (LLM)** - GPT、Claude、开源模型
- 🤖 **AI Agent** - AutoGPT、LangChain、Function Calling
- 📖 **RAG 技术** - 向量数据库、Embedding、检索增强
- 🔧 **AI 应用开发** - Prompt Engineering、Fine-tuning
- 📊 **机器学习** - 基础算法、深度学习框架
- 🎨 **生成式 AI** - Text、Image、Video 生成

---

## 🗂️ 推荐目录结构

```
13-AI/
├── LLM/
│   ├── GPT-API-Usage.md
│   ├── Claude-Best-Practices.md
│   └── Prompt-Engineering.md
├── Agent/
│   ├── LangChain-Guide.md
│   ├── Function-Calling.md
│   └── Agent-Architecture.md
├── RAG/
│   ├── Vector-Database.md
│   ├── Embedding-Models.md
│   └── RAG-Optimization.md
├── Applications/
│   ├── AI-Chat-System.md
│   ├── Document-QA.md
│   └── Code-Assistant.md
└── Research/
    ├── Paper-Reading.md
    └── Latest-Trends.md
```

---

## 🎯 重点领域

### 大语言模型 (LLM)
- 🔑 API 使用与优化
- 💡 Prompt Engineering 技巧
- 🎨 System Prompt 设计
- 📊 Token 优化策略
- 🔒 安全与隐私考虑

### AI Agent
- 🤖 Agent 架构设计
- 🔧 工具调用 (Function Calling)
- 🔄 多 Agent 协作
- 📝 ReAct Pattern
- 🎯 任务规划与执行

### RAG 技术
- 🗄️ 向量数据库选择 (Pinecone、Chroma、Qdrant)
- 📐 Embedding 模型对比
- 🔍 检索策略优化
- 📚 文档分块技巧
- 🎯 上下文窗口管理

### 实践应用
- 💬 对话系统
- 📄 文档问答
- 🔍 智能搜索
- 📝 内容生成
- 🤖 代码助手

---

## 📝 笔记示例

### API 使用
```markdown
# OpenAI API Function Calling

## 基本用法
\`\`\`python
from openai import OpenAI

client = OpenAI()

tools = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "获取指定城市的天气",
            "parameters": {
                "type": "object",
                "properties": {
                    "city": {"type": "string"}
                },
                "required": ["city"]
            }
        }
    }
]

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "北京天气怎么样？"}],
    tools=tools
)
\`\`\`

## 最佳实践
- 清晰的函数描述
- 完整的参数定义
- 错误处理机制

#llm #openai #function-calling
```

### RAG 实现
```markdown
# RAG 系统实现指南

## 架构
1. 文档加载
2. 文本分块
3. Embedding 生成
4. 向量存储
5. 检索查询
6. LLM 生成

## 关键代码
\`\`\`python
from langchain.vectorstores import Chroma
from langchain.embeddings import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter

# 文档分块
splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200
)
chunks = splitter.split_documents(documents)

# 创建向量库
embeddings = OpenAIEmbeddings()
vectorstore = Chroma.from_documents(
    documents=chunks,
    embedding=embeddings
)

# 检索
results = vectorstore.similarity_search(query, k=3)
\`\`\`

## 优化技巧
- 合适的 chunk_size
- 适当的 overlap
- Hybrid Search (向量+关键词)
- Reranking

#rag #vector-database #embedding
```

### Prompt Engineering
```markdown
# Prompt Engineering 最佳实践

## 基本原则
1. **清晰明确** - 明确说明期望输出
2. **提供示例** - Few-shot Learning
3. **分步骤** - 复杂任务拆解
4. **设置约束** - 格式、长度、风格

## 模板示例

### 代码生成
\`\`\`
你是一个专业的 Python 工程师。

任务：编写一个函数 {function_name}
要求：
- 功能：{description}
- 输入：{input_params}
- 输出：{output_format}
- 包含完整的类型注解和文档字符串
- 包含错误处理

示例输出格式：
···python
def example_function(param: str) -> dict:
    """
    函数说明

    Args:
        param: 参数说明

    Returns:
        返回值说明
    """
    # 实现
    pass
···
\`\`\`

## 相关资源
- [[OpenAI-Prompt-Guide]]
- [[Claude-Prompt-Tips]]

#prompt-engineering #llm #best-practices
```

---

## 🏷️ 标签系统

### 技术分类
- `#llm` - 大语言模型
- `#agent` - AI Agent
- `#rag` - 检索增强生成
- `#embedding` - 向量嵌入
- `#prompt-engineering` - 提示工程

### 工具框架
- `#openai` / `#claude` / `#gemini`
- `#langchain` / `#llamaindex`
- `#chromadb` / `#pinecone` / `#qdrant`

### 应用类型
- `#chatbot` - 聊天机器人
- `#document-qa` - 文档问答
- `#code-assistant` - 代码助手
- `#content-generation` - 内容生成

---

## 🔗 相关资源

### 官方文档
- [OpenAI API](https://platform.openai.com/docs)
- [Anthropic Claude](https://docs.anthropic.com/)
- [LangChain](https://python.langchain.com/)
- [LlamaIndex](https://docs.llamaindex.ai/)

### 学习资源
- [Prompt Engineering Guide](https://www.promptingguide.ai/)
- [OpenAI Cookbook](https://github.com/openai/openai-cookbook)
- [DeepLearning.AI Courses](https://www.deeplearning.ai/)

### 向量数据库
- [Chroma](https://www.trychroma.com/)
- [Pinecone](https://www.pinecone.io/)
- [Qdrant](https://qdrant.tech/)
- [Weaviate](https://weaviate.io/)

---

## 📊 笔记统计

```dataview
TABLE WITHOUT ID
  file.link as "笔记",
  file.mtime as "最后修改",
  tags as "标签"
FROM "13-AI"
WHERE file.name != "README"
SORT file.mtime DESC
LIMIT 20
```

---

## 🎯 学习路径

### 基础入门
1. ✅ 理解 LLM 基本概念
2. ✅ 学习 API 基本使用
3. ⏳ 掌握 Prompt Engineering
4. ⏳ 了解 Token 计费机制

### 进阶应用
1. ⏳ Function Calling 和工具使用
2. ⏳ RAG 系统搭建
3. ⏳ Agent 架构设计
4. ⏳ 向量数据库实践

### 高级探索
1. ⏳ Fine-tuning 技术
2. ⏳ 多模态应用
3. ⏳ 性能优化
4. ⏳ 成本控制策略

---

## 💡 实践项目

### 入门项目
- [ ] 简单的 ChatGPT 界面
- [ ] Prompt 测试工具
- [ ] Token 计算器

### 进阶项目
- [ ] 个人知识库问答系统
- [ ] PDF 文档智能分析
- [ ] 代码审查助手

### 高级项目
- [ ] 多 Agent 协作系统
- [ ] 企业级 RAG 平台
- [ ] AI 驱动的工作流自动化

---

## 🔥 最新趋势

### 关注方向
- 🚀 GPT-4.5 / Claude Opus 4.5 新特性
- 🤖 Multi-Agent 系统
- 🎯 长上下文处理技术
- 💡 提示工程新范式
- 🔒 AI 安全与对齐

---

**AI 时代，持续学习** 🚀

[[00-Dashboard/README|← 返回 Dashboard]] | [[12-Backend/README|← 后端]] | [[20-Projects/README|项目 →]]
