# 🚀 文档转换器 - 生产环境部署指南

## 📋 目录

- [前置要求](#前置要求)
- [方案A：Vercel + Railway（推荐）](#方案a-vercel---railway推荐)
- [方案B：自建服务器](#方案b-自建服务器)
- [部署后配置](#部署后配置)
- [域名绑定](#域名绑定)
- [监控和维护](#监控和维护)

---

## 前置要求

**账号准备：**
- [x] GitHub账号（用于代码托管）
- [x] Vercel账号（前端部署）
- [x] Railway账号（后端部署）

**可选：**
- [ ] 自有域名（用于绑定自定义域名）
- [ ] 微信支付/支付宝账号（用于VIP订阅）

---

## 方案A：Vercel + Railway（推荐）

**总成本：$0/月**
**预计时间：15分钟**

### 第一步：推送到GitHub

1. **创建GitHub仓库**
   ```
   1. 访问 https://github.com/new
   2. 仓库名称：doc-converter
   3. 设为私有（推荐）或公开
   4. 点击"Create repository"
   ```

2. **初始化Git并推送**
   ```bash
   # 进入项目目录
   cd c:\Users\ZhuanZ（无密码）\WorkBuddy\20260408091252\doc-converter

   # 初始化Git
   git init
   git add .
   git commit -m "Initial commit"

   # 关联远程仓库
   git remote add origin https://github.com/你的用户名/doc-converter.git
   git branch -M main
   git push -u origin main
   ```

### 第二步：部署前端到Vercel

1. **登录Vercel**
   ```
   访问：https://vercel.com
   使用GitHub账号登录
   ```

2. **导入项目**
   ```
   1. 点击"Add New" -> "Project"
   2. 选择"Import from Git"
   3. 选择刚才创建的GitHub仓库
   4. Vercel会自动检测项目类型
   ```

3. **配置项目**
   ```
   1. Project Name: doc-converter（或你喜欢的名字）
   2. Framework Preset: Other
   3. Root Directory: ./
   4. Output Directory: ./
   5. 点击"Deploy"
   ```

4. **等待部署完成**
   ```
   - 通常需要30-60秒
   - 部署完成后，Vercel会提供一个URL
   - 例如：https://doc-converter.vercel.app
   ```

5. **部署后配置**
   ```
   1. 进入项目设置（Settings）
   2. 检查域名和HTTPS状态
   3. 测试访问
   ```

### 第三步：部署后端到Railway

1. **登录Railway**
   ```
   访问：https://railway.app
   使用GitHub账号登录
   ```

2. **创建新项目**
   ```
   1. 点击"New Project"
   2. 选择"Deploy from GitHub repo"
   3. 选择你的GitHub仓库
   ```

3. **配置后端服务**
   ```
   1. Service Name: doc-converter-api
   2. 选择"backend"目录
   3. Railway会自动检测Dockerfile
   ```

4. **设置环境变量（自动配置）**
   ```
   Railway会自动设置：
   - PORT: 8000
   - PYTHONUNBUFFERED: 1
   ```

5. **启动服务**
   ```
   1. 点击"Deploy Now"
   2. 等待部署完成（通常2-3分钟）
   3. 部署完成后，Railway会提供一个URL
   4. 例如：https://doc-converter-api.up.railway.app
   ```

6. **测试后端API**
   ```
   访问：https://doc-converter-api.up.railway.app/api/health
   应该返回：{"status":"healthy","service":"document-converter"}
   ```

### 第四步：连接前后端

1. **获取后端API地址**
   ```
   在Railway项目中查看后端URL：
   https://doc-converter-api.up.railway.app
   ```

2. **更新前端配置**
   ```
   方法1：修改代码（推荐）
   - 打开 index.html
   - 找到这一行：
     <input type="text" class="config-input" id="apiUrl" value="http://localhost:8000"
   - 改为：
     <input type="text" class="config-input" id="apiUrl" value="https://doc-converter-api.up.railway.app"
   - 提交并推送更新

   方法2：使用Vercel环境变量
   1. 在Vercel项目设置中添加环境变量：
     - Key: NEXT_PUBLIC_API_URL
     - Value: https://doc-converter-api.up.railway.app
   2. 修改前端代码使用环境变量
   3. 重新部署
   ```

3. **测试完整流程**
   ```
   1. 访问前端URL：https://doc-converter.vercel.app
   2. 点击"测试连接"按钮
   3. 应该显示"连接成功！"
   4. 上传测试文件（图片）
   5. 选择"图片转PDF"
   6. 点击"开始转换"
   7. 下载并查看PDF文件
   ```

### 第五步：配置CORS（如果需要）

如果后端返回跨域错误，需要在backend/main.py中添加：

```python
# 在main.py中添加CORS中间件
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 生产环境应指定域名
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

---

## 方案B：自建服务器

**总成本：¥50-100/月（阿里云/腾讯云）**
**预计时间：30分钟**

### 服务器要求

- **操作系统**：Ubuntu 20.04+ 或 CentOS 7+
- **配置**：1核2G以上
- **存储**：20GB以上
- **带宽**：5Mbps以上

### 部署步骤

#### 1. 安装Docker

```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# CentOS
sudo yum install docker
sudo systemctl start docker
sudo systemctl enable docker
```

#### 2. 安装Docker Compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

#### 3. 上传项目文件

```bash
# 方法1：使用SCP上传
scp -r doc-converter root@your-server-ip:/root/

# 方法2：使用Git克隆
cd /root
git clone https://github.com/你的用户名/doc-converter.git
cd doc-converter
```

#### 4. 创建docker-compose.yml

```yaml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend/uploads:/app/uploads
      - ./backend/outputs:/app/outputs
    environment:
      - PORT=8000
      - PYTHONUNBUFFERED=1
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./index.html:/usr/share/nginx/html/index.html
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - backend
    restart: unless-stopped
```

#### 5. 配置Nginx

创建nginx.conf：

```nginx
worker_processes auto;
events {
    worker_connections 1024;
}

http {
    include mime.types;
    default_type application/octet-stream;

    server {
        listen 80;
        server_name your-domain.com;

        # 前端
        location / {
            root /usr/share/nginx/html;
            try_files $uri $uri/ /index.html;
        }

        # 后端API
        location /api {
            proxy_pass http://backend:8000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```

#### 6. 启动服务

```bash
cd /root/doc-converter
docker-compose up -d
```

#### 7. 配置SSL（Let's Encrypt）

```bash
# 安装certbot
sudo apt-get install certbot python3-certbot-nginx

# 获取SSL证书
sudo certbot --nginx -d your-domain.com

# 自动续期
sudo certbot renew --dry-run
```

---

## 部署后配置

### 1. 性能优化

**前端优化（Vercel已自动优化）：**
- ✅ CDN加速
- ✅ 自动HTTPS
- ✅ 图片优化
- ✅ 代码分割

**后端优化：**

```python
# backend/main.py中添加

# 限制请求大小
app = FastAPI(max_upload_size=50 * 1024 * 1024)  # 50MB

# 添加响应压缩
from fastapi.middleware.gzip import GZipMiddleware
app.add_middleware(GZipMiddleware, minimum_size=1000)
```

### 2. 监控和日志

**Vercel监控：**
- 访问项目Dashboard
- 查看"Deployments"和"Analytics"
- 检查错误率和性能

**Railway监控：**
- 访问项目Dashboard
- 查看"Metrics"
- 检查CPU、内存、网络使用情况

### 3. 备份策略

**自动备份：**
```bash
# 创建备份脚本
#!/bin/bash
DATE=$(date +%Y%m%d)
tar -czf /backup/doc-converter-$DATE.tar.gz /root/doc-converter

# 设置定时任务
crontab -e
# 每天凌晨3点备份
0 3 * * * /root/backup-script.sh
```

### 4. 安全加固

```python
# backend/main.py中添加

# 限制请求频率
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

@app.post("/api/convert/*")
@limiter.limit("5/minute")
async def convert_endpoint(...):
    pass
```

---

## 域名绑定

### Vercel

1. **进入项目设置**
   - Dashboard -> Settings -> Domains

2. **添加域名**
   - 输入你的域名：doc-converter.yourdomain.com
   - 点击"Add"

3. **配置DNS**
   - Vercel会提供DNS记录
   - 在域名服务商处添加CNAME记录

### Railway

1. **进入项目设置**
   - Dashboard -> Settings -> Domains

2. **添加域名**
   - 输入：api.yourdomain.com
   - 点击"Generate Custom Domain"

3. **配置DNS**
   - 添加CNAME记录指向Railway提供的域名

---

## 监控和维护

### 日常检查

**每天：**
- [ ] 检查服务是否正常运行
- [ ] 查看错误日志
- [ ] 监控服务器资源使用情况

**每周：**
- [ ] 检查转换成功率
- [ ] 分析用户行为数据
- [ ] 清理临时文件

**每月：**
- [ ] 更新依赖包
- [ ] 检查安全漏洞
- [ ] 备份数据

### 故障排查

**常见问题：**

1. **前端无法连接后端**
   ```
   检查：
   - 后端服务是否运行
   - CORS配置是否正确
   - API地址是否正确
   - 防火墙是否阻止请求
   ```

2. **转换失败**
   ```
   检查：
   - 文件大小是否超限
   - 文件格式是否正确
   - 后端日志中的错误信息
   ```

3. **性能慢**
   ```
   优化：
   - 增加服务器配置
   - 使用CDN
   - 启用缓存
   - 优化图片处理算法
   ```

---

## 💰 成本估算

### 方案A（免费）

| 服务 | 月费 | 说明 |
|------|------|------|
| Vercel (前端) | $0 | 免费额度足够 |
| Railway (后端) | $0 | 免费额度$5/月 |
| **总计** | **$0/月** | **¥0/月** |

### 方案B（自建）

| 服务 | 月费 | 说明 |
|------|------|------|
| 云服务器 | ¥50-100 | 阿里云/腾讯云1核2G |
| 域名 | ¥10-50 | .com/.net等 |
| SSL证书 | ¥0 | Let's Encrypt免费 |
| **总计** | **¥60-150/月** | |

---

## 🎯 下一步

部署完成后，你可以：

1. **开始推广**
   - 在社交媒体分享链接
   - 在知乎、小红书发推广帖
   - 在开发者社区推广

2. **收集用户反馈**
   - 添加用户反馈表单
   - 监控用户行为
   - 优化用户体验

3. **实现变现**
   - 接入微信支付/支付宝
   - 添加VIP订阅功能
   - 接入Google AdSense

4. **持续优化**
   - 添加更多转换格式
   - 优化转换速度
   - 改进UI设计

---

## 📞 技术支持

**Vercel文档：** https://vercel.com/docs
**Railway文档：** https://docs.railway.app
**FastAPI文档：** https://fastapi.tiangolo.com/

---

## ✅ 部署检查清单

- [ ] 代码已推送到GitHub
- [ ] 前端已部署到Vercel
- [ ] 后端已部署到Railway
- [ ] 前后端已连接
- [ ] CORS配置正确
- [ ] 测试转换功能正常
- [ ] 域名已绑定（可选）
- [ ] SSL证书已配置（可选）
- [ ] 监控和日志已设置
- [ ] 备份策略已实施

---

**祝部署顺利！🎉**
