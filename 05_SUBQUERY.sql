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
ORDER BY 1;

-- ���� 2-3
-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������
-- ���, �̸�, ����, �޿��� ��ȸ

-- 1) ������ '�븮'�� ������ ���, �̸�, ���޸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '�븮';

-- 2) ������ ������ �������� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '����';

-- 3) MIN�� �̿��Ͽ� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
              FROM EMPLOYEE
              NATURAL JOIN JOB
              WHERE JOB_NAME = '����');

-- 4) > ANY�� �̿��Ͽ� ���� �� ���� ���� �޿����� �ʰ��ؼ� �޴� �븮
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY
              FROM EMPLOYEE
              NATURAL JOIN JOB
              WHERE JOB_NAME = '����');

-- ���� 2-4
-- ���� ������ ���� ������ �� ���� ���� �޴� ���� ����
-- �� ���� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
-- (> ALL, < ALL)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '����'
AND SALARY > ALL (SELECT SALARY
                  FROM EMPLOYEE
                  NATURAL JOIN JOB
                  WHERE JOB_NAME = '����');

-- �������� ���� ����

-- LOCATION ���̺��� NATIONAL_CODE�� KO�� ����� LOCAL_CODE��
-- DEPARTMENT ���̺��� LOCATION_ID�� ������ DEPT_ID�� 
-- EMPLOYEE���̺��� DEPT_CODE�� ������ ����� ���Ͻÿ�.

-- 1) LOCATION ���̺��� NATIONAL_CODE�� KO�� ����� LOCAL_CODE
SELECT LOCAL_CODE
FROM LOCATION
WHERE NATIONAL_CODE = 'KO';

-- 2) DEPARTMENT ���̺��� LOCATION_ID�� ������ DEPT_ID
SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID = (SELECT LOCAL_CODE
                     FROM LOCATION
                     WHERE NATIONAL_CODE = 'KO');
                     

-- 3) EMPLOYEE ���̺��� DEPT_CODE�� ������ ������� ��ȸ                     
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_ID
                    FROM DEPARTMENT
                    WHERE LOCATION_ID = (SELECT LOCAL_CODE
                                         FROM LOCATION
                                         WHERE NATIONAL_CODE = 'KO'));
                                         --> ������ ��������

--------------------------------------------------------------------------------

/*
    3. ���߿� ��������(MULTI COLUMN SUBQUERY)
    - �������� SELECT���� ������ �÷� ���� ���� ���� ��������
*/

-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ�
-- ����� �̸�, ����, �μ�, �Ի����� ��ȸ

-- 1) ����� �������� �̸�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN = 'Y'
AND SUBSTR(EMP_NO, 8, 1) = '2';

-- 2) ����� ������ ���� �μ�, ���� ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 
    -- ���� �μ� 
    DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE ENT_YN = 'Y'
                 AND SUBSTR(EMP_NO, 8, 1) = '2')
AND
    -- ���� ����
    JOB_CODE = (SELECT JOB_CODE
                 FROM EMPLOYEE
                 WHERE ENT_YN = 'Y'
                 AND SUBSTR(EMP_NO, 8, 1) = '2')
AND 
    ENT_YN != 'Y';

-- 3) ���߿� ���������� �ۼ�
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                 FROM EMPLOYEE
                                 WHERE ENT_YN = 'Y'
                                 AND SUBSTR(EMP_NO, 8, 1) = '2')
AND ENT_YN != 'Y';

--------------------------------------------------------------------------------

-- 4. ������ ���߿� ��������

-- ���� ������ ��� �޿��� �ް� �ִ� ������
-- ���, �̸�, �����ڵ�, �޿��� ��ȸ
-- ��, �޿��� �޿� ����� ���� ���������� ���. (TRUNC(�÷���, -4))

-- 1) �޿��� 200, 600�� �޴� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2000000, 6000000);

-- 2) ���޺� ��� �޿�(���� ���������� ���)
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
FROM EMPLOYEE
GROUP BY JOB_CODE; --> ��������

-- 3) 1, 2 ������ �ϳ��� ��ħ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN 
                (SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
                 FROM EMPLOYEE
                 GROUP BY JOB_CODE);

-- �� �μ��� �ְ� �޿��� �޴� ����� ��ȸ�Ͻÿ�(��, �μ��� �������� ���� �Ͻÿ�)
-- ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, 0), SALARY) IN 
                    (SELECT NVL(DEPT_CODE, 0), MAX(SALARY)
                     FROM EMPLOYEE
                     GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;
-- ���߿� �������� ����� NULL �����Ͱ� �ϳ��� ������ ��ȸ���� ����.

--------------------------------------------------------------------------------

-- 5. ��� ��������(��ȣ���� ��������)
-- ��� ������ ���� ������ ����ϴ� ���̺� ���� ���� ������ �̿��ؼ� ����� ����.
-- ���������� ���̺� ���� ����Ǹ� �������� ��� ���� ����Ǵ� ����.

-- ** ��������� ���� ���������� �� ���� ��ȸ�ϰ�
-- �ش� ���� ���������� ������ �����ϴ��� Ȯ���Ͽ� SELECT�� ������.

-- ���� 5-1.
-- �����ڰ� EMPLOYEE ���̺� �ִ� ������ ���, �̸�, �μ���, ������ ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, MANAGER_ID
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
-- EXISTS : ���������� �ش��ϴ� ���� ��� 1�� �̻� ������ ��� �����Ǵ� SELECT�� ����
WHERE EXISTS (SELECT EMP_ID
              FROM EMPLOYEE M
              WHERE E.MANAGER_ID = M.EMP_ID);
              
-- ���� 5-2.
-- ���޺� �޿� ��պ��� �޿��� ���� �޴� ������
-- �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE M
                WHERE E.JOB_CODE = M.JOB_CODE);
                
--------------------------------------------------------------------------------

-- 6. ��Į�� ��������
-- SELECT���� ���Ǵ� ������ ��������(1��)
-- SQL������ ���� ���� ������ '��Į��'��� ��.

-- ���� 6-1.
-- ��� ����� ���, �̸�, �����ڹ�ȣ, �����ڸ��� ��ȸ
-- ��, �����ڰ� ���� ��� '����'���� ǥ��
SELECT EMP_ID, EMP_NAME, MANAGER_ID,
        NVL((SELECT M.EMP_NAME
            FROM EMPLOYEE M
            WHERE E.MANAGER_ID = M.EMP_ID), '����') �����ڸ�
FROM EMPLOYEE E
ORDER BY 1;

-- ���� 6-2.
-- �� �������� ���� ������ �޿� ����� ��ȸ(�Ҽ��� �Ʒ� ����)
SELECT EMP_NAME, JOB_CODE, FLOOR((SELECT AVG(SALARY)
                            FROM EMPLOYEE M
                            WHERE E.JOB_CODE = M.JOB_CODE)) "���� �޿� ���"
FROM EMPLOYEE E;

--------------------------------------------------------------------------------

-- 7. �ζ��� ��(INLINE VIEW)
-- FROM���� ����ϴ� ��������
-- ���������� ���� ����� ����(RESULT SET)�� ���̺� ��� Ȱ��

SELECT ���, �޿�
FROM (SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�
      FROM EMPLOYEE
      WHERE SALARY >= 3000000)
WHERE �޿� < 4000000;
      

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- ���� 7-1 : �ζ��� �並 �̿��� TOP-N �м�

-- �� ���� �� �޿��� ���� ���� 5����
-- ����, �̸�, �޿� ��ȸ

-- * ROWNUM : ��ȸ�� ������� 1���� 1�� �����ϴ� ��ȣ�� �ű�� �÷�

-- ROWNUM ���ǻ���1 : ORDER BY������ ���� �ؼ��Ǿ� ��ȣ�� �ο���
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--> �ζ��κ� ����ϱ�
SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- ���� 7-2.
-- �޿� ����� 3�� �ȿ� ��� �μ��� �μ��ڵ�, �μ���, �޿� ��� ��ȸ
SELECT ROWNUM, DEPT_CODE, DEPT_TITLE, ���
FROM(SELECT DEPT_CODE, DEPT_TITLE, FLOOR(AVG(SALARY)) ���
     FROM EMPLOYEE
     JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     GROUP BY DEPT_CODE, DEPT_TITLE
     ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

--------------------------------------------------------------------------------

-- 8. WITH
-- ���������� �̸��� �ٿ��ְ� ���� �̸��� ȣ���ϰ���.
-- �ַ� �ζ��� ��� ���� ���������� �����.
-- ����ӵ��� ������.

-- �� ������ �޿� ���� TOP 10 ��ȸ

WITH TOPN_SAL AS(SELECT EMP_ID, EMP_NAME, SALARY
                 FROM EMPLOYEE
                 ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM TOPN_SAL
WHERE ROWNUM <= 10;

--------------------------------------------------------------------------------

-- 9. RANK() OVER / DENSE_RACK() OVER

-- RANK() OVER : ������ ���� ���� ����� ������ �ο� �� ��ŭ �ǳ� �ٰ� ���� ���
                    -- EX) ���� 1���� 2���̸� ���� ������ 3��
                    
-- DENSE_RACK() OVER : ������ ���� ���� ����� �ǳ� ���� �ʰ� ���� ���
                    -- EX) ���� 1���� 2���̸� ���� ������ 2��
                    
-- ��ü �޿� ����
SELECT EMP_NAME, SALARY,
    RANK() OVER(ORDER BY SALARY DESC) ���� -- �޿� ������������ ���� �ο�
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) ���� -- �޿� ������������ ���� �ο�
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 1������
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
AND EMP_NAME != '������'
ORDER BY 1;

-- 2�� ����

SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEE
                WHERE HIRE_DATE >= '00/01/01');

-- 3������

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
NATURAL JOIN JOB
WHERE (DEPT_CODE, JOB_CODE) IN ( SELECT DEPT_CODE, JOB_CODE
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME = '���ö')
AND EMP_NAME != '���ö';
                                 
-- 4������

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE SUBSTR(HIRE_DATE, 1, 2) = 00);

-- 5������

SELECT EMP_ID, EMP_NAME, MANAGER_ID, EMP_NO, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID
                                 FROM EMPLOYEE
                                 WHERE SUBSTR(EMP_NO, 1, 2) = 77
                                 AND SUBSTR(EMP_NO, 8, 1) = 2);

-- 6������

SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE, '�ҼӾ���'), JOB_NAME, HIRE_DATE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE (NVL(DEPT_CODE, 0), HIRE_DATE) IN (SELECT NVL(DEPT_CODE, 0), MIN(HIRE_DATE)
                                    FROM EMPLOYEE
                                    WHERE ENT_YN != 'Y'
                                    GROUP BY DEPT_CODE)
ORDER BY HIRE_DATE;

-- 7������
SELECT JOB_CODE, MIN(CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12)) ����
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_NAME, 
CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12) ����,
TO_CHAR(SALARY*(1+NVL(BONUS, 0))*12, 'L999,999,999') ����
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE (JOB_CODE, CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12))
IN ( SELECT JOB_CODE, MIN(CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12))
     FROM EMPLOYEE
     GROUP BY JOB_CODE)
ORDER BY ���� DESC;


