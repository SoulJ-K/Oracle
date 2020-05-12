--함수(FUNCTION) : 컬럼의 값을 읽어서 계산한 결과 리턴
--단일 행 함수(SINGLE ROW FUNCTION) : N개의 값을 넣어서 N개의 결과 리턴
--그룹 함수(GROUP FUNCTION) : N개의 값을 넣어서 한 개의 결과 리턴
--SELECT안에 단일행함수와 그룹함수가 같이 들어갈 수 없다.

SELECT LENGTH(EMP_NAME)
FROM EMPLOYEE;

SELECT COUNT(EMP_NAME)
FROM employee;

select count (BONUS) from employee;

--SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--FROM employee;
-- SELECT안에 반환하는 갯수가 달라서 반환이 안됨

--함수를 사용할 수 있는 위치
--SELECT절, WHERE절, GROUP BY절, HAVING절, ORDER BY절


--단일 행 함수

--1. 문자 관련 함수

--LENGTH / LENGTHB
--LENGTH(컬럼명 | '문자열') : 글자 수 반환
--LENGTHB(컬럼명 | '문자열') : 글자의 바이트 사이즈 반환
SELECT LENGTH('오라클'), LENGTH('오라클')
FROM DUAL; --가상 테이블

SELECT EMAIL, LENGTH(EMAIL), LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT LENGTHB('오라클'), LENGTH('오라클')  --오라클에서 한글은 3BYTE
FROM DUAL;

--INSTR : 해당 문자열의 첫번째 나오는 위치
SELECT INSTR('AABAACAABBAA', 'B')  --오라클은 제로인덱스 기반이 아님
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'Z')
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1)  --1번째부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1)  -- -1번째(끝)부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'C', -1)  
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1, 2)  -- 두번째로 나오는 B의 위치 반환
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', -1, 2) -- 뒤에서부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'C', 1, 2) --두번째 C가 없기 때문에 0반환
FROM DUAL;

--EMPLOYEE 테이블에서 이메일의 @ 위치 반환
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

--LPAD / RPAD
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;
--LPAD : 주어진 컬럼이나 문자열에 임의의 문자열을 왼쪽에 덧붙여 길이 N의 문자열 반환

SELECT RPAD(EMAIL, 20, '$')
FROM EMPLOYEE;
--RPAD : 주어진 컬럼이나 문자열에 임의의 문자열을 오른쪽에 덧붙여 길이 N의 문자열 반환

--LTRIM / RTRIM / TRIM : 주어진 컬럼이나 문자열의 왼쪽/오른쪽/앞/뒤/양쪽에서 지정한 문자를 제거한 나머지 반환
SELECT LTRIM('   KH')  -- 삭제할 문자열을 지정하지 않았을 경우 기본적으로 공백 제거
FROM DUAL;

SELECT LTRIM('   KH',  ' ') 
FROM DUAL;

SELECT LTRIM('000123456', '0')
FROM DUAL;

SELECT LTRIM('123123KH', '123') 
FROM DUAL;

SELECT LTRIM('123123KH123', '123')  --KH 뒤에 123이 있지만 K를 만나면서 일치하지 않으므로 끝
FROM DUAL;

SELECT LTRIM('ACABACCKH', 'ABC')  --문자가 포함되어있으면 삭제
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

SELECT TRIM('123' FROM '123132KH123321') -- TRIM은 한글자만 제거 가능
FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') --앞
FROM DUAL;

SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ')  --뒤
FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZ')   --양 쪽 둘다
FROM DUAL;

--SUBSTR : 컬럼이나 문자열에서 지정한 위치부터 지정 개수의 문자열을 잘라내 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7)  --7부터 끝까지 쭉 반환. 끝점을 정해주지 않으면 끝까지 반환함
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 5,2)  --5자리 부터 2개
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 5, 0)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3)  --뒤에서부터 시작
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-10, 2)
FROM DUAL;

--EMPLOYEE테이블에서 이름, 이메일 ,@ 이후를 제외한 아이디 조회
SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1)
--SELECT EMP_NAME, EMAIL, RTRIM(EMAIL, '@kh.or.kr')
FROM employee;

--주민등록번호에서 성별을 나타내는 부분만 잘라보기
SELECT SUBSTR(EMP_NO, 8, 1)
FROM employee;

--EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원명, 생년, 생월, 생일 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) 생년, SUBSTR(EMP_NO, 3, 2) 생월, SUBSTR(EMP_NO, 5,2) 생일
FROM employee;

--LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World')   -- 모두 다 소문자로
FROM DUAL;

SELECT UPPER('Welcome To My World')   --모두 다 대문자로
FROM DUAL;

SELECT INITCAP('welcome to my world')   --띄어쓰기를 기준으로 맨 앞글자만 대문자로
FROM DUAL;

--CONCAT
SELECT CONCAT('가나다라', 'ABCD')
FROM DUAL;

SELECT '가나다라' || 'ABCD'
FROM DUAL;

--REPLACE : 지정한 문자열을 바꿈
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동')
FROM DUAL;

SELECT REPLACE('서정호 학생의 별명은 군인일까요?', '군인', '에코')
FROM DUAL;

--EMPLOYEE 테이블에서 이메일의 도메인을 GMAIL.COM으로 변경하기
SELECT REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
from employee;

--select emp_name, replace(EMP_NO, SUBSTR(emp_no, 9), '******')
--SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8)||'******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;


--2. 숫자 관련 함수

--ABS : 절대값을 반환하는 함수
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9)  FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

--MOD : 나머지 값을 구하는 함수
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10, -3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
SELECT MOD(-10.9, 3) FROM DUAL;
SELECT MOD(-10, -3) FROM DUAL;

--ROUND : 반올림(지정해주지 않으면 소수 첫번째 자리가 반올림됨)
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

--번외
SELECT ROUND(-10.61) FROM DUAL; 

--FLOOR : 내림
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

--TRUNC : 버림(잘라내기)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

--CEIL : 올림
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

--3. 날짜 관련 함수
--SYSDATE : 오늘 날짜 반환

--MONTHS_BETWEEN : 날짜와 날짜 사이의 개월 수 차이를 숫자로 리턴하는 함수
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM employee;

--ADD_MONTHS : 날짜에 숫자만큼의 개월 수를 더해 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL;

--NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜를 리턴하는 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
--일 월 화 수 목 금 토
--1  2  3  4 5  6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목캔디 맛없어') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '임연화') FROM DUAL;  --무조건 첫번째 글자가 요일이어야함
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;  --

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--LAST_DAY : 해당 월에 마지막 날짜 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

--EXTRACT : 날짜에서 년, 월, 일 추출하여 리턴
--EXTRACT(YEAR FROM 날짜)
--EXTRACT(MONTH FROM 날짜)
--EXTRACT(DAY FROM 날짜)

--EMPLOYEE 테이블에서 사원의 이름, 입사 년, 입사 월, 입사 일 조회
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 입사년도, EXTRACT(MONTH FROM HIRE_DATE) 입사월, EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE;

--4. 형 변환 함수
--TO_CHAR(날짜[, 포맷]) : 날짜형 데이터를 문자형 데이터로 바꾸는 함수
--TO_CHAR(숫자[, 포맷]) : 숫자형 데이터를 문자형 데이터로 바꾸는 함수

SELECT TO_CHAR(1234) 챠 FROM DUAL;
SELECT TO_CHAR(1234, '99999') 챠 FROM DUAL;  --5칸, 오른쪽 정렬, 빈칸 공백
SELECT TO_CHAR(1234, '00000')챠 FROM DUAL;   --5칸, 오른쪽 정렬, 빈칸 0
SELECT TO_CHAR(1234, 'L99999') 챠 FROM DUAL; --원화 설정
SELECT TO_CHAR(1234, 'FML99999') 챠 FROM DUAL; --공백을 아예 없애고 싶으면 FM
SELECT TO_CHAR(1234, 'FM$99999') 챠 FROM DUAL;
SELECT TO_CHAR(1234, '99,999') 챠 FROM DUAL;    --공백은 무조건 FM
SELECT TO_CHAR(1234, '00,000') 챠 FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') 챠 FROM DUAL;
SELECT TO_CHAR(1234, '999') 챠 FROM DUAL;
SELECT TO_CHAR(SALARY, 'FM9,999,999') FROM employee;

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;  --AM, PM 크게 상관 없음
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL;  --Q : 분기
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY') FROM DUAL;

--오늘 날짜에 대해 연도, 월, 일 출력
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'),TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DDD'), TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'D') FROM DUAL;
--DDD : 년 기준으로 몇일째인지    DD : 오늘 날짜(달 기준)    D : 이번 주에 몇일 째인지

--분기, 요일 출력
SELECT TO_CHAR(SYSDATE, 'Q'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')    FROM DUAL;
        
--TO_DATE : 문자/숫자형 데이터  -> 날짜형 데이터
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;   --오라클에서 연도는 기본적으로 2자리만 출력
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;

--2010 01 01 을 2010, 1월
SELECT TO_CHAR(TO_DATE(20100101, 'YYYYMMDD'), 'YYYY, MON') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM') FROM DUAL;

--RR과 YY의 차이 : 연도를 나타냄
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYYMMDD'),  -- 두 자리 연도에 YY는 무조건 현재 세기 기준
        TO_CHAR(TO_DATE('140918', 'YYMMDD'), 'YYYYMMDD'),
        TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD'),  -- 두 자리 연도가 50년 이상이면 이전 세기, 50년 미만이면 현재 세기 적용
        TO_CHAR(TO_DATE('140918', 'RRMMDD'), 'YYYYMMDD')   
FROM DUAL;

--TO_NUMBER : 문자형 데이터 --> 숫자형 데이터
SELECT TO_NUMBER('12345789') FROM DUAL;
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL;

SELECT '1,000,000' + '550,000' FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;

--5. NULL 처리 함수
--NVL(컬럼명, 컬럼 값이 NULL일 때 바꿀 값)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '없습니다')
FROM EMPLOYEE;

--NVL2(컬럼명, 바꿀 값1, 바꿀 값2)   컬럼값이 NULL이 아니면 바꿀 값1, NULL이면 바꿀 값2 로 바꿈
--EMPLOYEE테이블에서 보너스가 NULL인 직원은 0.5로, NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

--NULLIF(비교대상1, 비교대상2) : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
SELECT NULLIF(123, 123) FROM DUAL;
SELECT NULLIF(123, 124) FROM DUAL;

--6. 선택함수 : 여러 가지 경우 선택할 수 있는 기능 제공
--DECODE(계산식/컬럼명, 조건값1, 선택값1, 조건값2, 선택값2....)
--비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') 성별
FROM employee;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') 성별
FROM employee;
--마지막 인자로 조건 값 없이 선택 값을 작성하면 아무것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함

--CASE WHEN 조건식 THEN 결과 값
--     WHEN 조건식 THEN 결과 값
--     ELSE 결과 값
--END
--비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(조건은 범위 가능)
SELECT EMP_ID, EMP_NAME, EMP_NO, 
           CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남'
            ELSE '여'
            END 성별
            
FROM employee;

--급여가 500만원을 초과하면 1등급, 350만원을 초과하면 2등급, 200만원을 초과하면 3등급, 나머지는 4등급
SELECT EMP_NAME, SALARY, 
        CASE WHEN SALARY > 5000000 THEN '1등급'
             WHEN SALARY > 3500000 THEN '2등급'
            WHEN SALARY > 2000000 THEN '3등급'
            ELSE '4등급' END 등급
--SELECT EMP_NAME, SALARY,
      --  DECODE(SALARY > 5000000, '1등급', SALARY > 3500000, '2등급', SALARY > 2500000, '3등급', '4등급')
      -- DECODE는 크기비교 불가능
FROM EMPLOYEE;

--그룹함수 : 여러 행을 넣으면 한 개의 결과만 반환
--SUM(숫자가 기록된 컬럼) : 합계 리턴
--EMPLOYEE 테이블에서 전 사원의 급여 총합 조회
SELECT SUM(SALARY) FROM employee;

--EMPLOYEE 테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

--AVG(숫자가 기록된 컬럼) : 평균 리턴
--EMPLOYEE 테이블에서 전 사원의 급여 평균 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

--전 사원의 보너스 합계 조회
SELECT SUM(BONUS)
FROM EMPLOYEE;

--보너스 평균 조회
SELECT AVG(BONUS), AVG(NVL(BONUS,0))
FROM EMPLOYEE;
--NULL값을 가진 행은 평균 계산에서 제외

--MIN / MAX : 최소 / 최대
--가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

--가장 많은 급여, 알파벳 순서가 가장 마지막인 이메일, 가장 느린 입사일
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

--COUNT(* 혹은 컬럼명) : 행의 개수 리턴
--COUNT(DISTINCT 컬럼명) : 중복을 제거한 행 개수 리턴
--COUNT(*) : NULL을 포함한 전체 행 개수 리턴
--COUNT(컬럼명) : NULL을 제외한 전체 행 개수 리턴
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

