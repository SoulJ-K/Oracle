/**/
-- �ּ�
--������ ���� : �����ͺ��̽��� ������ ������ ����ϴ� ���� ���� ����
--              ������Ʈ�� ����, ����, ���� ���� �۾��� �����ϸ�
--              �����ͺ��̽��� ���� ��� ���Ѱ� å���� ������ ����

--����� ���� : �����ͺ��̽��� ���Ͽ� ����(Query), ����, ���� �ۼ� ���� �۾��� ������ �� �ִ� ����
--              �Ϲ� ������ ������ ���� �ּ����� �ʿ��� ���Ѹ� ������ ���� ��Ģ���� ��

CREATE USER KH IDENTIFIED BY KH;     --���� ����
--           �����̸�         ������й�ȣ

GRANT RESOURCE, CONNECT TO KH;     -- ���� ���� �ο�

CREATE USER SCOTT IDENTIFIED BY SCOTT;
GRANT RESOURCE, CONNECT TO SCOTT;

CREATE USER CHOON IDENTIFIED BY CHOON;
GRANT RESOURCE, CONNECT TO CHOON;
