CREATE OR REPLACE FUNCTION CHECK_SAL_RANGE() RETURNS TRIGGER AS
BEGIN
  -- Проверка изменения MIN_SALARY и MAX_SALARY
  IF NEW.min_salary <> OLD.min_salary OR NEW.max_salary <> OLD.max_salary THEN
    -- Проверка, попадает ли текущая зарплата сотрудника в новый диапазон
    IF EXISTS (
      SELECT 1
      FROM EMPLOYEES
      WHERE job_id = NEW.job_id
        AND salary NOT BETWEEN NEW.min_salary AND NEW.max_salary
    ) THEN
      RAISE EXCEPTION 'Salary range change affects existing employee.';
    END IF;
  END IF;

  RETURN NEW;
END;
/

-- Создание триггера
CREATE TRIGGER CHECK_SAL_RANGE
BEFORE UPDATE OF min_salary, max_salary ON JOBS
FOR EACH ROW
EXECUTE FUNCTION CHECK_SAL_RANGE();
/

-- Тестирование триггера
UPDATE JOBS
SET min_salary = 5000, max_salary = 7000
WHERE job_id = 'SY_ANAL';

UPDATE JOBS
SET min_salary = 7000, max_salary = 18000
WHERE job_id = 'SY_ANAL';
