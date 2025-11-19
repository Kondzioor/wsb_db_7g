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
        `name` VARCHAR(300) UNIQUE NOT NULL,
        `address` VARCHAR(300) NOT NULL,
        `zip_code` VARCHAR(20) NOT NULL,
        `city` VARCHAR(100) NOT NULL,
        `phone` VARCHAR(20) NOT NULL,
        `email` VARCHAR(100) UNIQUE NOT NULL, --main_email
        `website` VARCHAR(100) UNIQUE NOT NULL,
        `rector_name` VARCHAR(50) NOT NULL,
        `rector_surname` VARCHAR(50) NOT NULL,
        `dean_name` VARCHAR(50) NOT NULL,
        `dean_surname` VARCHAR(50) NOT NULL,
        `secretariat_phone` VARCHAR(20) NOT NULL,
        `secretariat_email` VARCHAR(100) UNIQUE NOT NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -- -------------------------------------------------------------------------------
DROP TABLE IF EXISTS `teaching_staff`;

CREATE TABLE
    `teaching_staff` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(50) NOT NULL,
        `surname` VARCHAR(50) NOT NULL,
        `sex` ENUM ('unknown', 'male', 'female', 'other') DEFAULT 'unknown',
        `pesel` VARCHAR(11) UNIQUE NOT NULL,
        `email` VARCHAR(100) UNIQUE NOT NULL,
        `phone` VARCHAR(20) NOT NULL,
        `street` VARCHAR(100) NOT NULL,
        `house_number` VARCHAR(10) NOT NULL,
        `apartment_number` VARCHAR(10) DEFAULT NULL,
        `zip_code` VARCHAR(20) NOT NULL,
        `city` VARCHAR(100) NOT NULL,
        `hire_date` DATE NOT NULL,
        `termination_date` DATE DEFAULT NULL,
        `account_number` VARCHAR(34) UNIQUE NOT NULL,
        `degree` ENUM (
            'engineer',
            'master',
            'doctor',
            'professor',
            'other'
        ) DEFAULT 'other' `university_id` INT NOT NULL, -- i'm not sure
        FOREIGN KEY (`university_id`) REFERENCES `university` (`id`),
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `courses`;

CREATE TABLE
    `courses` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `name` VARCHAR(200) NOT NULL,
        `code` VARCHAR(20) UNIQUE NOT NULL,
        `ects` INT NOT NULL,
        `description` TEXT DEFAULT NULL,
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `students`;

CREATE TABLE
    `students` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        'number_index' VARCHAR(20) UNIQUE NOT NULL,
        `name` VARCHAR(50) NOT NULL,
        `surname` VARCHAR(50) NOT NULL,
        `sex` ENUM ('unknown', 'male', 'female', 'other') DEFAULT 'unknown',
        `pesel` VARCHAR(11) UNIQUE NOT NULL,
        'birth_date' DATE NOT NULL,
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