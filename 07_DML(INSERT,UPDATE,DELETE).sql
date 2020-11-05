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


