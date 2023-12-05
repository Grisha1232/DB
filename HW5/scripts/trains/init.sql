\c trains

CREATE TABLE city (
    Name varchar,
    Region varchar,
    PRIMARY KEY (Name, Region)
);

CREATE TABLE Station (
    Name varchar,
    Tracks integer,
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

INSERT INTO city (Name, Region) VALUES
    ('Москва', 'Центральный'),
    ('Тверь', 'Центральный'),
    ('Санкт-Петербург', 'Северо-Западный');

INSERT INTO station (Name, Tracks, CityName, Region) VALUES
    ('Станция1', 3, 'Москва', 'Центральный'),
    ('Станция2', 2, 'Тверь', 'Центральный'),
    ('Станция3', 4, 'Санкт-Петербург', 'Северо-Западный');

INSERT INTO train (TrainNr, Length, StartStationName, EndStationName) VALUES
    (101, 200, 'Станция1', 'Станция2'),
    (102, 250, 'Станция2', 'Станция3');

INSERT INTO connection (FromStation, ToStation, TrainNr, Departure, Arrival) VALUES
    ('Станция1', 'Станция2', 101, '2023-01-01 08:00:00', '2023-01-01 12:00:00'),
    ('Станция2', 'Станция3', 102, '2023-01-01 14:00:00', '2023-01-01 18:00:00'),
    ('Станция1', 'Станция3', 101, '2023-01-01 10:00:00', '2023-01-01 16:00:00');