# WebReminder Project Cleanup Script

## ⚠️ WARNING: DESTRUCTIVE OPERATION
This script will permanently delete files and restructure your project. **Create a backup before proceeding!**

```bash
# Create backup
cp -r . ../WebReminder-backup
```

---

## Phase 1: Remove Unnecessary Directories

```bash
# Remove test directories
rm -rf src/test
rm -rf src/examples  
rm -rf src/docs

# Remove build artifacts
rm -rf dist
rm -rf build
rm -rf coverage

# Remove IDE/tool directories
rm -rf .kiro
rm -rf .vscode

# Remove unnecessary documentation
rm -rf DEPLOYMENT_QUICK_START.md
rm -rf VERCEL_RENDER_DEPLOYMENT.md
```

---

## Phase 2: Remove Test Files

```bash
# Remove all test files
find src -name "*.test.ts" -type f -delete
find src -name "*.test.tsx" -type f -delete
find src -name "*.spec.ts" -type f -delete
find src -name "*.spec.tsx" -type f -delete

# Remove vitest config
rm -f vitest.config.ts
```

---

## Phase 3: Remove Unnecessary Features

### Remove Advanced Features (Keep Only Core Medicine Reminder)

```bash
# Remove chronic diseases feature
rm -rf src/components/chronic-diseases
rm -rf src/data/chronic-diseases.ts
rm -rf src/data/disease-keywords.ts
rm -rf src/data/medication-disease-map.ts
rm -rf src/pages/ChronicDiseases.tsx
rm -rf src/services/disease-detector.ts
rm -rf src/services/guideline-generator.ts
rm -rf src/services/profile-creator.ts

# Remove prescription analysis/OCR
rm -rf src/components/prescription-analysis
rm -rf src/pages/PrescriptionUpload.tsx
rm -rf src/pages/PrescriptionVoice.tsx
rm -rf src/services/ocr-service.ts
rm -rf src/services/medication-parser.ts
rm -rf src/services/section-based-parser.ts

# Remove video consultation
rm -rf src/components/dashboard/VideoConsultPanel.tsx
rm -rf src/pages/VideoConsultation.tsx
rm -rf src/services/telehealth.ts
rm -rf src/services/appointment-service.ts
rm -rf src/types/appointment.ts

# Remove orders/store features
rm -rf src/components/orders
rm -rf src/components/dashboard/OrdersPanel.tsx
rm -rf src/pages/Orders.tsx
rm -rf src/pages/OrdersStore.tsx
rm -rf src/services/fulfillment.ts
rm -rf src/data/vendors.ts
rm -rf src/data/doctors.ts
rm -rf src/types/vendor.ts

# Remove caregiver features
rm -rf src/pages/Caregiver.tsx

# Remove integrations
rm -rf src/pages/Integrations.tsx
rm -rf src/services/integrations.ts
rm -rf src/services/drugs.ts
rm -rf src/services/fdb.ts

# Remove voice features (keep only basic reminders)
rm -rf src/components/voice
rm -rf src/components/dashboard/VoicePrescriptionPanel.tsx
rm -rf src/services/voice-modulator.ts
rm -rf src/services/voice-modulator.test.ts
rm -rf src/hooks/useVoiceReminder.ts

# Remove PDF generation
rm -rf src/services/pdf-generator.ts

# Remove email service
rm -rf src/services/email.ts
```

---

## Phase 4: Clean Package.json

Create a new minimal `package.json`:

```json
{
  "name": "webreminder",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-router-dom": "^6.30.1",
    "axios": "^1.7.2",
    "zustand": "^5.0.8",
    "lucide-react": "^0.462.0",
    "date-fns": "^3.6.0",
    "sonner": "^1.7.4"
  },
  "devDependencies": {
    "@types/react": "^18.3.23",
    "@types/react-dom": "^18.3.7",
    "@vitejs/plugin-react-swc": "^3.11.0",
    "autoprefixer": "^10.4.21",
    "postcss": "^8.5.6",
    "tailwindcss": "^3.4.17",
    "typescript": "^5.8.3",
    "vite": "^5.4.19"
  }
}
```

Backend `server/package.json`:

```json
{
  "name": "webreminder-backend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "start": "node server.js",
    "dev": "node --watch server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "mysql2": "^3.6.5",
    "dotenv": "^16.3.1",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.2",
    "express-validator": "^7.0.1"
  }
}
```

---

## Phase 5: Simplify Project Structure

### Target Structure:

```
webreminder/
├── public/
│   ├── favicon.ico
│   └── robots.txt
├── src/
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Layout.tsx
│   │   │   └── Sidebar.tsx
│   │   ├── medicines/
│   │   │   ├── MedicineCard.tsx
│   │   │   ├── MedicineForm.tsx
│   │   │   └── MedicineList.tsx
│   │   ├── dashboard/
│   │   │   ├── QuickStats.tsx
│   │   │   └── TodaySchedule.tsx
│   │   └── ui/
│   │       ├── Button.tsx
│   │       ├── Input.tsx
│   │       ├── Card.tsx
│   │       └── Modal.tsx
│   ├── pages/
│   │   ├── Landing.tsx
│   │   ├── Login.tsx
│   │   ├── Signup.tsx
│   │   ├── Dashboard.tsx
│   │   ├── Medicines.tsx
│   │   ├── History.tsx
│   │   ├── Settings.tsx
│   │   └── NotFound.tsx
│   ├── services/
│   │   └── api.ts
│   ├── store/
│   │   └── useStore.ts
│   ├── types/
│   │   └── index.ts
│   ├── lib/
│   │   └── utils.ts
│   ├── App.tsx
│   ├── main.tsx
│   └── index.css
├── server/
│   ├── config/
│   │   └── database.js
│   ├── routes/
│   │   ├── auth.js
│   │   ├── medicines.js
│   │   ├── schedules.js
│   │   └── history.js
│   ├── models/
│   │   ├── User.js
│   │   ├── Medicine.js
│   │   ├── Schedule.js
│   │   └── History.js
│   ├── middleware/
│   │   └── auth.js
│   ├── database/
│   │   └── schema.sql
│   ├── .env
│   ├── package.json
│   └── server.js
├── .env
├── .gitignore
├── package.json
├── tailwind.config.ts
├── vite.config.ts
└── README.md
```

---

## Phase 6: Clean Up Remaining Files

```bash
# Remove unnecessary config files
rm -f components.json
rm -f eslint.config.js
rm -f postcss.config.js
rm -f vercel.json
rm -f .env.production

# Remove server deployment configs
rm -f server/Procfile
rm -f server/railway.json
rm -f server/render.yaml
rm -f server/setup-database.js
rm -f server/test-connection.js
```

---

## Phase 7: Update Core Files

### Update `.gitignore`:

```
# Dependencies
node_modules/
server/node_modules/

# Build
dist/
build/

# Environment
.env
.env.local
.env.production
server/.env

# IDE
.vscode/
.idea/

# Logs
*.log
npm-debug.log*

# OS
.DS_Store
Thumbs.db
```

### Update `.env`:

```
VITE_API_BASE_URL=http://localhost:3001
```

### Update `server/.env`:

```
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=webreminder

PORT=3001
NODE_ENV=development

JWT_SECRET=your_secret_key_here
JWT_EXPIRES_IN=7d
```

---

## Phase 8: Reinstall Dependencies

```bash
# Remove node_modules
rm -rf node_modules
rm -rf server/node_modules
rm -f package-lock.json
rm -f server/package-lock.json

# Install fresh dependencies
npm install
cd server && npm install
```

---

## Phase 9: MySQL Database Setup

### Create Database:

```sql
CREATE DATABASE webreminder;
USE webreminder;
```

### Create Tables:

```sql
-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Medicines table
CREATE TABLE medicines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    medicine_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    start_date DATE,
    end_date DATE,
    stock_quantity INT DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
);

-- Schedules table
CREATE TABLE schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    time TIME NOT NULL,
    days_of_week VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    INDEX idx_medicine_id (medicine_id)
);

-- Dose logs (history) table
CREATE TABLE dose_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    scheduled_time TIMESTAMP NOT NULL,
    taken_at TIMESTAMP,
    status ENUM('taken', 'missed', 'skipped') DEFAULT 'missed',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    INDEX idx_medicine_id (medicine_id),
    INDEX idx_scheduled_time (scheduled_time)
);

-- Notifications table
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    medicine_id INT,
    type VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read)
);
```

---

## Phase 10: Verification

After cleanup, verify:

```bash
# Check project structure
ls -la

# Check dependencies
npm list --depth=0
cd server && npm list --depth=0

# Try to build
npm run build

# Try to start servers
cd server && npm start
# In another terminal:
npm run dev
```

---

## Summary of Deletions

### Removed Features:
- ❌ Chronic disease management
- ❌ OCR prescription scanning
- ❌ Voice prescription
- ❌ Video consultation
- ❌ Medicine ordering/store
- ❌ Caregiver features
- ❌ Integrations
- ❌ PDF generation
- ❌ Email notifications
- ❌ Advanced analytics

### Kept Features:
- ✅ User authentication
- ✅ Medicine management (CRUD)
- ✅ Reminder scheduling
- ✅ Dose history tracking
- ✅ Dashboard with today's schedule
- ✅ Basic notifications
- ✅ User settings
- ✅ Responsive UI

### Removed Dependencies:
- Testing libraries (vitest, testing-library)
- Supabase
- Tesseract.js (OCR)
- jsPDF, pdf-lib
- EmailJS
- Radix UI (replaced with simple components)
- Framer Motion (optional animations)
- TanStack Query
- React Hook Form
- Zod
- Many others...

### Final Bundle Size:
- Before: ~50+ dependencies
- After: ~15 core dependencies
- Estimated size reduction: 70-80%

---

## Next Steps

1. **Backup your project first!**
2. Run the cleanup commands phase by phase
3. Test after each phase
4. Update imports in remaining files
5. Fix any broken references
6. Test the application thoroughly
7. Deploy to production

---

**Estimated Time:** 2-3 hours for complete cleanup and testing
**Risk Level:** High (destructive operation)
**Recommendation:** Do this in a separate branch first!
