\c library;

CREATE TABLE Reader(
    ID integer NOT NULL,
    LastName varchar NOT NULL,
    FirstName varchar NOT NULL,
    Address varchar NOT NULL,
    BirthDate date,
    PRIMARY KEY(ID)
);

CREATE TABLE Publisher(
    PubName varchar,
    PubKind varchar,

    PRIMARY KEY (PubName)
);


CREATE TABLE Book(
    ISBN integer,
    Title varchar,
    Author varchar,
    PagesNum integer,
    PubYear integer,
    PubName varchar,

    PRIMARY KEY(ISBN),
    FOREIGN KEY(PubName) REFERENCES Publisher (PubName)
);



CREATE TABLE Category(
    CategoryName varchar,
    ParentCat varchar,

    PRIMARY KEY (CategoryName),
    FOREIGN KEY (ParentCat) REFERENCES Category (CategoryName)
);

CREATE TABLE Copy(
    ISBN integer,
    CopyNumber integer,
    Shelf varchar,
    Position integer,

    PRIMARY KEY (ISBN, CopyNumber),
    FOREIGN KEY (ISBN) REFERENCES Book (ISBN)
);

CREATE TABLE Borrowing(
    ReaderNr integer,
    ISBN integer,
    CopyNumber integer,
    ReturnDate date,

    FOREIGN KEY (ReaderNr) REFERENCES Reader (ID),
    FOREIGN KEY (ISBN, CopyNumber) REFERENCES Copy (ISBN, CopyNumber)
);

CREATE TABLE BookCat(
    ISBN integer,
    CategoryName varchar,

    FOREIGN KEY (ISBN) REFERENCES Book (ISBN),
    FOREIGN KEY (CategoryName) REFERENCES Category (CategoryName)
);

-- Издатели
INSERT INTO Publisher (PubName, PubKind)
VALUES
  ('Издательство1', 'Адрес1'),
  ('Издательство2', 'Адрес2'),
  ('Издательство3', 'Адрес3');


-- Читатели
INSERT INTO Reader (ID, LastName, FirstName, Address, BirthDate)
VALUES
  (1, 'Иванов', 'Иван', 'Москва', '1990-01-01'),
  (2, 'Петров', 'Петр', 'Санкт-Петербург', '1985-05-15'),
  (3, 'Сидорова', 'Мария', 'Москва', '1995-07-20');

-- Книги
INSERT INTO Book (ISBN, Title, Author, PagesNum, PubYear, PubName)
VALUES
  (111111, 'Горы мира', 'Автор1', 300, 2020, 'Издательство1'),
  (222222, 'Морские приключения', 'Автор2', 250, 2018, 'Издательство2'),
  (333333, 'Путешествия по странам', 'Автор3', 400, 2019, 'Издательство3');

-- Категории
INSERT INTO Category (CategoryName, ParentCat)
VALUES
  ('Горы', NULL),
  ('Море', NULL),
  ('Путешествия', NULL);

-- Книги-категории
INSERT INTO BookCat (ISBN, CategoryName)
VALUES
  (111111, 'Горы'),
  (222222, 'Море'),
  (333333, 'Путешествия');

-- Копии книг
INSERT INTO Copy (ISBN, CopyNumber, Shelf, Position)
VALUES
  (111111, 1, 'A', 1),
  (222222, 1, 'B', 2),
  (333333, 1, 'C', 3);

-- Займы книг
INSERT INTO Borrowing (ReaderNr, ISBN, CopyNumber, ReturnDate)
VALUES
  (1, 111111, 1, '2022-01-15'),
  (2, 222222, 1, '2022-02-01'),
  (3, 333333, 1, NULL),
  (1, 222222, 1, '2022-02-28');

