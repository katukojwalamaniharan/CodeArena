# CodeBattle Arena

A Java full-stack web app where two users join a room to solve algorithm problems in real time. First to pass all tests wins.

## Stack
- Backend: Spring Boot 3 (Java 17), Web, Security (JWT later), WebSocket/STOMP (later)
- Frontend: React + Vite + TypeScript
- Database: PostgreSQL (Docker)
- Execution: Judge0 API (optional Docker later)

## Quick Start

1) Prereqs: Docker Desktop, Java 17, Node 18+

2) Start PostgreSQL (optional for now):
```
docker compose up -d postgres adminer
```
Adminer at http://localhost:8081

3) Backend (first run without DB):
- Open `codebattle-arena/backend`
- Build and run:
```
mvn spring-boot:run
```
Backend at http://localhost:8080 (health: `/api/health`).

4) Frontend:
- Open `codebattle-arena/frontend`
- Install and run:
```
npm install
npm run dev
```
Frontend at http://localhost:5173

## Features Implemented
✅ JWT auth with email/password registration and login
✅ **Google OAuth authentication**
✅ User management with PostgreSQL
✅ Flyway database migrations
- WebSockets for rooms and editor sync (to be implemented)
- Judge0 integration for code execution (to be implemented)
- Leaderboard and scoring (partially implemented)

## Google OAuth Setup

This application supports Google Sign-In for easy authentication. See [GOOGLE_OAUTH_SETUP.md](./GOOGLE_OAUTH_SETUP.md) for detailed setup instructions.

**Quick setup:**
1. Get Google OAuth Client ID from [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
2. Set environment variables:
   - Backend: `GOOGLE_CLIENT_ID`
   - Frontend: Create `.env` file with `VITE_GOOGLE_CLIENT_ID`
3. Run `npm install` in the frontend directory

## Environment Variables

### Backend
Create a `.env` file or set environment variables (see `backend/.env.example`):
- `DB_URL` - PostgreSQL connection URL
- `DB_USER` - Database username
- `DB_PASS` - Database password
- `JWT_SECRET` - Secret key for JWT tokens (min 32 chars)
- `JUDGE0_URL` - Judge0 API endpoint
- `JUDGE0_KEY` - Judge0 API key
- `GOOGLE_CLIENT_ID` - Google OAuth client ID

### Frontend
Create `frontend/.env` file (see `frontend/.env.example`):
- `VITE_GOOGLE_CLIENT_ID` - Google OAuth client ID

See `docker-compose.yml` for local services.