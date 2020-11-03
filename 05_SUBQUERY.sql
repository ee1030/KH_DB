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

-- ** ���������� WHERE�� �Ӹ� �ƴ϶�
-- SELECT, FROM, HAVING���� �ۼ� ������.

-- ���� 1-4
-- �μ���(�μ� ���� ��� ����) �޿��� �հ谡
-- ���� ū �μ��� �μ���, �޿� �� ��ȸ

-- 1)�μ��� �޿� �� �� ���� ū ���� ��ȸ
SELECT MAX(SUM(SALARY) )
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) �μ��� �޿� ���� 17700000���� �μ��� �μ���� �޿� �� ��ȸ
SELECT DEPT_TITLE, SUM(SALARY) "�޿� ��"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = 17700000;

-- 1, 2 ��ġ��
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------
/*
    2. ������ ��������(MULTI ROW SUBQUERY)
    - ���������� ��ȸ ��� ���� ������ ���� ���� ��������
    
    - ** ������ ������������ �Ϲ� �񱳿����ڸ� ����� �� ����.
        
        IN / NOT IN : �������� ��� ���� �ϳ��� ��ġ�ϴ� ���� �ִٸ� / ���ٸ�
        
        > ANY, < ANY : �������� ����� ��
                        �ϳ��� ū / ���� ���
                        -> ���� ���� ������ ū��? 
                            / ���� ū ������ ������?
                        
        > ALL, < ALL : �������� ����� ��
                        ��� ������ ū / ���� ���
                        -> ���� ū ������ ū��? 
                            / ���� ������ ���� ������
        
        EXISTS / NOT EXISTS : ���� ���� �ϴ°�? / �������� �ʴ°�?
*/

-- ���� 2-1
-- �μ��� �ְ� �޿��� �޴� ������
-- �̸�, �μ���, ���޸�, �޿��� ��ȸ

-- 1) �� �μ��� �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) ��ü ��� �� �� �μ��� �ְ� �޿��� ��ġ�ϴ� �����
-- �̸�, �μ���, ���޸�, �޿��� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY IN(2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);



SELECT EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SALARY IN(SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);

-- ���� 2-2
-- ��� ����� ���� ������/������ �����Ͽ�
-- ���, �̸�, �μ���, ���޸�, ����(������/����)�� ��ȸ

-- 1) �����ڿ� �ش��ϴ� ����� ��� ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2) �����ڿ� �ش��ϴ� ������ 
-- ���, �̸�, �μ���, ���޸�, ����(������/����)�� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 3) ������ �ش��ϴ� �����
-- ���, �̸�, �μ���, ���޸�, ����(������/����)�� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' ����
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID NOT IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 4) 2, 3 ��ȸ ����� �ϳ��� ��ħ

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' ����
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE EMP_ID NOT IN(SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL);

-- 5) SELECT���� �������� ����� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
    CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                         FROM EMPLOYEE
                         WHERE MANAGER_ID IS NOT NULL) THEN '������'
         ELSE '����'
    END ����
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)





