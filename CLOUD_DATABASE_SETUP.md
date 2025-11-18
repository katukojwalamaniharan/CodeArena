# ☁️ Cloud Database Setup Guide

## Best Cloud Database Options (FREE)

### Option 1: Neon PostgreSQL ⭐ RECOMMENDED
- **Free Tier:** 512 MB storage, 1 database
- **Always-on:** Data accessible from anywhere
- **PostgreSQL-compatible:** No code changes needed
- **Setup Time:** 2 minutes

### Option 2: Supabase PostgreSQL
- **Free Tier:** 500 MB storage, up to 2 databases
- **Features:** Real-time, Auth built-in
- **PostgreSQL-compatible**
- **Setup Time:** 3 minutes

### Option 3: Railway PostgreSQL
- **Free Trial:** $5 credit (lasts months for small apps)
- **Easy deployment**
- **PostgreSQL**

---

## 🚀 Quick Setup: Neon (Recommended)

### Step 1: Create Neon Account

1. Go to: https://neon.tech
2. Click **"Sign Up"** (use Google/GitHub)
3. Create a new project: **"CodeBattle"**
4. Select region: **Choose closest to you**
5. Click **"Create Project"**

### Step 2: Get Connection String

After project creation, you'll see:
```
postgres://username:password@ep-xxx-xxx.region.aws.neon.tech/neondb?sslmode=require
```

Copy this entire connection string!

### Step 3: Update Your Backend

Create this file in backend:
**`backend/src/main/resources/application-prod.yml`**

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:postgresql://YOUR-NEON-HOST/neondb?sslmode=require
    username: YOUR-USERNAME
    password: YOUR-PASSWORD
    driverClassName: org.postgresql.Driver
  jpa:
    hibernate:
      ddl-auto: update
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
    open-in-view: false

app:
  security:
    jwtSecret: ${JWT_SECRET:your-super-secret-key-change-this-in-production-min-32-chars}
```

### Step 4: Add PostgreSQL Driver

Add to `backend/pom.xml`:

```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```

### Step 5: Run with Cloud Database

```bash
cd backend
mvn clean package -DskipTests
java -jar target/codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

---

## 🔐 Environment Variables (More Secure)

Instead of hardcoding credentials, use environment variables:

**Windows (Command Prompt):**
```cmd
set DB_URL=jdbc:postgresql://your-neon-host/neondb?sslmode=require
set DB_USERNAME=your-username
set DB_PASSWORD=your-password
set JWT_SECRET=your-32-character-secret-key-here

java -jar target/codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

**application-prod.yml with env variables:**
```yaml
spring:
  datasource:
    url: ${DB_URL}
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
```

---

## 📊 Supabase Setup (Alternative)

### Step 1: Create Supabase Project

1. Go to: https://supabase.com
2. Sign up with GitHub/Google
3. Click **"New Project"**
4. Name: **CodeBattle**
5. Database Password: **Create strong password**
6. Region: **Choose closest**
7. Click **"Create new project"** (takes 2 minutes)

### Step 2: Get Database URL

1. Go to **Settings** → **Database**
2. Scroll to **Connection String**
3. Select **"URI"**
4. Copy the connection string (replace `[YOUR-PASSWORD]` with your password)

### Step 3: Convert to JDBC Format

Supabase gives:
```
postgresql://postgres:[YOUR-PASSWORD]@db.xxx.supabase.co:5432/postgres
```

Convert to JDBC:
```
jdbc:postgresql://db.xxx.supabase.co:5432/postgres
```

### Step 4: Use in application-prod.yml

```yaml
spring:
  datasource:
    url: jdbc:postgresql://db.xxx.supabase.co:5432/postgres
    username: postgres
    password: YOUR-PASSWORD
    driverClassName: org.postgresql.Driver
```

---

## 🎯 Benefits of Cloud Database

### ✅ Accessibility
- Access from anywhere in the world
- Multiple devices can connect
- No local storage dependency

### ✅ Reliability
- Automatic backups
- High availability
- Professional infrastructure

### ✅ Scalability
- Easy to upgrade
- Handle more users
- Better performance

### ✅ Collaboration
- Multiple developers can access
- Shared development environment
- Production-ready setup

---

## 🔄 Migration Steps

### From Local H2 to Cloud PostgreSQL:

1. **Setup cloud database** (Neon/Supabase)
2. **Add PostgreSQL dependency** to pom.xml
3. **Create application-prod.yml** with cloud credentials
4. **Rebuild backend**: `mvn clean package`
5. **Run with prod profile**: `--spring.profiles.active=prod`
6. **Re-register users** (fresh start on cloud)

---

## 💰 Cost Comparison

| Provider | Free Tier | Storage | Bandwidth | Best For |
|----------|-----------|---------|-----------|----------|
| **Neon** | Forever | 512 MB | Unlimited | Small apps |
| **Supabase** | Forever | 500 MB | 2 GB/month | Full features |
| **Railway** | $5 credit | Unlimited | Varies | Trial/Testing |
| **ElephantSQL** | Forever | 20 MB | Limited | Tiny apps |

**Recommendation:** Start with **Neon** - easiest setup, generous free tier.

---

## 🛡️ Security Best Practices

### 1. Never Commit Credentials
Add to `.gitignore`:
```
application-prod.yml
.env
```

### 2. Use Environment Variables
```bash
set DB_PASSWORD=secret123
```

### 3. Strong JWT Secret
```
openssl rand -base64 32
```

### 4. Enable SSL
Always use `?sslmode=require` in connection string

---

## 📱 Access from Anywhere

Once on cloud database:

### From Your Computer:
```bash
java -jar backend.jar --spring.profiles.active=prod
```

### From Friend's Computer:
1. Copy JAR file
2. Set environment variables
3. Run with prod profile
4. **Same users, same data!**

### From Server/VPS:
1. Deploy backend
2. Set environment variables
3. Point frontend to server URL
4. **Live for everyone!**

---

## 🔧 Troubleshooting

### "Connection refused"
- Check firewall settings
- Verify connection string
- Ensure database is running

### "Authentication failed"
- Verify username/password
- Check for special characters in password
- Use environment variables

### "SSL required"
- Add `?sslmode=require` to URL
- Ensure PostgreSQL driver supports SSL

---

## 📝 Summary

**Quick Steps:**
1. Create free Neon account → 2 min
2. Copy connection string → 30 sec
3. Update `application-prod.yml` → 1 min
4. Add PostgreSQL dependency → 30 sec
5. Rebuild & run → 2 min

**Total Time:** ~6 minutes to cloud database! ☁️

**Your data will be:**
- ✅ Accessible from anywhere
- ✅ Automatically backed up
- ✅ Secure and encrypted
- ✅ Production-ready
- ✅ FREE (on free tiers)

Ready to set up cloud database?
