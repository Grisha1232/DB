\c ambulance


CREATE TABLE Station (
    StatNr integer,
    Name varchar,

    PRIMARY KEY (StatNr)
);

CREATE TABLE StationsPersonal (
    PersonNr integer,
    Name varchar,
    StatNr integer,

    PRIMARY KEY (PersonNr),
    FOREIGN KEY (StatNr)
        REFERENCES Station (StatNr)
);

CREATE TABLE Doctor (
    PersonNr integer,
    Name varchar,
    StatNr integer,
    Area varchar,
    Rang varchar,

    PRIMARY KEY (PersonNr),

    FOREIGN KEY (PersonNr)
                    REFERENCES StationsPersonal (PersonNr),
    FOREIGN KEY (StatNr)
                    REFERENCES Station (StatNr)
);

CREATE TABLE Caregivers (
    PersonNr integer,
    Name varchar,
    StatNr integer,
    Qualification varchar,

    PRIMARY KEY (PersonNr),
    FOREIGN KEY (PersonNr)
                        REFERENCES StationsPersonal (PersonNr),
    FOREIGN KEY (StatNr)
                        REFERENCES Station (StatNr)
);

CREATE TABLE Room(
    StatNr integer,
    RoomNr integer,
    BedsNr integer,

    PRIMARY KEY (RoomNr)
);

CREATE TABLE Patient (
    PatientNr integer,
    Name varchar,
    Disease varchar,
    RoomNr integer,
    "from" date,
    "to" date,

    PRIMARY KEY (PatientNr),
    FOREIGN KEY (RoomNr)
                     REFERENCES Room (RoomNr)
);

CREATE TABLE Treats (
    PatientNr integer,
    PersonNr integer,

    FOREIGN KEY (PatientNr)
                    REFERENCES Patient (PatientNr),
    FOREIGN KEY (PersonNr)
                    REFERENCES StationsPersonal (PersonNr)
);