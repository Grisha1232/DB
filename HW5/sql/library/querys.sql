-- a)

SELECT lastname FROM reader WHERE address LIKE '%Москва%';

-- б)

SELECT author, title FROM book b, borrowing br, reader r
                     WHERE r.id = br.readernr AND
                           r.firstname = 'Иван' AND
                           r.lastname = 'Иванов' AND
                           b.isbn = br.isbn

-- в)



-- г)

SELECT

-- д)


