# Deployment Guide

This is a monorepo with separate frontend and backend applications.

## Frontend Deployment (Vercel)

The frontend is configured to deploy to Vercel with the included `vercel.json` configuration.

### Steps:

1. **Push to GitHub**: Ensure all changes are committed and pushed
   ```bash
   git add .
   git commit -m "Add Vercel configuration"
   git push
   ```

2. **Import to Vercel**:
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Import your GitHub repository
   - Vercel will automatically detect the configuration

3. **Set Environment Variables** in Vercel dashboard:
   - Go to Project Settings → Environment Variables
   - Add: `VITE_API_URL` = Your backend API URL (see Backend Deployment below)
   - Example: `https://your-backend.railway.app/api`

4. **Deploy**: Vercel will automatically build and deploy

## Backend Deployment Options

The backend needs to be deployed separately. Here are recommended options:

### Option 1: Railway (Recommended)

1. Go to [railway.app](https://railway.app)
2. Create new project from GitHub repo
3. Select the `backend` directory as root
4. Add environment variables:
   - `ANTHROPIC_API_KEY` = Your Claude API key
   - `DATABASE_URL` = Your PostgreSQL connection string (Railway provides this)
   - `PORT` = 3001 (or Railway's auto-assigned port)
5. Railway will auto-deploy on push

### Option 2: Render

1. Go to [render.com](https://render.com)
2. Create new Web Service
3. Connect GitHub repository
4. Set Root Directory to `backend`
5. Build Command: `npm install && npm run build`
6. Start Command: `npm start`
7. Add environment variables (same as Railway)

### Option 3: Fly.io

1. Install flyctl CLI
2. From the `backend` directory:
   ```bash
   cd backend
   fly launch
   fly secrets set ANTHROPIC_API_KEY=your_key_here
   fly deploy
   ```

## Database Setup

All deployment platforms above offer PostgreSQL databases:

1. **Create a PostgreSQL database** on your chosen platform
2. **Run migrations**: Connect to your database and run the SQL files in `backend/src/database/`
   - Run files in order: `001_initial_schema.sql` through `007_add_modern_witch_deck.sql`
3. **Update DATABASE_URL** environment variable with your database connection string

## After Deployment

1. Get your backend URL (e.g., `https://your-app.railway.app`)
2. Update the `VITE_API_URL` environment variable in Vercel to: `https://your-app.railway.app/api`
3. Redeploy frontend on Vercel (or it will auto-deploy)
4. Test the application

## CORS Configuration

Ensure your backend's CORS configuration (in `backend/src/index.ts`) includes your Vercel frontend URL:

```typescript
app.use(cors({
  origin: [
    'http://localhost:5173',
    'https://your-app.vercel.app'  // Add your Vercel URL
  ]
}));
```

## Troubleshooting

- **"Failed to fetch"**: Check that VITE_API_URL is set correctly in Vercel
- **CORS errors**: Ensure backend allows your frontend URL
- **Database connection errors**: Verify DATABASE_URL is correct
- **API key errors**: Ensure ANTHROPIC_API_KEY is set in backend environment
