# 💊 MedReminder Pro

A comprehensive medication reminder and management system with OCR prescription scanning, voice reminders, chronic disease management, and telemedicine integration.

## ✨ Features

### Core Features
- 📝 **Medicine Management** - Add, edit, and track medications
- ⏰ **Smart Reminders** - Customizable medication schedules
- 📊 **Dashboard** - Visual overview of today's medications and adherence
- 📜 **Dose History** - Complete medication intake tracking
- 🔔 **Notifications** - Real-time reminders for medications

### Advanced Features
- 📸 **OCR Prescription Scanning** - Extract medication details from prescription images
- 🎤 **Voice Reminders** - Audio notifications for elderly users
- 🏥 **Chronic Disease Management** - Track and manage chronic conditions
- 📋 **Personalized Guidelines** - Generate PDF health guidelines
- 🛒 **Medicine Ordering** - Order medications from multiple vendors
- 👨‍⚕️ **Video Consultation** - Book appointments with doctors
- 👥 **Caregiver Support** - Share medication schedules with caregivers

### Accessibility
- ♿ **Elderly Mode** - Larger fonts and touch targets
- ⌨️ **Keyboard Navigation** - Full keyboard accessibility
- 🎨 **High Contrast** - WCAG 2.1 AA compliant
- 📱 **Responsive Design** - Works on mobile, tablet, and desktop

## 🚀 Tech Stack

### Frontend
- **React** 18.3.1 + **TypeScript** 5.8.3
- **Vite** - Fast build tool
- **Tailwind CSS** - Utility-first styling
- **Radix UI** - Accessible components
- **Zustand** - State management
- **TanStack Query** - Server state
- **Framer Motion** - Animations
- **Tesseract.js** - OCR processing
- **jsPDF** - PDF generation

### Backend
- **Node.js** + **Express** 4.18.2
- **MySQL2** - Database
- **JWT** - Authentication
- **bcrypt** - Password hashing

### Testing
- **Vitest** - Unit testing
- **Testing Library** - React testing
- **fast-check** - Property-based testing

## 📦 Installation

### Prerequisites
- Node.js 16+ and npm
- MySQL 8.0+

### Local Development

1. **Clone the repository**
```bash
git clone https://github.com/Gowtham-gangster/WebReminder.git
cd WebReminder
```

2. **Install frontend dependencies**
```bash
npm install
```

3. **Install backend dependencies**
```bash
cd server
npm install
cd ..
```

4. **Configure environment variables**

Frontend `.env`:
```env
VITE_API_BASE_URL=http://localhost:3001
```

Backend `server/.env`:
```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=medreminder
PORT=3001
JWT_SECRET=your_secret_key
```

5. **Initialize database**
```bash
# Connect to MySQL and run:
mysql -u root -p < server/database/schema.sql
```

6. **Start the servers**

Terminal 1 (Backend):
```bash
cd server
npm start
```

Terminal 2 (Frontend):
```bash
npm run dev
```

7. **Open the app**
- Frontend: http://localhost:8080
- Backend: http://localhost:3001

## 🌐 Deployment

### Quick Deployment (Vercel + Render)

See detailed guides:
- **Quick Start**: `DEPLOYMENT_QUICK_START.md` (30 minutes)
- **Complete Guide**: `VERCEL_RENDER_DEPLOYMENT.md` (detailed)

**Frontend → Vercel**
```bash
vercel
```

**Backend → Render**
1. Create MySQL database on Render
2. Deploy backend service
3. Add environment variables
4. Initialize database schema

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests with UI
npm run test:ui

# Run tests in watch mode
npm test -- --watch
```

## 📁 Project Structure

```
WebReminder/
├── src/                          # Frontend source
│   ├── components/               # React components
│   │   ├── ui/                   # Enhanced UI components
│   │   ├── dashboard/            # Dashboard components
│   │   ├── medicines/            # Medicine components
│   │   └── ...
│   ├── pages/                    # Page components
│   ├── services/                 # API services
│   ├── store/                    # State management
│   ├── lib/                      # Utilities
│   ├── styles/                   # Design system
│   └── test/                     # Test files
├── server/                       # Backend source
│   ├── routes/                   # API routes
│   ├── models/                   # Database models
│   ├── middleware/               # Express middleware
│   ├── config/                   # Configuration
│   └── database/                 # Database schema
├── public/                       # Static assets
└── .kiro/specs/                  # Feature specifications
```

## 🎨 Design System

- **Theme**: Futuristic dark neon with glassmorphism
- **Colors**: Cyan, Violet, Magenta accents
- **Typography**: Inter font family
- **Spacing**: Consistent 8px grid system
- **Animations**: Smooth 200ms transitions

## 🔒 Security

- JWT-based authentication
- Password hashing with bcrypt
- CORS protection
- Input validation
- SQL injection prevention
- XSS protection

## 📊 Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+
- Mobile browsers (iOS Safari 14+, Chrome Mobile 90+)

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Gowtham**
- GitHub: [@Gowtham-gangster](https://github.com/Gowtham-gangster)

## 🙏 Acknowledgments

- Radix UI for accessible components
- Tailwind CSS for styling system
- Tesseract.js for OCR capabilities
- All open-source contributors

---

**Made with ❤️ for better medication management**
