# MedReminder Pro - Vercel + Render Deployment Guide

Complete guide to deploy your frontend on Vercel and backend on Render.

---

## 📋 Prerequisites

- GitHub account
- Vercel account (sign up at https://vercel.com)
- Render account (sign up at https://render.com)
- MySQL database (Render provides free MySQL or use external service)

---

## 🎯 Deployment Overview

1. **Backend → Render** (with MySQL database)
2. **Frontend → Vercel** (connected to Render backend)

---

## Part 1: Deploy Backend to Render

### Step 1: Prepare Your Repository

Your backend code is already in the `server/` directory. Render will automatically detect it.

### Step 2: Create MySQL Database on Render

1. Go to https://dashboard.render.com
2. Click **"New +"** → **"MySQL"**
3. Configure:
   - **Name**: `medreminder-db`
   - **Database**: `medreminder`
   - **User**: `medreminder_user`
   - **Region**: Choose closest to you
   - **Plan**: Free (or paid for better performance)
4. Click **"Create Database"**
5. **Save these credentials** (you'll need them):
   - Internal Database URL
   - External Database URL
   - Host
   - Port
   - Database Name
   - Username
   - Password

### Step 3: Deploy Backend Service

1. Go to https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure:
   - **Name**: `medreminder-backend`
   - **Region**: Same as database
   - **Branch**: `master` (or `main`)
   - **Root Directory**: `server`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Plan**: Free (or paid for better performance)

### Step 4: Add Environment Variables

In the Render dashboard, add these environment variables:

```env
NODE_ENV=production
PORT=10000

# Database Configuration (from Step 2)
DB_HOST=your-db-host.render.com
DB_PORT=3306
DB_USER=medreminder_user
DB_PASSWORD=your-db-password
DB_NAME=medreminder

# Database Retry Configuration
DB_MAX_RETRIES=5
DB_INITIAL_RETRY_DELAY=1000

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=7d

# CORS Configuration (Update after deploying frontend)
FRONTEND_URL=https://your-app.vercel.app
CORS_ORIGIN=https://your-app.vercel.app
```

**Important:** Generate a strong JWT_SECRET:
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

### Step 5: Deploy Backend

1. Click **"Create Web Service"**
2. Wait for deployment (5-10 minutes)
3. Once deployed, you'll get a URL like: `https://medreminder-backend.onrender.com`
4. Test the health endpoint: `https://medreminder-backend.onrender.com/health`

### Step 6: Initialize Database Schema

1. Connect to your MySQL database using the External Database URL
2. Run the schema from `server/database/schema.sql`

**Option A: Using MySQL Workbench or similar tool**
- Connect using the credentials from Step 2
- Execute the schema.sql file

**Option B: Using Render Shell**
1. Go to your database in Render dashboard
2. Click "Connect" → "External Connection"
3. Use the provided command to connect
4. Run your schema SQL

---

## Part 2: Deploy Frontend to Vercel

### Step 1: Update Frontend Environment Variables

1. Open `.env.production` in your project
2. Update `VITE_API_BASE_URL` with your Render backend URL:

```env
VITE_API_BASE_URL=https://medreminder-backend.onrender.com
```

### Step 2: Update Backend CORS

1. Go back to Render dashboard → Your backend service
2. Update environment variables:
   - `FRONTEND_URL`: Your Vercel URL (you'll get this in Step 4)
   - `CORS_ORIGIN`: Your Vercel URL

### Step 3: Push Changes to GitHub

```bash
git add .
git commit -m "Configure for Vercel and Render deployment"
git push origin master
```

### Step 4: Deploy to Vercel

**Option A: Using Vercel Dashboard (Recommended)**

1. Go to https://vercel.com/dashboard
2. Click **"Add New..."** → **"Project"**
3. Import your GitHub repository
4. Configure:
   - **Framework Preset**: Vite
   - **Root Directory**: `./` (leave as root)
   - **Build Command**: `npm run build` (auto-detected)
   - **Output Directory**: `dist` (auto-detected)
   - **Install Command**: `npm install` (auto-detected)

5. Add Environment Variables:
   - Click **"Environment Variables"**
   - Add: `VITE_API_BASE_URL` = `https://medreminder-backend.onrender.com`

6. Click **"Deploy"**

7. Wait for deployment (2-5 minutes)

8. You'll get a URL like: `https://your-app.vercel.app`

**Option B: Using Vercel CLI**

```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
vercel

# Follow the prompts:
# - Set up and deploy? Yes
# - Which scope? Your account
# - Link to existing project? No
# - Project name? medreminder-pro
# - Directory? ./
# - Override settings? No

# Add environment variable
vercel env add VITE_API_BASE_URL production
# Enter: https://medreminder-backend.onrender.com

# Deploy to production
vercel --prod
```

### Step 5: Update Backend CORS (Final Step)

1. Go to Render dashboard → Your backend service
2. Update environment variables with your actual Vercel URL:
   ```
   FRONTEND_URL=https://your-app.vercel.app
   CORS_ORIGIN=https://your-app.vercel.app
   ```
3. Save changes (Render will auto-redeploy)

---

## 🧪 Testing Your Deployment

### Test Backend
```bash
# Health check
curl https://medreminder-backend.onrender.com/health

# Should return:
# {"status":"ok","message":"MedReminder API is running","timestamp":"..."}
```

### Test Frontend
1. Visit your Vercel URL: `https://your-app.vercel.app`
2. Try to sign up / log in
3. Check browser console for any errors
4. Verify API calls are going to Render backend

---

## 🔧 Troubleshooting

### Backend Issues

**Database Connection Failed**
- Verify DB credentials in Render environment variables
- Check if database is running in Render dashboard
- Ensure DB_HOST uses internal hostname (faster)

**CORS Errors**
- Verify FRONTEND_URL and CORS_ORIGIN match your Vercel URL exactly
- Include https:// in the URL
- Redeploy backend after changing CORS settings

**Cold Start Delays**
- Free tier on Render spins down after 15 minutes of inactivity
- First request after spin-down takes 30-60 seconds
- Upgrade to paid plan for always-on service

### Frontend Issues

**API Connection Failed**
- Verify VITE_API_BASE_URL in Vercel environment variables
- Check if backend is running (visit /health endpoint)
- Look for CORS errors in browser console

**Environment Variables Not Working**
- Environment variables must start with `VITE_` to be exposed to frontend
- Redeploy after adding/changing environment variables
- Clear browser cache

**Build Failures**
- Check build logs in Vercel dashboard
- Ensure all dependencies are in package.json
- Verify TypeScript has no errors locally

---

## 🚀 Automatic Deployments

### Vercel (Frontend)
- **Automatic**: Every push to `master` branch triggers deployment
- **Preview**: Pull requests get preview deployments
- **Rollback**: Easy rollback in Vercel dashboard

### Render (Backend)
- **Automatic**: Every push to `master` branch triggers deployment
- **Manual**: Can disable auto-deploy in settings
- **Rollback**: Can redeploy previous versions

---

## 💰 Cost Breakdown

### Free Tier Limits

**Vercel Free Tier:**
- ✅ Unlimited deployments
- ✅ 100 GB bandwidth/month
- ✅ Automatic HTTPS
- ✅ Global CDN
- ✅ Preview deployments

**Render Free Tier:**
- ✅ 750 hours/month (enough for 1 service)
- ⚠️ Spins down after 15 min inactivity
- ✅ 100 GB bandwidth/month
- ✅ Automatic HTTPS
- ⚠️ Slower cold starts

**Render MySQL Free Tier:**
- ✅ 1 GB storage
- ✅ Expires after 90 days (must upgrade or migrate)
- ⚠️ Limited connections

### Recommended Upgrades

For production use, consider:
- **Render Starter Plan** ($7/month): Always-on, faster performance
- **Render MySQL** ($7/month): Persistent database, more storage
- **Vercel Pro** ($20/month): More bandwidth, better analytics

---

## 📊 Monitoring

### Vercel
- Dashboard: https://vercel.com/dashboard
- Analytics: Built-in performance monitoring
- Logs: Real-time deployment and function logs

### Render
- Dashboard: https://dashboard.render.com
- Logs: Real-time application logs
- Metrics: CPU, memory, request metrics
- Alerts: Email notifications for downtime

---

## 🔐 Security Checklist

- [ ] Change JWT_SECRET to a strong random value
- [ ] Use environment variables for all secrets
- [ ] Enable HTTPS (automatic on both platforms)
- [ ] Restrict CORS to your Vercel domain only
- [ ] Use strong database password
- [ ] Enable database backups (paid feature)
- [ ] Set up monitoring and alerts
- [ ] Review Render logs regularly

---

## 🎉 Post-Deployment

### Custom Domain (Optional)

**Vercel:**
1. Go to Project Settings → Domains
2. Add your custom domain
3. Update DNS records as instructed

**Render:**
1. Go to Service Settings → Custom Domain
2. Add your custom domain
3. Update DNS records as instructed

### Database Backups

**Render MySQL:**
- Free tier: No automatic backups
- Paid tier: Daily automatic backups
- Manual: Export via MySQL client

### Performance Optimization

1. **Enable Vercel Analytics** (free)
2. **Monitor Render metrics** (CPU, memory)
3. **Optimize database queries** (add indexes)
4. **Enable caching** where appropriate
5. **Monitor error rates** in both platforms

---

## 📞 Support

- **Vercel Docs**: https://vercel.com/docs
- **Render Docs**: https://render.com/docs
- **Vercel Support**: support@vercel.com
- **Render Support**: https://render.com/support

---

## ✅ Deployment Checklist

### Backend (Render)
- [ ] MySQL database created
- [ ] Database schema initialized
- [ ] Backend service deployed
- [ ] Environment variables configured
- [ ] Health endpoint responding
- [ ] CORS configured for Vercel URL

### Frontend (Vercel)
- [ ] Repository connected
- [ ] Environment variables set
- [ ] Build successful
- [ ] Deployment live
- [ ] Can access the app
- [ ] API calls working

### Final Verification
- [ ] Sign up works
- [ ] Login works
- [ ] Can add medicines
- [ ] Can view dashboard
- [ ] No console errors
- [ ] Mobile responsive
- [ ] HTTPS enabled

---

**Congratulations! Your MedReminder Pro app is now live! 🎉**

Your URLs:
- Frontend: `https://your-app.vercel.app`
- Backend: `https://medreminder-backend.onrender.com`
- API Health: `https://medreminder-backend.onrender.com/health`
