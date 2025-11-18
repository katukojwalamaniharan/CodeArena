# 📦 Install Maven - Quick Guide

## 🎯 Easiest Options (Choose One)

### **Option 1: Download & Install (5 minutes)** ⭐ RECOMMENDED

**Step 1: Download Maven**
1. Go to: https://maven.apache.org/download.cgi
2. Download: **apache-maven-3.9.9-bin.zip** (Binary zip archive)
3. File size: ~9 MB

**Step 2: Extract**
1. Extract ZIP to: `C:\Program Files\Maven`
2. You should have: `C:\Program Files\Maven\apache-maven-3.9.9\`

**Step 3: Add to PATH**
1. Press **Windows + R**
2. Type: `sysdm.cpl` and press Enter
3. Click **"Advanced"** tab
4. Click **"Environment Variables"**
5. Under **"System variables"**, find **"Path"**
6. Click **"Edit"**
7. Click **"New"**
8. Add: `C:\Program Files\Maven\apache-maven-3.9.9\bin`
9. Click **"OK"** on all dialogs

**Step 4: Verify**
1. Open **NEW PowerShell** (important: NEW window)
2. Run: `mvn -version`
3. Should show Maven version ✅

---

### **Option 2: Use IntelliJ IDEA / VS Code** ⭐ EASIER

If you have IntelliJ IDEA or VS Code installed:

#### **IntelliJ IDEA:**
1. Open IntelliJ IDEA
2. File → Open → Select `d:\Cursor_projects\codebattle-arena\backend`
3. Wait for project to load
4. Click **Maven** tab (right side)
5. Expand **Lifecycle**
6. Double-click **package**
7. Wait for build to complete ✅
8. JAR file rebuilt!

#### **VS Code with Java Extension:**
1. Open VS Code
2. Open folder: `d:\Cursor_projects\codebattle-arena\backend`
3. Install "Extension Pack for Java" (if not installed)
4. Press **Ctrl+Shift+P**
5. Type: `Java: Update Project Configuration`
6. Right-click `pom.xml` → **Run Maven Commands** → **package**

---

### **Option 3: Install Chocolatey THEN Maven**

**Step 1: Install Chocolatey**
Open PowerShell as **Administrator** and run:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Step 2: Close and reopen PowerShell as Admin**

**Step 3: Install Maven**
```powershell
choco install maven -y
```

**Step 4: Verify**
```powershell
mvn -version
```

---

## ⚡ After Maven is Installed

### **Rebuild Backend (2 minutes):**

**Step 1: Stop Backend**
```powershell
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force
```

**Step 2: Build**
```powershell
cd d:\Cursor_projects\codebattle-arena\backend
mvn clean package -DskipTests
```

**Step 3: Start with Neon**
```powershell
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

**Step 4: Test Admin Panel**
1. Go to: http://localhost:5173
2. Login as admin: `krupakargurija177@gmail.com` / `nobita@2004`
3. Click "Admin Panel"
4. See all users from Neon database! ✅

---

## 🎓 What Maven Does

Maven rebuilds your backend JAR with:
- ✅ Admin panel endpoints
- ✅ User management API
- ✅ Neon database connection
- ✅ All new features

---

## 💡 My Recommendation

**If you have IntelliJ IDEA or VS Code:**
→ Use Option 2 (IDE's built-in Maven)

**If not:**
→ Use Option 1 (Manual download - 5 minutes)

---

## ⏱️ Time Estimate

- **Download Maven**: 2 minutes
- **Extract & Setup PATH**: 2 minutes
- **Rebuild Backend**: 1 minute
- **Total**: ~5 minutes

---

## 🆘 Need Help?

After installing Maven, run:
```powershell
cd d:\Cursor_projects\codebattle-arena\backend
mvn clean package -DskipTests
```

This will rebuild everything and enable the admin panel with Neon database!
