--1. 학과 이름과 계열을 표시하시오.
--단 별칭은 학과명, 계열로 표시
SELECT DEPARTMENT_NAME 학과명, CATEGORY 계열
FROM TB_DEPARTMENT;

--2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력
--학과별 정원
-------------------------------
--국어국문학과의 정원은 20명 입니다.
--영어영문학과의 정원은 36명 입니다.
SELECT DEPARTMENT_NAME ||'의 정원은 ' || CAPACITY || '명 입니다.' 학과별정원
FROM tb_department;

--3. 국어국문학과에 다니는 여학생 중 현재 휴학중인 여학생을 찾기
--국문학과의 학과코드는 학과 테이블(TB_DEPARTMENT)을 조회
SELECT STUDENT_NAME
FROM tb_student S, tb_department D
WHERE ABSENCE_YN = 'Y' AND S.DEPARTMENT_NO = D.DEPARTMENT_NO AND SUBSTR(STUDENT_SSN,8,1) = 2 AND DEPARTMENT_NAME = '국어국문학과';

--4. 대출 도서 장기 연체자의 이름 찾기
--학번  A513079, A513090, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ( 'A513079', 'A513090', 'A513110', 'A513119');

--5. 입학정원이 20명 이상 30명 이하인 학과 이름과 계열 출력
SELECT DEPARTMENT_NAME, CATEGORY 
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6. 대학교 총장 이름은? (모든 교수는 소속학과 가지고 있음. 총장 없음)
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. 학과 지정 안된 학생
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. 선수과목 존재하는 과목의 과목번호 조회
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. 계열(CATEGORY) 조회
SELECT DISTINCT CATEGORY
FROM tb_department;

--10. 02학번 전주 거주자 의 학번, 이름, 주민번호 출력(휴학제외)
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'N' AND student_address LIKE '전주%' AND SUBSTR(TO_CHAR(ENTRANCE_DATE), 1, 2) = 02; 


