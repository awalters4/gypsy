# Deployment Guide - Dual Vercel Setup

This is a monorepo with separate frontend and backend applications, both deployed to Vercel as separate projects.

## Overview

You'll have **two separate Vercel projects**:
1. **gypsy** - Frontend (React/Vite application)
2. **tarot-reader** - Backend (Express API server)

---

## Frontend Deployment (gypsy)

### Initial Setup:

1. **Create Vercel Project**:
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Import your GitHub repository
   - Name it "gypsy"

2. **Configure Build Settings**:
   - The root `vercel.json` handles the configuration
   - Vercel should auto-detect:
     - Build Command: `cd frontend && npm install && npm run build`
     - Output Directory: `frontend/dist`
     - Install Command: `echo 'Skipping root install'`

3. **Set Environment Variables**:
   - Go to Project Settings → Environment Variables
   - Add: `VITE_API_URL` = `https://tarot-reader.vercel.app/api`
   - (Replace with your actual backend Vercel URL)

4. **Deploy**: Push to GitHub to trigger deployment

---

## Backend Deployment (tarot-reader)

### Initial Setup:

1. **Create Second Vercel Project**:
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Import the **same** GitHub repository
   - Name it "tarot-reader"

2. **Configure Build Settings**:
   - Root Directory: `backend`
   - Framework Preset: Other
   - Build Command: Leave default (uses package.json)
   - Output Directory: Leave default
   - Install Command: `npm install`

3. **Set Environment Variables** (CRITICAL):

   Go to Project Settings → Environment Variables and add:

   - **ANTHROPIC_API_KEY**: Your Claude API key from anthropic.com
     - Get from: https://console.anthropic.com/settings/keys

   - **DATABASE_URL**: PostgreSQL connection string
     - Format: `postgresql://user:password@host:port/database?sslmode=require`
     - See Database Setup below

   - **ALLOWED_ORIGINS**: Your frontend URL
     - Example: `https://gypsy.vercel.app`
     - Important: No trailing slash

   - **NODE_ENV**: `production`

4. **Deploy**: Push to GitHub to trigger deployment

---

## Database Setup

You need a PostgreSQL database. Options:

### Option 1: Vercel Postgres (Recommended)

1. In your backend Vercel project:
   - Go to Storage tab
   - Click "Create Database"
   - Select "Postgres"
   - Vercel will automatically add `DATABASE_URL` to environment variables

2. **Connect and run migrations**:
   ```bash
   # Install Vercel CLI
   npm i -g vercel

   # Link to your project
   vercel link

   # Connect to database
   vercel env pull .env.local

   # Run migrations using psql or a database client
   # Execute SQL files in order from backend/src/database/
   ```

3. **Run migrations** in order:
   - `001_initial_schema.sql`
   - `002_add_card_meanings.sql`
   - `003_add_default_decks.sql`
   - `004_add_marseille_deck.sql`
   - `005_add_thoth_deck.sql`
   - `006_add_wild_unknown_deck.sql`
   - `007_add_modern_witch_deck.sql`

### Option 2: Neon Database (Free Tier)

1. Go to [neon.tech](https://neon.tech)
2. Create a new project
3. Copy the connection string
4. Add to Vercel backend as `DATABASE_URL`
5. Run migrations using Neon's SQL editor or psql

### Option 3: Supabase

1. Go to [supabase.com](https://supabase.com)
2. Create a new project
3. Get connection string from Settings → Database
4. Add to Vercel backend as `DATABASE_URL`
5. Run migrations in Supabase SQL editor

---

## After Deployment

### 1. Get Your URLs

After both projects deploy, you'll have:
- Frontend: `https://gypsy.vercel.app` (or your custom domain)
- Backend: `https://tarot-reader.vercel.app`

### 2. Update Environment Variables

**In Frontend (gypsy) Vercel project**:
- Set `VITE_API_URL` = `https://tarot-reader.vercel.app/api`
- Redeploy (or auto-deploys on env change)

**In Backend (tarot-reader) Vercel project**:
- Set `ALLOWED_ORIGINS` = `https://gypsy.vercel.app`
- Redeploy (or auto-deploys on env change)

### 3. Test the Application

1. Visit your frontend URL
2. Try creating a tarot reading
3. Check that AI interpretation works
4. Verify deck selection

---

## Environment Variables Summary

### Frontend (gypsy)
```
VITE_API_URL=https://tarot-reader.vercel.app/api
```

### Backend (tarot-reader)
```
ANTHROPIC_API_KEY=sk-ant-xxxxx (from anthropic.com)
DATABASE_URL=postgresql://user:pass@host:port/db?sslmode=require
ALLOWED_ORIGINS=https://gypsy.vercel.app
NODE_ENV=production
```

---

## Troubleshooting

### Build Errors

**Frontend fails with "vite: command not found"**
- ✅ Fixed with vercel.json configuration
- Ensure vercel.json exists in repository root

**Backend fails to build**
- Check that `backend/vercel.json` exists
- Verify all dependencies are in package.json, not devDependencies

### Runtime Errors

**"Failed to fetch" / Network errors**
- Check `VITE_API_URL` in frontend environment variables
- Ensure it ends with `/api`
- Verify backend is deployed and accessible

**CORS errors**
- Check `ALLOWED_ORIGINS` in backend environment variables
- Must match frontend URL exactly (no trailing slash)
- Check browser console for the actual origin being blocked

**Database connection errors**
- Verify `DATABASE_URL` format includes `?sslmode=require`
- Test connection using psql or database client
- Check database is accessible from Vercel

**"ANTHROPIC_API_KEY environment variable is required"**
- Add API key to backend environment variables
- Get key from https://console.anthropic.com/settings/keys
- Redeploy after adding

**Empty readings / No cards showing**
- Database migrations not run
- Check Vercel logs: `vercel logs [project-url]`
- Manually run migrations on database

### Deployment Issues

**Changes not showing up**
- Clear browser cache
- Check Vercel deployment logs
- Ensure latest commit is deployed
- Try forcing a redeploy in Vercel dashboard

**Database migrations**
- Use a PostgreSQL client (DBeaver, pgAdmin, psql)
- Connect using DATABASE_URL
- Run each .sql file in the backend/src/database/ directory in order

---

## Continuous Deployment

Both projects will auto-deploy when you push to GitHub:
- Frontend redeploys on any change
- Backend redeploys on any change
- Environment variable changes trigger redeployment

---

## Custom Domains (Optional)

### Frontend
1. In Vercel "gypsy" project → Settings → Domains
2. Add your domain (e.g., mytarot.com)
3. Update DNS records as instructed
4. Update `ALLOWED_ORIGINS` in backend to include new domain

### Backend
1. In Vercel "tarot-reader" project → Settings → Domains
2. Add subdomain (e.g., api.mytarot.com)
3. Update DNS records
4. Update `VITE_API_URL` in frontend to new backend domain

---

## Monitoring

### Check Logs
```bash
# Install Vercel CLI
npm i -g vercel

# View frontend logs
vercel logs gypsy

# View backend logs
vercel logs tarot-reader
```

### Common Log Commands
- `vercel logs --follow` - Stream logs in real-time
- `vercel logs --since 1h` - Last hour of logs
- `vercel logs --until 2h` - Logs from 2 hours ago until now
