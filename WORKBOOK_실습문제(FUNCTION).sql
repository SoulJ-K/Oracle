--1. ������а�(�а��ڵ� 002) �л����� �й�, �̸�, ���г⵵ ���
--���г⵵ ���� ������ ���
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM tb_student
WHERE DEPARTMENT_NO = '002'
ORDER BY entrance_date;

--2. ���� �̸��� �����ڰ� �ƴ� ������ �̸�, �ֹι�ȣ
SELECT professor_name, PROFESSOR_SSN
FROM tb_professor
WHERE LENGTH(professor_name) != 3;

--3. ���� �������� �̸��� ���� ���
-- ���� ��������, ���̴� ������
-- ��Ī �����̸�, ����
SELECT PROFESSOR_NAME �����̸�, ABS(TRUNC(MONTHS_BETWEEN(SYSDATE,SUBSTR(PROFESSOR_SSN, 1, 6))/12)) ����
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY ����;

--4. ���� �̸� �� �� ���� �̸��� ���. ��Ī�� �̸�
SELECT SUBSTR(PROFESSOR_NAME,2) �̸�
FROM tb_professor;

--5. ����� ������ ã��. 19�� ���� != ���
SELECT STUDENT_NAME
FROM tb_student
WHERE EXTRACT(YEAR FROM entrance_date) - TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,2), 'RR'), 'YYYY') >19;

--6. 2020�� ũ���������� ���� ����?
--�޷º��°� ������
SELECT TO_CHAR(TO_DATE('20201225', 'YYYYMMDD'), 'DAY')
FROM DUAL;

--7.TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD') ���� ��¥�� ��ȯ
--7-1. TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD') ���� ��¥�� ��ȯ
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYYMMDD'), TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYYMMDD') ,
        TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'),'YYYYMMDD'), TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'),'YYYYMMDD')
FROM DUAL;

--8. 2000�⵵ ���� ������ �й� A%, 2000�⵵ ���� �й� �л��� �й�, �̸� ���
SELECT STUDENT_NAME, STUDENT_NO
FROM tb_student
WHERE ENTRANCE_DATE < '00/01/01';

--9. �й� A517178 �ѾƸ� ���� �� ����(�ݿø�, �Ҽ��� ���ڸ�)
--��Ī ����
SELECT ROUND(AVG(POINT),1) ����
FROM tb_grade
WHERE STUDENT_NO = 'A517178';

--10. �а��� �л��� ���ϱ� ���� ��Ī �а���ȣ �л���(��)
SELECT DEPARTMENT_NO �а���ȣ, COUNT(*) "�л���(��)"
FROM tb_student
GROUP BY department_no
ORDER BY 1;

--11. �������� ���� �л� ���?
SELECT COUNT(*)
FROM tb_student
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й� A112113 ������ �⵵�� ���� ���ϱ�(�ݿø�, �Ҽ��� ���ڸ�)
--��Ī �⵵, �⵵ �� ����
SELECT SUBSTR(TERM_NO,1,4) �⵵, ROUND(AVG(POINT),1) "�⵵ �� ����"
FROM tb_grade
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY SUBSTR(TERM_NO,1,4);

--13. �а� �� ���л� �� "�а��ڵ��" "���л� ��"
SELECT DEPARTMENT_NO �а��ڵ��, COUNT(ABSENCE_YN) "���л� ��"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO;


--14. ���� �̸� ã�� (���� �̸��� ���������)
SELECT STUDENT_NAME, COUNT(*)
FROM tb_student
GROUP BY student_name
HAVING COUNT(*) > 1;

--15. �й� A112113 ������ �⵵, �б⺰ ������ �⵵ �� ���� ����, �� ����
--������ �ݿø� �Ҽ��� ���ڸ� 
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, SUBSTR(TERM_NO, 5, 2)�б�, ROUND(AVG(POINT),1) ���
FROM tb_grade
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO, 1, 4) , SUBSTR(TERM_NO, 5, 2));
--HAVING NVL(ROLLUP (SUBSTR(TERM_NO, 1, 4) , SUBSTR(TERM_NO, 5, 2)), '  ');



