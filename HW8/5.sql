CREATE OR REPLACE FUNCTION GET_JOB_COUNT(emp_id INT) RETURNS INT AS
DECLARE
  job_count INT := 0;
BEGIN
  -- Обработка ошибок
  BEGIN
    -- Работа с PL/SQL-таблицей
    DECLARE
      TYPE job_id_table IS TABLE OF VARCHAR(50);
      job_ids job_id_table;
    BEGIN
      -- Получение уникальных job_id для сотрудника
      SELECT DISTINCT job_id
      BULK COLLECT INTO job_ids
      FROM JOB_HISTORY
      WHERE employee_id = emp_id;

      -- Исключение текущего job_id из результата
      FOR i IN 1..job_ids.COUNT LOOP
        IF job_ids(i) = (SELECT job_id FROM EMPLOYEES WHERE employee_id = emp_id) THEN
          CONTINUE;
        END IF;
        job_count := job_count + 1;
      END LOOP;
    END;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE EXCEPTION 'Invalid employee ID.';
  END;

  RETURN job_count;
END;
/

-- Вызов функции
DO $$ 
BEGIN 
  DBMS_OUTPUT.PUT_LINE(GET_JOB_COUNT(176)); 
END $$;
