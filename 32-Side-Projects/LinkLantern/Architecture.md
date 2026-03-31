---
项目: LinkLantern
文档类型: 架构设计
更新日期: 2026-03-31
---

# LinkLantern 架构设计

## 🏗️ 整体架构

### 系统分层

```
┌──────────────────────────────────────────────┐
│              表现层 (Presentation)            │
│    ┌─────────────┐      ┌─────────────┐      │
│    │  Nuxt Pages │      │  Components │      │
│    └─────────────┘      └─────────────┘      │
├──────────────────────────────────────────────┤
│              业务逻辑层 (Business)            │
│    ┌─────────────┐      ┌─────────────┐      │
│    │ Composables │      │   API Layer │      │
│    └─────────────┘      └─────────────┘      │
├──────────────────────────────────────────────┤
│              数据访问层 (Data Access)         │
│    ┌─────────────┐      ┌─────────────┐      │
│    │ Prisma ORM  │      │   Services  │      │
│    └─────────────┘      └─────────────┘      │
├──────────────────────────────────────────────┤
│              数据存储层 (Storage)             │
│              ┌─────────────┐                 │
│              │    MySQL    │                 │
│              └─────────────┘                 │
└──────────────────────────────────────────────┘
```

## 🗄️ 数据库设计

### 核心表结构

#### User（用户表）
```prisma
model User {
  id         Int      @id @default(autoincrement())
  username   String   @unique
  email      String   @unique
  password   String   // bcrypt 加密
  avatar     String?
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt
  links      Link[]
  categories Category[]
}
```

#### Link（链接表）
```prisma
model Link {
  id          Int      @id @default(autoincrement())
  title       String
  url         String
  description String?
  icon        String?
  clicks      Int      @default(0)
  isPublic    Boolean  @default(false)
  userId      Int
  categoryId  Int?
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  user        User     @relation(fields: [userId], references: [id])
  category    Category? @relation(fields: [categoryId], references: [id])
  tags        Tag[]
}
```

#### Category（分类表）
```prisma
model Category {
  id        Int      @id @default(autoincrement())
  name      String
  icon      String?
  order     Int      @default(0)
  userId    Int
  createdAt DateTime @default(now())
  user      User     @relation(fields: [userId], references: [id])
  links     Link[]
}
```

#### Tag（标签表）
```prisma
model Tag {
  id    Int    @id @default(autoincrement())
  name  String @unique
  links Link[]
}
```

### 索引设计
- `User.username` - 唯一索引
- `User.email` - 唯一索引
- `Link.userId` - 普通索引
- `Link.categoryId` - 普通索引
- `Link.createdAt` - 普通索引（用于排序）

## 🔄 数据流设计

### 请求流程

```
客户端请求
    ↓
Nuxt Middleware（认证检查）
    ↓
API Route Handler
    ↓
Service Layer（业务逻辑）
    ↓
Prisma ORM
    ↓
MySQL Database
    ↓
返回数据（逐层返回）
```

### 状态管理流程

```
用户操作
    ↓
Vue Component
    ↓
Composable（useLinks, useAuth）
    ↓
API 请求
    ↓
Pinia Store 更新
    ↓
组件响应式更新
```

## 🔌 API 设计

### RESTful API 结构

#### 认证 API
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/logout` - 用户登出
- `GET /api/auth/me` - 获取当前用户信息

#### 链接 API
- `GET /api/links` - 获取链接列表（支持分页、筛选）
- `GET /api/links/:id` - 获取链接详情
- `POST /api/links` - 创建链接
- `PUT /api/links/:id` - 更新链接
- `DELETE /api/links/:id` - 删除链接
- `POST /api/links/:id/click` - 记录点击

#### 分类 API
- `GET /api/categories` - 获取分类列表
- `POST /api/categories` - 创建分类
- `PUT /api/categories/:id` - 更新分类
- `DELETE /api/categories/:id` - 删除分类

#### 热榜 API
- `GET /api/trending/:platform` - 获取指定平台热榜
- `GET /api/trending/all` - 获取所有平台热榜

#### 搜索 API
- `GET /api/search?q=keyword` - 搜索链接
- `GET /api/search/suggestions?q=keyword` - 搜索建议

### API 响应格式

```typescript
// 成功响应
{
  success: true,
  data: any,
  message?: string
}

// 错误响应
{
  success: false,
  error: string,
  code?: string
}

// 分页响应
{
  success: true,
  data: {
    items: any[],
    total: number,
    page: number,
    pageSize: number,
    totalPages: number
  }
}
```

## 🔐 认证与授权

### JWT 认证流程

```
1. 用户登录（username + password）
   ↓
2. 服务端验证（bcrypt 比对密码）
   ↓
3. 生成 JWT Token（包含 userId, username）
   ↓
4. 返回 Token 给客户端
   ↓
5. 客户端存储 Token（localStorage/Cookie）
   ↓
6. 后续请求携带 Token（Authorization Header）
   ↓
7. 服务端验证 Token（Middleware）
   ↓
8. 解析用户信息，执行业务逻辑
```

### Token 结构

```typescript
{
  userId: number,
  username: string,
  iat: number,      // 签发时间
  exp: number       // 过期时间（7天）
}
```

## 🎨 前端架构

### 组件组织

```
components/
├── layout/              # 布局组件
│   ├── Header.vue
│   ├── Sidebar.vue
│   └── Footer.vue
├── link/               # 链接相关
│   ├── LinkCard.vue
│   ├── LinkList.vue
│   └── LinkForm.vue
├── category/           # 分类相关
│   ├── CategoryList.vue
│   └── CategoryForm.vue
├── search/             # 搜索相关
│   ├── SearchBar.vue
│   └── SearchResults.vue
└── common/             # 通用组件
    ├── Modal.vue
    ├── Dropdown.vue
    └── Loading.vue
```

### Composables 设计

```typescript
// useAuth.ts
export const useAuth = () => {
  const user = useState('user')
  const login = async (credentials) => { }
  const logout = async () => { }
  const isAuthenticated = computed(() => !!user.value)
  return { user, login, logout, isAuthenticated }
}

// useLinks.ts
export const useLinks = () => {
  const links = ref([])
  const fetchLinks = async (params) => { }
  const createLink = async (data) => { }
  const updateLink = async (id, data) => { }
  const deleteLink = async (id) => { }
  return { links, fetchLinks, createLink, updateLink, deleteLink }
}
```

## 🚀 性能优化

### 前端优化
1. **代码分割**：页面级别的动态导入
2. **虚拟滚动**：大列表使用虚拟滚动
3. **图片懒加载**：链接图标按需加载
4. **缓存策略**：静态资源强缓存
5. **组件缓存**：keep-alive 缓存页面状态

### 后端优化
1. **数据库索引**：关键字段建立索引
2. **分页查询**：限制单次查询数量
3. **查询优化**：使用 Prisma include 减少查询次数
4. **数据缓存**：热榜数据使用 Redis 缓存
5. **并发控制**：连接池管理数据库连接

### SSR 优化
1. **页面预渲染**：首页和公开页面使用 SSR
2. **数据预取**：服务端提前获取数据
3. **HTML 流式传输**：渐进式渲染页面
4. **状态注入**：服务端状态注入到客户端

## 📦 部署架构

### 生产环境

```
┌─────────────────────────────────────────┐
│              Nginx（反向代理）            │
│         SSL/HTTPS + Gzip压缩             │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│          PM2（进程管理）                  │
│      Nuxt Server（端口 3000）            │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│           MySQL（数据库）                 │
│         端口 3306（内网访问）             │
└─────────────────────────────────────────┘
```

### 部署流程

```
1. 代码推送到 GitHub
   ↓
2. 服务器拉取代码（git pull）
   ↓
3. 安装依赖（npm install）
   ↓
4. 数据库迁移（prisma migrate deploy）
   ↓
5. 构建项目（npm run build）
   ↓
6. PM2 重启服务（pm2 restart）
   ↓
7. Nginx 反向代理配置
   ↓
8. 验证部署成功
```

## 🔍 监控与日志

### 日志策略
- **访问日志**：Nginx access.log
- **错误日志**：应用级别错误捕获
- **业务日志**：关键操作记录
- **性能日志**：慢查询监控

### 监控指标
- **服务健康**：接口响应时间
- **数据库性能**：查询执行时间
- **资源使用**：CPU、内存、磁盘
- **用户行为**：活跃用户数、操作统计

---

**文档维护**：随项目迭代持续更新  
**相关文档**：[[LinkLantern/README|项目概览]] | [[LinkLantern/Problems|问题记录]]
