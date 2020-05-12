--1. 영어영문학과(학과코드 002) 학생들의 학번, 이름, 입학년도 출력
--입학년도 빠른 순으로 출력
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM tb_student
WHERE DEPARTMENT_NO = '002'
ORDER BY entrance_date;

--2. 교수 이름이 세글자가 아닌 교수의 이름, 주민번호
SELECT professor_name, PROFESSOR_SSN
FROM tb_professor
WHERE LENGTH(professor_name) != 3;

--3. 남자 교수들의 이름과 나이 출력
-- 나이 오름차순, 나이는 만나이
-- 별칭 교수이름, 나이
SELECT PROFESSOR_NAME 교수이름, ABS(TRUNC(MONTHS_BETWEEN(SYSDATE,SUBSTR(PROFESSOR_SSN, 1, 6))/12)) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이;

--4. 교수 이름 중 성 제외 이름만 출력. 별칭은 이름
SELECT SUBSTR(PROFESSOR_NAME,2) 이름
FROM tb_professor;

--5. 재수생 입학자 찾기. 19살 입학 != 재수
SELECT STUDENT_NAME
FROM tb_student
WHERE EXTRACT(YEAR FROM entrance_date) - TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,2), 'RR'), 'YYYY') >19;

--6. 2020년 크리스마스는 무슨 요일?
--달력보는게 빠를듯
SELECT TO_CHAR(TO_DATE('20201225', 'YYYYMMDD'), 'DAY')
FROM DUAL;

--7.TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD') 각각 날짜로 변환
--7-1. TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD') 각각 날짜로 변환
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYYMMDD'), TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYYMMDD') ,
        TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'),'YYYYMMDD'), TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'),'YYYYMMDD')
FROM DUAL;

--8. 2000년도 이후 입학자 학번 A%, 2000년도 이전 학번 학생들 학번, 이름 출력
SELECT STUDENT_NAME, STUDENT_NO
FROM tb_student
WHERE ENTRANCE_DATE < '00/01/01';

--9. 학번 A517178 한아름 학점 총 평점(반올림, 소수점 한자리)
--별칭 평점
SELECT ROUND(AVG(POINT),1) 평점
FROM tb_grade
WHERE STUDENT_NO = 'A517178';

--10. 학과별 학생수 구하기 각각 별칭 학과번호 학생수(명)
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM tb_student
GROUP BY department_no
ORDER BY 1;

--11. 지도교수 없는 학생 몇명?
SELECT COUNT(*)
FROM tb_student
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번 A112113 김고운의 년도별 평점 구하기(반올림, 소수점 한자리)
--별칭 년도, 년도 별 평점
SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) "년도 별 평점"
FROM tb_grade
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY SUBSTR(TERM_NO,1,4);

--13. 학과 별 휴학생 수 "학과코드명" "휴학생 수"
SELECT DEPARTMENT_NO 학과코드명, COUNT(ABSENCE_YN) "휴학생 수"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO;


--14. 같은 이름 찾기 (같은 이름이 몇명인지도)
SELECT STUDENT_NAME, COUNT(*)
FROM tb_student
GROUP BY student_name
HAVING COUNT(*) > 1;

--15. 학번 A112113 김고운의 년도, 학기별 평점과 년도 별 누적 평점, 총 평점
--평점은 반올림 소수점 한자리 
SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 2)학기, ROUND(AVG(POINT),1) 평균
FROM tb_grade
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO, 1, 4) , SUBSTR(TERM_NO, 5, 2));
--HAVING NVL(ROLLUP (SUBSTR(TERM_NO, 1, 4) , SUBSTR(TERM_NO, 5, 2)), '  ');



