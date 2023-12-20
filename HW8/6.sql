CREATE OR REPLACE PACKAGE EMPJOB_PKG AS
  -- Спецификация пакета
  PROCEDURE NEW_JOB(job_id VARCHAR(50), job_title VARCHAR(50), min_salary NUMERIC);
  PROCEDURE ADD_JOB_HIST(employee_id INT, new_job_id VARCHAR(50));
  PROCEDURE UPD_JOBSAL(job_id VARCHAR(50), new_min_salary NUMERIC, new_max_salary NUMERIC);
  FUNCTION GET_YEARS_SERVICE(emp_id INT) RETURNS INT;
  FUNCTION GET_JOB_COUNT(emp_id INT) RETURNS INT;
END EMPJOB_PKG;
/

-- Тело пакета
CREATE OR REPLACE PACKAGE BODY EMPJOB_PKG AS
  PROCEDURE NEW_JOB(job_id VARCHAR(50), job_title VARCHAR(50), min_salary NUMERIC) AS
  BEGIN
    INSERT INTO JOBS(job_id, job_title, min_salary, max_salary)
    VALUES(job_id, job_title, min_salary, min_salary * 2);
  END;

  PROCEDURE ADD_JOB_HIST(employee_id INT, new_job_id VARCHAR(50)) AS
  -- (код аналогичен коду из пункта 2)

  PROCEDURE UPD_JOBSAL(job_id VARCHAR(50), new_min_salary NUMERIC, new_max_salary NUMERIC) AS
  -- (код аналогичен коду из пункта 3)

  FUNCTION GET_YEARS_SERVICE(emp_id INT) RETURNS INT AS
  -- (код аналогичен коду из пункта 4)

  FUNCTION GET_JOB_COUNT(emp_id INT) RETURNS INT AS
  -- (код аналогичен коду из пункта 5)
END EMPJOB_PKG;
/

-- Вызов процедур и функций из пакета
CALL EMPJOB_PKG.NEW_JOB('PR_MAN', 'Public Relations Manager', 6250);
CALL EMPJOB_PKG.ADD_JOB_HIST(110, 'PR_MAN');
