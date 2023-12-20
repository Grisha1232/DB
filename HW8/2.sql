CREATE OR REPLACE PROCEDURE ADD_JOB_HIST(employee_id INT, new_job_id VARCHAR(50)) AS
DECLARE
  emp_hire_date DATE;
BEGIN
  SELECT hire_date INTO emp_hire_date FROM EMPLOYEES WHERE employee_id = employee_id;

  -- Проверка наличия сотрудника
  IF emp_hire_date IS NULL THEN
    RAISE EXCEPTION 'Nonexistent employee.';
  END IF;

  -- Отключение триггеров
  ALTER TABLE EMPLOYEES DISABLE TRIGGER ALL;
  ALTER TABLE JOBS DISABLE TRIGGER ALL;
  ALTER TABLE JOB_HISTORY DISABLE TRIGGER ALL;

  -- Обновление JOB_HISTORY и EMPLOYEES
  UPDATE EMPLOYEES
  SET hire_date = CURRENT_DATE,
      job_id = new_job_id,
      salary = (SELECT min_salary + 500 FROM JOBS WHERE job_id = new_job_id)
  WHERE employee_id = employee_id;

  INSERT INTO JOB_HISTORY(employee_id, start_date, end_date, job_id)
  VALUES (employee_id, emp_hire_date, CURRENT_DATE, new_job_id);

  -- Просмотр изменений
  SELECT * FROM JOB_HISTORY WHERE employee_id = employee_id;
  SELECT * FROM EMPLOYEES WHERE employee_id = employee_id;

  -- Фиксация изменений
  COMMIT;

  -- Включение триггеров
  ALTER TABLE EMPLOYEES ENABLE TRIGGER ALL;
  ALTER TABLE JOBS ENABLE TRIGGER ALL;
  ALTER TABLE JOB_HISTORY ENABLE TRIGGER ALL;
END;
/

-- Вызов процедуры
CALL ADD_JOB_HIST(106, 'SY_ANAL');
