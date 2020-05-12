--시퀀스(SEQUENCE) : 자동 번호 발생기
CREATE SEQUENCE SEQ_EMPID --시퀀스 이름 지정
START WITH 300 --시작숫자
INCREMENT BY 5 -- 증가숫자
MAXVALUE 310 --최대 숫자
NOCYCLE -- 반복 안함
NOCACHE ; --메모리상에서 관리하지 않겠다

SELECT * FROM USER_SEQUENCES;

--SEQUENCE 사용
--시퀀스명.CURRVAL  : 현재 생성된 시퀀스의 값
--시퀀스명.NEXTVAL : 시퀀스를 증가시키거나 최초로 시퀀스를 실행시키는 역할
--                 ----------- 
--                 시퀀스명.NEXTVAL = 시퀀스명.CURRVAL + INCREMENT 로 지정한 값
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
--equence SEQ_EMPID.CURRVAL is not yet defined in this session
--NEXTVAL로 먼저 실행을 시킨다음에 해야함. 생성만 되어있는 상태여서 실행을 시킨 뒤 해야함

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;  --300
SELECT SEQ_EMPID.CURRVAL FROM DUAL;   --300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;  --305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;  --310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; 
--sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated

SELECT SEQ_EMPID.CURRVAL FROM DUAL; 
--성공적으로 호출된 마지막 NEXTVAL 값을 저장

--CURRVAL / NEXTVAL 사용 가능 및 불가능
--사용 가능
--서브쿼리가 아닌 SELECT문
--INSERT문의 SELECT절
--INSERT문의 VALUES절
--UPDATE문의 SET절

--사용불가
--VIEW의 SELECT절
--DISTINCT 키워드가 들어간 SELECT절
--GROUP BY , HAVING, ORDER BY 절의 SELECT문
--SELECT, UPDATE, DELETE문의 서브쿼리
--CREATE TABLE, ALTER TABLE의 DEFAUL값

--시작 숫자가 300이고 증가값은 1이며 최대 숫자가 10000인 비순환, 캐시사용 안하는 SEQ_EID시퀀스 생성
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1  --(생략하면 1로 기본값)
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

INSERT INTO EMPLOYEE VALUES(SEQ_EID.NEXTVAL, '홍길동', '666666-6666666', 'hong_gd@kh.or.kr', '01066666666', 
                            'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
                            
SELECT * FROM EMPLOYEE;

CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    E_NAME VARCHAR2(30)
    );
--ORA-00984: column not allowed here

ROLLBACK;

--시퀀스 변경
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
--START WITH 값 변경 불가

SELECT SEQ_EMPID.NEXTVAL FROM ;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;

