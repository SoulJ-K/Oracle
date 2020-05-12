--VIEW(��)
--SELECT ���� ���� ��� ȭ���� ������ ��ü, ������ ���� ���̺�
--���� �����͸� �����ϰ� ���� ������ ���̺��� ����ϴ� �Ͱ� �����ϰ� ��� ����
--ǥ����
--CREATE [OR REPLACE] VIEW ���̸� AS ��������
--OR REPLACE : �� ���� �� ���� �̸��� �䰡 ������ �����Ѵٸ� ����� ����
--OR REPLACE�� ������� �ʰ� �並 ���� �� ���� �̸��� �� �� ���� �� �̹� �ٸ� ��ü�� ������� �̸��̶�� ���� �߻�

--���, �̸�, �μ� ��, �ٹ� ������ ��ȸ�ϰ� �� ����� V_EMPLOYEE��� �並 �����Ͽ� ����
CREATE OR REPLACE VIEW V_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING(NATIONAL_CODE);
--    insufficient privileges : �並 ������ ������ ����

GRANT CREATE VIEW TO KH;    --�����ڰ�������

SELECT * FROM v_employee;

COMMIT;

SELECT EMP_NAME
FROM v_employee
WHERE EMP_ID = '205';

-- EMPLOYEE���̺��� ����� 205���� ����� �̸��� '���߾�'���� ����
UPDATE EMPLOYEE 
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;

SELECT * FROM v_employee;
--���̽����̺��� ������ ����Ǹ� VIEW�� ���� �����.

ROLLBACK;

--������ �� �÷��� ��Ī �ο�
--���������� SELECT���� �Լ��� ���� ��� �ݵ�� ��Ī ����(�� �������� �ȿ� ���� ����� ���� ����)
CREATE OR REPLACE VIEW V_EMP_JOB (���, �̸�, ����, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO,8,1), 1, '��', '��'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);
--must name this expression with a column alias : �ݵ�� ��Ī�� �ʿ��ϴ�.

SELECT * FROM V_EMP_JOB;

--������ �並 �̿��� DML�� ��� ����
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

--�信 INSERT���
INSERT INTO V_JOB
VALUES ('J8', '����');

SELECT * FROM V_JOB;
SELECT * FROM JOB;

--�信�� ��û�� DML������ ���̽� ���̺� ������

--�信 UPDATE���
UPDATE V_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE= 'J8';

--�信 DELETE ���
DELETE FROM V_JOB
WHERE JOB_CODE = 'J8';

COMMIT;

--DML��ɾ�� ������ �Ұ����� ���
--1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
FROM JOB;

SELECT * FROM V_JOB2;
SELECT * FROM JOB;

INSERT INTO V_JOB2 VALUES('J8', '����');
--00913. 00000 -  "too many values"

UPDATE V_JOB2
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
--ORA-00904: "JOB_NAME": invalid identifier

DELETE FROM V_JOB2
WHERE JOB_NAME = '���';
--ORA-00904: "JOB_NAME": invalid identifier

--2. �信 ���Ե��� ���� �÷� �߿� ���̽��� �Ǵ� �÷��� NOT NULL ���������� ������ ���
-- : INSERT������ �����߻�
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
FROM JOB;

SELECT * FROM V_JOB3;

INSERT INTO V_JOB3 VALUES ('����');
--ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
--�信 INSERT�� �ϸ� ���̽����̺��� ������ ��. 
--���̽� ���̺� �ִ� JOB_CODE���� NOT NULL ���������� �ɷ�����. 
--V_JOB3�� ������ ������ JOB���̺� �ִ� JOB_CODE���� �������� �ʾ� NULL�� �Ǵµ� NOT NULL���������� �ɷ��־ ������

INSERT INTO JOB VALUES ('J8', '����');

UPDATE V_JOB3
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '����';

DELETE FROM V_JOB3
WHERE JOB_NAME = '�˹�';

--3. ��� ǥ�������� ���ǵ� ���
--���, ��� ��, �޿�, ���ʽ��� ���Ե� �������� �̷���� EMP_SAL �� ����
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*(1+NVL(BONUS,0))*12 ����
FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES (800, '������', 3000000, 36000000);
--ORA-01733: virtual column not allowed here : ������ ���ǥ�������� ���ǰ� �ִµ� �߰��Ϸ��� ���� ���ǥ���� �ƴϰ� �ٷ� ������ �־ ����)

UPDATE EMP_SAL
SET ���� = 8000000
WHERE EMP_ID = 200;
--ORA-01733: virtual column not allowed here : INSERT�� ���� ����

COMMIT;

DELETE FROM EMP_SAL
WHERE ���� = 124800000;
--��� ������� �ƴ� ��ġ�� �͸� ã�Ƽ� ����� ���̱� ������ �����

ROLLBACK;

CREATE OR REPLACE VIEW VVV
AS (SELECT EMP_ID
FROM EMPLOYEE);

DROP VIEW VVV;


--4. �׷��Լ��� GROUP BY���� ������ ���
--�μ��ڵ�, ���� �ڵ� �� �޿� �հ�, �μ� �ڵ� �� �޿� ����� ������ �ִ� V_GROUPDEPT �� ����
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY)���
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES ('D10', 6000000, 4000000);
--ORA-01733: virtual column not allowed here 
--�׷��Լ� �����ؼ�

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';
--ORA-01732: data manipulation operation not legal on this view

DELETE  FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';
--data manipulation operation not legal on this view

--5. DISTINCT�� ������ ���
CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES ('J9');
--ORA-01732: data manipulation operation not legal on this view

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';

DELETE FROM V_DT_EMP
WHERE JOB_CODE = 'J1';


--6. JOIN�� �̿��� ���� ���̺��� ������ ���
--���, �����, �μ��� ������ ������ �ִ� V_JOINEMP �� ����
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES (888, '������', '�λ������');
--ORA-01776: cannot modify more than one base table through a join view
--���ε� VIEW������ �Ұ�

UPDATE V_JOINEMP
SET DEPT_TITLE = '�λ������'
WHERE EMP_ID = 219;                     -- ������
--RA-01779: cannot modify a column which maps to a non key-preserved table

COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;

ROLLBACK;

SELECT * FROM USER_VIEWS;
--���̺��� ���� �����°� �ƴ϶� �ؽ�Ʈ�� ����Ǿ��ִ� ���� ������

--VIEW �ɼ�
--VIEW ���� ǥ����
--CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸� [��Ī,��Ī,��Ī]
--AS SUBQUERY
--[WITH CHECK OPTION]
--[WITH READ ONLY];

--1) OR REPLACE �ɼ� : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
--2) FORCE / NOFORCE �ɼ�
--   FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
--   NOFORCE : ���������� ���� ���̺��� �����ؾ߸� �� ����(�⺻��)
--3) WITH CHECK OPTION �ɼ� : �ɼ��� ������ �÷��� ���� ���� �Ұ����ϰ� ��
--4) WITH READ ONLY �ɼ� : �信 ���� ��ȸ�� ����

--1) OR REPLACE �ɼ� : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
--�ֹι�ȣ�� ��� �� ������ ������ �ִ� V_EMP1�� ����
CREATE OR REPLACE VIEW V_EMP1(�ֹι�ȣ,�̸�)
AS SELECT EMP_NO, EMP_NAME 
FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1(�ֹι�ȣ,�̸�,�޿�)
AS SELECT EMP_NO, EMP_NAME , SALARY
FROM EMPLOYEE;

CREATE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
FROM EMPLOYEE;
--ORA-00955: name is already used by an existing object  -----> ����� �Ұ�

--2) FORCE / NOFORCE �ɼ�
--   FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
CREATE OR REPLACE /*NOFORCE*/VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
--    table or view does not exist : ���̺�/�䰡 �������� �ʾƿ�
CREATE OR REPLACE FORCE VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
    
 SELECT * FROM V_EMP2;
    --�� ������ �Ǿ�����
 SELECT * FROM USER_VIEWS;
--   NOFORCE : ���������� ���� ���̺��� �����ؾ߸� �� ����(�⺻��)

--3) WITH CHECK OPTION �ɼ� : �ɼ��� ������ �÷��� ���� ���� �Ұ����ϰ� ��
CREATE OR REPLACE VIEW V_EMP3
AS SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' WITH CHECK OPTION;

SELECT* FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
--ORA-01402: view WITH CHECK OPTION where-clause violation   : VIEW�� üũ�ɼǿ� ����Ǿ���.
--WITH CHECK OPTION �� �ɾ �ٲ� �� ���� ��������

COMMIT;

UPDATE V_EMP3
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

ROLLBACK;

--4) WITH READ ONLY �ɼ� : �信 ���� ��ȸ�� ����
CREATE OR REPLACE VIEW V_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

DELETE FROM V_DEPT;
--ORA-42399: cannot perform a DML operation on a read-only view

COMMIT;
