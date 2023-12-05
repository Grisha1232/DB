-- 1
SELECT Book.Title, Publisher.PubName
FROM Book
JOIN Publisher ON Book.PubName = Publisher.PubName;

-- 2
SELECT Title
FROM Book
ORDER BY PagesNum DESC
LIMIT 1;

-- 3
SELECT Author, COUNT(*) AS BookCount
FROM Book
GROUP BY Author
HAVING COUNT(*) > 5;

-- 4
SELECT Title
FROM Book
WHERE PagesNum > 2 * (SELECT AVG(PagesNum) FROM Book);

-- 5
SELECT DISTINCT ParentCat
FROM Category
WHERE ParentCat IS NOT NULL;

--6
SELECT Author, COUNT(*) AS BookCount
FROM Book
GROUP BY Author
ORDER BY BookCount DESC
LIMIT 1;

-- 7
SELECT ReaderNr
FROM Borrowing
WHERE ISBN IN (SELECT ISBN FROM Book WHERE Author = 'Марк Твен')
GROUP BY ReaderNr
HAVING COUNT(DISTINCT ISBN) = (SELECT COUNT(*) FROM Book WHERE Author = 'Марк Твен');

-- 8
SELECT ISBN, COUNT(*) AS CopyCount
FROM Copy
GROUP BY ISBN
HAVING COUNT(*) > 1;

-- 9
SELECT Title, PubYear
FROM Book
ORDER BY PubYear
LIMIT 10;

-- 10
WITH RECURSIVE CategoryHierarchy AS (
    SELECT CategoryName, ParentCat
    FROM Category
    WHERE ParentCat = 'Спорт'
    UNION
    SELECT c.CategoryName, c.ParentCat
    FROM Category c
    JOIN CategoryHierarchy ch ON c.ParentCat = ch.CategoryName
)
SELECT DISTINCT CategoryName
FROM CategoryHierarchy;



