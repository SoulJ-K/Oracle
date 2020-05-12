--1. �а� �̸��� �迭�� ǥ���Ͻÿ�.
--�� ��Ī�� �а���, �迭�� ǥ��
SELECT DEPARTMENT_NAME �а���, CATEGORY �迭
FROM TB_DEPARTMENT;

--2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ���
--�а��� ����
-------------------------------
--������а��� ������ 20�� �Դϴ�.
--������а��� ������ 36�� �Դϴ�.
SELECT DEPARTMENT_NAME ||'�� ������ ' || CAPACITY || '�� �Դϴ�.' �а�������
FROM tb_department;

--3. ������а��� �ٴϴ� ���л� �� ���� �������� ���л��� ã��
--�����а��� �а��ڵ�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ
SELECT STUDENT_NAME
FROM tb_student S, tb_department D
WHERE ABSENCE_YN = 'Y' AND S.DEPARTMENT_NO = D.DEPARTMENT_NO AND SUBSTR(STUDENT_SSN,8,1) = 2 AND DEPARTMENT_NAME = '������а�';

--4. ���� ���� ��� ��ü���� �̸� ã��
--�й�  A513079, A513090, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ( 'A513079', 'A513090', 'A513110', 'A513119');

--5. ���������� 20�� �̻� 30�� ������ �а� �̸��� �迭 ���
SELECT DEPARTMENT_NAME, CATEGORY 
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6. ���б� ���� �̸���? (��� ������ �Ҽ��а� ������ ����. ���� ����)
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. �а� ���� �ȵ� �л�
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. �������� �����ϴ� ������ �����ȣ ��ȸ
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. �迭(CATEGORY) ��ȸ
SELECT DISTINCT CATEGORY
FROM tb_department;

--10. 02�й� ���� ������ �� �й�, �̸�, �ֹι�ȣ ���(��������)
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'N' AND student_address LIKE '����%' AND SUBSTR(TO_CHAR(ENTRANCE_DATE), 1, 2) = 02; 


