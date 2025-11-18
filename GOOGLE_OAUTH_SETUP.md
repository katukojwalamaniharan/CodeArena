# Google OAuth Setup Guide

This guide will help you set up Google Authentication for the CodeBattle Arena application.

## Prerequisites

- Google Cloud Platform account
- Access to Google Cloud Console

## Step 1: Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Note your project ID

## Step 2: Configure OAuth Consent Screen

1. Navigate to **APIs & Services** → **OAuth consent screen**
2. Select **External** user type (or Internal if using Google Workspace)
3. Fill in the required information:
   - **App name**: CodeBattle Arena
   - **User support email**: Your email
   - **Developer contact information**: Your email
4. Add scopes:
   - `userinfo.email`
   - `userinfo.profile`
   - `openid`
5. Save and continue

## Step 3: Create OAuth 2.0 Credentials

1. Navigate to **APIs & Services** → **Credentials**
2. Click **Create Credentials** → **OAuth client ID**
3. Select **Web application** as the application type
4. Configure:
   - **Name**: CodeBattle Arena Web Client
   - **Authorized JavaScript origins**:
     - `http://localhost:5173` (for development)
     - Your production frontend URL (when deployed)
   - **Authorized redirect URIs**:
     - `http://localhost:5173` (for development)
     - Your production frontend URL (when deployed)
5. Click **Create**
6. **Copy the Client ID** - you'll need this for configuration

## Step 4: Configure Backend

1. Set the environment variable for the backend:
   ```bash
   export GOOGLE_CLIENT_ID=your-client-id-here.apps.googleusercontent.com
   ```

   Or add it to your backend runtime configuration.

2. The backend configuration is already set in `application.yml`:
   ```yaml
   google:
     client:
       id: ${GOOGLE_CLIENT_ID:}
   ```

## Step 5: Configure Frontend

1. Create a `.env` file in the `frontend` directory:
   ```bash
   cd frontend
   cp .env.example .env
   ```

2. Edit the `.env` file and add your Google Client ID:
   ```env
   VITE_GOOGLE_CLIENT_ID=your-client-id-here.apps.googleusercontent.com
   ```

## Step 6: Install Frontend Dependencies

Run the following command in the frontend directory:
```bash
npm install
```

This will install the `@react-oauth/google` package and other dependencies.

## Step 7: Database Migration

The User entity has been updated to support OAuth providers. You'll need to create a database migration:

1. Create a new migration file in `backend/src/main/resources/db/migration/`
2. Name it with the next version number (e.g., `V3__add_oauth_fields.sql`)
3. Add the following SQL:

```sql
ALTER TABLE users
    ALTER COLUMN password_hash DROP NOT NULL,
    ADD COLUMN provider VARCHAR(50),
    ADD COLUMN provider_id VARCHAR(255);

-- Set existing users to 'local' provider
UPDATE users SET provider = 'local' WHERE provider IS NULL;
```

## Step 8: Rebuild and Run

### Backend:
```bash
cd backend
mvn clean package
java -jar target/codebattle-arena-0.0.1-SNAPSHOT.jar
```

### Frontend:
```bash
cd frontend
npm run dev
```

## Testing

1. Navigate to `http://localhost:5173/login`
2. You should see the traditional email/password login form
3. Below it, you'll see "Or continue with" followed by a Google Sign In button
4. Click the Google button to authenticate with your Google account
5. After successful authentication, you'll be redirected to the lobby

## Troubleshooting

### "Invalid Google ID token" error
- Verify that your Client ID is correctly set in both frontend and backend
- Ensure the authorized origins are correctly configured in Google Cloud Console

### "Origin mismatch" error
- Add your exact frontend URL to the authorized JavaScript origins in Google Cloud Console
- Make sure there are no trailing slashes

### Google button not appearing
- Check browser console for errors
- Verify that the `@react-oauth/google` package is installed
- Ensure `VITE_GOOGLE_CLIENT_ID` is set in your `.env` file

## Security Notes

- **Never commit** your Google Client ID to public repositories if it's a production credential
- Use environment variables for all sensitive configuration
- In production, use HTTPS for all OAuth flows
- Consider implementing additional security measures like CSRF protection

## Features Implemented

✅ Google OAuth login button on the login page
✅ Backend endpoint to verify Google ID tokens
✅ Automatic user creation for new Google users
✅ Account linking for existing users who sign in with Google
✅ JWT token generation after successful OAuth authentication
✅ One-tap sign-in support

## Next Steps

You may want to consider:
- Adding Google Sign In to the registration page
- Implementing OAuth for other providers (GitHub, Facebook, etc.)
- Adding profile pictures from Google accounts
- Implementing email verification for local accounts
