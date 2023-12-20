CREATE OR REPLACE PROCEDURE UPD_JOBSAL(job_id VARCHAR(50), new_min_salary NUMERIC, new_max_salary NUMERIC) AS
BEGIN
  -- Проверка наличия job_id в JOBS
  IF NOT EXISTS (SELECT 1 FROM JOBS WHERE job_id = job_id) THEN
    RAISE EXCEPTION 'Invalid job ID.';
  END IF;

  -- Проверка на корректность диапазона зарплат
  IF new_max_salary < new_min_salary THEN
    RAISE EXCEPTION 'Invalid salary range.';
  END IF;

  -- Обновление JOBS
  UPDATE JOBS
  SET min_salary = new_min_salary,
      max_salary = new_max_salary
  WHERE job_id = job_id;

  EXCEPTION
    WHEN OTHERS THEN
      -- Вывод сообщения об ошибке
      RAISE NOTICE 'Error: %', SQLERRM;
END;
/

-- Вызов процедуры
CALL UPD_JOBSAL('SY_ANAL', 7000, 140);
