--ALTER  : 객체 수정 구문

--컬럼 추가, 삭제, 수정
SELECT * FROM DEPT_COPY;

--컬럼 추가
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

--컬럼 추가 시 DEFAULT값 지정
ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '한국');

--컬럼 수정
DESC DEPT_COPY;      --컬럼구조보는거

ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT '미국';

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);    
--cannot decrease column length because some value is too big : 컬럼값을 줄일 수 없음. 가지고 있는 값이 너무 커서

--컬럼 삭제 : 데이터가 들어가있어도 삭제 가능. 한번 삭제한 후 복구 불가
--           테이블에는 최소 한개의 컬럼이 존재해야함. 모든 컬럼 삭제 불가
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;
--cannot drop all columns in a table : 테이블에 있는 모든 컬럼을 지울 수 없다

ROLLBACK;

SELECT * FROM DEPT_COPY2;

--제약조건이 설정되어 있는 컬럼 삭제
CREATE TABLE TB1(
    PK1 NUMBER PRIMARY KEY,
    COL1 NUMBER,
    CHECK(PK1 >0 AND COL1 >0)
    );

CREATE TABLE TB3(
    PK3 NUMBER PRIMARY KEY,
    FK3 NUMBER REFERENCES TB1,
    COL3 NUMBER,
    CHECK(PK3 >0 AND COL3 >0)
    );

ALTER TABLE TB3
DROP COLUMN FK3;

SELECT * FROM TB3;

--DROP TABLE TB2;
--RENAME TB3 TO TB2

ALTER TABLE TB1
DROP COLUMN PK1;
--column is referenced in a multi-column constraint : 제약조건이 2개 있다.

ALTER TABLE TB3
DROP COLUMN PK3;
--column is referenced in a multi-column constraint

ALTER TABLE TB1
DROP COLUMN PK1 CASCADE CONSTRAINTS;

ALTER TABLE TB3
DROP COLUMN PK3 CASCADE CONSTRAINTS;

--제약조건 추가, 삭제
--NOT NULL만 MODIFY 사용해서 추가
ALTER TABLE DEPT_COPY
DROP CONSTRAINT SYS_C007079;
--DROP CONSTRAINT 제약조건 이름;
--MODIFY 제약조건 이름 바꿀 제약조건
--MODIFY SYS_C007079 NULL;

--컬럼, 제약조건, 테이블 이름 변경
--컬럼 이름 변경
SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--제약조건 이름 변경
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007065 TO UF_UP_NN;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007064 TO UF_UN_PK;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007063 TO UF_UI_UQ;

ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT FK_GRADE_CODE TO UF_GC_FK;

--테이블 명 변경
ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST; 

--테이블 삭제
DROP TABLE DEPT_TEST
CASCADE CONSTRAINTS;                --제약조건까지 삭제



