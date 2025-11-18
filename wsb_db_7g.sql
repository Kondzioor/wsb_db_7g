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

DROP TABLE ID EXISTS 'university';

CREEATE TABLE 'university' (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(300) UNIQUE NOT NULL,
    address VARCHAR(300) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, --main_email
    website VARCHAR(100) UNIQUE NOT NULL,
    rector_name VARCHAR(50) NOT NULL,
    rector_surname VARCHAR(50) NOT NULL,
    dean_name VARCHAR(50) NOT NULL,
    dean_surname VARCHAR(50) NOT NULL,
    secretariat_phone VARCHAR(20) NOT NULL,
    secretariat_email VARCHAR(100) UNIQUE NOT NULL,
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;