/**/
-- 주석
--관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 슈퍼 유저 계정
--              오브젝트의 생성, 변경, 삭제 등의 작업이 가능하며
--              데이터베이스에 대한 모든 권한과 책임을 가지는 계정

--사용자 계정 : 데이터베이스에 대하여 질의(Query), 갱신, 보고서 작성 등의 작업을 수행할 수 있는 계정
--              일반 계정은 보안을 위해 최소한의 필요한 권한만 가지는 것을 원칙으로 함

CREATE USER KH IDENTIFIED BY KH;     --계정 생성
--           계정이름         계정비밀번호

GRANT RESOURCE, CONNECT TO KH;     -- 계정 권한 부여

CREATE USER SCOTT IDENTIFIED BY SCOTT;
GRANT RESOURCE, CONNECT TO SCOTT;

CREATE USER CHOON IDENTIFIED BY CHOON;
GRANT RESOURCE, CONNECT TO CHOON;
