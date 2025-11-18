@echo off
echo ========================================
echo   CodeBattle Arena - Compiler Setup
echo ========================================

cd backend

echo.
echo [1/4] Stopping existing backend...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do (
    echo Stopping process %%a
    taskkill /PID %%a /F 2>nul
)
timeout /t 2 >nul

echo.
echo [2/4] Updating JAR with compiler code...
cd target\classes
jar -uf ..\codebattle-arena-0.0.1-SNAPSHOT.jar com/codebattle/arena/execution
cd ..\..

echo.
echo [3/4] Starting backend with compiler enabled...
start "CodeBattle Backend" java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev

echo.
echo [4/4] Waiting for backend to start...
timeout /t 12 >nul

echo.
echo ========================================
echo   ✓ Compiler Enabled!
echo ========================================
echo.
echo Backend: http://localhost:8080
echo Frontend: http://localhost:5173
echo.
echo Try clicking "Run Code" in a room now!
echo.
pause
