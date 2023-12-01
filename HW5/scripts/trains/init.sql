\c trains

CREATE TABLE city (
    Name varchar,
    Region varchar,
    PRIMARY KEY (Name, Region)
);

CREATE TABLE Station (
    Name varchar,
    TracksNr integer,
    CityName varchar,
    Region varchar,

    PRIMARY KEY (Name),
    FOREIGN KEY (CityName, Region) REFERENCES city (Name, Region)
);

CREATE TABLE Train (
    TrainNr integer,
    Length integer,
    StartStationName varchar,
    EndStationName varchar,

    PRIMARY KEY (TrainNr),
    FOREIGN KEY (StartStationName) REFERENCES Station (Name),
    FOREIGN KEY (EndStationName) REFERENCES Station (Name)
);

CREATE TABLE Connection (
    FromStation varchar,
    ToStation varchar,
    TrainNr integer,
    Departure date,
    Arrival date,

    FOREIGN KEY (TrainNr) REFERENCES Train (TrainNr),
    FOREIGN KEY (FromStation) REFERENCES Station (Name),
    FOREIGN KEY (ToStation) REFERENCES Station (Name)
);
