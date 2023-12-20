CREATE OR REPLACE FUNCTION GET_YEARS_SERVICE(emp_id INT) RETURNS INT AS
DECLARE
  hire_date DATE;
BEGIN
  -- Получение даты приема на работу
  SELECT hire_date INTO hire_date FROM EMPLOYEES WHERE employee_id = emp_id;

  -- Проверка наличия сотрудника
  IF hire_date IS NULL THEN
    RAISE EXCEPTION 'Invalid employee ID.';
  END IF;

  -- Расчет стажа
  RETURN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM hire_date);
END;
/

-- Вызов функции
DO $$ 
BEGIN 
  DBMS_OUTPUT.PUT_LINE(GET_YEARS_SERVICE(999)); 
  DBMS_OUTPUT.PUT_LINE(GET_YEARS_SERVICE(106)); 
END $$;
