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

## API 访问权限测试

### 管理员 API Token 验证
- **Token 状态**：✅ 有效
- **权限级别**：管理员权限（用户 ID: 1, 用户名: kif）
- **测试时间**：2026-04-01 15:20 (UTC+8)

### 已验证的操作权限

#### 1. 内容管理 ✅
- **文章管理**：
  - 查看文章列表 (`GET /api/v2/admin/articles`)
  - 创建新文章 (`POST /api/v2/articles`)
  - 删除文章 (`DELETE /api/v2/articles/{id}`)
  - 查看文章详情 (`GET /api/v2/admin/articles/{id}`)
- **手记管理**：可管理 Moments
- **页面管理**：可管理 Pages
- **思考管理**：可管理 Thinkings

#### 2. 系统管理 ✅
- **用户管理**：查看用户列表 (`GET /api/v2/admin/users`)
- **数据统计**：查看仪表板数据 (`GET /api/v2/admin/stats/dashboard`)
- **分类标签**：管理分类和标签
- **系统配置**：管理系统设置

#### 3. 高级功能 ✅
- **联合社交**：管理 ActivityPub 相关功能
- **RSS 管理**：管理 RSS 订阅
- **Webhook**：管理 Webhook
- **评论管理**：管理评论系统
- **友链管理**：管理友情链接

### 自动化发布能力
基于测试结果，该 token 支持完整的**自动化内容发布流程**：
1. **创建文章**：`POST /api/v2/articles`
2. **管理文章**：查看、更新、删除
3. **内容分类**：支持分类和标签
4. **发布控制**：可控制发布状态（草稿/已发布）

## 后续任务

1. **深入了解 GrtBlog 系统架构**
2. **配置自动化发布流程**（基于已验证的 API）
3. **优化博客内容管理**
4. **探索联合社交功能**
5. **设计 Obsidian → GrtBlog 自动化工作流**

## 相关链接

- [GrtBlog GitHub](https://github.com/wkif/grtblog)
- [GrtBlog 官方文档](https://github.com/grtsinry43/grtblog)
- [生产站点](https://www.kifroom.icu/)
- [旧博客系统](https://blog.kifroom.icu/)