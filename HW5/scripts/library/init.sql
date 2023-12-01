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
    PubKind integer,

    PRIMARY KEY (PubName)
);


CREATE TABLE Book(
    ISBN integer,
    Title varchar,
    Author varchar,
    PagesNum integer,
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
    ISBN integer,
    CopyNumber integer,
    Shelf integer,
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