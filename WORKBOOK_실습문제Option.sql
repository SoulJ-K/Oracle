-- 1. �л��̸��� �ּ��� ǥ��. �̸� ����
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS �ּ���
FROM tb_student
ORDER BY student_name;

-- 2. ���л� �̸� �ֹι�ȣ
SELECT STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'Y'
ORDER BY student_ssn DESC;

-- 3. �ּҰ� �������� ��⵵ �л� �� 1900��� �й����� �л��� �̸� �й� �ּҸ� �̸� ������������
SELECT STUDENT_NAME �л��̸�, STUDENT_NO �й�, STUDENT_ADDRESS "������ �ּ�"
FROM tb_student
WHERE (student_address LIKE '������%' OR student_address LIKE '��⵵%') AND STUDENT_NO NOT LIKE '%A%'
ORDER BY student_name;

--4. ���� ���а� ���� �߿� ���� ���̰� ���� ������� �̸� Ȯ��
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR JOIN TB_CLASS USING (DEPARTMENT_NO)
WHERE CLASS_NAME LIKE '��%'
ORDER BY professor_ssn;

--5. 2004�� 2�б⿡ C3118100 ������ ������ �л����� ���� ��ȸ.
--���� ���� ������� ǥ���ϰ� ���� ������ ���� �л����� ǩ
SELECT STUDENT_NO, TO_NUMBER(POINT, 9.99)POINT
FROM tb_grade
WHERE class_no = 'C3118100' AND term_no = '200402'
ORDER BY POINT DESC, student_no;

--6. �л� ��ȣ, �̸�, �а��̸��� �л��̸�  ������������ ����
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM tb_student
JOIN TB_DEPARTMENT USING( DEPARTMENT_NO )
ORDER BY STUDENT_NAME;

--7. ���� �̸�, �а� �̸�
SELECT CLASS_NAME, DEPARTMENT_NAME 
FROM TB_CLASS
JOIN tb_department USING (DEPARTMENT_NO);

--8. ���� ���� �̸�. ���� �̸�, ���� �̸�
SELECT DISTINCT CLASS_NAME, PROFESSOR_NAME
FROM tb_class
JOIN tb_professor USING (DEPARTMENT_NO)
GROUP BY CLASS_NAME, PROFESSOR_NAME;

--9. 8�� ����߿� �ι���ȸ �迭�� ���� ���� ���� �̸�
SELECT CLASS_NAME, PROFESSOR_NAME
FROM tb_class
JOIN tb_professor USING (DEPARTMENT_NO)
JOIN tb_department USING (DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ';
--GROUP BY CLASS_NAME;

--10. �����а� �л��� ���� ���ϱ�. �й�, �л� �̸�, ��ü����
SELECT STUDENT_NO �й� , STUDENT_NAME "�л� �̸�" , ROUND(AVG(POINT),1) ��ü����
FROM tb_grade
JOIN tb_student USING (STUDNET_NO)
JOIN tb_department USING (DEPARMTNE_NO)
WHERE DEPARTMENT_NAME = '�����а�';
--GROUP BY DEPARTMENT_NO;

----11. �й��� A313047 �� �л��� �а� �̸�, �������� �̸�
--SELECT DEPARTMENT_NAME �а��̸�, STUDENT_NAME �л��̸�, PROFESSOR_NAME
--FROM tb_professor
--JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
--JOIN TB_STUDENT USING (DEPARTMENT_NO)
--WHERE STUDENT_NO = 'A313047';

--12. 2007�⿡ �ΰ������ ���� ���� �л� �̸�, �����б� �̸�
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM tb_student 
JOIN tb_grade USING (STUDENT_NO)
JOIN tb_class USING (CLASS_NO)
WHERE TERM_NO LIKE '2007%' AND CLASS_NAME = '�ΰ������';

--13. ��ü�� ���� �� ��米���� ���� ���� �̸��� �а� �̸�
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
    LEFT JOIN tb_department USING(DEPARTMENT_NO)
    LEFT JOIN tb_class_professor USING (CLASS_NO)
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL;

----14. ���ݾƾ��а� �л����� ��������
----�������� ���� �� �������� ������. ���й�����
--SELECT STUDENT_NAME �л��̸�, NVL(PROFESSOR_NAME,'�������� ������') ��������
--FROM tb_student 
--LEFT JOIN tb_professor ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
-- JOIN tb_department USING (department_no)
--WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
--ORDER BY STUDENT_NO;

--15. ���л� �ƴ� �л� �� ���� 4.0 �̻��� �л��� �й� �̸� �а� �̸�, ���� ���
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, AVG(POINT)
FROM tb_department
JOIN tb_student USING(DEPARTMENT_NO)
JOIN tb_grade USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;
--GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME �� ���⼭ �ϳ��� ���� �ȵǴ°�?

--16. ȯ�������а� ����������� ���� �� ����
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM tb_class
JOIN tb_grade USING (CLASS_NO)
JOIN tb_department USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME  = 'ȯ�������а�' AND CLASS_TYPE LIKE '%����%'
GROUP BY CLASS_NO,CLASS_NAME;

--17. �ְ��� �л��� ���� �� �л����� �̸��� �ּ�
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM tb_student
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                        FROM TB_STUDENT
                        WHERE STUDENT_NAME = '�ְ���');

--18. ������а����� �� ������ ���� ���� �л� �̸� �й�
SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
     JOIN TB_GRADE USING(STUDENT_NO)
     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '������а�'
     GROUP BY STUDENT_NO, STUDENT_NAME
     ORDER BY AVG(POINT) DESC;

SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
        FROM TB_STUDENT
     JOIN TB_GRADE USING(STUDENT_NO)
     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '������а�'
     GROUP BY STUDENT_NO, STUDENT_NAME
     ORDER BY AVG(POINT) DESC)
WHERE ROWNUM =1;

--19. ȯ�������а��� ���� ���� �迭 �а����� �а��� �������� ����
--ȯ�������а� ���� �迭
SELECT CATEGORY
FROM tb_department
WHERE DEPARTMENT_NAME = 'ȯ�������а�';

--�ڿ����� �迭 �а�
SELECT DEPARTMENT_NAME
FROM tb_department
WHERE CATEGORY = (SELECT CATEGORY
                    FROM tb_department
                    WHERE DEPARTMENT_NAME = 'ȯ�������а�');

--�а��� �������� ����
SELECT DEPARTMENT_NAME,TRUNC( AVG(POINT),1)
FROM tb_department
JOIN tb_class USING (DEPARTMENT_NO)
JOIN tb_grade USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                    FROM tb_department
                    WHERE DEPARTMENT_NAME = 'ȯ�������а�')
GROUP BY DEPARTMENT_NAME;
