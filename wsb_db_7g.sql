-- -- -------------------------------------------------------------------------------
-- -- Zadanie DB
-- -- -------------------------------------------------------------------------------

-- -- -------------------------------------------------------------------------------
-- Section: setting sql_mode
-- -- -------------------------------------------------------------------------------
SET sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

--
-- Current Database: `wsb_db`
--

-- -- -------------------------------------------------------------------------------
-- Section: USE
-- -- -------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS wsb_db;
CREATE SCHEMA wsb_db DEFAULT CHARACTER SET UTF8MB4;
USE wsb_db;

DROP TABLE ID EXISTS 'university';

CREEATE TABLE 'university'(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200)

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
