-- 1
SELECT (CHAR_LENGTH(name) + LENGTH(race)) AS calculation
FROM demographics;

-- 2
SELECT id, BIT_LENGTH(name) AS name, birthday, BIT_LENGTH(race) AS race
FROM demographics;

-- 3
SELECT id, ASCII(SUBSTRING(name FROM 1 FOR 1)) AS name, birthday, ASCII(SUBSTRING(race FROM 1 FOR 1)) AS race
FROM demographics;

-- 4
SELECT CONCAT_WS(' ', prefix, first, last, suffix) AS title
FROM names;

-- 5
SELECT
    RPAD(md5, LENGTH(sha256), '1') AS md5,
    LPAD(sha1, LENGTH(sha256), '0') AS sha1,
    sha256
FROM encryption;

-- 6
SELECT 
    SUBSTRING(project FROM 1 FOR commits) AS project,
    RIGHT(address, contributors) AS address
FROM repositories;

-- 7
SELECT 
    project,
    commits,
    contributors,
    REGEXP_REPLACE(address, '\d', '!') AS address
FROM repositories;

-- 8
SELECT
    name,
    weight,
    price,
    ROUND((price / (weight / 1000))::numeric, 2) AS price_per_kg
FROM products
ORDER BY price_per_kg ASC, name ASC;
