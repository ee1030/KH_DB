/*
    DML(Data Manipulation Language) : ������ ���� ���
    
    - ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����
    
    -- DML ���� �� ���ǻ���!!
       -> ȥ�ڼ� �ۼ� ���ߴٰ� �������� ����!
       -> ���� COMMIT, ROLLBACK ���� ������� �������� ����!
       
    
*/

--------------------------------------------------------------------------------

/*
    1. INSERT
    - ���̺� ���ο� ���� �߰��ϴ� ����
    - ���̺��� �� ������ ������
    
    
    [�ۼ��� 1]
    INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3, ...)
    VALUES(������1, ������2, ������3, ...);
    
    -> ������ ���̺��� Ư�� �÷��� �����Ͽ� ������ ����(INSERT)�ϴ� ���
        --> ������ �ȵ� �÷��� NULL ���� ���ų�,
            �����Ǿ��ִ� DEFAULT���� ��
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL,
                     PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL,
                     SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
VALUES('900', '��ä��', '901123-1080503', 'jang_ch@kh.or.kr',
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '��ä��';

/*
    [�ۼ��� 2]
    INSERT INTO ���̺��
    VALUES(������1, ������2, ������3, ...);
    
    --> ���̺� ��� �÷��� ���� ���� INSERT �� �� ����ϴ� ���
        --> INSERT ������ �÷� ����, VALUES�� �÷� ������� �����͸� �ۼ��ؾ� ��
*/

ROLLBACK;

INSERT INTO EMPLOYEE
VALUES('900', '��ä��', '901123-1080503', 'jang_ch@kh.or.kr',
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
        NULL, DEFAULT);
    
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '��ä��';

COMMIT;

-- INSERT�� VALUES ��� �������� ����ϱ�
CREATE TABLE EMP_01(
    EMP_ID VARCHAR2(3) PRIMARY KEY,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

COMMIT;

--------------------------------------------------------------------------------

/*
    2. INSERT ALL
    
    - ���δٸ� ���̺� INSERT�� ���������� ����ϴ� ���̺��� ���� ���
      �� �� �̻��� ���̺� INSERT ALL�� �̿��Ͽ� �� ���� ���� ������ ����.
      (��, �������� �������� ���ƾ���)
*/

-- INSERT ALL ����1

-- ���, �����, �μ��ڵ�, �Ի��� �÷��� ������ ���̺� EMP_DEPT�� �����ϰ�
-- EMPLOYEE ���̺��� �÷�, ������ Ÿ�Ը� ����
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1 = 0;
   --> ���������� WHERE�� ������ �׻� FALSE�� �ǰ� �����
   -- �����ʹ� ������� �ʰ�, ���̺��� �÷�, ������ Ÿ�Ը� ���簡 ��.

SELECT * FROM EMP_DEPT;

-- ���, �̸�, �����ڹ�ȣ �÷��� ������ ���̺� EMP_MANAGER�� �����ϰ�
-- EMPLOYEE ���̺��� �÷���, ������ Ÿ�Ը� ����
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;

SELECT * FROM EMP_MANAGER;

-- EMP_DEPT ���̺�
-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� �����
-- ���, �̸�, �μ��ڵ�, �Ի��� ����.
INSERT INTO EMP_DEPT
(SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1');


-- EMP_MANAGER ���̺�
-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� �����
-- ���, �̸�, �����ڹ�ȣ ����.
INSERT INTO EMP_MANAGER
(SELECT EMP_ID, EMP_NAME, MANAGER_ID
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1');

ROLLBACK;

-- ������������ ����ϴ� ���̺�� ������ ������ �����Ƿ�
-- INSERT ALL�� �̿��ؼ� �ѹ��� ������ ���� �� �� ����
INSERT ALL 
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1';

-- INSERT ALL ����2

-- EMPLOYEE���̺��� ������ �����Ͽ� ���, �̸�, �Ի���, �޿��� ����� �� �ִ�
-- ���̺� EMP_OLD�� EMP_NEW ����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;
   
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

-- EMPLOYEE���̺��� �Ի��� �������� 2000�� 1�� 1�� ������ �Ի��� ����� ���, �̸�,
-- �Ի���, �޿��� ��ȸ�ؼ� EMP_OLD���̺� �����ϰ� �� �Ŀ� �Ի��� ����� ������ 
-- EMP_NEW���̺� ����
INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
	INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
	INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

COMMIT;

