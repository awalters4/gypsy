# Gypsy Setup Guide

## Issues Found and Fixed

The site wasn't working because:

1. ✅ **Dependencies were not installed** - Fixed by running `npm install` in both `backend/` and `frontend/`
2. ✅ **Missing .env files** - Created `.env` files in both `backend/` and `frontend/`
3. ⚠️ **Database and API key need configuration** - See steps below

## Quick Setup

### 1. Configure Database

You need a PostgreSQL database. Choose one option:

#### Option A: Neon (Recommended - Free tier available)

1. Go to [neon.tech](https://neon.tech) and sign up
2. Create a new project
3. Copy your connection string (looks like: `postgresql://user:pass@ep-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require`)
4. Update `backend/.env` - replace `DATABASE_URL` with your connection string

#### Option B: Supabase (Free tier available)

1. Go to [supabase.com](https://supabase.com) and sign up
2. Create a new project
3. Go to Settings → Database → Connection string → URI
4. Copy the connection string
5. Update `backend/.env` - replace `DATABASE_URL` with your connection string

#### Option C: Local PostgreSQL

1. Install PostgreSQL on your machine
2. Create a database: `createdb tarot_reader`
3. Update `backend/.env` with your local connection:
   ```
   DATABASE_URL=postgresql://your_username:your_password@localhost:5432/tarot_reader
   ```

### 2. Set Up Database Schema

Once you have a database:

#### For Neon or Supabase:

1. Open the SQL editor in your database dashboard
2. Copy the contents of `backend/src/database/COMBINED_MIGRATION.sql`
3. Paste and run it
4. Verify: You should see 5 decks, 78 cards, and 8 spread types

#### For Local PostgreSQL:

```bash
psql $DATABASE_URL -f backend/src/database/COMBINED_MIGRATION.sql
```

### 3. Get Anthropic API Key

1. Go to [console.anthropic.com](https://console.anthropic.com/)
2. Sign up or log in
3. Go to API Keys section
4. Create a new API key
5. Update `backend/.env` - replace `ANTHROPIC_API_KEY` with your key

### 4. Start the Application

Open two terminal windows:

**Terminal 1 - Backend:**
```bash
cd backend
npm run dev
```

You should see: `⚡️ Server is running at http://localhost:3001`

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
```

You should see the Vite dev server running (usually at http://localhost:5173)

### 5. Test the Application

1. Open your browser to http://localhost:5173
2. You should see the Gypsy tarot reading app
3. Select a deck (should show 5 decks)
4. Select a spread (should show 8 spread types)
5. Draw cards and get an interpretation

## Verification Checklist

- [ ] Backend dependencies installed (`backend/node_modules` exists)
- [ ] Frontend dependencies installed (`frontend/node_modules` exists)
- [ ] Backend `.env` file exists with valid `DATABASE_URL`
- [ ] Backend `.env` file has valid `ANTHROPIC_API_KEY`
- [ ] Frontend `.env` file exists with `VITE_API_URL=http://localhost:3001/api`
- [ ] Database has been initialized with COMBINED_MIGRATION.sql
- [ ] Backend server starts without errors on port 3001
- [ ] Frontend dev server starts without errors
- [ ] Decks and spreads load in the UI

## Troubleshooting

### Backend won't start

**Error: "ANTHROPIC_API_KEY environment variable is required"**
- Update `backend/.env` with a valid Anthropic API key

**Error: "connection refused" or database errors**
- Verify your `DATABASE_URL` in `backend/.env`
- Make sure the database exists and is accessible
- Check if you've run the migration SQL

### Frontend can't connect to backend

**Error: "Failed to fetch decks/spreads"**
- Make sure backend is running on port 3001
- Check `frontend/.env` has `VITE_API_URL=http://localhost:3001/api`
- Check browser console for CORS errors

### Decks/Spreads showing empty

- Database migration hasn't been run
- Run `backend/src/database/COMBINED_MIGRATION.sql` in your database

## Current Configuration

Your `.env` files have been created with placeholder values:

**backend/.env:**
- DATABASE_URL: Needs to be updated with your PostgreSQL connection string
- ANTHROPIC_API_KEY: Needs to be updated with your API key
- PORT: 3001 (default)
- ALLOWED_ORIGINS: Configured for local development

**frontend/.env:**
- VITE_API_URL: http://localhost:3001/api (ready for local development)

## Next Steps

1. Set up a database (Neon is quickest)
2. Run the migration SQL
3. Get an Anthropic API key
4. Update the `.env` files
5. Start both backend and frontend
6. Enjoy your tarot readings! 🔮
