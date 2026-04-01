# 🎨 Frontend - 前端技术

> 前端开发知识库 | Vue、React、性能优化、架构设计

## 📚 涵盖内容

这里记录所有**前端相关**的技术知识：
- 🖼️ **框架** - Vue、React、Nuxt、Next.js
- 🎯 **状态管理** - Pinia、Vuex、Redux、Zustand
- 🚀 **性能优化** - 加载优化、渲染优化、Bundle 分析
- 🎨 **UI/UX** - 组件设计、动画、响应式
- 🔧 **工程化** - Webpack、Vite、构建优化
- 📱 **移动端** - 响应式设计、PWA、Hybrid App

---

## 🗂️ 推荐目录结构

```
11-Frontend/
├── Vue/
│   ├── Vue-Reactivity-System.md
│   ├── Vue-Composition-API.md
│   └── Vue-Performance-Tips.md
├── React/
│   ├── React-Hooks-Deep-Dive.md
│   └── React-Fiber-Architecture.md
├── Performance/
│   ├── Code-Splitting.md
│   ├── Lazy-Loading.md
│   └── Bundle-Optimization.md
├── Patterns/
│   ├── Component-Design-Patterns.md
│   ├── State-Management-Patterns.md
│   └── Error-Handling.md
└── Tools/
    ├── Vite-Config.md
    └── Webpack-Optimization.md
```

---

## 🎯 重点领域

### Vue 生态
- ⚡ Vue 3 Composition API
- 🔄 响应式原理
- 🎭 组件通信模式
- 🚀 Nuxt.js 最佳实践
- 🎨 自定义指令和组合式函数

### React 生态
- 🪝 Hooks 深入理解
- 🎯 状态管理方案
- 🔄 并发特性
- 📦 Next.js SSR/SSG

### 性能优化
- 📦 代码分割与懒加载
- 🖼️ 图片和资源优化
- ⚡ 首屏加载优化
- 🔍 性能监控与分析

### 架构设计
- 🏗️ 组件架构
- 📁 目录结构设计
- 🔌 插件系统
- 🎨 设计系统

---

## 📝 笔记示例

### 技术原理
```markdown
# Vue 响应式系统原理

## 核心概念
- Proxy vs Object.defineProperty
- 依赖收集机制
- 派发更新流程

## 关键代码
\`\`\`javascript
// reactive 实现
function reactive(target) {
  return new Proxy(target, {
    get(target, key, receiver) {
      track(target, key)
      return Reflect.get(target, key, receiver)
    },
    set(target, key, value, receiver) {
      const result = Reflect.set(target, key, value, receiver)
      trigger(target, key)
      return result
    }
  })
}
\`\`\`

## 应用场景
-

## 参考资料
- [Vue 3 官方文档](https://vuejs.org/)

#vue #reactivity #principle
```

### 实践技巧
```markdown
# Vue 防抖指令实现

## 需求
输入框实时搜索，需要防抖优化

## 实现
\`\`\`javascript
const debounceDirective = {
  mounted(el, binding) {
    let timer
    el.addEventListener('input', (e) => {
      clearTimeout(timer)
      timer = setTimeout(() => {
        binding.value(e)
      }, binding.arg || 300)
    })
  }
}
\`\`\`

## 使用
\`\`\`vue
<input v-debounce:500="handleSearch" />
\`\`\`

#vue #directive #performance #tip
```

### 问题记录
```markdown
# Vue 3 动态组件 TS 类型问题

## 问题
\`component :is\` 使用时 TypeScript 报错

## 原因
动态组件类型推断不准确

## 解决
使用 shallowRef 和 defineAsyncComponent

## 相关
- [[Vue-TypeScript-Tips]]
- 来自 [[2026-03-25|Daily]]

#vue #typescript #bug
```

---

## 🏷️ 标签系统

### 技术分类
- `#vue` / `#react` / `#nuxt` / `#nextjs`
- `#typescript` / `#javascript`
- `#css` / `#tailwind`

### 内容类型
- `#principle` - 原理和机制
- `#pattern` - 设计模式
- `#tip` - 实用技巧
- `#performance` - 性能优化
- `#bug` - 问题和解决
- `#tutorial` - 教程

### 优先级
- `#important` - 重要知识点
- `#todo` - 待深入研究

---

## 🔗 相关资源

### 官方文档
- [Vue 3](https://vuejs.org/)
- [React](https://react.dev/)
- [Nuxt](https://nuxt.com/)
- [Next.js](https://nextjs.org/)

### 学习资源
- [Vue Mastery](https://www.vuemastery.com/)
- [React 官方教程](https://react.dev/learn)
- [JavaScript Info](https://javascript.info/)

### 工具
- [Vite](https://vitejs.dev/)
- [Vitest](https://vitest.dev/)
- [Playwright](https://playwright.dev/)

---

## 📊 笔记统计

```dataview
TABLE WITHOUT ID
  file.link as "笔记",
  file.mtime as "最后修改",
  tags as "标签"
FROM "11-Frontend"
WHERE file.name != "README"
SORT file.mtime DESC
LIMIT 20
```

### 按标签分类
```dataview
TABLE length(rows) as "数量"
FROM "11-Frontend"
WHERE file.name != "README"
FLATTEN file.tags as tag
GROUP BY tag
SORT length(rows) DESC
```

---

## 🎯 学习路径

### 初级 → 中级
1. ✅ 掌握 Vue/React 基础语法
2. ✅ 理解组件化思想
3. ⏳ 学习状态管理
4. ⏳ 掌握路由和导航

### 中级 → 高级
1. ⏳ 深入理解框架原理
2. ⏳ 性能优化实践
3. ⏳ 架构设计能力
4. ⏳ 工程化和自动化

---

## 💡 快速查找

### 常见问题
- [[Vue-Common-Issues]]
- [[React-Common-Issues]]
- [[Performance-Checklist]]

### 最佳实践
- [[Vue-Best-Practices]]
- [[React-Best-Practices]]
- [[Component-Design-Guide]]

---

**持续学习，持续记录** 📝

[[00-Dashboard/README|← 返回 Dashboard]] | [[10-Tech/README|技术总览 →]]
