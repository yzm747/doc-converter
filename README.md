# 📄 文档转换专家

专业级在线文档转换工具，支持PDF、Word、图片之间的互转。

## ✨ 功能特性

### 核心功能
- ✅ **图片转PDF** - 支持JPG/PNG/GIF格式
- ✅ **Word转PDF** - 支持标题提取、自动换行、页码
- ⚠️ **PDF转Word** - 需要额外配置（暂不可用）
- ⚠️ **PDF转图片** - 需要额外配置（暂不可用）

### 用户体验
- 🎨 精美UI设计，渐变色和动画效果
- 📊 实时统计（总转换次数、今日转换）
- 📋 转换历史记录（最多10条）
- 🔒 文件大小限制（50MB）
- ✅ 格式验证和错误提示
- 📱 完美移动端适配

### 商业功能
- 💎 VIP会员推广
- 🎯 每日转换限制（免费3次/天）
- 💰 多种变现方式

## 🚀 快速开始

### 本地运行

**方法1：使用启动脚本**
```bash
cd c:\Users\ZhuanZ（无密码）\WorkBuddy\20260408091252\doc-converter
start.bat
```

**方法2：手动启动**
```bash
# 启动后端
cd backend
pip install -r requirements.txt
python main.py

# 前端直接用浏览器打开 index.html
```

### 访问地址

- 前端：`file:///c:/.../doc-converter/index.html`
- 后端API：`http://localhost:8000`

## 🌐 生产环境部署

### 方案A：免费部署（推荐）

**总成本：$0/月**

详细部署指南：[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

**快速部署步骤：**

1. **推送到GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/你的用户名/doc-converter.git
   git push -u origin main
   ```

2. **前端 - Vercel**
   - 访问 [Vercel](https://vercel.com)
   - 导入GitHub仓库
   - 点击Deploy（5分钟完成）

3. **后端 - Railway**
   - 访问 [Railway](https://railway.app)
   - 导入GitHub仓库（backend目录）
   - 点击Deploy（10分钟完成）

4. **连接前后端**
   - 修改index.html中的API地址
   - 提交更新并重新部署

**总时间：15分钟**

### 方案B：自建服务器

**总成本：¥60-150/月**

详见：[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

## 📂 项目结构

```
doc-converter/
├── index.html              # 前端主页面
├── vercel.json            # Vercel部署配置
├── package.json          # 项目元数据
├── README.md            # 项目说明
├── DEPLOYMENT_GUIDE.md   # 详细部署指南
├── start.bat            # 本地启动脚本
└── backend/
    ├── main.py         # FastAPI后端
    ├── requirements.txt # Python依赖
    ├── Dockerfile      # Docker配置
    ├── railway.json    # Railway部署配置
    ├── Procfile       # Railway进程配置
    └── README.md     # 后端说明
```

## 🛠️ 技术栈

### 前端
- 纯HTML + CSS + JavaScript
- 无需框架，轻量级
- LocalStorage数据持久化

### 后端
- Python 3.11+
- FastAPI（Web框架）
- python-docx（Word处理）
- Pillow（图片处理）
- reportlab（PDF生成）

## 💰 变现方式

### 1. VIP订阅（主要收入）

**免费用户：**
- 每天3次转换
- 50MB文件限制
- 基础功能

**VIP用户（¥9.9/月）：**
- 无限次转换
- 500MB文件限制
- 优先处理
- 无广告

**预期收益：**
- 50个VIP用户 = ¥495/月
- 100个VIP用户 = ¥990/月

### 2. 广告变现

- Google AdSense
- 转换完成页广告
- 每千次展示¥10-50

### 3. API服务

- 为其他开发者提供API接口
- 按调用次数收费
- 每千次调用¥5-10

## 📊 成本分析

### 免费方案（Vercel + Railway）
| 项目 | 月费 | 说明 |
|------|------|------|
| 前端(Vercel) | $0 | 免费额度足够 |
| 后端(Railway) | $0 | 免费额度$5/月 |
| **总计** | **$0/月** | **¥0/月** |

### 自建方案
| 项目 | 月费 | 说明 |
|------|------|------|
| 云服务器 | ¥50-100 | 1核2G配置 |
| 域名 | ¥10-50 | .com/.net等 |
| SSL证书 | ¥0 | Let's Encrypt免费 |
| **总计** | **¥60-150/月** | |

## 🔧 配置说明

### 修改API地址

在`index.html`中找到这一行：
```html
<input type="text" class="config-input" id="apiUrl" value="http://localhost:8000">
```

改为你的后端地址：
```html
<input type="text" class="config-input" id="apiUrl" value="https://your-api.railway.app">
```

### 调整文件大小限制

在`index.html`中修改：
```javascript
const maxSize = 50 * 1024 * 1024; // 50MB
```

### 调整每日转换限制

在`index.html`中修改：
```javascript
if (todayConversions >= 3) { // 每天3次
```

## 📈 优化方向

### 短期优化
- [ ] 添加用户认证（注册/登录）
- [ ] 接入微信支付/支付宝
- [ ] 添加Google AdSense广告
- [ ] 实现PDF转Word（需要pdf2docx库）
- [ ] 实现PDF转图片（需要pdf2image + poppler）

### 长期优化
- [ ] 支持批量转换
- [ ] 添加邮件发送转换结果
- [ ] 支持更多格式（TXT、RTF、EPUB等）
- [ ] 添加OCR文字识别
- [ ] 支持在线编辑文档
- [ ] 开发移动端APP

## 🐛 故障排查

### 常见问题

**1. 前端无法连接后端**
```
检查：
- 后端服务是否运行
- API地址是否正确
- CORS配置是否正确
- 防火墙是否阻止请求
```

**2. 转换失败**
```
检查：
- 文件大小是否超限
- 文件格式是否正确
- 后端日志中的错误信息
```

**3. 图片转PDF后文件被占用**
```
解决方案：
- 已在v2.0中修复
- 确保使用最新版本
```

## 📞 技术支持

- **部署指南：** [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
- **Vercel文档：** https://vercel.com/docs
- **Railway文档：** https://docs.railway.app
- **FastAPI文档：** https://fastapi.tiangolo.com/

## 📝 更新日志

### v2.0 (2026-04-08)
- ✅ 全新UI设计
- ✅ 添加转换历史记录
- ✅ 添加文件大小限制和格式验证
- ✅ 优化Word转PDF功能
- ✅ 完善错误提示
- ✅ 移动端适配
- ✅ 添加VIP会员推广

### v1.0 (2026-04-08)
- ✅ 基础转换功能
- ✅ 拖拽上传
- ✅ 实时进度显示

## 📄 License

MIT License - 自由使用、修改和分发

---

**⭐ 如果这个项目对你有帮助，请给个Star！**

**💬 有问题？欢迎提Issue或Pull Request！**
