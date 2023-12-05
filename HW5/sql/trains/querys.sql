
SELECT * FROM connection;
SELECT * FROM station;
--a)

SELECT DISTINCT TrainNr, Departure, Arrival
FROM connection
WHERE fromstation IN (SELECT name FROM station WHERE cityname = 'Москва') AND
      tostation IN (SELECT name FROM station WHERE cityname = 'Тверь');

SELECT C.FromStation, C.ToStation, C.TrainNr, C.Departure, C.Arrival
FROM Connection C
JOIN Station StartStation ON C.FromStation = StartStation.Name AND StartStation.CityName = 'Москва'
JOIN Station EndStation ON C.ToStation = EndStation.Name AND EndStation.CityName = 'Тверь';

--б)


SELECT DISTINCT c1.fromstation, c2.tostation, c1.departure, c2.arrival
FROM connection c1
JOIN connection c2 ON c1.tostation = c2.fromstation
WHERE c1.fromstation IN (SELECT name FROM station WHERE cityname = 'Москва') AND
      c2.tostation IN (SELECT name FROM station WHERE cityname = 'Санкт-Петербург')



