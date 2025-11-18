# 🔧 Admin Panel Not Showing Users - Troubleshooting

## Step-by-Step Debug Guide

### Step 1: Check Backend is Running

**Look for the Java console window that just opened.**

**Good signs (Backend is working):**
```
✅ HikariPool-1 - Starting...
✅ HikariPool-1 - Start completed
✅ Started CodebattleArenaApplication in X.XXX seconds
✅ Tomcat started on port(s): 8080
```

**Bad signs (Problem):**
```
❌ Connection refused
❌ Failed to configure a DataSource
❌ Error creating bean
❌ Application run failed
```

**Action:** If you see errors, take a screenshot and share them.

---

### Step 2: Verify Backend API is Accessible

Open a **NEW PowerShell** and run:

```powershell
Invoke-WebRequest -Uri http://localhost:8080 -UseBasicParsing
```

**Expected:** Should return something (not connection refused)

---

### Step 3: Register a Test User

1. Go to: **http://localhost:5173/register**
2. Fill in:
   - Email: `testuser@test.com`
   - Password: `test123`
   - Name: `Test User`
3. Click "Create account"

**Expected:** Should redirect to lobby and say "Welcome, Test User"

**If this fails:** Backend is not saving users properly.

---

### Step 4: Check Frontend Console

1. Press **F12** in your browser
2. Go to **Console** tab
3. Look for errors (red text)

**Common errors:**
- `Network Error` - Backend not running
- `401 Unauthorized` - Token issue
- `404 Not Found` - Admin endpoints missing
- `Failed to fetch` - CORS or connection issue

---

### Step 5: Login as Admin

1. **Logout** (if logged in)
2. Go to: **http://localhost:5173/login**
3. Enter:
   - Email: `krupakargurija177@gmail.com`
   - Password: `nobita@2004`
4. Click "Sign in"

**Expected:** You should see navbar with "Admin Panel" link (red)

**If no "Admin Panel" link:**
- Check if you're really logged in
- Check browser console for errors

---

### Step 6: Click Admin Panel

1. Click the red "Admin Panel" link
2. Watch the **browser console** (F12)

**What to look for:**
- Network requests to `/api/admin/users` and `/api/admin/stats`
- Status codes (should be 200, not 401 or 404)
- Response data

---

### Step 7: Check Network Tab

With F12 open:
1. Go to **Network** tab
2. Click "Admin Panel" link
3. Look for requests:
   - `admin/users`
   - `admin/stats`

**Click on each request and check:**
- **Status:** Should be `200 OK`
  - If `401`: Token problem
  - If `404`: Endpoints not found
  - If `500`: Server error
- **Response:** Should show JSON data
- **Headers:** Check Authorization header exists

---

## 🐛 Common Issues & Solutions

### Issue 1: "Failed to load data" or Empty Dashboard

**Cause:** Backend not running with prod profile

**Solution:**
```powershell
# Stop all Java
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force

# Start with prod profile
cd d:\Cursor_projects\codebattle-arena\backend
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

### Issue 2: 404 Not Found for /api/admin/*

**Cause:** AdminController not in JAR

**Solution:** Rebuild:
```powershell
cd d:\Cursor_projects\codebattle-arena\backend
D:\Windsurf\maven-mvnd-2.0.0-rc-3-windows-amd64\bin\mvnd.cmd clean package -DskipTests
```

### Issue 3: 401 Unauthorized

**Cause:** Token not being sent or invalid

**Solution:**
1. Logout completely
2. Clear browser cache (Ctrl+Shift+Delete)
3. Login again as admin
4. Try admin panel again

### Issue 4: CORS Error

**Cause:** Backend CORS not allowing frontend

**Solution:** Backend should have `@CrossOrigin(origins = "*")` on AdminController (already added)

### Issue 5: Backend Using H2 Instead of Neon

**Cause:** Not started with `prod` profile

**Check:** In backend console, look for:
```
✅ jdbc:postgresql://ep-delicate-sea-a1nu524d-pooler (GOOD - Neon)
❌ jdbc:h2:file:./data/codebattle (BAD - Local H2)
```

**Solution:** Always start with `--spring.profiles.active=prod`

---

## 🔍 Manual Test

### Test Admin API Directly

**After logging in as admin:**

1. Open browser console (F12)
2. Get your token:
```javascript
localStorage.getItem('cba_token')
```
3. Copy the token value

4. In PowerShell:
```powershell
$token = "YOUR_TOKEN_HERE"
$headers = @{"Authorization"="Bearer $token"}
Invoke-RestMethod -Uri http://localhost:8080/api/admin/stats -Headers $headers
```

**Expected:** Should return JSON with user statistics

**If it works:** Frontend issue
**If it doesn't work:** Backend issue

---

## 📊 Check Database Directly

### Option A: Neon Console
1. Go to: https://console.neon.tech
2. Login → Your project
3. SQL Editor
4. Run:
```sql
SELECT COUNT(*) FROM users;
SELECT * FROM users LIMIT 5;
```

**Expected:** Should show users you registered

### Option B: Check Backend Logs
Look in the Java console window for:
```
Hibernate: select ... from users
```

If you see this, backend is querying database.

---

## 🎯 Quick Checklist

Test each item:

- [ ] Backend JAR built successfully
- [ ] Backend running in console window
- [ ] No errors in backend console
- [ ] Can access http://localhost:8080
- [ ] Can register a new user
- [ ] Can login as that user
- [ ] Can login as admin (krupakargurija177@gmail.com)
- [ ] See "Admin Panel" link in navbar
- [ ] Clicking Admin Panel loads the page
- [ ] No errors in browser console (F12)
- [ ] Network tab shows 200 OK for admin requests
- [ ] Backend console shows connection to Neon (not H2)

---

## 📝 Information to Collect

If still not working, collect this information:

1. **Backend Console Output:**
   - Copy first 50 lines after starting
   - Look for "Started" line
   - Look for "HikariPool" line

2. **Browser Console Errors:**
   - Press F12 → Console
   - Screenshot any red errors

3. **Network Tab:**
   - F12 → Network
   - Click Admin Panel
   - Screenshot the requests

4. **What You See:**
   - Blank page?
   - Loading spinner forever?
   - "Failed to load data"?
   - Empty table?

---

## 🚀 Nuclear Option (Fresh Start)

If nothing works:

```powershell
# 1. Stop everything
Get-Process java,node -ErrorAction SilentlyContinue | Stop-Process -Force

# 2. Rebuild backend
cd d:\Cursor_projects\codebattle-arena\backend
D:\Windsurf\maven-mvnd-2.0.0-rc-3-windows-amd64\bin\mvnd.cmd clean package -DskipTests

# 3. Start backend with prod
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

# 4. In new terminal: Start frontend
cd d:\Cursor_projects\codebattle-arena\frontend
npm run dev

# 5. Test
# - Register user at http://localhost:5173/register
# - Login as admin
# - Check admin panel
```

---

## 💬 What to Report

If you need help, provide:
1. Screenshot of backend console (first 50 lines)
2. Screenshot of browser console errors
3. Screenshot of Network tab when clicking Admin Panel
4. What you see in the admin panel (blank? error message? loading?)

This will help diagnose the exact issue!
