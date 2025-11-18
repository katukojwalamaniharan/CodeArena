# 🔒 Admin Panel - Complete Setup

## ✅ Admin Panel Implemented

A professional, secure admin dashboard has been created exclusively for the admin user.

---

## 🔑 Admin Credentials

**Email:** `krupakargurija177@gmail.com`  
**Password:** `nobita@2004`

These credentials are **hard-coded** in the backend for security and exclusivity.

---

## 🎯 Features

### **Admin Login Page** (`/admin/login`)
- Exclusive admin authentication
- Dark theme with security-focused design
- Shield icon and restricted area messaging
- Token-based authentication

### **Admin Dashboard** (`/admin/dashboard`)
- **Statistics Cards:**
  - Total Users
  - Local Users (email/password)
  - Google Users (OAuth)
  - Average Rating

- **User Management Table:**
  - View all registered users
  - Search functionality
  - User details: Email, Display Name, Provider, Rating, W/L
  - Registration date
  - Color-coded provider badges

- **Features:**
  - Real-time data from database
  - Search/filter users
  - Professional dark theme
  - Secure logout
  - Mobile responsive

---

## 🌐 Routes

| Route | Access | Description |
|-------|--------|-------------|
| `/admin/login` | Public | Admin login page |
| `/admin/dashboard` | Protected | Admin dashboard (requires admin token) |

---

## 🔐 Security

### Backend Protection:
- Admin credentials validated on every request
- JWT token includes admin email
- All admin endpoints verify token
- 401/403 errors for unauthorized access

### Token Storage:
- `admin_token` - JWT authentication token
- `admin_email` - Admin email for reference

### Endpoint Protection:
All admin endpoints require `Authorization: Bearer <token>` header

---

## 📡 API Endpoints

### **POST /api/admin/login**
Login as admin
```json
Request:
{
  "email": "krupakargurija177@gmail.com",
  "password": "nobita@2004"
}

Response:
{
  "token": "eyJhbGc...",
  "userId": 0,
  "displayName": "Admin",
  "email": "krupakargurija177@gmail.com"
}
```

### **POST /api/admin/verify**
Verify admin status
```
Headers: Authorization: Bearer <token>

Response:
{
  "isAdmin": true
}
```

### **GET /api/admin/users**
Get all registered users
```
Headers: Authorization: Bearer <token>

Response:
[
  {
    "id": 1,
    "email": "user@example.com",
    "displayName": "User One",
    "provider": "local",
    "rating": 1200,
    "wins": 5,
    "losses": 3,
    "createdAt": "2025-10-14T10:30:00"
  }
]
```

### **GET /api/admin/stats**
Get dashboard statistics
```
Headers: Authorization: Bearer <token>

Response:
{
  "totalUsers": 42,
  "googleUsers": 15,
  "localUsers": 27,
  "averageRating": 1235
}
```

---

## 📁 Files Created

### Backend:
- `backend/src/main/java/com/codebattle/arena/admin/AdminController.java`
  - Admin authentication
  - User management endpoints
  - Statistics endpoints

### Frontend:
- `frontend/src/pages/admin/AdminLogin.tsx`
  - Admin login interface
  - Dark themed security design
  
- `frontend/src/pages/admin/AdminDashboard.tsx`
  - Complete admin dashboard
  - Statistics display
  - User table with search
  - Logout functionality

### Updated:
- `frontend/src/main.tsx` - Added admin routes
- `backend/src/main/java/com/codebattle/arena/auth/JwtService.java` - Added `extractEmail()` method

---

## 🎨 Design Features

### Color Scheme:
- **Background:** Dark gray gradient (gray-900, gray-800)
- **Cards:** Gray-800 with gray-700 borders
- **Accents:** Red-600 (admin theme)
- **Text:** White and gray shades

### UI Elements:
- **Shield icon** - Admin security symbol
- **Statistics cards** - Color-coded by category
- **Provider badges** - Blue (local), Red (Google)
- **Search bar** - Real-time filtering
- **Hover effects** - Smooth transitions
- **Table rows** - Zebra striping

---

## 🚀 How to Access

### Step 1: Start Servers
```bash
# Backend
cd backend
java -jar target/codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev

# Frontend
cd frontend
npm run dev
```

### Step 2: Access Admin Panel
1. Go to: **http://localhost:5173/admin/login**
2. Enter credentials:
   - Email: `krupakargurija177@gmail.com`
   - Password: `nobita@2004`
3. Click "Access Admin Panel"
4. Redirected to dashboard: **http://localhost:5173/admin/dashboard**

---

## 📊 Dashboard Sections

### 1. Header
- Admin shield icon
- "Admin Dashboard" title
- Logout button

### 2. Statistics Grid (4 cards)
- **Total Users** - Blue theme, user group icon
- **Local Users** - Green theme, single user icon
- **Google Users** - Red theme, Google logo
- **Average Rating** - Yellow theme, star icon

### 3. Users Table
- Search box (filters by email/name)
- Columns:
  - ID
  - Email
  - Display Name
  - Provider (badge)
  - Rating (yellow)
  - W/L (green/red)
  - Joined date
- Hover effects on rows
- Result count at bottom

---

## 🔒 Security Notes

### Hardcoded Credentials:
- Admin email and password are in backend configuration
- Can be overridden with environment variables:
  ```bash
  ADMIN_EMAIL=your-email@example.com
  ADMIN_PASSWORD=your-password
  ```

### Token Validation:
- Every admin endpoint checks token
- Email extracted from JWT
- Compared against admin email
- Non-admin requests rejected with 403

### Separate from User Auth:
- Admin tokens stored separately (`admin_token`)
- User tokens remain in `cba_token`
- No conflict between systems

---

## 💡 Usage Examples

### View All Users:
1. Login to admin panel
2. See complete user list
3. Search by email or name
4. View user statistics

### Check Statistics:
- Total registered users
- Google vs Local breakdown
- Average rating across platform
- Real-time updated

### Manage Users:
- View user details
- Track wins/losses
- See registration dates
- Monitor provider types

---

## 🎯 What Admin Can See

For each user:
- ✅ Unique ID
- ✅ Email address
- ✅ Display name
- ✅ Login provider (Google/Local)
- ✅ Current rating
- ✅ Win/Loss record
- ✅ Registration date

Platform stats:
- ✅ Total user count
- ✅ Users by provider
- ✅ Average rating
- ✅ Growth metrics

---

## 🛡️ Why This Design?

### Professional:
- Clean, modern interface
- Industry-standard layout
- Data tables with search
- Statistics cards

### Secure:
- Token-based authentication
- Backend validation on every request
- Separate from user authentication
- Clear access denied messages

### Functional:
- All essential admin features
- Real-time data
- Easy navigation
- Quick logout

---

## 📝 Summary

✅ **Admin login** - Exclusive access with hard-coded credentials  
✅ **Dashboard** - Professional dark-themed interface  
✅ **User management** - View all registered users  
✅ **Statistics** - Real-time platform metrics  
✅ **Search** - Filter users by email/name  
✅ **Secure** - Token-based, backend-validated  
✅ **Beautiful** - Modern design with icons and colors  

**Access URL:** http://localhost:5173/admin/login

The admin panel provides complete visibility into user registration and platform statistics! 🎉
