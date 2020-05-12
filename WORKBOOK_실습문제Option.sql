-- 1. 학생이름과 주소지 표시. 이름 정렬
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지
FROM tb_student
ORDER BY student_name;

-- 2. 휴학생 이름 주민번호
SELECT STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'Y'
ORDER BY student_ssn DESC;

-- 3. 주소가 강원도나 경기도 학생 중 1900년대 학번가진 학생의 이름 학번 주소를 이름 오름차순으로
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM tb_student
WHERE (student_address LIKE '강원도%' OR student_address LIKE '경기도%') AND STUDENT_NO NOT LIKE '%A%'
ORDER BY student_name;

--4. 현재 법학과 교수 중에 가장 나이가 많은 사람부터 이름 확인
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR JOIN TB_CLASS USING (DEPARTMENT_NO)
WHERE CLASS_NAME LIKE '법%'
ORDER BY professor_ssn;

--5. 2004년 2학기에 C3118100 과목을 수강한 학생들의 학점 조회.
--학점 높은 순서대로 표시하고 학점 같으면 낮은 학생부터 푯
SELECT STUDENT_NO, TO_NUMBER(POINT, 9.99)POINT
FROM tb_grade
WHERE class_no = 'C3118100' AND term_no = '200402'
ORDER BY POINT DESC, student_no;

--6. 학생 번호, 이름, 학과이름을 학생이름  오름차순으로 정렬
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM tb_student
JOIN TB_DEPARTMENT USING( DEPARTMENT_NO )
ORDER BY STUDENT_NAME;

--7. 과목 이름, 학과 이름
SELECT CLASS_NAME, DEPARTMENT_NAME 
FROM TB_CLASS
JOIN tb_department USING (DEPARTMENT_NO);

--8. 과목별 교수 이름. 과목 이름, 교수 이름
SELECT DISTINCT CLASS_NAME, PROFESSOR_NAME
FROM tb_class
JOIN tb_professor USING (DEPARTMENT_NO)
GROUP BY CLASS_NAME, PROFESSOR_NAME;

--9. 8번 결과중에 인문사회 계열에 속한 과목 교수 이름
SELECT CLASS_NAME, PROFESSOR_NAME
FROM tb_class
JOIN tb_professor USING (DEPARTMENT_NO)
JOIN tb_department USING (DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';
--GROUP BY CLASS_NAME;

--10. 음악학과 학생들 평점 구하기. 학번, 학생 이름, 전체평점
SELECT STUDENT_NO 학번 , STUDENT_NAME "학생 이름" , ROUND(AVG(POINT),1) 전체평점
FROM tb_grade
JOIN tb_student USING (STUDNET_NO)
JOIN tb_department USING (DEPARMTNE_NO)
WHERE DEPARTMENT_NAME = '음악학과';
--GROUP BY DEPARTMENT_NO;

----11. 학번이 A313047 인 학생의 학과 이름, 지도교수 이름
--SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME
--FROM tb_professor
--JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
--JOIN TB_STUDENT USING (DEPARTMENT_NO)
--WHERE STUDENT_NO = 'A313047';

--12. 2007년에 인간관계론 수업 들은 학생 이름, 수강학기 이름
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM tb_student 
JOIN tb_grade USING (STUDENT_NO)
JOIN tb_class USING (CLASS_NO)
WHERE TERM_NO LIKE '2007%' AND CLASS_NAME = '인간관계론';

--13. 예체능 과목 중 담당교수가 없는 과목 이름과 학과 이름
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
    LEFT JOIN tb_department USING(DEPARTMENT_NO)
    LEFT JOIN tb_class_professor USING (CLASS_NO)
WHERE CATEGORY = '예체능' AND PROFESSOR_NO IS NULL;

----14. 서반아어학과 학생들의 지도교수
----지도교수 없을 땐 지도교수 미지정. 고학번부터
--SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME,'지도교수 미지정') 지도교수
--FROM tb_student 
--LEFT JOIN tb_professor ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
-- JOIN tb_department USING (department_no)
--WHERE DEPARTMENT_NAME = '서반아어학과'
--ORDER BY STUDENT_NO;

--15. 휴학생 아닌 학생 중 평점 4.0 이상인 학생의 학번 이름 학과 이름, 평점 출력
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, AVG(POINT)
FROM tb_department
JOIN tb_student USING(DEPARTMENT_NO)
JOIN tb_grade USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;
--GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME 왜 여기서 하나만 쓰면 안되는가?

--16. 환경조경학과 전공과목들의 과목 별 평점
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM tb_class
JOIN tb_grade USING (CLASS_NO)
JOIN tb_department USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME  = '환경조경학과' AND CLASS_TYPE LIKE '%전공%'
GROUP BY CLASS_NO,CLASS_NAME;

--17. 최경희 학생과 같은 과 학생들의 이름과 주소
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM tb_student
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                        FROM TB_STUDENT
                        WHERE STUDENT_NAME = '최경희');

--18. 국어국문학과에서 총 평점이 가장 높은 학생 이름 학번
SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
     JOIN TB_GRADE USING(STUDENT_NO)
     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '국어국문학과'
     GROUP BY STUDENT_NO, STUDENT_NAME
     ORDER BY AVG(POINT) DESC;

SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
        FROM TB_STUDENT
     JOIN TB_GRADE USING(STUDENT_NO)
     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '국어국문학과'
     GROUP BY STUDENT_NO, STUDENT_NAME
     ORDER BY AVG(POINT) DESC)
WHERE ROWNUM =1;

--19. 환경조경학과가 속한 같은 계열 학과들의 학과별 전공과목 평점
--환경조경학과 속한 계열
SELECT CATEGORY
FROM tb_department
WHERE DEPARTMENT_NAME = '환경조경학과';

--자연과학 계열 학과
SELECT DEPARTMENT_NAME
FROM tb_department
WHERE CATEGORY = (SELECT CATEGORY
                    FROM tb_department
                    WHERE DEPARTMENT_NAME = '환경조경학과');

--학과별 전공과목 평점
SELECT DEPARTMENT_NAME,TRUNC( AVG(POINT),1)
FROM tb_department
JOIN tb_class USING (DEPARTMENT_NO)
JOIN tb_grade USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                    FROM tb_department
                    WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME;
