-- 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸���, �ֹι�ȣ, �μ���, ���� ��ȸ
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM employee E, JOB J, department D
WHERE e.job_code = j.job_code AND E.DEPT_CODE = D. DEPT_ID 
        AND SUBSTR(EMP_NO, 1,2) >=70 AND SUBSTR(EMP_NO , 1,2)<= 79 
        AND SUBSTR(EMP_NO, 8,1) = 2 AND EMP_NAME LIKE '��%';

-- ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
--���� ����
SELECT MIN(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM (TO_DATE(SUBSTR(EMP_NO,1,2),'RR')))+1)
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM (TO_DATE(SUBSTR(EMP_NO,1,2),'RR')))+1 ����, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E 
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM (TO_DATE(SUBSTR(EMP_NO,1,2),'RR')))+1 = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM (TO_DATE(SUBSTR(EMP_NO,1,2),'RR')))+1)
FROM EMPLOYEE);

-- �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- �μ� �ڵ尡 D5�̰ų� D6�� ����� ��� ��, ����, �μ� �ڵ�, �μ� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = j.job_code AND DEPT_CODE = DEPT_ID AND DEPT_CODE IN ('D5', 'D9');

-- ���ʽ��� �޴� ����� ��� ��, ���ʽ�, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- ��� ��, ����, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM employee E, JOB J, department D, location L
WHERE E.JOB_CODE = j.job_code AND DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM employee
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION  ON  (LOCATION_ID = LOCAL_CODE)
JOIN national USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

-- �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ
SELECT E. EMP_NAME, E.DEPT_CODE, D.EMP_NAME
FROM employee E
JOIN employee D ON (E.DEPT_CODE = D.DEPT_CODE)
WHERE E.EMP_NAME != D.EMP_NAME
ORDER BY 1;

-- ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ����, �޿� ��ȸ (NVL �̿�)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM employee
 JOIN job USING (JOB_CODE)
WHERE JOB_CODE IN ('J4', 'J7') AND NVL(BONUS, 0) =0;

-- ���� ���̺��� ���ʽ� ������ ������ ���� 5����
-- ���, �̸�, �μ���, ���޸�, �Ի����� ��ȸ�ϼ���
SELECT EMP_ID,EMP_NAME, salary*(1+NVL(BONUS,0))*12
FROM employee
--WHERE ROWNUM <= 5
ORDER BY salary*(1+NVL(BONUS,0))*12 DESC;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,  salary*(1+NVL(BONUS,0))*12
        FROM employee
        JOIN JOB USING (JOB_CODE)
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        ORDER BY salary*(1+NVL(BONUS,0))*12 DESC)
        WHERE ROWNUM <= 5;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,  salary*(1+NVL(BONUS,0))*12, 
            RANK() OVER (ORDER BY salary*(1+NVL(BONUS,0))*12 DESC) ����
        FROM employee
        JOIN JOB USING (JOB_CODE)
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID))        
        WHERE ���� <= 5;

-- �μ��� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ����, �μ��� �޿� �հ� ��ȸ
-- 1) having ���
--�μ��� �޿� �հ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM department JOIN employee ON (DEPT_ID = DEPT_CODE)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) *0.2 FROM employee);

-- 2) �ζ��� �� ���
SELECT DEPT_TITLE, S
FROM (SELECT DEPT_TITLE, SUM(SALARY) S
        FROM department 
        JOIN employee ON (DEPT_ID = DEPT_CODE)
        GROUP BY DEPT_TITLE)
WHERE S >(SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

-- 3) WITH ���
WITH TH AS (SELECT DEPT_TITLE, SUM(SALARY) S
        FROM department 
        JOIN employee ON (DEPT_ID = DEPT_CODE)
        GROUP BY DEPT_TITLE)
    
SELECT DEPT_TITLE, S
FROM TH
WHERE S > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);