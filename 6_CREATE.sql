--CREATE : �����ͺ��̽� ��ü�� �����ϴ� ����
--���̺� �����
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20));
    
SELECT * FROM MEMBER;

--�÷��� �ּ��ޱ�
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';

SELECT * FROM USER_TABLES;
--USER_TABLES : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��

SELECT * FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
--USER_TAB_COLUMNS : ���̺�, ���� �÷���� ���õ� ���� ��ȸ DATA DICTIONARY

DESC MEMBER;
--���̺� ���� �����ϰ� ������

--��������
--���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� �������� ����
--���� : ������ ���Ἲ ����
--      ������ ���Ἲ? �������� ��Ȯ��, �ϰ���, ��ȿ���� �����Ǵ� ��
--          --> �������� �Է�, ����, ������ ���� ������ ������ �ڵ� �˻翡 ������ ��
--���������� ���̺��� ó�� ���鶧 �����ص� �ǰ� ���߿� ���̺��� ����� ���� �����ص� ��

--NOT NULL : NULL���� ������� �ʵ��� �÷��������� ����
CREATE TABLE USER_NOCONST(--���������� �ƹ��͵� �������� ���� ���̺�
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );
    
INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');
INSERT INTO USER_NOCONST
VALUES(2, NULL, NULL, NULL, NULL, '010-1111-2222', 'hong123@kh.or.kr');

CREATE TABLE USER_NOTNULL1(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );
    
INSERT INTO USER_NOTNULL1
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');
INSERT INTO USER_NOTNULL1
VALUES(2, NULL, NULL, NULL, NULL, '010-1111-2222', 'hong123@kh.or.kr');

--UNIQUE���� ���� : �÷� �Է� ���� ���� �ߺ� ��� ����
--�÷�����, ���̺� ���� �� �� ��� ����

--�ߺ� ������ ����
INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

SELECT * FROM USER_NOCONST;

CREATE TABLE USER_UNIQUE(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );
INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');
--�ٸ� ���̺� ���� �̸��� ���Ѱ��� �־ ������ �ɸ�. ������ ���ٸ� �ٸ� �̸��� ������ �־����.
--DROP TABLE USER_NOTNULL  �߸����� ���̺� ����;
--RENAME USER_NOTNULL1 TO USER_NOTNULL;

CREATE TABLE USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID)   --���̺� �������� �������� ����
    );
INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE2    --�̸��� NULL���ٰ� ������
VALUES(1, NULL, 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE2     -- UNIQUE�� ���� ���������� ����Ǿ��ٰ� ��
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

SELECT * FROM USER_UNIQUE2;

CREATE TABLE USER_UNIQUE3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) ,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID)  --��� ������ ���̹Ƿ� �� ���� ��. ������ ���� ������ ���� �ƴ�.
    );

INSERT INTO USER_UNIQUE3 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3  --���̵� �ߺ��ƴµ� ��
VALUES(2, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(1, 'user02', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_UNIQUE3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

--���� ���ǿ� �̸� ����
CREATE TABLE CONS_NAME(
    TEST_DATA1 VARCHAR2 (20) CONSTRAINT NN_TEST_DATA1 NOT NULL, --NOTNULL = NN    /  ��������_���̺��̸�
    TEST_DATA2 VARCHAR2 (20) CONSTRAINT UK_TEST_DATA2 NOT NULL,  -- UK = UNIQUE
    TEST_DATA3 VARCHAR2 (30),
    CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3));
    
INSERT INTO CONS_NAME
VALUES ('TEST1', 'TEST2', 'TEST3');

INSERT INTO CONS_NAME
VALUES ('TEST1', 'TEST2', 'TEST3');

--PRIMARY KEY : NOT NULL + UNIQUE
--�� �࿡�� ������ �� �ִ� ���� �ĺ��� ����
--�� ���̺� �� �ϳ��� ���� ����, �÷�����/���̺� ���� �� �� ���� ����
--�� �� �÷��� ������ �� �ְ� ���� �� �÷��� ��� ���� �� �� ����

CREATE TABLE USER_PRIMARYKEY(
    USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr');
--unique constraint (KH.PK_USER_NO) violated

INSERT INTO USER_PRIMARYKEY
VALUES(null, 'user03', 'pass03', '������', '��', '010-3333-4444', 'yoo123@kh.or.kr');
--cannot insert NULL into ("KH"."USER_PRIMARYKEY"."USER_NO")

CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER ,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    constraint PK_USERNO_USERID PRIMARY KEY(USER_NO, USER_ID)
    );

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'lee123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(2, 'user01', 'pass01', '������', '��', '010-3333-4444', 'yoo123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(null, 'user01', 'pass01', '�Ż��Ӵ�', '��', '010-4444-4444', 'shin123@kh.or.kr');
--annot insert NULL into ("KH"."USER_PRIMARYKEY2"."USER_NO")

--FOREIGN KEY : ������ �ٸ� ���̺��� �����ϴ� ���� ����� �� ����
--�����Ǵ� �� �ܿ���  NULL�� ��� ����

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'LEE123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '������', '��', '010-3333-4444', 'YOO123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-4444-5555', 'ahn123@kh.or.kr', null);

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '������', '��', '010-5555-6666', 'YOON123@kh.or.kr', 50);
--integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found
SELECT * FROM USER_FOREIGNKEY;

--�����ɼ� : �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����͸� � ������ ó���� ���� ���� ���� ����
DELETE FROM USER_GRADE
WHERE GRADE_CODE = 10;
--integrity constraint (KH.FK_GRADE_CODE) violated - child record found  �ڽ����̺��� ���� �־ ���� �Ұ�
-- ON DELETE RESTRICTED(���� ����)�� �⺻ �����Ǿ� ����
--FOREIGN KEY�� ������ �÷����� ���ǰ� �ִ� ���� ��� �����ϴ� �÷��� ���� �������� ����

COMMIT;
--COMMIT : ��� �۾��� ���������� ó���ϰڴٰ� Ȯ���ϴ� ��ɾ�
--          Ʈ������� ó�� ������ �����ͺ��̽��� �ݿ��ϱ� ���ؼ� ����� ������ ��� ���� ����
--          COMMIT �����ϸ�, �ϳ��� Ʈ����� ������ �����ϰ� ��
--ROLLBACK : �۾� �� ������ �߻����� ��, Ʈ����� ó�� �������� �߻��� ��������� ����ϰ� ��æ��� ���� ����

DELETE FROM USER_GRADE
WHERE GRADE_CODE = 20;

ROLLBACK;

CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );
    
INSERT INTO USER_GRADE2 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
    --ON DELETE SET NULL : �θ�Ű�� �������� �� �ڽ� Ű�� NULL�� ����
);

INSERT INTO USER_FOREIGNKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'LEE123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(3, 'user03', 'pass03', '������', '��', '010-3333-4444', 'YOO123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY2
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-4444-5555', 'ahn123@kh.or.kr', null);

COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM user_foreignkey2;

DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;



CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
    );
    
INSERT INTO USER_GRADE3 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2 (10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    --CASCADE : �θ�Ű ���� �� �ڽ� Ű�� �Բ� ����(�����)
);

INSERT INTO USER_FOREIGNKEY3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-2222-3333', 'LEE123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(3, 'user03', 'pass03', '������', '��', '010-3333-4444', 'YOO123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY3
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-4444-5555', 'ahn123@kh.or.kr', null);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM user_foreignkey3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

--CHECK �������� : �÷��� ��ϵǴ� ���� ������ ������ �� ����(���ϴ� ���̳� �Լ��� ��� �Ұ�)
CREATE TABLE USER_CHECK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(2, 'user02', 'pass02', 'ȫ�浿', '����', '010-1111-2222', 'hong123@kh.or.kr');
--check constraint (KH.SYS_C007110) violated

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
    );
    
INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-1);

CREATE TABLE USER_CHECK3(
    C_NAME VARCHAR2(15 CHAR),
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT TBCH_NAME_PK PRIMARY KEY(C_NAME),
    CONSTRAINT TBCH_PRICE_CH CHECK(C_PRICE >=1 AND C_PRICE <= 99999),
    CONSTRAINT TBCH_LEVEL_CK CHECK(C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT TBCH_DATE_CK CHECK(D_DATE >= TO_DATE('2016/01/01', 'YYYY/MM/DD'))
    );

-- [�ǽ� ����]
-- ȸ�����Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ) - �⺻Ű(PK_USER_NO), 
--         USER_ID(ȸ�����̵�) - �ߺ�����(UK_USER_ID),
--         USER_PWD(ȸ����й�ȣ) - NULL�� ������(NN_USER_PWD),
--         PNO(�ֹε�Ϲ�ȣ) - �ߺ�����(UK_PNO), NULL ������(NN_PNO),
--         GENDER(����) - '��' Ȥ�� '��'�� �Է�(CK_GENDER),
--         PHONE(����ó),
--         ADDRESS(�ּ�),
--         STATUS(Ż�𿩺�) - NOT NULL(NN_STATUS), 'Y' Ȥ�� 'N'���� �Է�(CK_STATUS)
-- �� �÷��� �������ǿ� �̸� �ο��� ��
-- 5�� �̻� INSERT�� ��
drop table user_test;

CREATE TABLE USER_TEST(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) CONSTRAINT NN_USER_PWD NOT NULL,
    PNO VARCHAR2(20) CONSTRAINT NN_PNO NOT NULL,
    GENDER CHAR(3),
    PHONE varchar2 (20),
    ADDRESS VARCHAR2(40),
    STATUS CHAR(1) CONSTRAINT NO_STATUS NOT NULL,
    CONSTRAINT PK_NO PRIMARY KEY(USER_NO),
    CONSTRAINT UQ_ID UNIQUE (USER_ID),
    CONSTRAINT UQ_PNO UNIQUE (PNO),
    CONSTRAINT CK_GENDER CHECK (GENDER IN ('��', '��')),
    CONSTRAINT CK_STATUS CHECK (STATUS IN ('Y', 'N'))
    );
COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';
    
INSERT INTO USER_TEST
    VALUES (01, 'user1', 'pwd1', '00000-0000', '��', '010-1223-1111', '����', 'Y');
    
INSERT INTO USER_TEST
    VALUES (02, 'user2', 'pwd2', '00000-0011', '��', '010-1223-1111', '����', 'Y');
    
INSERT INTO USER_TEST
    VALUES (03, 'user3', 'pwd3', '00670-0000', '��', '010-1223-1111', '�λ�', 'N');
    
INSERT INTO USER_TEST
    VALUES (04, 'user4', 'pwd4', '23000-0000', '��', '010-1223-1111', '����', 'Y');
    
INSERT INTO USER_TEST
    VALUES (05, 'user5', 'pwd5', '06000-0000', '��', '010-1223-1111', '����', 'N');

--SUBQUERY�� �̿��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT JOIN JOB USING(JOB_CODE);
    
SELECT * FROM EMPLOYEE_COPY2;

--�������� �߰�
CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
);

ALTER TABLE USER_GRADE4 ADD PRIMARY KEY(GRADE_CODE);

CREATE TABLE USER_FOREIGNKEY4(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20), -- UNIQUE
  USER_PWD VARCHAR2(30), -- NOT NULL
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10), -- CHECK
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER -- FOREIGN KEY
);

ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('��', '��'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4;
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;

-- �̴� �ǽ�
-- DEPARTMENT���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻Ű

COMMIT;