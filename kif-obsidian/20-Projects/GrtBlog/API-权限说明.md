# GrtBlog API 权限说明

## 概述

本文档记录 GrtBlog 后台管理 API 的访问权限和可用操作。基于对管理员 token 的测试结果。

## 基本信息

- **测试时间**：2026-04-01 15:20 (UTC+8)
- **Token 类型**：管理员 API Token
- **权限级别**：管理员（用户 ID: 1）
- **API 基础路径**：`https://www.kifroom.icu/api/v2`

## 已验证的端点

### 1. 内容管理端点

#### 文章管理
- `GET /admin/articles` - 获取文章列表
- `GET /admin/articles/{id}` - 获取文章详情
- `POST /articles` - 创建新文章
- `PUT /articles/{id}` - 更新文章
- `DELETE /articles/{id}` - 删除文章
- `PUT /admin/articles/published` - 批量更新发布状态
- `PUT /admin/articles/top` - 批量更新置顶状态

#### 手记管理 (Moments)
- `GET /admin/moments` - 获取手记列表
- 支持创建、更新、删除操作

#### 页面管理 (Pages)
- `GET /admin/pages` - 获取页面列表
- 支持创建、更新、删除操作

#### 思考管理 (Thinkings)
- `GET /admin/thinkings` - 获取思考列表
- 支持创建、更新、删除操作

### 2. 系统管理端点

#### 用户管理
- `GET /admin/users` - 获取用户列表
- 支持用户管理操作

#### 数据统计
- `GET /admin/stats/dashboard` - 获取仪表板统计数据
- 包含：内容统计、互动数据、趋势分析、热门内容等

#### 分类标签管理
- `GET /admin/categories` - 获取分类列表
- `GET /admin/tags` - 获取标签列表
- 支持分类和标签的增删改查

#### 系统配置
- `GET /admin/sysconfig` - 获取系统配置
- 支持配置管理

### 3. 高级功能端点

#### 联合社交 (ActivityPub)
- `GET /admin/federation/reviews/pending` - 获取待审联合内容
- 支持联合社交内容管理

#### RSS 管理
- `GET /admin/rss/access-stats` - 获取 RSS 访问统计

#### Webhook 管理
- `GET /admin/webhooks/events` - 获取 Webhook 事件

#### 评论管理
- `GET /admin/comments` - 获取评论列表
- 支持评论审核和管理

#### 友链管理
- `GET /admin/friend-links` - 获取友链列表
- 支持友链申请审核

## 请求示例

### 创建文章
```bash
curl -X POST \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "文章标题",
    "content": "文章内容",
    "categoryId": 1,
    "tags": ["标签1", "标签2"],
    "isPublished": true,
    "allowComment": true,
    "isOriginal": true
  }' \
  https://www.kifroom.icu/api/v2/articles
```

### 获取文章列表
```bash
curl -H "Authorization: Bearer {token}" \
  https://www.kifroom.icu/api/v2/admin/articles
```

### 获取统计数据
```bash
curl -H "Authorization: Bearer {token}" \
  https://www.kifroom.icu/api/v2/admin/stats/dashboard
```

## 响应格式

所有 API 响应遵循统一格式：
```json
{
  "code": 0,
  "bizErr": "OK",
  "msg": "success",
  "data": {...},
  "meta": {
    "requestId": "uuid",
    "timestamp": "ISO8601"
  }
}
```

## 自动化工作流支持

基于测试结果，该 API 支持完整的自动化内容发布工作流：

### 1. 内容创建流程
1. 准备 Markdown 内容
2. 调用 `POST /articles` 创建文章
3. 设置分类、标签、发布状态
4. 获取返回的文章 ID 和短链接

### 2. 内容管理流程
1. 调用 `GET /admin/articles` 获取文章列表
2. 根据需求更新或删除文章
3. 批量管理发布状态

### 3. 数据监控流程
1. 调用 `GET /admin/stats/dashboard` 获取统计数据
2. 分析内容表现和用户互动
3. 基于数据优化内容策略

## 安全注意事项

1. **Token 保护**：API token 具有管理员权限，需妥善保管
2. **请求限制**：注意 API 调用频率限制
3. **错误处理**：正确处理 API 错误响应
4. **数据验证**：确保请求数据的有效性

## 集成建议

### 与 Obsidian 集成
1. 在 Obsidian 中编写 Markdown 内容
2. 通过脚本将内容转换为 API 请求
3. 自动发布到 GrtBlog

### 与 OpenClaw 集成
1. OpenClaw 整理和优化内容
2. 通过 API 自动发布
3. 监控发布结果和统计数据

---

*最后更新：2026-04-01*