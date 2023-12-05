-- 1
INSERT INTO Borrowing (ReaderNr, ISBN, CopyNumber)
VALUES (
    (SELECT id FROM Reader WHERE FirstName = 'Василий' AND LastName = 'Петров'),
    '123456',
    4
);

-- 2
DELETE FROM Book
WHERE PubYear > 2000;

-- 3
UPDATE Borrowing
SET ReturnDate = ReturnDate + 30
WHERE ISBN IN (SELECT ISBN FROM BookCat WHERE CategoryName = 'Базы данных') AND ReturnDate >= '2016-01-01';

SELECT * from borrowing