/*
    * SUNQUERY(��������)
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SQL(SELECT)��
    - ���������� ���� �����ϴ� ���ҷ� ����ϴ� ������
*/

-- �������� ����
-- �μ��ڵ尡 '���ö' ����� ���� ������
-- ���, �̸�, �μ��ڵ� ��ȸ

-- 1) ���ö�� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; --> 'D9'

-- 2) �μ��ڵ尡 'D9'�� �������� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 1, 2�� SQL �ѹ��� �ۼ��ϱ�
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������
-- ���, �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� ������ �޿� ���
SELECT AVG(SALARY) FROM EMPLOYEE;

-- 2) ������ �� �޿��� 3047662
-- �̻��� ����� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;

-- 3) 1, 2�� �ۼ��� SQL���� �ϳ��� ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);
                 
--------------------------------------------------------------------------------

/*
    - ������ �������� : ���������� ��ȸ ��� ���� ������ 1 ( + ���Ͽ�)
    
    - ������ �������� : ���������� ��ȸ ��� ���� ������ N�� �� �� ( + ���Ͽ�)
    
    - ���߿� �������� : ���������� SELECT���� ������ �׸� ���� ������ �� ��
    
    - ������ ���߿� �������� : ���������� ��ȸ ����� N��, N���� ��
    
    - ���(��ȣ����) �������� : ���������� ���� ������� ���������� �񱳿��� �� ��
                                ���������� ��� ���� ����Ǹ�
                                ���������� ��� ������ ������ ��ġ�� ��������
    
    - ��Į�� �������� : SELECT ���� ���Ǵ� ��������(������ ��������)
    
    - �ζ��� �� : FROM���� ���Ǵ� ��������
*/

--------------------------------------------------------------------------------

/*
    1. ������ ��������(SINGLE ROW SUBQUERY)
    - ���������� ��ȸ ��� ���� ������ 1���� ��������
    - WHERE���� ��� �� �������� �տ��� �� �����ڸ� �����.
    ( >, <, >=, <=, =, !=, <>, ^= )
*/

-- ���� 1-1
-- �� ������ �޿� ��պ��� ���� �޿��� �޴� ������
-- �̸�, ���޸�, �μ���, �޿��� �����ڵ� ������������ �����Ͽ� ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE DESC;

-- ���� 1-2
-- ���� ���� �޿��� �޴� ������
-- ���, �̸�, ���޸�, �μ���, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY, HIRE_DATE
FROM EMPLOYEE
NATURAL JOIN JOB
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);
 
-- ���� 1-3
-- ���ö ������� �޿��� ���� �޴� �����
-- ���, �̸�, �μ���, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');




