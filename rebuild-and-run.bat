@echo off
echo ====================================
echo Rebuilding Backend with New Features
echo ====================================

cd backend

echo.
echo Stopping any running backend...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do taskkill /PID %%a /F 2>nul

echo.
echo Copying compiled classes to JAR...
cd target\classes
jar -uf ..\codebattle-arena-0.0.1-SNAPSHOT.jar com\codebattle\arena\execution\*
cd ..\..

echo.
echo Starting backend server...
start "CodeBattle Backend" java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev

echo.
echo ====================================
echo Backend is starting...
echo Wait 10 seconds for it to fully start
echo ====================================
timeout /t 10

echo.
echo Done! Backend should be running on http://localhost:8080
echo Frontend should be on http://localhost:5173
pause
