# 🛠️ Admin Panel Not Showing Users - Quick Fix

## ⚠️ Problem

The admin panel endpoints were not compiled into the JAR file, so the backend can't serve user data.

## ✅ Solution: Rebuild Backend with Maven

You need Maven to rebuild the backend with the admin panel code.

---

## 🚀 Option 1: Install Maven & Rebuild (Recommended)

### Step 1: Install Maven

**Download:**
https://maven.apache.org/download.cgi

**Or use Chocolatey (if installed):**
```powershell
choco install maven
```

### Step 2: Rebuild Backend
```bash
cd backend
mvn clean package -DskipTests
```

### Step 3: Restart Backend
```bash
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

### Step 4: Test Admin Panel
1. Login as admin
2. Click "Admin Panel"
3. See all users! ✅

---

## 🔄 Option 2: Use IntelliJ IDEA / Eclipse

If you have an IDE installed:

### IntelliJ IDEA:
1. Open project in IntelliJ
2. Right-click `pom.xml`
3. Maven → Reload Project
4. Maven → codebattle-arena → Lifecycle → package
5. Run with prod profile

### Eclipse:
1. Import as Maven project
2. Right-click project → Run As → Maven build
3. Goals: `clean package -DskipTests`
4. Run JAR with prod profile

---

## 🆘 Option 3: Temporary Workaround (Use H2 Local Database)

Until you rebuild, you can test with local database:

### Step 1: Start with Dev Profile
```bash
cd backend
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev
```

### Step 2: Access H2 Console
1. Go to: http://localhost:8080/h2-console
2. JDBC URL: `jdbc:h2:file:./data/codebattle`
3. Username: `sa`
4. Password: (leave empty)
5. Click "Connect"

### Step 3: View Users in H2
```sql
SELECT * FROM users;
```

**Note:** This uses local database, not Neon cloud.

---

## 📋 What's Missing

The JAR file needs these admin files compiled:
- `AdminController.java` - Admin endpoints
- `JwtService.extractEmail()` - Token validation

These were created but not compiled into the JAR.

---

## ✅ Recommended Solution

**Install Maven and rebuild:**

1. **Install Maven** (5 minutes):
   - Download from: https://maven.apache.org/download.cgi
   - Extract to `C:\Program Files\Maven`
   - Add to PATH: `C:\Program Files\Maven\bin`
   - Verify: `mvn -version`

2. **Rebuild Backend** (2 minutes):
   ```bash
   cd d:\Cursor_projects\codebattle-arena\backend
   mvn clean package -DskipTests
   ```

3. **Restart with Neon** (1 minute):
   ```bash
   java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
   ```

4. **Admin Panel Works!** ✅

---

## 🎯 Quick Test After Rebuild

1. Register user: http://localhost:5173/register
2. Login as admin: `krupakargurija177@gmail.com`
3. Click "Admin Panel"
4. See user in table with Neon data!

---

## 📝 Summary

**Problem:** Admin endpoints not in JAR  
**Solution:** Rebuild with Maven  
**Time:** ~10 minutes total  

**Files already created and ready:**
- ✅ AdminController.java
- ✅ AdminDashboard.tsx
- ✅ Admin routes
- ✅ Neon database connection

**Just need:** Maven to compile them into JAR!

---

## 💡 After Maven Install

You'll be able to:
- Rebuild backend anytime
- Add new features easily
- Run tests
- Package for production

**Install Maven once, use forever!**
