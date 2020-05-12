--�Լ�(FUNCTION) : �÷��� ���� �о ����� ��� ����
--���� �� �Լ�(SINGLE ROW FUNCTION) : N���� ���� �־ N���� ��� ����
--�׷� �Լ�(GROUP FUNCTION) : N���� ���� �־ �� ���� ��� ����
--SELECT�ȿ� �������Լ��� �׷��Լ��� ���� �� �� ����.

SELECT LENGTH(EMP_NAME)
FROM EMPLOYEE;

SELECT COUNT(EMP_NAME)
FROM employee;

select count (BONUS) from employee;

--SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--FROM employee;
-- SELECT�ȿ� ��ȯ�ϴ� ������ �޶� ��ȯ�� �ȵ�

--�Լ��� ����� �� �ִ� ��ġ
--SELECT��, WHERE��, GROUP BY��, HAVING��, ORDER BY��


--���� �� �Լ�

--1. ���� ���� �Լ�

--LENGTH / LENGTHB
--LENGTH(�÷��� | '���ڿ�') : ���� �� ��ȯ
--LENGTHB(�÷��� | '���ڿ�') : ������ ����Ʈ ������ ��ȯ
SELECT LENGTH('����Ŭ'), LENGTH('����Ŭ')
FROM DUAL; --���� ���̺�

SELECT EMAIL, LENGTH(EMAIL), LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT LENGTHB('����Ŭ'), LENGTH('����Ŭ')  --����Ŭ���� �ѱ��� 3BYTE
FROM DUAL;

--INSTR : �ش� ���ڿ��� ù��° ������ ��ġ
SELECT INSTR('AABAACAABBAA', 'B')  --����Ŭ�� �����ε��� ����� �ƴ�
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'Z')
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1)  --1��°���� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1)  -- -1��°(��)���� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'C', -1)  
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1, 2)  -- �ι�°�� ������ B�� ��ġ ��ȯ
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1, 2) -- �ڿ������� �б� �����ؼ� �ι�°�� ������ B�� ��ġ ��ȯ
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'C', 1, 2) --�ι�° C�� ���� ������ 0��ȯ
FROM DUAL;

--EMPLOYEE ���̺��� �̸����� @ ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

--LPAD / RPAD
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;
--LPAD : �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� ���ʿ� ���ٿ� ���� N�� ���ڿ� ��ȯ

SELECT RPAD(EMAIL, 20, '$')
FROM EMPLOYEE;
--RPAD : �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� �����ʿ� ���ٿ� ���� N�� ���ڿ� ��ȯ

--LTRIM / RTRIM / TRIM : �־��� �÷��̳� ���ڿ��� ����/������/��/��/���ʿ��� ������ ���ڸ� ������ ������ ��ȯ
SELECT LTRIM('   KH')  -- ������ ���ڿ��� �������� �ʾ��� ��� �⺻������ ���� ����
FROM DUAL;

SELECT LTRIM('   KH',  ' ') 
FROM DUAL;

SELECT LTRIM('000123456', '0')
FROM DUAL;

SELECT LTRIM('123123KH', '123') 
FROM DUAL;

SELECT LTRIM('123123KH123', '123')  --KH �ڿ� 123�� ������ K�� �����鼭 ��ġ���� �����Ƿ� ��
FROM DUAL;

SELECT LTRIM('ACABACCKH', 'ABC')  --���ڰ� ���ԵǾ������� ����
FROM DUAL;

SELECT LTRIM('5781KH', '0123456789')
FROM DUAL;

SELECT RTRIM('KH   ') 
FROM DUAL;

SELECT RTRIM('123456000', '0')
FROM DUAL;

SELECT RTRIM('KHACABACC', 'ABC')
FROM DUAL;

SELECT TRIM('   KH   ') 
FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL;

SELECT TRIM('123' FROM '123132KH123321') -- TRIM�� �ѱ��ڸ� ���� ����
FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') --��
FROM DUAL;

SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ')  --��
FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZ')   --�� �� �Ѵ�
FROM DUAL;

--SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ���� ���� ������ ���ڿ��� �߶� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7)  --7���� ������ �� ��ȯ. ������ �������� ������ ������ ��ȯ��
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 5,2)  --5�ڸ� ���� 2��
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 5, 0)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3)  --�ڿ������� ����
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-10, 2)
FROM DUAL;

--EMPLOYEE���̺��� �̸�, �̸��� ,@ ���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1)
--SELECT EMP_NAME, EMAIL, RTRIM(EMAIL, '@kh.or.kr')
FROM employee;

--�ֹε�Ϲ�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱�
SELECT SUBSTR(EMP_NO, 8, 1)
FROM employee;

--EMPLOYEE���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� �����, ����, ����, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) ����, SUBSTR(EMP_NO, 3, 2) ����, SUBSTR(EMP_NO, 5,2) ����
FROM employee;

--LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World')   -- ��� �� �ҹ��ڷ�
FROM DUAL;

SELECT UPPER('Welcome To My World')   --��� �� �빮�ڷ�
FROM DUAL;

SELECT INITCAP('welcome to my world')   --���⸦ �������� �� �ձ��ڸ� �빮�ڷ�
FROM DUAL;

--CONCAT
SELECT CONCAT('�����ٶ�', 'ABCD')
FROM DUAL;

SELECT '�����ٶ�' || 'ABCD'
FROM DUAL;

--REPLACE : ������ ���ڿ��� �ٲ�
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
FROM DUAL;

SELECT REPLACE('����ȣ �л��� ������ �����ϱ��?', '����', '����')
FROM DUAL;

--EMPLOYEE ���̺��� �̸����� �������� GMAIL.COM���� �����ϱ�
SELECT REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
from employee;

--select emp_name, replace(EMP_NO, SUBSTR(emp_no, 9), '******')
--SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)||'******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;


--2. ���� ���� �Լ�

--ABS : ���밪�� ��ȯ�ϴ� �Լ�
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9)  FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

--MOD : ������ ���� ���ϴ� �Լ�
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10, -3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
SELECT MOD(-10.9, 3) FROM DUAL;
SELECT MOD(-10, -3) FROM DUAL;

--ROUND : �ݿø�(���������� ������ �Ҽ� ù��° �ڸ��� �ݿø���)
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

--����
SELECT ROUND(-10.61) FROM DUAL; 

--FLOOR : ����
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

--TRUNC : ����(�߶󳻱�)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

--CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

--3. ��¥ ���� �Լ�
--SYSDATE : ���� ��¥ ��ȯ

--MONTHS_BETWEEN : ��¥�� ��¥ ������ ���� �� ���̸� ���ڷ� �����ϴ� �Լ�
--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM employee;

--ADD_MONTHS : ��¥�� ���ڸ�ŭ�� ���� ���� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;

--NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥�� �����ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
--�� �� ȭ �� �� �� ��
--1  2  3  4 5  6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��ĵ�� ������') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ӿ�ȭ') FROM DUAL;  --������ ù��° ���ڰ� �����̾����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;  --

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--LAST_DAY : �ش� ���� ������ ��¥ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

--EXTRACT : ��¥���� ��, ��, �� �����Ͽ� ����
--EXTRACT(YEAR FROM ��¥)
--EXTRACT(MONTH FROM ��¥)
--EXTRACT(DAY FROM ��¥)

--EMPLOYEE ���̺��� ����� �̸�, �Ի� ��, �Ի� ��, �Ի� �� ��ȸ
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵, EXTRACT(MONTH FROM HIRE_DATE) �Ի��, EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE;

--4. �� ��ȯ �Լ�
--TO_CHAR(��¥[, ����]) : ��¥�� �����͸� ������ �����ͷ� �ٲٴ� �Լ�
--TO_CHAR(����[, ����]) : ������ �����͸� ������ �����ͷ� �ٲٴ� �Լ�

SELECT TO_CHAR(1234) í FROM DUAL;
SELECT TO_CHAR(1234, '99999') í FROM DUAL;  --5ĭ, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000')í FROM DUAL;   --5ĭ, ������ ����, ��ĭ 0
SELECT TO_CHAR(1234, 'L99999') í FROM DUAL; --��ȭ ����
SELECT TO_CHAR(1234, 'FML99999') í FROM DUAL; --������ �ƿ� ���ְ� ������ FM
SELECT TO_CHAR(1234, 'FM$99999') í FROM DUAL;
SELECT TO_CHAR(1234, '99,999') í FROM DUAL;    --������ ������ FM
SELECT TO_CHAR(1234, '00,000') í FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') í FROM DUAL;
SELECT TO_CHAR(1234, '999') í FROM DUAL;
SELECT TO_CHAR(SALARY, 'FM9,999,999') FROM employee;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;  --AM, PM ũ�� ��� ����
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL;  --Q : �б�
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" DAY') FROM DUAL;

--���� ��¥�� ���� ����, ��, �� ���
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'),TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DDD'), TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'D') FROM DUAL;
--DDD : �� �������� ����°����    DD : ���� ��¥(�� ����)    D : �̹� �ֿ� ���� °����

--�б�, ���� ���
SELECT TO_CHAR(SYSDATE, 'Q'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')    FROM DUAL;
        
--TO_DATE : ����/������ ������  -> ��¥�� ������
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;   --����Ŭ���� ������ �⺻������ 2�ڸ��� ���
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;

--2010 01 01 �� 2010, 1��
SELECT TO_CHAR(TO_DATE(20100101, 'YYYYMMDD'), 'YYYY, MON') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM') FROM DUAL;

--RR�� YY�� ���� : ������ ��Ÿ��
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYYMMDD'),  -- �� �ڸ� ������ YY�� ������ ���� ���� ����
        TO_CHAR(TO_DATE('140918', 'YYMMDD'), 'YYYYMMDD'),
        TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD'),  -- �� �ڸ� ������ 50�� �̻��̸� ���� ����, 50�� �̸��̸� ���� ���� ����
        TO_CHAR(TO_DATE('140918', 'RRMMDD'), 'YYYYMMDD')   
FROM DUAL;

--TO_NUMBER : ������ ������ --> ������ ������
SELECT TO_NUMBER('12345789') FROM DUAL;
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL;

SELECT '1,000,000' + '550,000' FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;

--5. NULL ó�� �Լ�
--NVL(�÷���, �÷� ���� NULL�� �� �ٲ� ��)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�����ϴ�')
FROM EMPLOYEE;

--NVL2(�÷���, �ٲ� ��1, �ٲ� ��2)   �÷����� NULL�� �ƴϸ� �ٲ� ��1, NULL�̸� �ٲ� ��2 �� �ٲ�
--EMPLOYEE���̺��� ���ʽ��� NULL�� ������ 0.5��, NULL�� �ƴ� ������ 0.7�� �����Ͽ� ��ȸ
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

--NULLIF(�񱳴��1, �񱳴��2) : �� ���� ���� �����ϸ� NULL, �������� ������ �񱳴��1 ����
SELECT NULLIF(123, 123) FROM DUAL;
SELECT NULLIF(123, 124) FROM DUAL;

--6. �����Լ� : ���� ���� ��� ������ �� �ִ� ��� ����
--DECODE(����/�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2....)
--���ϰ����ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') ����
FROM employee;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') ����
FROM employee;
--������ ���ڷ� ���� �� ���� ���� ���� �ۼ��ϸ� �ƹ��͵� �ش���� ���� �� �������� �ۼ��� ���ð��� ������ ������

--CASE WHEN ���ǽ� THEN ��� ��
--     WHEN ���ǽ� THEN ��� ��
--     ELSE ��� ��
--END
--���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ(������ ���� ����)
SELECT EMP_ID, EMP_NAME, EMP_NO, 
           CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '��'
            ELSE '��'
            END ����
            
FROM employee;

--�޿��� 500������ �ʰ��ϸ� 1���, 350������ �ʰ��ϸ� 2���, 200������ �ʰ��ϸ� 3���, �������� 4���
SELECT EMP_NAME, SALARY, 
        CASE WHEN SALARY > 5000000 THEN '1���'
             WHEN SALARY > 3500000 THEN '2���'
            WHEN SALARY > 2000000 THEN '3���'
            ELSE '4���' END ���
--SELECT EMP_NAME, SALARY,
      --  DECODE(SALARY > 5000000, '1���', SALARY > 3500000, '2���', SALARY > 2500000, '3���', '4���')
      -- DECODE�� ũ��� �Ұ���
FROM EMPLOYEE;

--�׷��Լ� : ���� ���� ������ �� ���� ����� ��ȯ
--SUM(���ڰ� ��ϵ� �÷�) : �հ� ����
--EMPLOYEE ���̺��� �� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY) FROM employee;

--EMPLOYEE ���̺��� ���� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

--AVG(���ڰ� ��ϵ� �÷�) : ��� ����
--EMPLOYEE ���̺��� �� ����� �޿� ��� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

--�� ����� ���ʽ� �հ� ��ȸ
SELECT SUM(BONUS)
FROM EMPLOYEE;

--���ʽ� ��� ��ȸ
SELECT AVG(BONUS), AVG(NVL(BONUS,0))
FROM EMPLOYEE;
--NULL���� ���� ���� ��� ��꿡�� ����

--MIN / MAX : �ּ� / �ִ�
--���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի���
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

--���� ���� �޿�, ���ĺ� ������ ���� �������� �̸���, ���� ���� �Ի���
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

--COUNT(* Ȥ�� �÷���) : ���� ���� ����
--COUNT(DISTINCT �÷���) : �ߺ��� ������ �� ���� ����
--COUNT(*) : NULL�� ������ ��ü �� ���� ����
--COUNT(�÷���) : NULL�� ������ ��ü �� ���� ����
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

