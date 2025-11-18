@echo off
cls
echo =========================================
echo   CodeBattle Arena - Real Compiler
echo =========================================
echo.
echo This will start the backend with Judge0 integration
echo.
echo ⚠️ NOTE: Judge0 API key is optional
echo   - With API key: Real compilation for all languages
echo   - Without API key: Client-side execution (current mode)
echo.
echo To enable Judge0:
echo 1. Get free API key from: https://rapidapi.com/judge0-official/api/judge0-ce
echo 2. Set environment variable: set JUDGE0_KEY=your-api-key
echo 3. Restart this script
echo.
pause
echo.

cd backend

echo [1/2] Updating JAR with compiler code...
cd target\classes
jar -uf ..\codebattle-arena-0.0.1-SNAPSHOT.jar com/codebattle/arena/execution com/codebattle/arena/config
cd ..\..

echo.
echo [2/2] Starting backend...
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev

pause
