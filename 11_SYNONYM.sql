--���Ǿ� (SYNONYM) : �ٸ� DB�� ���� ��ü�� ���� ���� Ȥ�� ���Ӹ�
--���Ǿ ����Ͽ� �����ϰ� ���� �� �� �ֵ��� ��

--����� ���Ǿ� : ��ü�� ���� ���� ������ �ο����� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ��� ����
CREATE SYNONYM EMP FOR EMPLOYEE;
--An attempt was made to perform a database operation without the necessary privileges.
--���Ѻο� ���ؼ�

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

--���� ���Ǿ� : ��� ������ �ִ� ����ڰ�(DBA)�� ������ ���Ǿ�
--            ��� ����ڰ� ����� �� ����

SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.EMP;
SELECT * FROM KH.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;

SELECT * FROM DEPT;

--���Ǿ� ����
DROP SYNONYM EMP;
SELECT * FROM EMP;

DROP PUBLIC SYNONYM DEPT;
SELECT * FROM DEPT;

