# 📅 Daily - 每日记录

> 所有内容的起点 | 捕捉每天的思考、学习和灵感

## 🎯 为什么要写日记？

这里是你知识管理系统的**入口**。任何：
- 📚 学到的东西
- ❓ 遇到的问题
- 💡 突然想到的点子
- 🔧 解决的 Bug
- 🎨 看到的好设计

**都应该从这里开始记录。**

不要等整理好再写 —— **先写，再整理**。

---

## ⏰ 什么时候写？

**建议每天至少一次：**
- ✅ 下班前总结
- ✅ 学习结束后记录
- ✅ 解决问题后立即记录
- ✅ 有灵感时马上写下

---

## ✍️ 写什么？

### 核心内容
1. **今天做了什么** - 具体的任务和成果
2. **遇到了什么问题** - 问题描述和背景
3. **如何解决的** - 解决方案和思路
4. **学到了什么** - 新知识、新理解
5. **想到了什么点子** - 灵感和改进想法

### 可选内容
- 🔗 相关链接和参考资料
- 📊 数据和指标
- 🤔 反思和感悟
- 📝 TODO 和计划

---

## 📋 推荐模板

```markdown
# YYYY-MM-DD - 周X

## 📌 今日重点
-

## ✅ 今日完成
- [ ] 任务 1
- [ ] 任务 2

## 💻 技术记录

### 问题：标题
**现象：**


**原因：**


**解决：**


**参考：** [[相关笔记]]

## 💡 今日收获
-

## 🎯 明日计划
-

## 🔗 相关链接
-
```

---

## 🎨 使用技巧

### 快速记录
使用简洁的格式，不需要完美：
```markdown
## Django Channels 问题

现象：第二个用户发消息，第一个收不到

原因：group_add 没等待

解决：加 await

→ [[Django-Channels-Group]]
```

### 链接到其他笔记
遇到值得深入的话题，创建专门笔记：
```markdown
今天研究了 Vue 的响应式原理
→ 详见 [[Vue-Reactivity-System]]
```

### 标签分类
使用标签快速分类：
- `#bug` - Bug 相关
- `#learning` - 学习笔记
- `#idea` - 新想法
- `#tip` - 小技巧
- `#refactor` - 重构相关

---

## 🔄 后续整理

日记是**临时记录**，定期整理：

1. **技术内容** → 移到对应技术分类（11-Frontend, 12-Backend 等）
2. **想法和点子** → 移到 30-Ideas
3. **项目相关** → 移到 20-Projects
4. **深度思考** → 移到 40-Knowledge

---

## 📊 查看所有日记

```dataview
TABLE WITHOUT ID
  file.link as "日期",
  length(file.lists) as "条目数",
  file.ctime as "创建时间"
FROM "01-Daily"
WHERE file.name != "README"
SORT file.name DESC
LIMIT 30
```

---

## 💼 示例日记

### 2026-03-30

## 今日完成
- ✅ 实现 Vue 防抖指令
- ✅ 修复 Django Channels 问题

## 今日问题

### Django Channels 消息丢失

**现象：**
第二个用户发送消息，第一个收不到。

**原因：**
`group_add` 没有使用 `await`，导致异步操作未完成。

**解决：**
```python
await self.channel_layer.group_add(
    self.room_group_name,
    self.channel_name
)
```

→ 详见 [[Django-Channels-Group]]

## 今日收获
理解了 WebSocket 的 group 管理机制：
- group 是频道层的概念
- 必须正确处理异步操作
- 使用 `await` 确保操作完成

## 新想法
💡 做一个 [[AI-WebSocket-Debug-Tool]]
- 自动检测 WebSocket 连接问题
- 可视化消息流
- 智能提示解决方案

---

**记住：先记录，再整理。养成每日记录的习惯！** 🌱

[[00-Dashboard/README|← 返回 Dashboard]]
