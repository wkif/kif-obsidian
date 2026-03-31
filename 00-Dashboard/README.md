# 🎯 Dashboard - 控制中心

> 整个知识库的导航枢纽 | 快速了解当前状态和重点方向



## 🌟 这是什么？

这里是你每天打开 Obsidian 的起点。Dashboard 帮助你：
- 🎯 聚焦当前最重要的事
- 📊 追踪正在进行的项目
- 🎁 发现最近创建的笔记
- 🚀 规划短期和长期目标

**不要在这里写详细内容** —— 这里只做导航和概览。

---

## 📌 当前重点

> 此刻最需要关注的 3-5 件事

### 🔥 今日目标 (2026-03-31)

**个人任务：**
- [ ] 完成博客内容迁移
- [ ] 完成博客历史记录

**工作任务：**
- 暂无

### 💼 进行中的项目
- [[博客系统]] - 内容迁移中
-

### 🧠 正在学习
- [[技术主题]] - 进度/下一步
-

---

## 🎯 目标管理

### 本周目标
```dataview
LIST
FROM "02-Weekly"
WHERE file.ctime >= date(today) - dur(7 days)
SORT file.ctime DESC
LIMIT 1
```

**手动记录**：
- [ ] 目标 1
- [ ] 目标 2
- [ ] 目标 3

### 本月重点
- 🎯 主要目标：
- 📚 学习方向：
- 🚀 想要推进的项目：

---

## 📊 项目概览

### 🚀 活跃项目
```dataview
TABLE status as "状态", tags as "标签"
FROM "20-Projects"
WHERE contains(file.name, "active") OR !contains(file.name, "README")
SORT file.mtime DESC
LIMIT 5
```

**快速链接**：
- [[项目 A]] -
- [[项目 B]] -

### 💡 想法池
```dataview
TABLE WITHOUT ID
  file.link as "想法",
  file.ctime as "创建时间"
FROM "30-Ideas" OR "31-Product-Ideas" OR "32-Side-Projects"
WHERE file.name != "README"
SORT file.ctime DESC
LIMIT 5
```

---

## 📝 最近更新

### 今日笔记
```dataview
LIST
FROM "01-Daily"
WHERE file.ctime >= date(today)
```

### 最近 7 天创建的笔记
```dataview
TABLE file.ctime as "创建时间", file.folder as "分类"
WHERE file.ctime >= date(today) - dur(7 days)
  AND file.name != "README"
SORT file.ctime DESC
LIMIT 10
```

### 最近修改的技术笔记
```dataview
TABLE file.mtime as "修改时间", tags as "标签"
FROM "10-Tech" OR "11-Frontend" OR "12-Backend" OR "13-AI"
WHERE file.name != "README"
SORT file.mtime DESC
LIMIT 5
```

---

## 🔍 快速导航

### 📅 时间记录
- [[01-Daily/README|每日记录]] - 今天发生了什么？
- [[02-Weekly/README|每周复盘]] - 本周进展如何？

### 💻 技术笔记
- [[10-Tech/README|技术总览]] - 通用技术和工具
- [[11-Frontend/README|前端技术]] - React、Vue、CSS
- [[12-Backend/README|后端技术]] - API、数据库、架构
- [[13-AI/README|AI 技术]] - LLM、机器学习、Agent

### 📁 项目 & 想法
- [[20-Projects/README|项目管理]] - 所有项目总览
- [[30-Ideas/README|想法汇总]] - 灵感和点子
- [[31-Product-Ideas/README|产品创意]] - 产品 idea
- [[32-Side-Projects/README|Side Projects]] - 个人项目

### 📚 知识库
- [[40-Knowledge/README|知识总览]] - 系统化的知识
- [[41-Concepts/README|核心概念]] - 重要概念和原理
- [[42-Patterns/README|设计模式]] - 最佳实践

### ✍️ 内容创作
- [[50-Content/README|内容规划]] - 创作计划
- [[51-Blog-Drafts/README|博客草稿]] - 待发布文章
- [[52-Tutorials/README|教程指南]] - 教程和文档

### 🎬 娱乐生活
- [[60-Entertainment/README|影视记录]] - 电影和剧集追踪

---

## 🎨 使用技巧

### 每天早上
1. ✅ 查看「当前重点」
2. ✅ 检查「本周目标」进度
3. ✅ 创建今日 Daily Note

### 每周回顾
1. ✅ 更新项目状态
2. ✅ 回顾「最近更新」
3. ✅ 清理完成的任务
4. ✅ 规划下周重点

### 随时使用
- 💡 有新想法？记录到对应分类
- 📚 学到新知识？创建技术笔记
- 🔗 使用 `[[]]` 链接相关笔记

---

## 📊 统计面板

### 笔记分布
```dataview
TABLE length(rows) as "笔记数"
FROM ""
WHERE file.name != "README"
GROUP BY file.folder
SORT length(rows) DESC
```

---

**最后更新**：2026-03-31 | [[README|返回主页]]
