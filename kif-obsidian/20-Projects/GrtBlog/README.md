# GrtBlog 项目

## 项目概述

GrtBlog 是一个现代化的博客系统，以纯静态 HTML 分发实现极致首屏速度，通过 WebSocket 实现毫秒级实时更新，并内置联合社交协议。

## 项目状态

- **当前版本**：v2
- **部署状态**：✅ 已上线
- **访问地址**：https://www.kifroom.icu/
- **GitHub 仓库**：https://github.com/wkif/grtblog
- **本地路径**：`~/grtblog/`

## 迁移历史

### 2026-04-01：博客系统迁移完成
- **从**：旧博客系统 (kifroomnuxt3)
  - 访问地址：https://blog.kifroom.icu/
  - GitHub：https://github.com/wkif/kifroomnuxt3
- **到**：GrtBlog v2
  - 访问地址：https://www.kifroom.icu/
  - GitHub：https://github.com/wkif/grtblog
- **迁移状态**：✅ 已完成

## 系统特性

### 核心特性
- **极速加载**：页面以纯静态 HTML 分发，首屏 < 0.5s
- **实时更新**：WebSocket 驱动的内容热更新
- **联合社交**：自有联合协议 + ActivityPub 兼容
- **丰富内容**：文章、手记、思考、友链、时间线
- **管理后台**：Vue 3 后台，Markdown 实时预览
- **一键部署**：Docker Compose 一键启动

### 技术架构
```
                      ┌──────────┐
                      │  用户/CDN │
                      └────┬─────┘
                           │
                      ┌────▼─────┐
                      │  Nginx   │
                      └────┬─────┘
                           │
             ┌─────────────┼─────────────┐
             │             │             │
       ┌─────▼─────┐ ┌────▼────┐ ┌──────▼──────┐
       │ 静态 HTML  │ │ Go API  │ │  Admin SPA  │
       │           │ │  :8080  │ │  (Vue 3)    │
       └───────────┘ └────┬────┘ └─────────────┘
                          │
             ┌────────────┼────────────┐
             │            │            │
       ┌─────▼─────┐ ┌───▼───┐ ┌──────▼──────┐
       │ PostgreSQL │ │ Redis │ │  SvelteKit  │
       └───────────┘ └───────┘ └─────────────┘
```

## 部署信息

### 本地开发环境
- **路径**：`~/grtblog/`
- **状态**：已克隆并配置

### 生产环境
- **域名**：https://www.kifroom.icu/
- **部署方式**：Docker Compose
- **架构**：多架构镜像 (amd64/arm64)

## 集成计划

### Obsidian + OpenClaw + GrtBlog 工作流
- **目标**：建立从知识记录到博客发布的完整自动化流程
- **组件**：
  1. **Obsidian**：知识记录和管理
  2. **OpenClaw**：AI 辅助整理和分类
  3. **GrtBlog**：博客发布平台
- **状态**：规划中

## 后续任务

1. **深入了解 GrtBlog 系统架构**
2. **配置自动化发布流程**
3. **优化博客内容管理**
4. **探索联合社交功能**

## 相关链接

- [GrtBlog GitHub](https://github.com/wkif/grtblog)
- [GrtBlog 官方文档](https://github.com/grtsinry43/grtblog)
- [生产站点](https://www.kifroom.icu/)
- [旧博客系统](https://blog.kifroom.icu/)