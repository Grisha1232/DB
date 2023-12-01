\c library;

CREATE TABLE Reader(
    ID BIGSERIAL NOT NULL,
    LastName varchar NOT NULL,
    FirstName varchar NOT NULL,
    Address varchar NOT NULL,
    BirthDate date,
    PRIMARY KEY(ID)
);

CREATE TABLE Publisher(
    PubName varchar,
    PubKind INTEGER,

    PRIMARY KEY (PubName)
);


CREATE TABLE Book(
    ISBN INTEGER,
    Title varchar,
    Author varchar,
    PagesNum INTEGER,
    PubYear date,
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
    ISBN INTEGER,
    CopyNumber INTEGER,
    Shelf INTEGER,
    Position INTEGER,

    PRIMARY KEY (ISBN, CopyNumber),
    FOREIGN KEY (ISBN) REFERENCES Book (ISBN)
);

CREATE TABLE Borrowing(
    ReaderNr INTEGER,
    ISBN INTEGER,
    CopyNumber INTEGER,
    ReturnDate date,

    FOREIGN KEY (ReaderNr) REFERENCES Reader (ID),
    FOREIGN KEY (ISBN, CopyNumber) REFERENCES Copy (ISBN, CopyNumber)
);

CREATE TABLE BookCat(
    ISBN INTEGER,
    CategoryName varchar,

    FOREIGN KEY (ISBN) REFERENCES Book (ISBN),
    FOREIGN KEY (CategoryName) REFERENCES Category (CategoryName)
);
