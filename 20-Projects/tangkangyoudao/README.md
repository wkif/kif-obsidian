# tangkangyoudao

GitHub 组织：https://github.com/tangkangyoudao

## 项目概述

TangKang 项目是一个完整的全栈应用，包含前端小程序、前端 Vue 应用和后端 Django 服务。

## 基本信息

- **项目名称**: TangKang
- **类型**: 全栈应用项目
- **状态**: ✅ 后端服务和后台管理服务已部署（2026-04-02）
- **部署方式**: Jenkins + Docker 自动化部署
- **创建时间**: 2026-04-01
- **GitHub 组织**: https://github.com/tangkangyoudao

## 项目组成

### 1. 前端小程序 (MiniApp)
- **仓库**: https://github.com/tangkangyoudao/tangkang_frontend_miniapp
- **技术**: 微信小程序/支付宝小程序等
- **状态**: 待部署
- **功能**: 移动端用户界面

### 2. 前端 Vue 应用
- **仓库**: https://github.com/tangkangyoudao/tangkang_frontend_vue
- **技术**: Vue.js 前端框架
- **状态**: 待部署
- **功能**: Web 端管理界面或用户界面

### 3. 后端 Django 服务
- **仓库**: https://github.com/tangkangyoudao/tangkang_backend_django
- **技术**: Django + Django REST Framework
- **状态**: 待部署
- **功能**: API 服务、业务逻辑、数据管理

## 技术栈

### 前端技术栈
- **小程序框架**: 微信小程序/Uni-app 等
- **Web 框架**: Vue.js
- **构建工具**: Webpack/Vite
- **UI 组件**: Element UI/Vant 等
- **状态管理**: Vuex/Pinia

### 后端技术栈
- **后端框架**: Django
- **API 框架**: Django REST Framework
- **数据库**: PostgreSQL/MySQL
- **缓存**: Redis
- **任务队列**: Celery
- **Web 服务器**: Nginx + Gunicorn/uWSGI

## 项目架构

```
┌─────────────────────────────────────────────────────────┐
│                    TangKang 全栈应用                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │   小程序     │  │   Vue Web   │  │  Django API  │    │
│  │  (MiniApp)  │  │   应用      │  │   服务       │    │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘    │
│         │                │                │           │
│         └────────────────┼────────────────┘           │
│                          │                            │
│                   ┌──────▼──────┐                     │
│                   │   反向代理   │                     │
│                   │   (Nginx)   │                     │
│                   └──────┬──────┘                     │
│                          │                            │
│                   ┌──────▼──────┐                     │
│                   │   数据库     │                     │
│                   │ (PostgreSQL)│                     │
│                   └─────────────┘                     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## 部署架构

### 多仓库协同部署
1. **后端服务部署**
   - Django API 服务
   - 数据库迁移
   - 静态文件服务

2. **前端应用部署**
   - Vue Web 应用构建和部署
   - 小程序构建和发布

3. **基础设施**
   - Nginx 反向代理配置
   - 数据库服务
   - 缓存服务
   - 文件存储

## 服务器配置

- [Server-Config.md](Server-Config.md) - 服务器环境配置详情
  - ✅ 1panel 安装配置（2026-04-01）
  - ✅ Jenkins 配置（2026-04-01）
  - ⏳ 项目部署（计划 2026-04-02）

## 相关仓库

- **小程序前端**: https://github.com/tangkangyoudao/tangkang_frontend_miniapp
- **Vue 前端**: https://github.com/tangkangyoudao/tangkang_frontend_vue  
- **Django 后端**: https://github.com/tangkangyoudao/tangkang_backend_django

## 开发计划

待补充...

## 相关链接

- GitHub: https://github.com/tangkangyoudao

## 更新记录

### 2026-04-01
- 项目创建记录
- 服务器环境配置完成（1panel + Jenkins）
- 准备明日项目部署