-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 22, 2026 at 06:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barbershop_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(10) UNSIGNED NOT NULL,
  `appointment_code` varchar(20) DEFAULT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `barber_id` int(10) UNSIGNED DEFAULT NULL,
  `preferred_barber_id` int(10) UNSIGNED DEFAULT NULL,
  `service_id` int(10) UNSIGNED NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_start_time` time DEFAULT NULL,
  `appointment_end_time` time DEFAULT NULL,
  `requested_time` time DEFAULT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `booking_type` enum('Auto Booking','Reservation') NOT NULL DEFAULT 'Auto Booking',
  `appointment_status` enum('Pending','Confirmed','Waiting','Completed','Cancelled','No Show') NOT NULL DEFAULT 'Pending',
  `status_updated_at` timestamp NULL DEFAULT current_timestamp(),
  `customer_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `appointment_code`, `customer_id`, `barber_id`, `preferred_barber_id`, `service_id`, `appointment_date`, `appointment_start_time`, `appointment_end_time`, `requested_time`, `check_in_time`, `booking_type`, `appointment_status`, `status_updated_at`, `customer_notes`, `created_at`, `updated_at`) VALUES
(1, 'BC-508B5E', 2, 3, NULL, 1, '2026-09-22', '08:00:00', '08:30:00', NULL, '2026-09-21 11:58:05', 'Auto Booking', 'No Show', '2026-09-21 16:45:42', '', '2026-09-21 03:38:52', '2026-09-21 16:45:42'),
(2, 'BC-A3B4D3', 3, 1, NULL, 1, '2026-09-22', '08:00:00', '08:30:00', NULL, NULL, 'Auto Booking', 'No Show', '2026-09-21 16:45:40', '', '2026-09-21 03:56:20', '2026-09-21 16:45:40'),
(3, 'BC-F0D23D', 3, 2, NULL, 1, '2026-09-22', '13:00:00', '13:30:00', NULL, NULL, 'Auto Booking', 'Cancelled', '2026-09-21 17:07:20', '', '2026-09-21 16:48:05', '2026-09-21 17:07:20'),
(4, 'BC-3B57D8', 4, 1, NULL, 1, '2026-09-22', '08:00:00', '08:30:00', NULL, NULL, 'Auto Booking', 'Cancelled', '2026-09-21 17:07:19', '', '2026-09-21 16:50:41', '2026-09-21 17:07:19'),
(5, 'BC-D2780F', 3, 1, NULL, 1, '2026-09-22', '12:30:00', '13:00:00', NULL, NULL, 'Auto Booking', 'Cancelled', '2026-09-22 04:24:51', '', '2026-09-22 04:20:45', '2026-09-22 04:24:51'),
(6, 'BC-415447', 3, 1, NULL, 1, '2026-09-22', '12:30:00', '13:00:00', NULL, NULL, 'Auto Booking', 'Pending', '2026-09-22 04:26:31', '', '2026-09-22 04:26:31', '2026-09-22 04:26:31'),
(7, 'BC-3F3241', 4, 3, NULL, 1, '2026-09-22', '12:30:00', '13:00:00', NULL, NULL, 'Auto Booking', 'Cancelled', '2026-09-22 04:29:45', '', '2026-09-22 04:29:39', '2026-09-22 04:29:45');

-- --------------------------------------------------------

--
-- Table structure for table `barbers`
--

CREATE TABLE `barbers` (
  `barber_id` int(10) UNSIGNED NOT NULL,
  `barber_name` varchar(100) NOT NULL,
  `barber_description` text DEFAULT NULL,
  `barber_image` varchar(255) DEFAULT NULL,
  `barber_status` enum('Available','Busy','Offline') NOT NULL DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barbers`
--

INSERT INTO `barbers` (`barber_id`, `barber_name`, `barber_description`, `barber_image`, `barber_status`, `created_at`, `updated_at`) VALUES
(1, 'Juan Dela Cruz', 'Senior barber specializing in modern and classic haircuts.', NULL, 'Available', '2026-09-21 03:25:52', '2026-09-21 03:25:52'),
(2, 'Mark Santos', 'Professional barber specializing in fades and beard grooming.', NULL, 'Available', '2026-09-21 03:25:52', '2026-09-21 03:25:52'),
(3, 'Carlo Reyes', 'Barber specializing in premium styling and modern cuts.', NULL, 'Available', '2026-09-21 03:25:52', '2026-09-21 03:25:52'),
(4, 'Jay desu', 'Professional barber', NULL, 'Available', '2026-09-21 16:46:15', '2026-09-21 16:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `barber_schedules`
--

CREATE TABLE `barber_schedules` (
  `barber_schedule_id` int(10) UNSIGNED NOT NULL,
  `barber_id` int(10) UNSIGNED NOT NULL,
  `schedule_day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `schedule_status` enum('Available','Day Off') NOT NULL DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barber_schedules`
--

INSERT INTO `barber_schedules` (`barber_schedule_id`, `barber_id`, `schedule_day`, `start_time`, `end_time`, `schedule_status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Monday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(2, 1, 'Tuesday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(3, 1, 'Wednesday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(4, 1, 'Thursday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(5, 1, 'Friday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(6, 1, 'Saturday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(7, 2, 'Monday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(8, 2, 'Tuesday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(9, 2, 'Wednesday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(10, 2, 'Thursday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(11, 2, 'Friday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(12, 2, 'Saturday', '08:00:00', '19:00:00', 'Available', '2026-09-21 03:26:00', '2026-09-21 03:26:00'),
(20, 3, 'Monday', '08:00:00', '19:00:00', 'Available', '2026-09-22 04:19:43', '2026-09-22 04:19:43'),
(21, 3, 'Tuesday', '08:00:00', '19:00:00', 'Available', '2026-09-22 04:19:43', '2026-09-22 04:19:43'),
(22, 3, 'Wednesday', '08:00:00', '19:00:00', 'Available', '2026-09-22 04:19:43', '2026-09-22 04:19:43'),
(23, 3, 'Thursday', '08:00:00', '19:00:00', 'Available', '2026-09-22 04:19:43', '2026-09-22 04:19:43'),
(24, 3, 'Friday', '08:00:00', '19:00:00', 'Available', '2026-09-22 04:19:43', '2026-09-22 04:19:43'),
(25, 3, 'Saturday', '08:00:00', '19:00:00', 'Available', '2026-09-22 04:19:43', '2026-09-22 04:19:43');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `contact_message_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email_address` varchar(150) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `subject` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `message_status` enum('New','Read','Replied') NOT NULL DEFAULT 'New',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`contact_message_id`, `full_name`, `email_address`, `phone_number`, `subject`, `message`, `message_status`, `created_at`) VALUES
(1, 'shen', 'shen@gmail.com', '09098717619', 'concern', 'paki ayos po ng payment', 'New', '2026-09-22 04:30:22');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `customer_role` enum('Customer','Administrator') NOT NULL DEFAULT 'Customer',
  `account_status` enum('Active','Inactive','Blocked') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `full_name`, `phone_number`, `email_address`, `password_hash`, `profile_image`, `date_of_birth`, `customer_role`, `account_status`, `created_at`, `updated_at`) VALUES
(1, 'Shop Administrator', '09999999999', 'admin@thebarberco.com', '$2y$10$Qa/azL1lBRL0/gLw2u/xJeoEsWarX6pf4nvyPo.rWB81hRWYIIte2', NULL, NULL, 'Administrator', 'Active', '2026-09-21 03:25:42', '2026-09-21 03:25:42'),
(2, 'Jay Moreno', '09098717619', 'benedictmoreno21@gmail.com', '$2y$10$AcvVWojF5GRxFeTIq5d9OuSJ8qWMzFs.EQctpaUOVqOlLv3tUCp8C', NULL, '2016-08-01', 'Customer', 'Active', '2026-09-21 03:37:27', '2026-09-21 03:37:27'),
(3, 'kei', '09098717612', 'kei@gmail.com', '$2y$10$OtmpPqQ4moIBCRek8Q1Ja.s3Qjhn.1eyc9wuD8KF.UvgN1rL85E5q', NULL, '2005-08-01', 'Customer', 'Active', '2026-09-21 03:55:13', '2026-09-21 03:55:13'),
(4, 'shen', '09097654318', 'shen@gmail.com', '$2y$10$cD.zL6V0jCBWte2BIw31J.8sXpij0vn4zimoWy0dQz9eAlXWMM30q', NULL, '2006-08-01', 'Customer', 'Active', '2026-09-21 16:49:41', '2026-09-21 16:49:41');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `holiday_id` int(10) UNSIGNED NOT NULL,
  `holiday_date` date NOT NULL,
  `holiday_name` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(10) UNSIGNED NOT NULL,
  `appointment_id` int(10) UNSIGNED NOT NULL,
  `payment_method` enum('GCash','PayMaya','Cash') NOT NULL,
  `payment_purpose` enum('Reservation Fee','Full Payment') NOT NULL DEFAULT 'Full Payment',
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_reference_number` varchar(100) DEFAULT NULL,
  `payment_proof_image` varchar(255) DEFAULT NULL,
  `payment_status` enum('Pending','Verified','Rejected','Refunded') NOT NULL DEFAULT 'Pending',
  `admin_notes` varchar(255) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `appointment_id`, `payment_method`, `payment_purpose`, `payment_amount`, `payment_reference_number`, `payment_proof_image`, `payment_status`, `admin_notes`, `paid_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cash', 'Full Payment', 150.00, NULL, NULL, 'Verified', '', '2026-09-21 03:40:29', '2026-09-21 03:39:44', '2026-09-21 03:40:29'),
(2, 2, 'GCash', 'Full Payment', 150.00, '123123123123123', 'proof_2_1789963047_81d3c66a.png', 'Verified', '', '2026-09-21 03:57:51', '2026-09-21 03:57:27', '2026-09-21 03:57:51'),
(3, 5, 'GCash', 'Full Payment', 150.00, '123123123123123', 'proof_5_1790050922_b6768f61.png', 'Verified', '', '2026-09-22 04:22:35', '2026-09-22 04:22:02', '2026-09-22 04:22:35'),
(4, 6, 'GCash', 'Full Payment', 150.00, '123123123123123', 'proof_6_1790051204_aa38f77a.png', 'Pending', NULL, NULL, '2026-09-22 04:26:44', '2026-09-22 04:26:44');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(10) UNSIGNED NOT NULL,
  `service_name` varchar(150) NOT NULL,
  `service_description` text DEFAULT NULL,
  `service_price` decimal(10,2) NOT NULL,
  `estimated_duration_minutes` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `service_image` varchar(255) DEFAULT NULL,
  `service_status` enum('Available','Unavailable') NOT NULL DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `service_name`, `service_description`, `service_price`, `estimated_duration_minutes`, `service_image`, `service_status`, `created_at`, `updated_at`) VALUES
(1, 'Haircut', 'A clean and professional haircut customized to your preferred style.', 150.00, 30, NULL, 'Available', '2026-09-21 03:26:06', '2026-09-21 03:26:06'),
(2, 'Haircut + Beard', 'Complete haircut paired with professional beard grooming and shaping.', 200.00, 30, NULL, 'Available', '2026-09-21 03:26:06', '2026-09-21 17:13:49'),
(3, 'Haircut with Pomade and Beard Shave', 'Haircut, clean beard shave, and finished off with premium pomade styling.', 250.00, 30, NULL, 'Available', '2026-09-21 03:26:06', '2026-09-21 17:13:53'),
(4, 'Haircut with Pomade, Shampoo, and Beard Shave', 'Full haircut, relaxing shampoo wash, beard shave, and pomade styling.', 300.00, 60, NULL, 'Available', '2026-09-21 03:26:06', '2026-09-21 03:26:06'),
(5, 'Premium Package', 'Our complete grooming experience: haircut, shampoo, beard shave, pomade styling, and hot towel finish.', 350.00, 60, NULL, 'Available', '2026-09-21 03:26:06', '2026-09-21 17:14:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD UNIQUE KEY `appointment_code` (`appointment_code`),
  ADD KEY `foreign_key_appointment_customer` (`customer_id`),
  ADD KEY `foreign_key_appointment_barber` (`barber_id`),
  ADD KEY `foreign_key_appointment_service` (`service_id`),
  ADD KEY `foreign_key_appointment_preferred_barber` (`preferred_barber_id`);

--
-- Indexes for table `barbers`
--
ALTER TABLE `barbers`
  ADD PRIMARY KEY (`barber_id`);

--
-- Indexes for table `barber_schedules`
--
ALTER TABLE `barber_schedules`
  ADD PRIMARY KEY (`barber_schedule_id`),
  ADD UNIQUE KEY `unique_barber_schedule` (`barber_id`,`schedule_day`,`start_time`,`end_time`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`contact_message_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `email_address` (`email_address`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`holiday_id`),
  ADD UNIQUE KEY `holiday_date` (`holiday_date`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `foreign_key_payment_appointment` (`appointment_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `barbers`
--
ALTER TABLE `barbers`
  MODIFY `barber_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `barber_schedules`
--
ALTER TABLE `barber_schedules`
  MODIFY `barber_schedule_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `contact_message_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `holiday_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`barber_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_4` FOREIGN KEY (`preferred_barber_id`) REFERENCES `barbers` (`barber_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `barber_schedules`
--
ALTER TABLE `barber_schedules`
  ADD CONSTRAINT `barber_schedules_ibfk_1` FOREIGN KEY (`barber_id`) REFERENCES `barbers` (`barber_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
