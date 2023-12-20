CREATE OR REPLACE PROCEDURE NEW_JOB(job_id VARCHAR(50), job_title VARCHAR(50), min_salary NUMERIC) AS
BEGIN
  INSERT INTO JOBS(job_id, job_title, min_salary, max_salary)
  VALUES(job_id, job_title, min_salary, min_salary * 2);
END;
/

-- Вызов процедуры
CALL NEW_JOB('SY_ANAL', 'System Analyst', 6000);
