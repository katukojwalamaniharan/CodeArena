# 🚀 Real Compiler Setup - Judge0 Integration

## What is Judge0?

**Judge0** is the same code execution engine used by:
- ✅ LeetCode
- ✅ HackerRank
- ✅ CodeForces
- ✅ GeeksforGeeks

It provides **real compilation and execution** for 60+ programming languages including Python, Java, JavaScript, C++, and more.

---

## ✅ I've Already Built the Integration!

Your backend now has **full Judge0 support** built-in. You just need to add an API key to enable it!

### What's Already Implemented:

✅ **Judge0 API client** - Submits code and retrieves results  
✅ **Base64 encoding** - Handles code and input properly  
✅ **Polling mechanism** - Waits for compilation results  
✅ **Error handling** - Parses compilation errors, runtime errors  
✅ **Real execution times** - Actual CPU time and memory usage  
✅ **All 4 languages** - Python (71), Java (62), JavaScript (63), C++ (54)  
✅ **Fallback system** - Uses simulation when API unavailable  

---

## 🔑 How to Get Judge0 API Key (FREE)

### Option 1: RapidAPI (Recommended - Free Tier Available)

1. **Go to**: https://rapidapi.com/judge0-official/api/judge0-ce

2. **Sign Up/Login** with:
   - Google account
   - GitHub account
   - Or email

3. **Subscribe to Basic Plan**:
   - Click "Subscribe to Test"
   - Select **"Basic" plan** (FREE - 50 requests/day)
   - Or **"Pro" plan** ($5/month - 2000 requests/day)

4. **Copy Your API Key**:
   - After subscribing, you'll see **"X-RapidAPI-Key"**
   - Copy the long string (looks like: `abc123def456...`)

5. **That's it!** You now have a Judge0 API key!

---

### Option 2: Self-Hosted Judge0 (Advanced - Free Unlimited)

If you want unlimited requests:

1. **Install Docker Desktop** (if not already installed)

2. **Run Judge0 locally**:
```bash
cd backend
mkdir judge0
cd judge0
curl https://raw.githubusercontent.com/judge0/judge0/master/docker-compose.yml -o docker-compose.yml
docker-compose up -d
```

3. **Set URL** to `http://localhost:2358` instead of RapidAPI

4. **No API key needed** for local installation

---

## 🔧 Enable Real Compiler (2 Simple Steps)

### Step 1: Set Environment Variable

**Option A - Command Line (Temporary):**
```bash
set JUDGE0_KEY=your-api-key-here
```

**Option B - Create .env file (Permanent):**

Create `backend/.env` file:
```env
JUDGE0_KEY=your-rapidapi-key-here
JUDGE0_URL=https://judge0-ce.p.rapidapi.com
```

### Step 2: Restart Backend

```bash
cd backend
java -jar target\codebattle-arena-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev
```

**That's it!** Real compiler is now enabled!

---

## 🧪 Test Real Compilation

### Test 1: Python
```python
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

print(factorial(5))
```
**Expected Output**: `120`

### Test 2: JavaScript
```javascript
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
}
console.log(fibonacci(10));
```
**Expected Output**: `55`

### Test 3: Java
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from Java!");
        System.out.println(2 + 2);
    }
}
```
**Expected Output**: 
```
Hello from Java!
4
```

### Test 4: C++
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello from C++!" << endl;
    cout << "3 + 3 = " << (3+3) << endl;
    return 0;
}
```
**Expected Output**:
```
Hello from C++!
3 + 3 = 6
```

---

## 🎯 What You'll See with Real Compiler

### Before (Client-side simulation):
```
✓ Status: Accepted (Client-side)
Time: 0.003s
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Output:
[simulated output]
```

### After (Real Judge0 compilation):
```
✓ Status: Accepted
Time: 0.127s | Memory: 3840KB
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Output:
120

[actual program output]
```

Notice:
- **Real execution time** (actual CPU time)
- **Memory usage** (in KB)
- **Actual compilation** (works for Java, C++, Python, JS)
- **Real errors** (compilation errors, runtime errors)

---

## 📊 Judge0 Status Codes

The compiler returns real status codes:

| Code | Status | Meaning |
|------|--------|---------|
| 3 | Accepted | ✅ Code ran successfully |
| 4 | Wrong Answer | ❌ Output doesn't match expected |
| 5 | Time Limit Exceeded | ⏱️ Code took too long |
| 6 | Compilation Error | 🔧 Code doesn't compile |
| 7 | Runtime Error (SIGSEGV) | 💥 Segmentation fault |
| 8 | Runtime Error (SIGXFSZ) | 💥 Output too large |
| 9 | Runtime Error (SIGFPE) | 💥 Division by zero |
| 10 | Runtime Error (SIGABRT) | 💥 Abnormal termination |
| 11 | Runtime Error (NZEC) | 💥 Non-zero exit code |
| 12 | Runtime Error (Other) | 💥 Other runtime error |
| 13 | Internal Error | ❌ Judge0 system error |
| 14 | Exec Format Error | ❌ Executable format error |

---

## 🔒 Security & Rate Limits

### RapidAPI Free Tier:
- ✅ 50 requests/day
- ✅ Perfect for testing and development
- ✅ Upgrade to Pro ($5/month) for 2000/day

### Self-Hosted:
- ✅ Unlimited requests
- ✅ Complete control
- ✅ No API key needed
- ⚠️ Requires Docker and resources

---

## 🐛 Troubleshooting

### "Simulated execution" still appears
**Problem**: API key not configured  
**Solution**: Set `JUDGE0_KEY` environment variable and restart backend

### "Judge0 API error"
**Problem**: Invalid API key or network issue  
**Solution**: 
1. Verify API key is correct
2. Check RapidAPI subscription is active
3. Check network connection

### "Execution timeout"
**Problem**: Code takes too long or Judge0 is slow  
**Solution**:
1. Check if code has infinite loops
2. RapidAPI free tier may be slower
3. Consider self-hosting for faster execution

### "Compilation Error" in Java/C++
**Problem**: Code has syntax errors  
**Solution**: Check the error output - Judge0 provides detailed compilation errors

---

## 📈 What You Get with Real Compiler

### ✅ Actual Compilation
- Python: Real Python interpreter
- Java: javac compiler → JVM execution
- C++: g++ compiler → Native execution
- JavaScript: Node.js execution

### ✅ Real Error Messages
```
Compilation Error:
Main.java:3: error: ';' expected
    System.out.println("Hello")
                               ^
1 error
```

### ✅ Performance Metrics
- CPU time (seconds)
- Memory usage (KB)
- Execution wall time

### ✅ Security
- Sandboxed execution
- Resource limits
- Timeout protection

---

## 🎓 Upgrade Path

### Current (Client-side):
- JavaScript: ✅ Works
- Python: ⚠️ Basic simulation
- Java: ⚠️ Validation only
- C++: ⚠️ Validation only

### With Judge0 (Real compiler):
- JavaScript: ✅✅ Real Node.js
- Python: ✅✅ Real Python 3
- Java: ✅✅ Real javac + JVM
- C++: ✅✅ Real g++ compiler

---

## 💡 Pro Tips

1. **Start with Free Tier**: Test with 50 requests/day
2. **Monitor Usage**: Check RapidAPI dashboard
3. **Self-host for Production**: Unlimited and faster
4. **Cache Results**: Save compilation results for identical code
5. **Set Timeouts**: Prevent infinite loops

---

## 📝 Summary

**To Enable Real LeetCode-Style Compiler:**

1. Get Judge0 API key from RapidAPI (FREE - 2 minutes)
2. Set `JUDGE0_KEY` environment variable
3. Restart backend
4. Done! Real compilation for all languages!

**Current Status:**
- ✅ Backend has full Judge0 integration built
- ✅ Fallback to client-side when no API key
- ✅ Seamless switching between modes
- ⏳ Just needs API key to enable real compilation

**Get started**: https://rapidapi.com/judge0-official/api/judge0-ce

Your CodeBattle Arena will have the exact same compiler as LeetCode! 🚀
