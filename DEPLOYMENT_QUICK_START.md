# 🚀 Quick Deployment Guide - Vercel + Render

## Step-by-Step Deployment (30 minutes)

### 1️⃣ Deploy Backend to Render (15 min)

1. **Create MySQL Database**
   - Go to https://dashboard.render.com
   - New + → MySQL
   - Name: `medreminder-db`
   - Save credentials!

2. **Deploy Backend Service**
   - New + → Web Service
   - Connect GitHub repo
   - Root Directory: `server`
   - Build: `npm install`
   - Start: `npm start`

3. **Add Environment Variables**
   ```
   NODE_ENV=production
   PORT=10000
   DB_HOST=<from-step-1>
   DB_PORT=3306
   DB_USER=<from-step-1>
   DB_PASSWORD=<from-step-1>
   DB_NAME=medreminder
   JWT_SECRET=<generate-random-string>
   JWT_EXPIRES_IN=7d
   ```

4. **Initialize Database**
   - Connect to MySQL
   - Run `server/database/schema.sql`

5. **Test Backend**
   - Visit: `https://your-backend.onrender.com/health`
   - Should return: `{"status":"ok",...}`

### 2️⃣ Deploy Frontend to Vercel (10 min)

1. **Update .env.production**
   ```
   VITE_API_BASE_URL=https://your-backend.onrender.com
   ```

2. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Configure for deployment"
   git push origin master
   ```

3. **Deploy to Vercel**
   - Go to https://vercel.com/dashboard
   - New Project → Import from GitHub
   - Framework: Vite (auto-detected)
   - Add Environment Variable:
     - `VITE_API_BASE_URL` = `https://your-backend.onrender.com`
   - Deploy!

4. **Update Backend CORS**
   - Go back to Render → Backend service
   - Add environment variables:
     - `FRONTEND_URL` = `https://your-app.vercel.app`
     - `CORS_ORIGIN` = `https://your-app.vercel.app`
   - Save (auto-redeploys)

### 3️⃣ Test Your App (5 min)

1. Visit your Vercel URL
2. Sign up / Log in
3. Add a medicine
4. Check dashboard

---

## 🔑 Important URLs

After deployment, save these:

- **Frontend**: `https://your-app.vercel.app`
- **Backend**: `https://your-backend.onrender.com`
- **Health Check**: `https://your-backend.onrender.com/health`

---

## ⚠️ Common Issues

**CORS Error**
- Make sure FRONTEND_URL in Render matches your Vercel URL exactly
- Include `https://` in the URL

**Database Connection Failed**
- Check DB credentials in Render environment variables
- Ensure database is running

**Backend Slow/Timeout**
- Free tier spins down after 15 min
- First request takes 30-60 seconds
- Upgrade to paid plan for always-on

**Environment Variables Not Working**
- Must start with `VITE_` for frontend
- Redeploy after changing variables

---

## 💰 Free Tier Limits

**Vercel**: Unlimited deployments, 100GB bandwidth  
**Render**: 750 hours/month, spins down after 15 min  
**MySQL**: 1GB storage, expires after 90 days

---

## 📚 Full Documentation

See `VERCEL_RENDER_DEPLOYMENT.md` for complete guide with:
- Detailed instructions
- Troubleshooting
- Security checklist
- Monitoring setup
- Custom domains
- Performance optimization

---

**Need Help?**
- Vercel Docs: https://vercel.com/docs
- Render Docs: https://render.com/docs
