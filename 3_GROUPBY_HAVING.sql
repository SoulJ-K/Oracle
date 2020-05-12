--ORDER BY : SELECT�� �÷��� ������ ������ �� ���
--ORDER BY �÷��� | �÷� ��Ī | �÷����� ���� [ASC] | [DESC]
SELECT EMP_ID, JOB_CODE, EMP_NAME, SALARY �޿�, DEPT_CODE
FROM EMPLOYEE
--ORDER BY EMP_NAME;  --��������
--ORDER BY EMP_NAME ASC;  -- ASC : �������� / �⺻������ ���������� �Ǿ��־ �Ƚᵵ ��
--ORDER BY EMP_NAME DESC;   -- DESC : ��������
--ORDER BY DEPT_CODE NULLS FIRST;   --NULLS FIRST : NULL�� ���� ���� ���̰� �� ���� ����
--ORDER BY 3;  --�÷��� ���� ������ ��� ��. ���� ������� �ʴ°� ����
ORDER BY �޿�;

/*  �������
      5     SELECT : �÷� ��ȸ
      1     FROM : ������ ���̺� �� ( ���� ��Ƴ��´�)
      2     WHERE : SELECT�� ����
      3     GROUP BY
      4     HAVING
      6     ORDER BY : ����
    ----------------SELECT���� ��ü
*/

--GROUP BY : ���� ���� ���� ��� �ϳ��� ó���� �������� ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;  -- ������� ������ �޶� ������

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE NULLS FIRST;

--EMPLOYEE���̺��� �μ��ڵ�� ���ʽ��� �޴� ������� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--EMPLOYEE���̺��� �μ� �ڵ� �� �׷��� �����Ͽ� �μ��ڵ�, �׷� �� �޿��� �հ�, �׷� �� �޿��� ���, �ο����� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE, SUM(SALARY), TRUNC(AVG(SALARY))�޿����, COUNT(SALARY), COUNT(*) --�̹� �μ��ڵ�� ������ ������ ��ü�� ��Ÿ���� * ���
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--EMPLOYEE���̺��� �����ڵ�, ���ʽ��� �޴� ������� ��ȸ�Ͽ� �����ڵ������ ��������
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL   --COUNT(BONUS)�� 0�� ������ ���� ���� ������
GROUP BY JOB_CODE
ORDER BY job_code;

--������ ���� �� �޿� ���, �޿� �հ�, �ο� �� ��ȸ�ϰ� �ο� ���� �������� ����
SELECT DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', '��') ����, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', '��')
ORDER BY COUNT(*) DESC;

--�μ� �ڵ庰�� ���� ������ ����� �޿� �հ� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY dept_code, job_code;   --���� �÷��� �Բ� ���� �� ����

--HAVING : �׷��Լ��� ���� �� �׷쿡 ���� ������ ������ �� ���
--�μ��ڵ�� �޿� 300���� �̻��� ������ �׷캰 ���(�ݿø�) �޿� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

--�μ��ڵ�� �޿� ����� 300���� �̻��� �׷� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) >= 3000000;

--�μ� �� �׷��� �޿� �հ� �� 9�鸸���� �ʰ��ϴ� �μ� �ڵ�� �޿� �հ�(�μ��ڵ� ������ ����)
SELECT DEPT_CODE, SUM(SALARY)
FROM employee
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE;

--�����Լ�(ROLLUP, CUBE) : �׷� �� ������ ��� ���� ���� ���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)    --NULL�� �߰��Ǹ鼭 ��ü ������ ����
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)   --NULL�� �߰��Ǹ鼭 ��ü ������ ����
ORDER BY JOB_CODE;

--ROLLUP�Լ� : ������ �׷캰�� �߰����� ó��
--�׷����� ���� �� �߿��� ���� ���� ������ ���ͷ��� ���� �׷캰 �߰�����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

--CUBE�Լ� : ������ �Ǵ� ù��°�� �ι�° �׷��� �߰� ���� ó��
--�׷����� ���� �� ��ο� ���� �׷캰 �߰�����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

--GROUPING �Լ� 
--ROLLUP�̳� CUBE�� ���� ������� ���ڷ� ���޹��� �÷��� ����̸� 0 ��ȯ, �ƴϸ� 1��ȯ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),GROUPING(DEPT_CODE)�μ����׷�, GROUPING(JOB_CODE)���޺��׷�
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),GROUPING(DEPT_CODE)�μ����׷�, GROUPING(JOB_CODE)���޺��׷�
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

--���� ������
--UNION : ������ (OR)
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE emp_id = 200
UNION
SELECT EMP_ID, EMP_NAME
FROM employee
WHERE EMP_ID = 201;

--DEPT_CODE�� D5�ų� �޿��� 300������ �ʰ��ϴ� ������ ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5' OR SALARY > 3000000;

--UNION ALL : ������ + ������ (OR + AND)-> �ߺ��� �κ��� �� �� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000
ORDER BY EMP_ID;

--INTERSECT : ������(AND)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5' AND SALARY > 3000000;

--MINUS : ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code = 'D5' AND SALARY <= 3000000;

--GROUPING SETS : �׷캰�� ó���� ���� ���� SELECT���� �ϳ��� ��ĥ �� ���
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM employee
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID
ORDER BY DEPT_CODE;

SELECT DEPT_CODE,MANAGER_ID, FLOOR(AVG(SALARY))
FROM employee
GROUP BY DEPT_CODE, MANAGER_ID;

SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM employee
GROUP BY JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM employee
GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),(DEPT_CODE, MANAGER_ID), (JOB_CODE, MANAGER_ID))
ORDER BY DEPT_CODE;