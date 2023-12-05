## 1
Запросы лежат [здесь](https://github.com/Grisha1232/DB/blob/main/HW6/sql/task1.sql)

## 2
Запросы лежат [здесь](https://github.com/Grisha1232/DB/blob/main/HW6/sql/task2.sql)

## 3

* Student( MatrNr, Name, Semester )
* Check( MatrNr, LectNr, ProfNr, Note )
* Lecture( LectNr, Title, Credit, ProfNr )
* Professor( ProfNr, Name, Room )

1.
```sql
SELECT s.Name, s.MatrNr FROM Student s
WHERE NOT EXISTS (
SELECT * FROM Check c WHERE c.MatrNr = s.MatrNr AND c.Note >= 4.0 ) ;
```

Выбрать имена и номера студентов, у которых нет Note больше 4.0 
#
2.
```sql
( SELECT p.ProfNr, p.Name, sum(lec.Credit)
FROM Professor p, Lecture lec
WHERE p.ProfNr = lec.ProfNr
GROUP BY p.ProfNr, p.Name)
UNION
( SELECT p.ProfNr, p.Name, 0
FROM Professor p
WHERE NOT EXISTS (
SELECT * FROM Lecture lec WHERE lec.ProfNr = p.ProfNr ));
```

Выбрать номера и имена профессоров и сумму кредитов, если у профессора нет лекций, то вывести 0
#
3.
```sql
SELECT s.Name, с.Note
FROM Student s, Lecture lec, Check c
WHERE s.MatrNr = c.MatrNr AND lec.LectNr = c.LectNr AND c.Note >= 4
AND c.Note >= ALL (
SELECT c1.Note FROM Check c1 WHERE c1.MatrNr = c.MatrNr )
```

Выбрать имена и Note студентов, у которых note больше 4.0 и является максимальной среди его note
