# 📊 How to View Your Data in Neon

## 🔍 Method 1: Neon SQL Editor (Easiest)

### Step 1: Go to Neon Console
1. Visit: https://console.neon.tech
2. Login with your account
3. Select your project: **"CodeBattle"** or whatever you named it

### Step 2: Open SQL Editor
1. Click **"SQL Editor"** in the left sidebar
2. You'll see a query editor

### Step 3: View Your Users
Run this query:
```sql
SELECT * FROM users;
```

Click **"Run"** button

**You should see:**
- id
- email
- display_name
- password_hash
- provider
- rating
- wins
- losses
- created_at

### Step 4: View All Tables
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```

This shows all tables created by your app.

---

## 🔍 Method 2: Neon Tables View

### Alternative Way:
1. In Neon Console, click **"Tables"** tab
2. See list of all tables
3. Click on **"users"** table
4. View data directly
5. See row count, schema, indexes

---

## ⚠️ Troubleshooting: Data Not Showing?

### Problem: No tables or empty results

**Possible causes:**

### **Cause 1: Backend Not Using Neon**
Backend might still be using local H2 database.

**Solution:**
```bash
# Stop backend
Ctrl+C

# Restart with prod profile (IMPORTANT!)
cd backend
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

**Verify in logs:**
Look for: `HikariPool-1 - Start completed`
Should show: `ep-delicate-sea-a1nu524d-pooler.ap-southeast-1.aws.neon.tech`

### **Cause 2: Tables Not Created**
Hibernate might not have created tables yet.

**Solution:**
After starting backend with prod profile, wait 30 seconds, then:
1. Go to http://localhost:5173
2. Register a new user
3. This will trigger table creation
4. Check Neon console again

### **Cause 3: Wrong Database**
Make sure you're looking at the right database.

**Solution:**
In Neon Console:
1. Check database name is **"neondb"**
2. Check you're on the right branch (usually "main")

---

## 🧪 Test Connection to Neon

### Step 1: Check Backend Logs
When you start backend with `--spring.profiles.active=prod`, you should see:

**Good signs:**
```
✅ HikariPool-1 - Starting...
✅ HikariPool-1 - Start completed.
✅ Started CodebattleArenaApplication in X seconds
✅ Tomcat started on port(s): 8080
```

**Bad signs (means using local H2):**
```
❌ jdbc:h2:file:./data/codebattle
❌ H2 Console available
```

### Step 2: Force Table Creation
Register a user through your app:
1. http://localhost:5173/register
2. Fill form and submit
3. This creates tables in Neon

### Step 3: Verify in Neon
Run in SQL Editor:
```sql
-- Check if users table exists
SELECT COUNT(*) FROM users;

-- See all users
SELECT id, email, display_name, rating, created_at FROM users;

-- Show table structure
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'users';
```

---

## 🔧 Force Neon Connection

### Create a test script:

**File: `test-neon.bat`**
```batch
@echo off
echo Stopping any running backend...
taskkill /F /IM java.exe 2>nul

echo.
echo Starting backend with NEON database...
cd backend
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

pause
```

Run this script to ensure prod profile is used.

---

## 📊 Useful Neon SQL Queries

### View all users:
```sql
SELECT 
    id,
    email,
    display_name,
    provider,
    rating,
    wins,
    losses,
    TO_CHAR(created_at, 'YYYY-MM-DD HH24:MI:SS') as registered_at
FROM users
ORDER BY created_at DESC;
```

### Count users:
```sql
SELECT COUNT(*) as total_users FROM users;
```

### Count by provider:
```sql
SELECT 
    provider,
    COUNT(*) as count
FROM users
GROUP BY provider;
```

### Find admin:
```sql
SELECT * FROM users 
WHERE email = 'krupakargurija177@gmail.com';
```

### Recent registrations:
```sql
SELECT 
    email,
    display_name,
    created_at
FROM users
ORDER BY created_at DESC
LIMIT 10;
```

---

## 🎯 Quick Checklist

To see data in Neon, ensure:

- [ ] Backend started with `--spring.profiles.active=prod`
- [ ] No errors in backend console
- [ ] At least one user registered via app
- [ ] Logged into correct Neon account
- [ ] Looking at correct database: "neondb"
- [ ] Looking at correct branch: usually "main"

---

## 🆘 Still Not Working?

### Check application-prod.yml:
```yaml
spring:
  datasource:
    url: jdbc:postgresql://ep-delicate-sea-a1nu524d-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require
    username: neondb_owner
    password: npg_ef4a3RsMUJqo
```

### Verify JAR has latest config:
```bash
cd backend\target
jar -xf codebattle-arena-0.0.1-SNAPSHOT.jar BOOT-INF/classes/application-prod.yml
# Check if the file has correct Neon credentials
```

---

## 📝 Summary

**To view your Neon data:**

1. **Restart backend** with prod profile:
   ```bash
   java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
   ```

2. **Register a test user** at http://localhost:5173/register

3. **Go to Neon Console**: https://console.neon.tech

4. **Click SQL Editor**

5. **Run query**:
   ```sql
   SELECT * FROM users;
   ```

6. **See your data!** ✅

Need help? Check the backend console logs for connection details!
