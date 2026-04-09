# 文档转换后端服务

基于FastAPI的文档转换API服务，支持PDF、Word、图片之间的互转。

## 安装依赖

```bash
pip install -r requirements.txt
```

## 运行服务

### 本地运行
```bash
python main.py
# 或使用uvicorn
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

服务启动后，访问：http://localhost:8000

### Docker部署
```bash
docker build -t doc-converter .
docker run -p 8000:8000 doc-converter
```

## API接口

### 1. PDF转Word
**POST** `/api/convert/pdf-to-word`

**参数：**
- file: PDF文件（multipart/form-data）

**返回：** Word文件（.docx）

**示例：**
```bash
curl -X POST "http://localhost:8000/api/convert/pdf-to-word" \
  -F "file=@example.pdf" \
  --output output.docx
```

### 2. Word转PDF
**POST** `/api/convert/word-to-pdf`

**参数：**
- file: Word文件（.docx）

**返回：** PDF文件

**示例：**
```bash
curl -X POST "http://localhost:8000/api/convert/word-to-pdf" \
  -F "file=@example.docx" \
  --output output.pdf
```

### 3. 图片转PDF
**POST** `/api/convert/image-to-pdf`

**参数：**
- file: 图片文件（JPG, PNG等）

**返回：** PDF文件

**示例：**
```bash
curl -X POST "http://localhost:8000/api/convert/image-to-pdf" \
  -F "file=@example.jpg" \
  --output output.pdf
```

### 4. PDF转图片
**POST** `/api/convert/pdf-to-image`

**参数：**
- file: PDF文件
- page: 页码（可选，默认0）

**返回：** PNG图片

**示例：**
```bash
curl -X POST "http://localhost:8000/api/convert/pdf-to-image" \
  -F "file=@example.pdf" \
  --output output.png
```

## 系统要求

- Python 3.8+
- **pdf2image需要poppler**（Ubuntu: `sudo apt-get install poppler-utils`）
- **Word转PDF需要LibreOffice**（或使用其他转换库）

## 部署到云服务

### Railway（推荐）
1. 推送代码到GitHub
2. 连接Railway账户
3. 选择项目，Railway会自动部署

### Render
1. 在Render上创建Web Service
2. 连接GitHub仓库
3. 设置启动命令：`uvicorn main:app --host 0.0.0.0 --port $PORT`

### AWS Lambda
使用Mangum适配器：
```python
from mangum import Mangum

app = FastAPI()
lambda_handler = Mangum(app)
```

## 限制说明

- **PDF转Word**：复杂的PDF（扫描件、加密）转换效果可能不理想
- **Word转PDF**：简单文本效果好，复杂排版需要改进
- **图片转PDF**：支持常见图片格式
- **PDF转图片**：需要poppler库

## 优化建议

1. 添加文件大小限制
2. 添加转换队列（Celery + Redis）
3. 添加认证和限流
4. 添加转换历史记录
5. 支持批量转换

## License

MIT
