--VIEW(뷰)
--SELECT 쿼리 실행 결과 화면을 저장한 객체, 논리적인 가상 테이블
--실제 데이터를 저장하고 있지 않지만 테이블을 사용하는 것과 동일하게 사용 가능
--표현식
--CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리
--OR REPLACE : 뷰 생성 시 같은 이름의 뷰가 기존에 존재한다면 덮어쓰기 가능
--OR REPLACE를 사용하지 않고 뷰를 생성 후 같은 이름의 뷰 또 생성 시 이미 다른 객체가 사용중인 이름이라고 에러 발생

--사번, 이름, 부서 명, 근무 지역을 조회하고 그 결과를 V_EMPLOYEE라는 뷰를 생성하여 저장
CREATE OR REPLACE VIEW V_EMPLOYEE 
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING(NATIONAL_CODE);
--    insufficient privileges : 뷰를 생성할 권한이 없음

GRANT CREATE VIEW TO KH;    --관리자계정에서

SELECT * FROM v_employee;

COMMIT;

SELECT EMP_NAME
FROM v_employee
WHERE EMP_ID = '205';

-- EMPLOYEE테이블에서 사번이 205번인 사원의 이름을 '정중앙'으로 변경
UPDATE EMPLOYEE 
SET EMP_NAME = '정중앙'
WHERE EMP_ID = 205;

SELECT * FROM v_employee;
--베이스테이블의 정보가 변경되면 VIEW도 같이 변경됨.

ROLLBACK;

--생성된 뷰 컬럼에 별칭 부여
--서브쿼리의 SELECT절에 함수가 사용된 경우 반드시 별칭 지정(뷰 서브쿼리 안에 연산 결과도 포함 가능)
CREATE OR REPLACE VIEW V_EMP_JOB (사번, 이름, 직급, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO,8,1), 1, '남', '여'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);
--must name this expression with a column alias : 반드시 별칭이 필요하다.

SELECT * FROM V_EMP_JOB;

--생성된 뷰를 이용해 DML문 사용 가능
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

--뷰에 INSERT사용
INSERT INTO V_JOB
VALUES ('J8', '인턴');

SELECT * FROM V_JOB;
SELECT * FROM JOB;

--뷰에서 요청한 DML구문은 베이스 테이블도 변경함

--뷰에 UPDATE사용
UPDATE V_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE= 'J8';

--뷰에 DELETE 사용
DELETE FROM V_JOB
WHERE JOB_CODE = 'J8';

COMMIT;

--DML명령어로 조작이 불가능한 경우
--1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
FROM JOB;

SELECT * FROM V_JOB2;
SELECT * FROM JOB;

INSERT INTO V_JOB2 VALUES('J8', '인턴');
--00913. 00000 -  "too many values"

UPDATE V_JOB2
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
--ORA-00904: "JOB_NAME": invalid identifier

DELETE FROM V_JOB2
WHERE JOB_NAME = '사원';
--ORA-00904: "JOB_NAME": invalid identifier

--2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
-- : INSERT에서만 오류발생
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
FROM JOB;

SELECT * FROM V_JOB3;

INSERT INTO V_JOB3 VALUES ('인턴');
--ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
--뷰에 INSERT를 하면 베이스테이블에도 영향을 줌. 
--베이스 테이블에 있는 JOB_CODE에는 NOT NULL 제약조건이 걸려있음. 
--V_JOB3에 인턴을 넣으면 JOB테이블에 있는 JOB_CODE값은 정해지지 않아 NULL이 되는데 NOT NULL제약조건이 걸려있어서 오류뜸

INSERT INTO JOB VALUES ('J8', '인턴');

UPDATE V_JOB3
SET JOB_NAME = '알바'
WHERE JOB_NAME = '인턴';

DELETE FROM V_JOB3
WHERE JOB_NAME = '알바';

--3. 산술 표현식으로 정의된 경우
--사번, 사원 명, 급여, 보너스가 포함된 연봉으로 이루어진 EMP_SAL 뷰 생성
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*(1+NVL(BONUS,0))*12 연봉
FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES (800, '정진훈', 3000000, 36000000);
--ORA-01733: virtual column not allowed here : 연봉이 산술표현식으로 계산되고 있는데 추가하려는 값은 산술표현이 아니고 바로 값으로 넣어서 오류)

UPDATE EMP_SAL
SET 연봉 = 8000000
WHERE EMP_ID = 200;
--ORA-01733: virtual column not allowed here : INSERT랑 같은 이유

COMMIT;

DELETE FROM EMP_SAL
WHERE 연봉 = 124800000;
--계산 결과값이 아닌 일치된 것만 찾아서 지우는 것이기 때문에 실행됨

ROLLBACK;

CREATE OR REPLACE VIEW VVV
AS (SELECT EMP_ID
FROM EMPLOYEE);

DROP VIEW VVV;


--4. 그룹함수나 GROUP BY절을 포함한 경우
--부서코드, 보서 코드 별 급여 합계, 부서 코드 별 급여 평균을 가지고 있는 V_GROUPDEPT 뷰 생성
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY)평균
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES ('D10', 6000000, 4000000);
--ORA-01733: virtual column not allowed here 
--그룹함수 포함해서

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';
--ORA-01732: data manipulation operation not legal on this view

DELETE  FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';
--data manipulation operation not legal on this view

--5. DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES ('J9');
--ORA-01732: data manipulation operation not legal on this view

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';

DELETE FROM V_DT_EMP
WHERE JOB_CODE = 'J1';


--6. JOIN을 이용해 여러 테이블을 연결한 경우
--사번, 사원명, 부서명 정보를 가지고 있는 V_JOINEMP 뷰 생성
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES (888, '조세오', '인사관리부');
--ORA-01776: cannot modify more than one base table through a join view
--조인된 VIEW에서는 불가

UPDATE V_JOINEMP
SET DEPT_TITLE = '인사관리부'
WHERE EMP_ID = 219;                     -- 오류뜸
--RA-01779: cannot modify a column which maps to a non key-preserved table

COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;

ROLLBACK;

SELECT * FROM USER_VIEWS;
--테이블에서 값을 가져온게 아니라 텍스트에 저장되어있는 것을 가져옴

--VIEW 옵션
--VIEW 생성 표현식
--CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름 [별칭,별칭,별칭]
--AS SUBQUERY
--[WITH CHECK OPTION]
--[WITH READ ONLY];

--1) OR REPLACE 옵션 : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
--2) FORCE / NOFORCE 옵션
--   FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
--   NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본값)
--3) WITH CHECK OPTION 옵션 : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함
--4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능

--1) OR REPLACE 옵션 : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
--주민번호와 사원 명 정보를 가지고 있는 V_EMP1뷰 생성
CREATE OR REPLACE VIEW V_EMP1(주민번호,이름)
AS SELECT EMP_NO, EMP_NAME 
FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1(주민번호,이름,급여)
AS SELECT EMP_NO, EMP_NAME , SALARY
FROM EMPLOYEE;

CREATE VIEW V_EMP1
AS SELECT EMP_NO, EMP_NAME
FROM EMPLOYEE;
--ORA-00955: name is already used by an existing object  -----> 덮어쓰기 불가

--2) FORCE / NOFORCE 옵션
--   FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
CREATE OR REPLACE /*NOFORCE*/VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
--    table or view does not exist : 테이블/뷰가 존재하지 않아욤
CREATE OR REPLACE FORCE VIEW V_EMP2
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT;
    
 SELECT * FROM V_EMP2;
    --뷰 생성만 되어있음
 SELECT * FROM USER_VIEWS;
--   NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본값)

--3) WITH CHECK OPTION 옵션 : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함
CREATE OR REPLACE VIEW V_EMP3
AS SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' WITH CHECK OPTION;

SELECT* FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
--ORA-01402: view WITH CHECK OPTION where-clause violation   : VIEW의 체크옵션에 위배되었다.
--WITH CHECK OPTION 을 걸어서 바꿀 수 없게 만들어놓음

COMMIT;

UPDATE V_EMP3
SET EMP_NAME = '선동이'
WHERE EMP_ID = 200;

ROLLBACK;

--4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능
CREATE OR REPLACE VIEW V_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

DELETE FROM V_DEPT;
--ORA-42399: cannot perform a DML operation on a read-only view

COMMIT;
