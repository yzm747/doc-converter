@echo off
chcp 65001 > nul
echo ==========================================
echo    简易文档转换器 - 本地测试
echo ==========================================
echo.

echo [1/2] 启动后端服务...
cd backend
echo 正在安装依赖...
pip install -r requirements.txt
echo.
echo 启动API服务...
start "文档转换后端" cmd /k "python main.py"
echo 后端服务已启动，访问 http://localhost:8000
echo.

echo [2/2] 启动前端服务...
cd ..
echo 启动前端页面...
start http://file:///c:/Users/ZhuanZ（无密码）/WorkBuddy/20260408091252/doc-converter/index.html
echo.

echo ==========================================
echo    服务启动完成！
echo    前端：浏览器已打开
echo    后端：http://localhost:8000
echo ==========================================
echo.
echo 注意：请在浏览器中配置后端API地址为 http://localhost:8000
echo 按任意键关闭此窗口...
pause > nul
