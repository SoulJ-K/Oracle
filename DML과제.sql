--1
INSERT INTO TB_CLASS_TYPE VALUES (01, '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES (02, '��������');
INSERT INTO TB_CLASS_TYPE VALUES (03, '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES (04, '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES (05, '������');

--2
CREATE TABLE TB_�л��Ϲ�����
    AS  SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
        FROM tb_student;
        
--3. ������а� �л����� ������ ���Ե� �а� ���� ���̺�
CREATE TABLE TB_������а�
AS SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RR'),'YYYY') ����⵵, PROFESSOR_NAME �����̸�
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    LEFT JOIN tb_professor ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
    WHERE department_name = '������а�';
    
    SELECT * FROM TB_������а�;
    DROP TABLE TB_������а�;
 
--4
UPDATE TB_DEPARTMENT
SET (CAPACITY * 1.1);

--5
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
WHERE student_no = 'A413042';

COMMIT;
--6
UPDATE TB_STUDENT
SET STUDENT_SSN  = SUBSTR(STUDENT_SSN,1,6 );

--7

--8
DELETE FROM TB_GRADE
WHERE 

















