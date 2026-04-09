# 部署指南

## 方案一：前端部署到Vercel（免费）+ 后端部署到Railway（免费）

### 第一步：部署后端到Railway

1. **准备代码**
   ```bash
   cd backend
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/doc-converter-backend.git
   git push origin main
   ```

2. **在Railway创建项目**
   - 访问 https://railway.app
   - 点击 "New Project"
   - 选择 "Deploy from GitHub repo"
   - 选择你的仓库
   - Railway会自动检测Python项目并部署

3. **获取后端URL**
   - 部署完成后，Railway会给你一个URL
   - 例如：https://doc-converter-backend.railway.app

### 第二步：部署前端到Vercel

1. **准备代码**
   ```bash
   cd doc-converter
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/doc-converter-frontend.git
   git push origin main
   ```

2. **在Vercel部署**
   - 访问 https://vercel.com
   - 点击 "Add New Project"
   - 选择你的仓库
   - 点击 "Deploy"

3. **获取前端URL**
   - 部署完成后，Vercel会给你一个URL
   - 例如：https://doc-converter.vercel.app

### 第三步：配置前端连接后端

1. **访问你的前端网站**
   - 打开 https://doc-converter.vercel.app

2. **在配置区域输入后端API地址**
   - 输入：https://doc-converter-backend.railway.app
   - 点击"测试连接"
   - 如果显示"连接成功"，配置完成！

---

## 方案二：前后端都部署到Render（免费）

### 后端部署

1. 创建 `render.yaml`：
```yaml
services:
  - type: web
    name: doc-converter-api
    env: python
    buildCommand: pip install -r requirements.txt
    startCommand: uvicorn main:app --host 0.0.0.0 --port $PORT
    envVars:
      - key: PORT
        value: 8000
```

2. 推送代码到GitHub
3. 在Render创建Web Service，连接仓库

### 前端部署

1. 直接把 `index.html` 推送到GitHub
2. 在Render创建Static Site

---

## 方案三：本地测试（不推荐生产使用）

### 启动后端
```bash
cd backend
pip install -r requirements.txt
python main.py
```

### 启动前端
```bash
# 方法1：直接打开index.html
# 方法2：使用Python服务器
python -m http.server 3000
# 然后访问 http://localhost:3000
```

---

## 注意事项

### 后端依赖

1. **pdf2image需要poppler**
   - Ubuntu/Debian: `sudo apt-get install poppler-utils`
   - Windows: 下载poppler并添加到PATH
   - MacOS: `brew install poppler`

2. **Word转PDF优化**
   - 当前版本使用简单文本转换
   - 生产环境建议使用LibreOffice API或commercial API

### 文件大小限制

- Vercel免费版：单文件最大25MB
- Railway免费版：500MB/月
- 建议在前端限制文件大小到10MB

### 生产环境建议

1. 添加认证（API Key或JWT）
2. 添加速率限制
3. 添加文件大小验证
4. 使用CDN加速静态资源
5. 添加日志和监控

---

## 域名配置（可选）

### 前端域名
1. 在Vercel项目设置中添加自定义域名
2. 按提示配置DNS记录

### 后端域名
1. 在Railway项目设置中添加自定义域名
2. 按提示配置DNS记录

---

## 故障排查

### 后端无法启动
```bash
# 检查端口是否被占用
netstat -ano | findstr :8000

# 查看日志
uvicorn main:app --reload
```

### 前端无法连接后端
1. 检查后端是否正常运行
2. 检查API地址是否正确
3. 检查浏览器控制台错误
4. 检查CORS配置

### 转换失败
1. 检查文件格式是否正确
2. 检查文件是否损坏
3. 检查后端日志

---

## 成本预估

### Railway（免费）
- 512MB RAM
- 0.5GB存储
- $5/月免费额度

### Vercel（免费）
- 无限带宽
- 100GB构建
- 100GB部署

### Render（免费）
- 512MB RAM
- 750小时/月

**总成本：$0/月**（免费方案）

---

## 下一步优化

1. 添加数据库存储用户和转换记录
2. 实现VIP订阅功能（Stripe）
3. 添加广告位（Google AdSense）
4. 优化转换速度
5. 支持批量转换
6. 添加更多转换格式
