# 🔥 Firebase Setup Guide - Complete Integration

## Why Firebase?

Firebase offers several advantages:
- ✅ **Real-time Database** - Data syncs instantly
- ✅ **Authentication** - Built-in user management
- ✅ **Free Tier** - Generous free quota
- ✅ **Cloud Firestore** - NoSQL database
- ✅ **Hosting** - Deploy frontend for free
- ✅ **No backend needed** - Direct frontend-to-database

---

## 🚀 Quick Setup (10 Minutes)

### Step 1: Create Firebase Project

1. Go to: https://console.firebase.google.com
2. Click **"Add project"**
3. Project name: **"CodeBattle Arena"**
4. Disable Google Analytics (optional)
5. Click **"Create project"**

### Step 2: Enable Firestore Database

1. In Firebase Console, click **"Firestore Database"**
2. Click **"Create database"**
3. **Select mode**: Start in **"production mode"**
4. **Choose location**: asia-southeast1 (Singapore) or closest to you
5. Click **"Enable"**

### Step 3: Setup Authentication

1. Click **"Authentication"** in sidebar
2. Click **"Get started"**
3. **Enable Email/Password**:
   - Click "Email/Password"
   - Toggle "Enable"
   - Click "Save"
4. **Enable Google Sign-In**:
   - Click "Google"
   - Toggle "Enable"
   - Click "Save"

### Step 4: Get Firebase Configuration

1. Click **⚙️ Settings** (gear icon) → **Project settings**
2. Scroll to **"Your apps"**
3. Click **"Web"** icon (</>) to add a web app
4. App nickname: **"CodeBattle Frontend"**
5. Click **"Register app"**
6. **Copy the config object:**

```javascript
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "codebattle-xxxxx.firebaseapp.com",
  projectId: "codebattle-xxxxx",
  storageBucket: "codebattle-xxxxx.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef"
};
```

---

## 📦 Install Firebase SDK

### Frontend Dependencies:

```bash
cd frontend
npm install firebase
```

---

## 🔧 Firebase Integration

### 1. Create Firebase Config

Create: `frontend/src/config/firebase.ts`

```typescript
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId: "YOUR_APP_ID"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize services
export const auth = getAuth(app);
export const db = getFirestore(app);

export default app;
```

### 2. Update Auth Context

Replace `frontend/src/context/AuthContext.tsx`:

```typescript
import React, { createContext, useContext, useEffect, useState } from 'react';
import { 
  User,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut,
  onAuthStateChanged,
  GoogleAuthProvider,
  signInWithPopup,
  updateProfile
} from 'firebase/auth';
import { doc, setDoc, getDoc } from 'firebase/firestore';
import { auth, db } from '../config/firebase';

export type AuthUser = {
  uid: string;
  displayName: string;
  email: string;
  rating?: number;
  wins?: number;
  losses?: number;
};

type AuthContextType = {
  user: AuthUser | null;
  loading: boolean;
  isAdmin: boolean;
  register: (email: string, password: string, displayName: string) => Promise<void>;
  login: (email: string, password: string) => Promise<void>;
  loginWithGoogle: () => Promise<void>;
  logout: () => Promise<void>;
};

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [loading, setLoading] = useState(true);

  const isAdmin = user?.email?.toLowerCase() === 'krupakargurija177@gmail.com';

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, async (firebaseUser) => {
      if (firebaseUser) {
        // Get user data from Firestore
        const userDoc = await getDoc(doc(db, 'users', firebaseUser.uid));
        const userData = userDoc.data();
        
        setUser({
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName || userData?.displayName || 'User',
          email: firebaseUser.email || '',
          rating: userData?.rating || 1200,
          wins: userData?.wins || 0,
          losses: userData?.losses || 0
        });
      } else {
        setUser(null);
      }
      setLoading(false);
    });

    return unsubscribe;
  }, []);

  const register = async (email: string, password: string, displayName: string) => {
    const userCredential = await createUserWithEmailAndPassword(auth, email, password);
    await updateProfile(userCredential.user, { displayName });
    
    // Create user document in Firestore
    await setDoc(doc(db, 'users', userCredential.user.uid), {
      displayName,
      email,
      rating: 1200,
      wins: 0,
      losses: 0,
      createdAt: new Date()
    });
  };

  const login = async (email: string, password: string) => {
    await signInWithEmailAndPassword(auth, email, password);
  };

  const loginWithGoogle = async () => {
    const provider = new GoogleAuthProvider();
    const result = await signInWithPopup(auth, provider);
    
    // Check if user document exists, create if not
    const userDoc = await getDoc(doc(db, 'users', result.user.uid));
    if (!userDoc.exists()) {
      await setDoc(doc(db, 'users', result.user.uid), {
        displayName: result.user.displayName,
        email: result.user.email,
        rating: 1200,
        wins: 0,
        losses: 0,
        createdAt: new Date()
      });
    }
  };

  const logout = async () => {
    await signOut(auth);
  };

  return (
    <AuthContext.Provider value={{ user, loading, isAdmin, register, login, loginWithGoogle, logout }}>
      {!loading && children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}
```

### 3. Update Login Page

```typescript
import { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const { login, loginWithGoogle } = useAuth();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setLoading(true);
    
    try {
      await login(email, password);
      navigate('/lobby');
    } catch (err: any) {
      setError(err.message || 'Login failed');
    } finally {
      setLoading(false);
    }
  };

  const handleGoogleLogin = async () => {
    setError(null);
    setLoading(true);
    
    try {
      await loginWithGoogle();
      navigate('/lobby');
    } catch (err: any) {
      setError(err.message || 'Google login failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-md mx-auto">
      <div className="card">
        <h2 className="text-xl font-semibold mb-4">Sign in to your account</h2>
        
        {error && (
          <div className="mb-3 p-3 bg-red-50 border border-red-200 rounded text-red-600 text-sm">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-3">
          <div>
            <label className="block text-sm font-medium text-gray-700">Email</label>
            <input 
              className="input mt-1" 
              type="email"
              value={email} 
              onChange={e => setEmail(e.target.value)} 
              required
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700">Password</label>
            <input 
              className="input mt-1" 
              type="password"
              value={password} 
              onChange={e => setPassword(e.target.value)} 
              required
            />
          </div>
          
          <button 
            className="btn w-full" 
            type="submit"
            disabled={loading}
          >
            {loading ? 'Signing in...' : 'Sign in'}
          </button>
        </form>

        <div className="mt-4">
          <div className="relative">
            <div className="absolute inset-0 flex items-center">
              <div className="w-full border-t border-gray-300" />
            </div>
            <div className="relative flex justify-center text-sm">
              <span className="px-2 bg-white text-gray-500">Or continue with</span>
            </div>
          </div>

          <button
            onClick={handleGoogleLogin}
            disabled={loading}
            className="mt-3 w-full flex items-center justify-center gap-3 px-4 py-2 border border-gray-300 rounded-md shadow-sm bg-white text-sm font-medium text-gray-700 hover:bg-gray-50"
          >
            <svg className="w-5 h-5" viewBox="0 0 24 24">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
            </svg>
            Sign in with Google
          </button>
        </div>

        <p className="mt-4 text-sm text-gray-600">
          Don't have an account?{' '}
          <Link to="/register" className="text-brand-700 hover:underline">
            Create one
          </Link>
        </p>
      </div>
    </div>
  );
}
```

---

## 📊 Firestore Database Structure

### Collections:

#### **users** (Main user data)
```
users/
  {userId}/
    - displayName: string
    - email: string
    - rating: number
    - wins: number
    - losses: number
    - createdAt: timestamp
```

#### **rooms** (Coding rooms)
```
rooms/
  {roomCode}/
    - createdBy: userId
    - problemId: number
    - createdAt: timestamp
    - participants: array
```

#### **submissions** (Code submissions)
```
submissions/
  {submissionId}/
    - userId: string
    - problemId: number
    - code: string
    - language: string
    - result: string
    - timestamp: timestamp
```

---

## 🔐 Firestore Security Rules

In Firebase Console → Firestore → Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read their own data
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Admin can read all users
    match /users/{userId} {
      allow read: if request.auth.token.email == 'krupakargurija177@gmail.com';
    }
    
    // Rooms
    match /rooms/{roomId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth != null;
    }
    
    // Submissions
    match /submissions/{subId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## 💰 Firebase Free Tier Limits

| Service | Free Quota | Enough For |
|---------|------------|------------|
| **Firestore** | 1 GB storage | ~100,000 users |
| **Firestore Reads** | 50,000/day | Plenty for dev |
| **Firestore Writes** | 20,000/day | Good for testing |
| **Authentication** | Unlimited | ✅ Perfect |
| **Hosting** | 10 GB/month | Your frontend |

---

## 🎯 Benefits Over PostgreSQL

### Firebase Advantages:
✅ **No backend needed** - Direct frontend-to-database  
✅ **Real-time sync** - Instant updates  
✅ **Built-in auth** - User management included  
✅ **Easy setup** - No server configuration  
✅ **Auto-scaling** - Handles any load  
✅ **Free hosting** - Deploy frontend too  

### When to Use PostgreSQL:
- Complex SQL queries needed
- Existing backend code
- Relational data structure
- Traditional architecture

---

## 🚀 Migration Steps

1. **Create Firebase project** (5 min)
2. **Install Firebase SDK** (`npm install firebase`)
3. **Create config file** (copy from Firebase Console)
4. **Update AuthContext** (use Firebase Auth)
5. **Update Login/Register** pages
6. **Remove backend dependency** (optional)
7. **Deploy** to Firebase Hosting

---

## 📝 Summary

**Firebase gives you:**
- ✅ Cloud database (Firestore)
- ✅ User authentication
- ✅ Real-time sync
- ✅ Free hosting
- ✅ No backend needed

**Total setup time:** ~15 minutes

Want me to implement Firebase integration for you?
