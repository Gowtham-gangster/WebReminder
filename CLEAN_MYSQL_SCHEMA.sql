-- ============================================
-- WebReminder - Clean MySQL Database Schema
-- ============================================
-- Version: 1.0
-- Description: Simplified schema for medicine reminder system
-- ============================================

-- Drop database if exists (use with caution!)
-- DROP DATABASE IF EXISTS webreminder;

-- Create database
CREATE DATABASE IF NOT EXISTS webreminder;
USE webreminder;

-- ============================================
-- Table: users
-- Description: Store user account information
-- ============================================
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL COMMENT 'Hashed password using bcrypt',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: medicines
-- Description: Store medicine information
-- ============================================
CREATE TABLE medicines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    medicine_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(100) COMMENT 'e.g., 500mg, 2 tablets',
    frequency VARCHAR(100) COMMENT 'e.g., twice daily, every 8 hours',
    start_date DATE,
    end_date DATE,
    stock_quantity INT DEFAULT 0 COMMENT 'Number of doses remaining',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_medicine_name (medicine_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: schedules
-- Description: Store reminder schedules for medicines
-- ============================================
CREATE TABLE schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    time TIME NOT NULL COMMENT 'Time of day for reminder (e.g., 08:00:00)',
    days_of_week VARCHAR(50) COMMENT 'Comma-separated days: Mon,Tue,Wed,Thu,Fri,Sat,Sun',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    INDEX idx_medicine_id (medicine_id),
    INDEX idx_time (time),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: dose_logs
-- Description: Track medicine intake history
-- ============================================
CREATE TABLE dose_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    scheduled_time TIMESTAMP NOT NULL COMMENT 'When the dose was scheduled',
    taken_at TIMESTAMP NULL COMMENT 'When the dose was actually taken',
    status ENUM('taken', 'missed', 'skipped') DEFAULT 'missed',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    INDEX idx_medicine_id (medicine_id),
    INDEX idx_scheduled_time (scheduled_time),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: notifications
-- Description: Store user notifications
-- ============================================
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    medicine_id INT NULL,
    type VARCHAR(50) NOT NULL COMMENT 'e.g., reminder, low_stock, missed_dose',
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Insert Sample Data (Optional - for testing)
-- ============================================

-- Sample user (password: 'password123' hashed with bcrypt)
INSERT INTO users (name, email, password) VALUES
('John Doe', 'john@example.com', '$2b$10$rKvVLZ8L8L8L8L8L8L8L8OqN5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5Z5');

-- Sample medicines
INSERT INTO medicines (user_id, medicine_name, dosage, frequency, start_date, end_date, stock_quantity, notes) VALUES
(1, 'Aspirin', '100mg', 'Once daily', '2026-01-01', '2026-12-31', 90, 'Take with food'),
(1, 'Vitamin D', '1000 IU', 'Once daily', '2026-01-01', '2026-12-31', 60, 'Take in the morning');

-- Sample schedules
INSERT INTO schedules (medicine_id, time, days_of_week, is_active) VALUES
(1, '08:00:00', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun', TRUE),
(2, '09:00:00', 'Mon,Tue,Wed,Thu,Fri,Sat,Sun', TRUE);

-- Sample dose logs
INSERT INTO dose_logs (medicine_id, scheduled_time, taken_at, status, notes) VALUES
(1, '2026-01-01 08:00:00', '2026-01-01 08:05:00', 'taken', 'Taken on time'),
(1, '2026-01-02 08:00:00', NULL, 'missed', 'Forgot to take'),
(2, '2026-01-01 09:00:00', '2026-01-01 09:00:00', 'taken', NULL);

-- Sample notifications
INSERT INTO notifications (user_id, medicine_id, type, message, is_read) VALUES
(1, 1, 'reminder', 'Time to take Aspirin (100mg)', FALSE),
(1, 1, 'low_stock', 'Aspirin stock is running low (10 doses remaining)', FALSE);

-- ============================================
-- Useful Queries
-- ============================================

-- Get all medicines for a user
-- SELECT * FROM medicines WHERE user_id = 1;

-- Get today's schedule for a user
-- SELECT m.medicine_name, m.dosage, s.time 
-- FROM medicines m 
-- JOIN schedules s ON m.id = s.medicine_id 
-- WHERE m.user_id = 1 AND s.is_active = TRUE
-- ORDER BY s.time;

-- Get dose history for a medicine
-- SELECT * FROM dose_logs WHERE medicine_id = 1 ORDER BY scheduled_time DESC;

-- Get unread notifications for a user
-- SELECT * FROM notifications WHERE user_id = 1 AND is_read = FALSE ORDER BY created_at DESC;

-- Calculate adherence rate for a user
-- SELECT 
--     COUNT(CASE WHEN status = 'taken' THEN 1 END) * 100.0 / COUNT(*) as adherence_rate
-- FROM dose_logs dl
-- JOIN medicines m ON dl.medicine_id = m.id
-- WHERE m.user_id = 1;

-- ============================================
-- Database Maintenance
-- ============================================

-- Clean up old notifications (older than 30 days)
-- DELETE FROM notifications WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);

-- Clean up old dose logs (older than 1 year)
-- DELETE FROM dose_logs WHERE created_at < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- ============================================
-- End of Schema
-- ============================================
