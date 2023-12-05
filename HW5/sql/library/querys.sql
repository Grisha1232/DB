-- a)

SELECT lastname FROM reader WHERE address LIKE '%Москва%';

-- б)

SELECT DISTINCT book.Author, book.Title
FROM borrowing
JOIN reader ON borrowing.ReaderNr = reader.ID
JOIN book ON borrowing.ISBN = book.ISBN
WHERE reader.FirstName = 'Иван' AND reader.LastName = 'Иванов';


-- в)

SELECT DISTINCT bookcat.ISBN
FROM bookcat
JOIN category ON bookcat.CategoryName = category.CategoryName
WHERE category.CategoryName = 'Горы'
AND NOT EXISTS (
    SELECT *
    FROM bookcat AS BC2
    WHERE BC2.ISBN = bookcat.ISBN
    AND BC2.CategoryName = 'Путешествия'
);


-- г)

SELECT DISTINCT reader.LastName, reader.FirstName
FROM borrowing
JOIN reader ON borrowing.ReaderNr = reader.ID
WHERE borrowing.ReturnDate IS NOT NULL;


-- д)

SELECT DISTINCT R1.LastName, R1.FirstName
FROM borrowing AS B1
JOIN borrowing AS B2 ON B1.ISBN = B2.ISBN AND B1.CopyNumber = B2.CopyNumber
JOIN reader AS R1 ON B1.ReaderNr = R1.ID
JOIN reader AS R2 ON B2.ReaderNr = R2.ID
WHERE R1.LastName != 'Иванов' AND R1.FirstName != 'Иван'
AND R2.LastName = 'Иванов' AND R2.FirstName = 'Иван';

