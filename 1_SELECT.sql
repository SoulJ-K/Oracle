--SELECT
--Result Set : SELECT 구문으로 데이터를 조회한 결과물. 반환된 행들의 집합(0행 이상)

--ENOPLOYEE테이블의 사번과 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM employee;

--EMPLOYEE테이블에서 모든 사원의 모든 정보 조회
SELECT EMP_ID,emp_name,emp_no,EMAIL,phone,dept_code,job_code,sal_level,salary,bonus,manager_id,hire_date,ent_date,ent_yn
FROM employee;
SELECT * 
FROM employee;

--미니 실습문제
--1.JOB테이블의 모든 정보 조회
SELECT *
FROM JOB;
--2.JOB테이블의 직급 이름 조회
SELECT JOB_NAME
FROM JOB;
--3.DEPARTMENT테이블의 모든 정보 조회
SELECT *
FROM department;
--4.EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME,EMAIL,PHONE,hire_date
FROM employee;
--5.EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE,EMP_NAME,SALARY
FROM employee;

--컬럼 값 산술 연산
--SELECT시 컬럼 명 입력 부분에 계산에 필요한 컬럼명, 숫자, 연산자를 이용해서 결과 조회 가능

--EMPLOYEE테이블에 직원명, 연봉 조회(연봉 = 급여 *12)
SELECT EMP_NAME, SALARY*12
FROM employee;

--EMPLOYEE테이블에서 직원의 직원명, 연봉, 보너스를 추가한 연봉 조회
SELECT EMP_NAME, salary*12, (SALARY + (SALARY*BONUS))*12
FROM employee;

SELECT EMP_NAME, salary*12, (SALARY*(1+BONUS))*12
FROM employee;

SELECT *, SALARY*12   --*는 혼자써야함
FROM employee;

--미니실습문제
--1. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME, salary*12, (SALARY * (1+BONUS))*12, (SALARY * (1 + BONUS))*12 - ((SALARY*12)*0.03)
FROM employee;
--2. EMPLOYEE테이블에서 이름, 고용일, 근무일수(오늘 날짜 - 고용일) 조회
SELECT SYSDATE -- 오늘 날짜
FROM DUAL; -- 가상테이블
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE)
FROM employee;

SELECT SYSDATE - HIRE_DATE 근무일수, ROUND(SYSDATE-HIRE_DATE)반올림, CEIL(SYSDATE-HIRE_DATE)올림, FLOOR(SYSDATE-HIRE_DATE)내림,
        TRUNC(SYSDATE-HIRE_DATE)버림
FROM employee;

--컬럼 별칭
--컬럼 명 AS별칭
--컬럼 명 "별칭"
--컬럼 명 AS "별칭"
--컬럼 명 별칭
--별칭에 띄어쓰기, 특수문자, 숫자가 포함되는 경우 무조건 ""로 묶어야함.

--EMPLOYEE테이블에서 직원의 직원명(별칭:이름), 연봉(별칭:연봉(원)), 보너스를 추가한 연봉(별칭 : 총소득(원)) 조회
SELECT EMP_NAME 이름, SALARY*12 "연봉(원)", (SALARY*(1+BONUS))*12 AS"총소득(원)"
FROM EMPLOYEE;

--EMPLOYEE테이블에서 이름, 고용일, 근무일수(오늘날짜-고용일)조회
SELECT EMP_NAME AS 이름, HIRE_DATE AS 고용일, FLOOR(SYSDATE-HIRE_DATE) 근무일수
FROM employee;

--리터럴 : 테이블안에는 없는데 지정해서 뽑아놓은 것
--리터럴 : 임의로 정한 문자열을 select절에 사용하면 테이블에 존재하는 데이터처럼 사용 가능
--문자나 날짜 리터럴은 '' 기호 사용되며 모든 행에 반복 표시 됨

--employee테이블에서 직원의 직원 번호, 사원명, 급여, 단위(데이터 값 : 원) 조회
select EMP_ID 직원번호, EMP_NAME 사원명, SALARY 급여, '원' 단위
FROM EMPLOYEE;

--DISTINCT : 컬럼에 포함된 중복값을 한번씩만 표기하고자 할 때 사용, SELECT절에 딱 한번만 사용 가능
--EMPLOYEE테이블에서 직원의 직급 코드 조회
SELECT JOB_CODE
FROM employee;

--EMPLOYEE테이블에서 직원의 직급코드를 중복제거하여 조회
SELECT DISTINCT JOB_CODE
FROM employee;

--EMPLOYEE테이블에서 부서코드와 직급코드를 중복제거하여 조회
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM employee;

--WHERE절 : SELECT에 걸리는 조건문이 들어가는 절
--조회할 테이블에서 조건이 맞는 값을 가진 행을 골라냄
--비교 연산자
-- = 같다 /  > 크다  / < 작다   /  >= 크거나 같다    / <= 작거나 같다 /  !=, ^=, <> 같지 않다

--EMPLOYEE테이블에서 부서코드가 'D9'인 직원 이름, 부서 코드 조회
SELECT EMP_NAME, DEPT_CODE 
FROM employee
WHERE DEPT_CODE = 'D9';

--EMPLOYEE테이블에서 급여가 4000000 이상인 직원의 이름, 급여 조회
SELECT EMP_NAME, SALARY, '원' 
FROM employee
WHERE SALARY >= 4000000;

--EMPLOYEE테이블에서 부서코드가 D9이 아닌 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM employee
WHERE DEPT_CODE != 'D9';  -- ^=, <>

--EMPLOYEE테이블에서 퇴사 여부가 N인 직원을 조회하고 근무여부를 재직중으로 표시하여 사번, 이름, 고용일, 근부여부 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '재직중' 근무여부
FROM employee
WHERE ENT_YN = 'N';

--미니 실습 문제
--1. EMPLOYEE테이블에서 월급이 3000000이상인 사원의 이름, 월급, 고용일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE SALARY >= 3000000;

--2. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM employee
WHERE SAL_LEVEL = 'S1';

--3. EMPLOYEE테이블에서 실수령액(총수령액-(연봉*세금 3%))이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME, SALARY, (SALARY * (1+BONUS)*12) - ((SALARY*12)*0.03), HIRE_DATE
FROM employee
WHERE (SALARY *(1+BONUS)*12) - ((SALARY*12)*0.03) >= 50000000;

--논리 연산자 : AND / OR
--EMPLOYEE테이블에서 부서코드가 'D6'이고 급여를 2백만원보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D6' AND SALARY > 2000000;

--EMPLOYEE테이블에서 부서코드가 'D6'이거나 급여를 2백만원보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D6' OR SALARY > 2000000;

--EMPLOYEE테이블에서 급여를 350만원 이상 600만원 이하를 받는 직원의 사번, 이름, 급여, 부서코드, 직급 코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM employee
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--미니실습문제
--EMPLOYEE테이블에서 월급이 400만원 이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM employee
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

--EMPLOYEE테이블에서 DEPT_CODE가 D9이거나 D5인 사원 중 고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE,  HIRE_DATE
FROM employee
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/01/01';
--AND가 우선순위를 가짐.

--BETWEEN AND : 하한 값 이상 상한 값 이하 (끝의 값 포함)
--컬럼명 between 하한 값 and 상한값
--하한값 <= 컬럼명 <= 상한값

--급여를 3500000원보다 많이 받고 6000000보다 적게 받는 사원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--반대로 급여를 350만원 미만 또는 600만원을 초과하는 직원의 사번, 이름, 급여, 부서코드, 직급코드(NOT붙이면 됨.)
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
--WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

--미니실습문제
--EMPLOYEE테이블에 고용일이 '90/01/01'~'01/01/01'인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--LIKE
--비교하려는 값이 지정한 특정 패턴을 만족시키는지 조회
-- % : 0글자 이상
-- _ : 1글자 
-- '글자%' : 글자~ 로 되어있는 리터럴들을 조회. 글자로 시작하는 값. 글자 뒤에 아무것도 없어도 됨
-- '%글자%' : 글자가 포함된 값
-- '%글자' : 글자로 끝나는 값
-- '글자_' : 글자로 시작하는 값
-- '_' : 한 글자
-- '__' : 두 글자
-- '박__' : 박으로 시작하는 3글자

--EMPLOYEE테이블에서 성이 전씨인 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM employee
WHERE EMP_NAME  LIKE '전%';

--EMPLOYEE테이블에서 이름에 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM employee
WHERE EMP_NAME LIKE '%하%';

--EMPLOYEE테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM employee
WHERE PHONE LIKE '___9%';

--EMPLOYEE테이블에서 이메일 중 _ 앞글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일 주소 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM employee
WHERE EMAIL LIKE '____%';
-- % , _를 와일드카드라고 명명
--와일드 카드가 검색하고자하는 조건 안에 들어가는 문자와 같기 때문에 문자 자체가 아닌 와일드카드로 인식

-- ESCAPE OPTION : 데이터로 처리할 패턴 기호 앞에 임의의 문자를 사용하고  ESCAPE OPTION 등록
SELECT EMP_ID, EMP_NAME, EMAIL
FROM employee
--WHERE EMAIL LIKE '___#_%' ESCAPE '#';
WHERE EMAIL LIKE '___ _%' ESCAPE ' ';
--#자리에 무엇이 들어가든 상관 없음.

--NOT LIKE : 특정패턴을 만족시키지 않는 값을 조회
--EMPLOYEE 테이블에서 김씨 성이 아닌 직원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM employee
WHERE EMP_NAME NOT LIKE '김%';

--미니 실습 문제
--EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
FROM employee
WHERE EMP_NAME LIKE '%연';

--EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM employee
WHERE PHONE NOT LIKE '010%';

--EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4자 이면서 DEPT_CODE가 D9 또는 D6이고
--   고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만원 이상인 사원의 전체를 조회
SELECT *
FROM employee
WHERE EMAIL LIKE '____$_%' ESCAPE '$' AND  (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
        AND (HIRE_DATE BETWEEN '90/01/01' AND '00/12/01') AND SALARY >= 2700000;
        
--IS NULL / IS NOT NULL
--IS NULL : 컬럼값이 NULL인 경우
--IS NOT NULL : 컬럼값이 NULL이 아닌 경우

--EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
WHERE BONUS IS NULL;

--EMPLOYEE 테이블에서 보너스를 받는 사원의 사번, 이름, 급여 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--EMPLOYEE 테이블에서 관리자도 없고 부서배치도 받지 않은 직원의 이름, 관리자, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE (MANAGER_ID IS NULL) AND DEPT_CODE IS NULL;

--EMPLOYEE 테이블에서 부서 배치를 받지 않았지만 보너스를 받는 직원의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE IS NULL) AND BONUS IS NOT NULL;

--IN
--비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산자
--EMPLOYEE 테이블에서 부서코드가 D6이거나 D8인 사원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D9');

--직급코드가 J1, J2, J3, J4인 사람들의 이름, 직급코드, 급여
--1. IN 미사용
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';

--2. IN 사용
SELECT EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE JOB_CODE IN('J1','J2','J3','J4');

--연결 연산자 || : 여러 컬럼을 연결하거나 컬럼과 리터럴 연결
--EMPLOYEE테이블에서 사번, 이름, 급여를 연결하여 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM employee;

--EMPLOYEE테이블에서 '사원 명의 월급은 급여원입니다.' 형식으로 조회
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원입니다.'
FROM employee;

