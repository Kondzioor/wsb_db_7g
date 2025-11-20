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
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(300) NOT NULL, -- full name of university
        `address` VARCHAR(300) NOT NULL,
        `zip_code` VARCHAR(20) NOT NULL,
        `city` VARCHAR(100) NOT NULL,
        `phone` VARCHAR(20) NOT NULL,
        `email` VARCHAR(100) NOT NULL,
        `website` VARCHAR(100) NOT NULL,
        `rector_name` VARCHAR(50) NOT NULL,
        `rector_surname` VARCHAR(50) NOT NULL,
        `dean_name` VARCHAR(50) NOT NULL,
        `dean_surname` VARCHAR(50) NOT NULL,
        `secretariat_phone` VARCHAR(20) NOT NULL,
        `secretariat_email` VARCHAR(100) NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `university_name_uq` (`name`),
        UNIQUE KEY `university_email_uq` (`email`),
        UNIQUE KEY `university_website_uq` (`website`),
        UNIQUE KEY `university_secretariat_email_uq` (`secretariat_email`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `lecturers`;

CREATE TABLE
    `lecturers` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(50) NOT NULL,
        `surname` VARCHAR(50) NOT NULL,
        `sex` ENUM ('unknown', 'male', 'female', 'other') DEFAULT 'unknown',
        `pesel` VARCHAR(11) NOT NULL, -- BLOB encryption?
        `email` VARCHAR(100) NOT NULL,
        `phone` VARCHAR(20) NOT NULL,
        `street` VARCHAR(100) NOT NULL,
        `house_number` VARCHAR(10) NOT NULL,
        `apartment_number` VARCHAR(10) DEFAULT NULL,
        `zip_code` VARCHAR(20) NOT NULL,
        `city` VARCHAR(100) NOT NULL,
        `hire_date` DATE NOT NULL,
        `termination_date` DATE DEFAULT NULL,
        `account_number` VARCHAR(26) NOT NULL,
        `degree` ENUM (
            'engineer',
            'master',
            'doctor',
            'professor',
            'other'
        ) DEFAULT 'other',
        `university_id` INT unsigned NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `lecturers_email_uq` (`email`),
        UNIQUE KEY `lecturers_pesel_uq` (`pesel`),
        UNIQUE KEY `lecturers_account_number_uq` (`account_number`),
        CONSTRAINT `lecturers_university_fk` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`)
        -- ON UPDATE CASCADE ON DELETE RESTRICT??
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `courses`;

CREATE TABLE
    `courses` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(200) NOT NULL,
        `code` VARCHAR(20) NOT NULL,
        `ects` TINYINT unsigned NOT NULL, -- chceck(ects > 0 and ects <= 30)   decimal(2,0)?
        `description` TEXT DEFAULT NULL,
        `university_id` INT unsigned NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `courses_name_uq` (`name`),
        UNIQUE KEY `courses_code_uq` (`code`),
        CONSTRAINT `courses_university_fk` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `students`;

CREATE TABLE
    `students` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `number_index` VARCHAR(20) NOT NULL,
        `name` VARCHAR(50) NOT NULL,
        `surname` VARCHAR(50) NOT NULL,
        `sex` ENUM ('unknown', 'male', 'female', 'other') DEFAULT 'unknown',
        `pesel` VARCHAR(11) NOT NULL, -- BLOB ?
        `birth_date` DATE NOT NULL,
        `university_id` INT unsigned NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `students_number_index_uq` (`number_index`),
        UNIQUE KEY `students_pesel_uq` (`pesel`),
        CONSTRAINT `students_university_fk` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `groups`;

CREATE TABLE
    `groups` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(100) NOT NULL,
        `year` INT NOT NULL,
        `lecturer_id` INT unsigned NOT NULL,
        `specialization` VARCHAR(100) NOT NULL,
        `university_id` INT unsigned NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `group_uq` (`name`, `year`), -- ?
        CONSTRAINT `groups_lecturer_fk` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`), --
        CONSTRAINT `groups_university_fk` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `student_groups`;

CREATE TABLE
    `student_groups` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `student_id` INT unsigned NOT NULL,
        `group_id` INT unsigned NOT NULL,
        `enroll_date` DATE NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `student_group_uq` (`student_id`, `group_id`), --
        CONSTRAINT `student_groups_student_fk` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`), --
        CONSTRAINT `student_groups_group_fk` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `course_lecturers`;

CREATE TABLE
    `course_lecturers` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `course_id` INT unsigned NOT NULL,
        `lecturer_id` INT unsigned NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `course_lecturer_uq` (`course_id`, `lecturer_id`), --
        CONSTRAINT `course_lecturers_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`), --
        CONSTRAINT `course_lecturers_lecturer_fk` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `group_courses`;

CREATE TABLE
    `group_courses` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `group_id` INT unsigned NOT NULL,
        `course_id` INT unsigned NOT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `group_course_uq` (`group_id`, `course_id`), --
        CONSTRAINT `group_courses_group_fk` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`), --
        CONSTRAINT `group_courses_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `partial_grades`;

CREATE TABLE
    `partial_grades` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `student_id` INT unsigned NOT NULL,
        `course_id` INT unsigned NOT NULL,
        `group_course_id` INT unsigned NOT NULL,
        `grade` DECIMAL(2, 1) NOT NULL, -- check?   grade type? description?
        `date` DATE NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `partial_grades_student_fk` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`), --
        CONSTRAINT `partial_grades_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`), --
        CONSTRAINT `partial_grades_group_course_fk` FOREIGN KEY (`group_course_id`) REFERENCES `group_courses` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `final_grades`;

CREATE TABLE
    `final_grades` (
        `id` INT unsigned NOT NULL AUTO_INCREMENT,
        `student_id` INT unsigned NOT NULL,
        `course_id` INT unsigned NOT NULL,
        `group_course_id` INT unsigned NOT NULL,
        `grade` DECIMAL(2, 1) NOT NULL, -- enum('passed','failed', pending) DEFAULT pending ?
        `date` DATE NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `final_grades_student_fk` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`), -- on update cascade? on delete restrict?
        CONSTRAINT `final_grades_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`), --
        CONSTRAINT `final_grades_group_course_fk` FOREIGN KEY (`group_course_id`) REFERENCES `group_courses` (`id`) --
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;