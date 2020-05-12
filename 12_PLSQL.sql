--PL/SQL (Procedural Language extension to SQL)
--오라클 자체에 내장되어 있는 절차적 언어
--SQL문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL단점 보완

--PL/SQL구조
--선언부 : DECLARE로 시작
--         변수, 상수 선언
--실행부 : BEGIN으로 시작
--          로직 수행
--예외처리부 : EXCEPTION으로 시작
--             예외 상황 발생 시 해결하기 위한 문장 기술

/*
    System.out.println("Hello World");
*/
SET SERVEROUTPUT ON; 
--ON으로 바꿔준 다음에 실행해야함

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/

--타입 변수 선언
--변수의 선언 및 초기화, 변수 값 출력
DECLARE  --선언부
    EMP_ID NUMBER;          --변수명 자료형   NUMBER타입 변수 EMP_ID 선언   ===> JAVA : int empId;
    EMP_NAME VARCHAR2(30);   -- VARCHAR2타입 변수 EMP_NAME 선언           ===> JAVA :  String empName;
    
    PI CONSTANT NUMBER := 3.14;   --NUMBER타입 상수 PI 선언                   ===> JAVA : Final double PI == 3.14;
    --변수 값 대입 연산자 :=
    
BEGIN  --실행부
    EMP_ID := 888;                 --EMP_ID변수에 888로 값 초기화
    EMP_NAME := '배장남';           --EMP_NAME변수에 배장남으로 값 초기화
    
DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
DBMS_OUTPUT.PUT_LINE('PI : ' || PI);

END;
/

--레퍼런스 변수의 선언과 초기화, 변수 값 출력
DECLARE
--    EMP_ID EMPLOYEE.EMP_ID%TYPE;  --변수 EMP_ID의 타입을 EMPLOYEE테이블의 EMP_ID컬럼 타입으로 지정
--    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;

    ID EMPLOYEE.EMP_ID%TYPE;  --변수 EMP_ID의 타입을 EMPLOYEE테이블의 EMP_ID컬럼 타입으로 지정
    NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME  --컬럼이름
    INTO ID, NAME    --가져온 컬럼값을 넣은 변수 이름
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';   --&____ :  _____에 해당하는 값을 사용자에게 대체변수를 입력받는 변수 
    
--    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
--    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);

    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || NAME);
END;
/

--레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY를 선언하고
--EMPLOYEE 테이블에서 사번, 이름, 직급코드, 부서코드, 급여를 조회하고
--선언한 레퍼런스 변수에 담아 출력하시오
--단, 입력받은 이름과 일치하는 조건의 직원을 조회하세요.
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    DC EMPLOYEE.DEPT_CODE%TYPE;
    JC EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO ID, NAME, DC, JC, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || 이름);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DC);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JC);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    
END;
/

--한 행에 대한 ROWTYPE변수 선언과 초기화
DECLARE
    E EMPLOYEE%ROWTYPE;
    --%ROWTYPE : 테이블 또는 뷰의 컬럼 데이터 형, 크기, 속성 참조
BEGIN
    SELECT * 
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

--선택문(조건문)
--IF ~ THEN ~ END IF (단일IF)
--EMP_ID를 입력받아 해당 사원의 사번, 이름, 급여, 보너스율 출력
--단, 보너스를 받지 않는 사원은 보너스율 출력 전, '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
    IF(BONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS*100||'%');
END;
/

--IF ~ THEN ~ ELSE ~ END IF  (IF~ELSE)
--EMP_ID를 입력받아 해당 사원의 사번, 이름, 부서명, 소속 출력하시오
--TEAM변수를 만들어 소속이 'KO'인 사원은 '국내팀', 아닌 사원은 '해외팀'으로 저장
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(20);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&사번';
    
    IF(national_code = 'KO')
    THEN TEAM := '국내팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/

--사원의 연봉을 구하는 PL/SQL 블럭 작성
--보너스가 있는 사원은 보너스도 포함하여 계산
--급여, 이름, 보너스가 포함된 연봉
DECLARE
    E EMPLOYEE%ROWTYPE;
    연봉 NUMBER;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF(E.BONUS IS NULL)
    THEN 연봉 := E.SALARY *12;
    ELSE 연봉 := E.SALARY * (1 + E.BONUS) *12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(E.SALARY || ' ' || E.EMP_NAME || ' ' || TO_CHAR(연봉, 'FML999,999,999'));
 
END;
/
--IF ~ THEN ~ ELSIF ~ ELSE ~ END IF  (IF~ELSE IF~ELSE)
--점수를 입력받아 SCORE변수에 저장하고
--90점 이상은 'A', 80점 이상은 'B', 70점 이상은 'C', 60점 이상은 'D', 60점 미만은 'F'로 조건처리하여 GRADE변수에 저장
--출력양식 : 당신의 점수는 90점이고, 학점은 A학점 입니다.
DECLARE
    SCORE NUMBER;  --INT도 가능 NUMBER(38)과 같은 타입
    GRADE VARCHAR2(2);
BEGIN
    SCORE := '&SCORE';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >=80 THEN GRADE := 'B';
    ELSIF SCORE >=70 THEN GRADE := 'C';
    ELSIF SCORE >=60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 학점은 ' || GRADE || '학점 입니다.');
    
END;
/

--CASE ~ WHEN ~ THEN ~ END(SWITH~CASE)
--사원번호를 입력하여 해당 사원의 사번, 이름, 부서명 출력
--IF ELSIF사용
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF EMP.DEPT_CODE = 'D1' THEN DNAME := '인사관리부';
    ELSIF EMP.DEPT_CODE = 'D2' THEN DNAME := '회계관리부';
    ELSIF EMP.DEPT_CODE = 'D3' THEN DNAME := '마케팅부';
    ELSIF EMP.DEPT_CODE = 'D4' THEN DNAME := '국내영업부';
    ELSIF EMP.DEPT_CODE = 'D5' THEN DNAME := '해외영업1부';
    ELSIF EMP.DEPT_CODE = 'D6' THEN DNAME := '해외영업2부';
    ELSIF EMP.DEPT_CODE = 'D7' THEN DNAME := '해외영업3부';
    ELSIF EMP.DEPT_CODE = 'D8' THEN DNAME := '기술지원부';
    ELSIF EMP.DEPT_CODE = 'D9' THEN DNAME := '총무부';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번       이름        부서명');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || '         ' || EMP.EMP_NAME || '            ' || DNAME);
    
END;
/
    
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DNAME := CASE EMP.DEPT_CODE
            WHEN 'D1' THEN '인사관리부'
            WHEN 'D2' THEN '회계관리부'
            WHEN 'D3' THEN '마케팅부'
            WHEN 'D4' THEN '국내영업부'
            WHEN 'D5' THEN '해외영업1부'
            WHEN 'D6' THEN '해외영업2부'
            WHEN 'D7' THEN '해외영업3부'
            WHEN 'D8' THEN '기술지원부'
            WHEN 'D9' THEN '총부무'
            END;
            
     DBMS_OUTPUT.PUT_LINE('사번       이름        부서명');
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_ID || '         ' || EMP.EMP_NAME || '            ' || DNAME);
END;
/

--반복문
--BASIC LOOP : 내부에 처리문을 작성하고 마지막에 LOOP를 벗어날 조건 명시
/*
    LOOP
        처리문
        조건문
    END LOOP;
    
    조건문
    1) IF 조건식 THEN EXIT; END IF;
    2) EXIT WHEN 조건식
*/

--1~5까지 순차적으로 출력
DECLARE 
    N NUMBER := 1;
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        
--        IF N > 5 THEN EXIT;
--        END IF;
        
        EXIT WHEN N >5;
        
    END LOOP;
END;
/

--FOR LOOP
/*
    FOR 인덱스 IN [REVERSE] 초기값 .. 최종값
    LOOP
        처리문
    END LOOP;
*/
--1~5출력
BEGIN
    FOR N IN 1..5
    LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

--5~1출력
BEGIN 
    FOR N IN REVERSE 1..5
    LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

--반복문을 이용한 데이터 삽입
CREATE TABLE TEST1(
    BUNHO NUMBER(3),
    NALJJA DATE
    );
    
BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST1 VALUES(I, SYSDATE);
    END LOOP;
END;
/
    
SELECT * FROM TEST1;

--중첩반복
--구구단 짝수단 출력
BEGIN
    FOR I IN 1..9 
    LOOP
     IF MOD(I,2) = 0
     THEN
        FOR J IN 1..9
        LOOP
          DBMS_OUTPUT.PUT_LINE(I || '*' || J || '=' || I*J);
        END LOOP;
     END IF;
    END LOOP;
END;
/

--WHILE LOOP
/*
    WHILE 조건
    LOOP
        처리문
    END LOOP;
*/
--1~5
DECLARE
    N NUMBER := 1;
BEGIN
    WHILE N <= 5
    LOOP
        DBMS_OUTP
        UT.PUT_LINE(N);
        N := N +1;
    END LOOP;
END;
/

--WHILE 구구단 짝수단 출력
DECLARE
    N NUMBER := 2;
    M NUMBER;
BEGIN
    WHILE N <=9
    LOOP
    M := 1;
        IF MOD(N,2) = 0
        THEN
            WHILE M <=9
            LOOP
            DBMS_OUTPUT.PUT_LINE(N || '*' || M || '=' || N*M);
            M:= M+1;
            
            END LOOP;
        END IF;
        N := N +1;
    END LOOP;
END;
/

--테이블 타입
--테이블 : 키와 값의 쌍으로 이루어진 컬렉션
--하나의 테이블의 한 개의 컬럼데이터 저장
/*
    TYPE 테이블명 IS TABLE OF 데이터타입
    INDEX BY BINARY_INTEGER;
*/

DECLARE
    --테이블 타입 선언
    TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
    INDEX BY BINARY_INTEGER;
    --EMPLOYEE.EMP_ID타입의 데이터를 저장할 수 있는 테이블 타입 EMP_ID_TABLE_TYPE선언
    
    TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE
    INDEX BY BINARY_INTEGER;
    --EMPLOYEE.EMP_NAME 타입의 데이터를 저장할 수 있는 테이블 타입 EMP_NAME_TABLE_TYPE 선언
    
    --변수선언
    --테이블 타입 EMP_ID_TABLE_TYPE 변수 EMP_ID_TABLE 선언
    EMP_ID_TABLE EMP_ID_TABLE_TYPE;
    --테이블 타입 EMP_NAME_TABLE_TYPE 변수 EMP_NAME_TABLE 선언
    EMP_NAME_TABLE EMP_NAME_TABLE_TYPE;
    
    I BINARY_INTEGER := 0;
BEGIN
    FOR K IN (SELECT EMP_ID, EMP_NAME FROM EMPLOYEE)
    --K에 SELECT해 온 행 하나하나가 들어감
    LOOP
        I := I+1;
        
        EMP_ID_TABLE(I) := K.EMP_ID;
        EMP_NAME_TABLE)I) := K.EMP_NAME;
    END LOOP;
    
    FOR J IN 1..I
    LOOP
        DBMS_OUTPUT.PUT_INE('EMP_ID : ' || EMP_ID_TABLE(J) || ', EMP_NAME : ' || EMP_NAME_TABLE(J));
    END LOOP;
END;
/

--레코드 타입
--서로 다른 유형의 데이터를 한 줄로 나열한 형태
--테이블 타입의 경우 한 타입만 들어갈 수 있다면 레코드 타입의 경우 내가 정한 여러 타입이 들어갈 수 있음
/*
    TYPE 레코드명 IS RECORE(
        필드명 필드타입 [[NOT NULL] := DEFAULT 값],
        필드명 필드타입 [[NOT NULL] := DEFAULT 값],
        ...
        );
*/

DECLARE
    --레코드 타입 선언
    TYPE EMP_RECORD_TYPE IS RECORD(
        EMP_ID EMPLOYEE.EMP_ID%TYPE,
        EMP_NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    
    --레코드 타입 변수 생성
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO EMP_RECORD
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN JOB USING (JOB_CODE)
    WHERE EMP_NAME = '&이름';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_RECORD.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_RECORD.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || EMP_RECORD.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || EMP_RECORD.JOB_NAME);
END;
/

--예외처리
--EXCEPTION 절에 예외 상황 발생 시 해결하기 위한 문장 기술
--오라클에서 미리 정의한 예외에 대해서 예외처리를 할 수도 있고 사용자 정의 예외에 대해서 예외처리를 할 수도 있음

--미리 정의된 예외의 종류
--NO_DATA_FOUND : SELECT문이 아무런 데이터행을 반환하지 못할 때 
--DUP_VAL_ON_INDEX : UNIQUE 제약을 갖는 컬럼에 중복된 데이터가 들어갔을 때
--ZERO_DIVIDE : 0으로 나눌때
--등이 있음

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&사번'
    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/

DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = 5;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('조회결과가 없습니다.');
END;
/