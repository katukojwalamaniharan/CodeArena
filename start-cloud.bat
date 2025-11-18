@echo off
cls
echo =========================================
echo   CodeBattle Arena - Cloud Database
echo =========================================
echo.
echo This will start the backend with cloud PostgreSQL database
echo.
echo IMPORTANT: Set these environment variables first:
echo   set DB_URL=jdbc:postgresql://your-host/database?sslmode=require
echo   set DB_USERNAME=your-username
echo   set DB_PASSWORD=your-password
echo.
echo Or edit application-prod.yml with your cloud database credentials
echo.
pause
echo.

cd backend

echo Starting backend with PRODUCTION profile...
echo.
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

pause
