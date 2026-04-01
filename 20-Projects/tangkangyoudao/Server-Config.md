# Server Configuration（服务器配置）

## 服务器环境配置完成（2026-04-01）

### 已完成配置

#### 1. 1panel 安装配置
- **安装状态**: ✅ 已完成
- **用途**: 服务器管理和监控面板
- **功能**: 提供 Web 界面管理服务器、容器、应用等
- **配置要点**:
  - 访问地址: (待补充)
  - 管理员账号: (待补充)
  - 安全配置: (待补充)

#### 2. Jenkins 配置
- **安装状态**: ✅ 已完成
- **用途**: 持续集成/持续部署 (CI/CD)
- **功能**: 自动化构建、测试、部署流程
- **配置要点**:
  - 访问地址: (待补充)
  - 管理员账号: (待补充)
  - 构建任务: (待配置)
  - 部署脚本: (待配置)

### 服务器信息
- **服务器类型**: (待补充，如阿里云 ECS、腾讯云 CVM 等)
- **操作系统**: (待补充，如 Ubuntu 22.04、CentOS 7 等)
- **规格配置**: (待补充，如 CPU、内存、存储等)
- **网络配置**: (待补充，如公网 IP、安全组规则等)

### 部署架构
```
用户访问
    ↓
[负载均衡] (可选)
    ↓
[Web 服务器] (Nginx/Apache)
    ↓
[应用服务器] (Node.js/Java/Python)
    ↓
[数据库] (MySQL/PostgreSQL/MongoDB)
    ↓
[缓存] (Redis/Memcached)
```

### 安全配置
- **防火墙**: (待配置)
- **SSL/TLS**: (待配置)
- **访问控制**: (待配置)
- **监控告警**: (待配置)

### 备份策略
- **数据库备份**: (待配置)
- **文件备份**: (待配置)
- **配置备份**: (待配置)
- **恢复测试**: (待配置)

## 明日部署计划（多仓库协同部署）

### 1. 后端 Django 服务部署
#### 代码准备
```bash
# 克隆后端仓库
git clone https://github.com/tangkangyoudao/tangkang_backend_django.git
cd tangkang_backend_django

# 检查项目结构
ls -la
cat requirements.txt  # 查看 Python 依赖
cat .env.example      # 查看环境变量配置
```

#### 环境配置
- 创建 Python 虚拟环境
- 安装依赖：`pip install -r requirements.txt`
- 配置数据库连接（PostgreSQL/MySQL）
- 配置环境变量（SECRET_KEY, DATABASE_URL, REDIS_URL 等）
- 运行数据库迁移：`python manage.py migrate`

#### 服务启动
- 使用 Gunicorn/uWSGI 启动 Django 服务
- 配置 Nginx 反向代理
- 配置静态文件服务

### 2. 前端 Vue 应用部署
#### 代码准备
```bash
# 克隆前端仓库
git clone https://github.com/tangkangyoudao/tangkang_frontend_vue.git
cd tangkang_frontend_vue

# 检查项目结构
ls -la
cat package.json      # 查看 Node.js 依赖和脚本
cat .env.example      # 查看环境变量配置
```

#### 构建部署
- 安装 Node.js 依赖：`npm install` 或 `yarn install`
- 配置 API 端点（指向后端服务）
- 构建生产版本：`npm run build` 或 `yarn build`
- 部署构建产物到 Nginx 静态目录

### 3. 小程序部署准备
#### 代码准备
```bash
# 克隆小程序仓库
git clone https://github.com/tangkangyoudao/tangkang_frontend_miniapp.git
cd tangkang_frontend_miniapp

# 检查项目结构
ls -la
cat project.config.json  # 查看小程序配置
```

#### 配置要点
- 配置小程序后台域名（需在微信公众平台配置）
- 配置 API 端点（指向后端服务）
- 准备小程序发布流程

### 4. Jenkins 自动化配置
#### 创建构建任务
1. **后端构建任务**
   - 触发条件：Git push 到 main 分支
   - 构建步骤：安装依赖 → 运行测试 → 部署服务

2. **前端构建任务**
   - 触发条件：Git push 到 main 分支
   - 构建步骤：安装依赖 → 构建项目 → 部署静态文件

#### 部署流水线
```
Git Push → Jenkins 触发 → 代码拉取 → 依赖安装 → 
测试运行 → 构建打包 → 部署到服务器 → 服务重启 → 
健康检查 → 通知结果
```

### 5. Nginx 配置
```nginx
# 后端 API 服务
server {
    listen 80;
    server_name api.tangkang.example.com;
    
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    location /static/ {
        alias /path/to/django/static/;
    }
    
    location /media/ {
        alias /path/to/django/media/;
    }
}

# 前端 Vue 应用
server {
    listen 80;
    server_name www.tangkang.example.com;
    
    root /path/to/vue/dist;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    location /api/ {
        proxy_pass http://api.tangkang.example.com;
    }
}
```

### 6. 数据库配置
- 创建数据库用户和权限
- 导入初始数据（如果需要）
- 配置数据库备份策略
- 配置数据库监控

### 7. 验证测试
1. **API 测试**
   - 使用 Postman/curl 测试 API 端点
   - 验证认证和授权
   - 测试关键业务逻辑

2. **前端测试**
   - 访问 Web 应用验证功能
   - 测试响应式布局
   - 验证 API 调用

3. **集成测试**
   - 测试前后端数据流
   - 验证文件上传等复杂功能
   - 压力测试关键接口

### 风险与应对
- **数据库迁移风险**: 准备回滚方案
- **服务中断风险**: 蓝绿部署或金丝雀发布
- **配置错误风险**: 配置版本控制和回滚
- **性能问题风险**: 压力测试和性能监控

## 相关命令参考

### 1panel 常用命令
```bash
# 查看 1panel 状态
systemctl status 1panel

# 启动/停止/重启 1panel
systemctl start 1panel
systemctl stop 1panel
systemctl restart 1panel

# 查看日志
journalctl -u 1panel -f
```

### Jenkins 常用命令
```bash
# 查看 Jenkins 状态
systemctl status jenkins

# 启动/停止/重启 Jenkins
systemctl start jenkins
systemctl stop jenkins
systemctl restart jenkins

# 查看日志
tail -f /var/log/jenkins/jenkins.log
```

### 系统监控命令
```bash
# 查看系统资源
htop
free -h
df -h

# 查看网络连接
netstat -tulpn
ss -tulpn

# 查看服务状态
systemctl list-units --type=service --state=running
```

## 更新记录

### 2026-04-01
- 服务器基础环境配置完成
- 1panel 安装配置完成
- Jenkins 安装配置完成
- 为明日项目部署做好准备