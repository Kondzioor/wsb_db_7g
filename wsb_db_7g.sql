-- -- -------------------------------------------------------------------------------
-- -- Zadanie DB
-- -- -------------------------------------------------------------------------------
-- -- -------------------------------------------------------------------------------
-- Section: setting sql_mode
-- -- -------------------------------------------------------------------------------
SET
    sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

--
-- Current Database: `wsb_db`
--
-- -- -------------------------------------------------------------------------------
-- Section: USE
-- -- -------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS wsb_db;

CREATE SCHEMA wsb_db DEFAULT CHARACTER
SET
    UTF8MB4;

USE wsb_db;

DROP TABLE IF EXISTS `university`;

CREATE TABLE
    `university` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(300) NOT NULL,
        `address` VARCHAR(300) NOT NULL,
        `zip_code` VARCHAR(20) NOT NULL,
        `city` VARCHAR(100) NOT NULL,
        `phone` VARCHAR(20) NOT NULL,
        `email` VARCHAR(100) NOT NULL, --main_email
        `website` VARCHAR(100) NOT NULL,
        `rector_name` VARCHAR(50) NOT NULL,
        `rector_surname` VARCHAR(50) NOT NULL,
        `dean_name` VARCHAR(50) NOT NULL,
        `dean_surname` VARCHAR(50) NOT NULL,
        `secretariat_phone` VARCHAR(20) NOT NULL,
        `secretariat_email` VARCHAR(100) NOT NULL,
        UNIQUE KEY `university_name_uq` (`name`),
        UNIQUE KEY `university_email_uq` (`email`),
        UNIQUE KEY `university_website_uq` (`website`),
        UNIQUE KEY `university_secretariat_email_uq` (`secretariat_email`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -- -------------------------------------------------------------------------------
DROP TABLE IF EXISTS `teaching_staff`;

CREATE TABLE
    `teaching_staff` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(50) NOT NULL,
        `surname` VARCHAR(50) NOT NULL,
        `sex` ENUM ('unknown', 'male', 'female', 'other') DEFAULT 'unknown',
        `pesel` VARCHAR(11) NOT NULL,
        `email` VARCHAR(100) NOT NULL,
        `phone` VARCHAR(20) NOT NULL,
        `street` VARCHAR(100) NOT NULL,
        `house_number` VARCHAR(10) NOT NULL,
        `apartment_number` VARCHAR(10) DEFAULT NULL,
        `zip_code` VARCHAR(20) NOT NULL,
        `city` VARCHAR(100) NOT NULL,
        `hire_date` DATE NOT NULL,
        `termination_date` DATE DEFAULT NULL,
        `account_number` VARCHAR(34) NOT NULL,
        `degree` ENUM (
            'engineer',
            'master',
            'doctor',
            'professor',
            'other'
        ) DEFAULT 'other',
        UNIQUE KEY `teaching_staff_email_uq` (`email`),
        UNIQUE KEY `teaching_staff_pesel_uq` (`pesel`),
        UNIQUE KEY `teaching_staff_account_number_uq` (`account_number`),
        -- `university_id` INT NOT NULL, -- i'm not sure
        -- FOREIGN KEY (`university_id`) REFERENCES `university` (`id`),
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `courses`;

CREATE TABLE
    `courses` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(200) NOT NULL,
        `code` VARCHAR(20) NOT NULL,
        `ects` INT NOT NULL,
        `description` TEXT DEFAULT NULL,
        UNIQUE KEY `courses_name_uq` (`name`),
        UNIQUE KEY `courses_code_uq` (`code`),
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `students`;

CREATE TABLE
    `students` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        'number_index' VARCHAR(20) NOT NULL,
        `name` VARCHAR(50) NOT NULL,
        `surname` VARCHAR(50) NOT NULL,
        `sex` ENUM ('unknown', 'male', 'female', 'other') DEFAULT 'unknown',
        `pesel` VARCHAR(11) NOT NULL,
        'birth_date' DATE NOT NULL,
        UNIQUE KEY `students_number_index_uq` (`number_index`),
        UNIQUE KEY `students_pesel_uq` (`pesel`),
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `groups`;

CREATE TABLE
    `groups` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(100) NOT NULL,
        `year` INT NOT NULL,
        `lecturer_id` INT NOT NULL,
        `specialization` VARCHAR(100) NOT NULL,
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `partial_grades`;

CREATE TABLE
    `partial_grades` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `student_id` INT NOT NULL,
        `course_id` INT NOT NULL,
        `grade` DECIMAL(3, 2) NOT NULL,
        `date` DATE NOT NULL,
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `final_grades`;

CREATE TABLE
    `final_grades` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `student_id` INT NOT NULL,
        `course_id` INT NOT NULL,
        `grade` DECIMAL(3, 2) NOT NULL,
        `date` DATE NOT NULL,
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;