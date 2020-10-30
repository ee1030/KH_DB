-- �Լ� : �÷��� ���� �о ����� ����� ����
/*
    - ���� �� �Լ�(SINGLE ROW)
      �÷��� ��ϵ� N���� ���� �о N���� ����� �����ϴ� �Լ�
      
    - �׷� �Լ�(GROUP)
      �÷��� ��ϵ� N���� ���� �о 1���� ����� �����ϴ� �Լ�
    
    (���ǻ���)
    - ���� �� �Լ��� �׷� �Լ��� ���� ����� �� ����.
      --> ��� ���� ���� �ٸ��� ����
      
    - �Լ��� ����� �� �ִ� ��ġ
      --> SELECT��, WHERE��, ORDER BY��
      --> GROUP BY��, HAVING��
*/

--------------------------------------------------------------------------------

-- ���� �� �Լ�

-- 1. ���� ���� �Լ�

-- 1. LENGTH / LENGTHB
-- LENGTH : �־��� �÷� �������� ����
-- LENGTHB : �־��� �÷� �������� BYTE ũ��

-- EMPLOYEE ���̺��� ������, �̸���, �̸��� ���� ��ȸ
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

SELECT LENGTH('����Ŭ') FROM DUAL;
-- DUAL(DUMMY TABLE) : ���� ���̺�

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE123') FROM DUAL;

SELECT LENGTHB('����Ŭ') FROM DUAL;

-- ORACLE EXPRESS EDITION (XE����) : ������ ���� ����
-- ����, ���� 1����Ʈ
-- �ѱ�, �ٸ����� �ܱ���, Ư������ �� �ƽ�Ű�ڵ� �̿��� ���� : 3����Ʈ
-- -> �÷��� ������ Ÿ���� NVARCHAR2�� ���(�����ڵ� ���� ���)

--------------------------------------------------------------------------------

-- 2) INSTR
-- ������ ��ġ���� ������ ���� ��°�� ��Ÿ���� ������ ���� ��ġ ��ȯ
-- [�ۼ���]
-- INSTR('���ڿ�'|�÷���, '����'[, �˻� ���� �ε��� [, ����]])

-- ù��° ����(1)���� �˻��Ͽ� 'B'�� ó�� ������ ��ġ ��ȸ
SELECT INSTR('AABAACBBAA', 'B', -1, 1) FROM DUAL;
--> ����Ŭ�� �ε����� 1���� ����

-- ù��° ����(1)���� �˻��Ͽ� 'B'�� �ι�°�� ������ ��ġ ��ȸ
SELECT INSTR('AABAACBBAA', 'B', 1, 2) FROM DUAL;

-- ������ ���ں��� �˻��Ͽ� 'B'�� ó�� ������ ��ġ ��ȸ
SELECT INSTR('AABAACBBAA', 'B', -1, 1) FROM DUAL;

-- EMPLOYEE ���̺���
-- �����, �̸���, �̸��Ͽ��� '@'�� ��ġ ��ȸ
SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 3) TRIM
-- �־��� ���ڿ� �Ǵ� �÷� ���� ��/��/���ʿ� �ִ� ������ ���ڸ� ����
-- ������ ���ڰ� ���� ��� ������ �����Ѵ�.

SELECT '     KH     ' FROM DUAL;
SELECT TRIM('     KH     ') FROM DUAL;

-- ���� ����(BOTH, �⺻��)
SELECT TRIM('-' FROM '-----KH-----') FROM DUAL;
SELECT TRIM(BOTH '-' FROM '-----KH-----') FROM DUAL;

-- ���� ����(LEADING, LTRIM)
SELECT TRIM(LEADING '-' FROM '-----KH-----') FROM DUAL;
SELECT LTRIM('-----KH-----', '-') FROM DUAL;

-- ������ ����(TRAILING, RTRIM)
SELECT TRIM(TRAILING '-' FROM '-----KH-----') FROM DUAL;
SELECT RTRIM('-----KH-----', '-') FROM DUAL;

--------------------------------------------------------------------------------

/* 4) SUBSTR
    - �÷� ���̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڸ� �߶󳻾� ��ȯ�ϴ� �Լ�
    
    - [�ۼ���]
        SUBSTR(�÷���|'���ڿ�', POSITION [, LENGTH]
        POSITION : �߶󳻱� ������ ��ġ
        LENGTH : �߶� ����
*/

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;

-- 7������ ������ �߶󳻾� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;

-- ������ ���� 8��° ���� �߶󳻱� �����ؼ� 3���� �ڸ���
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

-- EMPLOYEE ���̺���
-- �����, �̸���, �̸��� ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- �����, �ֹε�Ϲ�ȣ, �ֹε�Ϲ�ȣ �� ���� �κ� ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1, 1)
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- ������ ������ ����� ��ȸ
-- �����, �ֹε�Ϲ�ȣ, �ֹε�Ϲ�ȣ �� ���� �κ� ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) "���� �κ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- EMPLOYEE ���̺���
-- �����, �¾ �⵵, ��, ���� ��ȸ
SELECT 
    EMP_NAME, SUBSTR(EMP_NO, 1, 2) || '��' ����,
    SUBSTR(EMP_NO, 3, 2) || '��' ��,
    SUBSTR(EMP_NO, 5, 2) || '��' ��
FROM 
    EMPLOYEE;
    
--------------------------------------------------------------------------------

-- 5) LPAD, RPAD
-- �־��� �÷� ���̳� ���ڿ��� ������ ���ڿ��� ��/�쿡 ���ٿ��� ���� N�� ���ڿ��� ��ȯ
-- [�ۼ���]
-- LPAD | RPAD (�÷��� | ���ڿ�, ��ȯ�� ���ڿ��� ����(N)[, �����̷��� ����(STR)]

-- 20ĭ�� �Ҵ��ϰ� �����͸� ������ ���� �� ���� ���鿡 ��ĭ�� �����δ�.
SELECT 
    LPAD(EMAIL, 20) 
FROM 
    EMPLOYEE;

-- 20ĭ�� �Ҵ��ϰ� �����͸� ������ ���� �� ���� ���鿡 '#'�� �����δ�.
SELECT 
    LPAD(EMAIL, 20, '#') 
FROM 
    EMPLOYEE;
    
-- 20ĭ�� �Ҵ��ϰ� �����͸� ���� ���� �� ������ ���鿡 '#'�� �����δ�.
SELECT 
    RPAD(EMAIL, 20, '#') 
FROM 
    EMPLOYEE;
    
-- EMPLOYEE ���̺���
-- �����, �ֹε�Ϲ�ȣ�� ��ȸ
-- ��, �ֹε�Ϲ�ȣ ���ڸ��� ������ ���̰� �������� *�� ó��
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1, 8), 14, '*') �ֹε�Ϲ�ȣ
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 6) REPLACE
-- �÷� ��, �Ǵ� ���ڿ����� Ư�� ���ڿ��� ������ ���ڿ��� ���� �� ��ȯ
-- [�ۼ���]
--  REPLACE(�÷��� | ���ڿ�, �����Ϸ��� ���ڿ�, �����ϰ��� �ϴ� ���ڿ�)
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') 
FROM DUAL;

-- EMPLOYEE ���̺���
-- ������� �̸��� �ּҸ� 'kh.or.kr'���� 'gmail.com'���� �����Ͽ�
-- �����, ���� �̸���, �ٲ� �̸��� ��ȸ
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 2. ���� ó�� �Լ�

-- 1) MOD
-- �� ���� ������ �������� ��ȯ�ϴ� �Լ�
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------------------------------------------------

-- 2) ROUND(�ݿø�)
-- [�ۼ���]
-- ROUND(�÷��� | ����[, �ݿø� ��ġ])
SELECT ROUND(123.456) FROM DUAL;
--> ROUND�� �⺻���� �Ҽ� ù��° �ڸ����� �ݿø��Ͽ� ������ ��ȯ��.

SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5

SELECT ROUND(123.456, 0) FROM DUAL; -- 123

SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46

SELECT ROUND(123.456, -2) FROM DUAL; -- 100

--------------------------------------------------------------------------------

-- 3) CEIL(�ø�)
SELECT CEIL(123.1) FROM DUAL;
SELECT CEIL(123.456*10) / 10 FROM DUAL;


--------------------------------------------------------------------------------

-- 4) FLOOR(����)
SELECT FLOOR(123.1) FROM DUAL; -- 123
SELECT FLOOR(123.9) FROM DUAL; -- 123
SELECT FLOOR(123.456*10) / 10 FROM DUAL;

SELECT CEIL(-10.9), FLOOR(-10.9), TRUNC(-10.9) FROM DUAL;

-- 5) TRUNC(����, ����)
SELECT TRUNC(123.456) FROM DUAL;
--> �Ҽ��� ��� ����

SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;

--------------------------------------------------------------------------------

-- 3. ��¥(DATE) ó�� �Լ�

-- 1) SYSDATE : �ý��ۿ� ����Ǿ� �ִ� ���� ��¥(�ð�)�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL;

-- 2) MONTHS_BETWEEN(DATE ,DATE)
-- �� DATE�� ���� �� ���̸� ���ڷ� �����ϴ� �Լ�

-- EMPLOYEE ���̺���
-- �����, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' "�ٹ� ���� ��"
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- �����, �Ի���, ���� ��ȸ
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) || '����' "����"
FROM EMPLOYEE;

-- 3) ADD_MONTHS(DATE, ����)
-- ��¥�� ���� ��ŭ�� ���� ���� �߰��Ͽ� ��ȯ
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE ���̺���
-- ����� �̸�, �Ի���, �Ի��Ϸ� ���� 6������ ���� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- 4) LAST_DAY(��¥) : �ش� ���� ������ ��¥�� ����
SELECT LAST_DAY('20/09/01') FROM DUAL;

-- 5) EXTRACT : ��¥ �����Ϳ��� ��, ��, �� ������ �����Ͽ� ����
-- EXTRACT(YEAR FROM ��¥) : ���� ����
-- EXTRACT(MONTH FROM ��¥) : �� ����
-- EXTRACT(DAY FROM ��¥) : �� ����

-- EMPLOYEE ���̺���
-- �����, �Ի����� ��,��,���� ��ȸ
SELECT EMP_NAME,
    EXTRACT(YEAR FROM HIRE_DATE) �Ի翬��,
    EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
    EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE;

-- 1. EMPLOYEE ���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, �Ի���-������ ��Ī�� "�ٹ��ϼ�1", 
-- ����-�Ի����� ��Ī�� "�ٹ��ϼ�2"�� �ϰ�
-- ��� ����(����)ó��, ����� �ǵ��� ó��
SELECT EMP_NAME,
    ABS(FLOOR(HIRE_DATE-SYSDATE)) �ٹ��ϼ�1,
    ABS(FLOOR(SYSDATE-HIRE_DATE)) �ٹ��ϼ�2
FROM
    EMPLOYEE;

-- 2. EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD (EMP_ID, 2) = 1;

-- 3. EMPLOYEE ���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) > 20;
-- WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

-- 4. EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ
SELECT EMP_NAME, HIRE_DATE,
    --EXTRACT(DAY FROM LAST_DAY(HIRE_DATE)) - EXTRACT(DAY FROM HIRE_DATE)
    LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
FROM
    EMPLOYEE;

--------------------------------------------------------------------------------

-- 4. ����ȯ �Լ�

/*
          --TO_CHAR-->           --TO_DATE-->
    NUBER <---------> CHARACTER <----------> DATE
         <--TO_NUMBER--          <-TO_CHAR--
*/

-- 1) TO_CHAR(��¥|����[, ����])
-- ��¥ �Ǵ� ������ �����͸� ���������� �ٲٴ� �Լ�
-- ���� ���� �� ���˿� �´� ������ �����ͷ� �����Ͽ� ��ȯ

-- [����]
SELECT TO_CHAR(1234) FROM DUAL; -- '1234'

-- 5ĭ ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '99999') FROM DUAL;

-- 5ĭ ������ ����, ��ĭ 0
SELECT TO_CHAR(1234, '00000') FROM DUAL;

--> 9, 0 �Ѵ� ���ڸ� ä��ڴٴ� �ǹ�
   -- 9�� ��ĭ / 0�� ��ĭ�� 0ä��

-- ���� ������ ������ ȭ�� ���� + ���ڸ� �� ���� , ���̱�
SELECT TO_CHAR(10000, 'L99,999') FROM DUAL;

-- �ٸ� ������ ȭ����� + ���ڸ� �� ���� , ���̱�
SELECT TO_CHAR(10000, '$99,999') FROM DUAL;


SELECT TO_CHAR(100000, 'L99,999') FROM DUAL;
--> ������ ������ ������ �Ѿ�� ���� ��� #���� �ʱ�ȭ ��

-- EMPLOYEE ���̺���
-- ��� ����� �����, �޿�, ������ ��ȸ
-- ��, �޿�, ������ ���ڸ����� ','�� ���� + ��ȭ��ȣ �߰�
SELECT EMP_NAME,
    TRIM(TO_CHAR(SALARY, 'L999,999,999')) �޿�,
    TRIM(TO_CHAR(SALARY*12, 'L999,999,999')) ����
FROM EMPLOYEE;

-- [��¥]
/*
    PM HH : AM/PM
    HH24 : 24�ð� ǥ���
    MI : ��
    SS : ��
    
    YYYY : 2020��, YY : 20��
    MM : ��
    DD : ��
    DAY : �ݿ��� DY : ��, D : 6
    Q : �б�
*/

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YY-MM-DD D Q') FROM DUAL;


-- EMPLOYEE ���̺���
-- ��� ����� �̸�, ����� ��ȸ
-- �� ������� '2020-10-30 ��' �������� ��ȸ
SELECT EMP_NAME �̸�, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD DY') �����
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- ��� ����� �̸�, ����� ��ȸ
-- �� ������� '2020�� 10�� 30�� �ݿ���' �������� ��ȸ
SELECT EMP_NAME �̸�, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" DAY') �����
FROM EMPLOYEE;
-- �������� ���� ������ ����ϰ� ���� ��� ""(�ֵ���ǥ)�� ���μ� �ۼ�

-- 2) TO_NUMBER(����[, ����]) : ������ �����͸� ������ �����ͷ� ����ȯ
-- ��������� ���� -> ���� ��ȯ
SELECT TO_NUMBER('100') + TO_NUMBER('200') FROM DUAL;

-- ������ ��ȯ
SELECT '100' + '200' FROM DUAL;
--> ����Ŭ�� ���� ������ ������������, ���� �Ǵ� ��¥�� ���¸� ��� �ִٸ�
--> �ڵ����� ���¸� ��ȯ���� ��.

SELECT TO_NUMBER('1,000,000', '9,999,999') FROM DUAL;

-- 3) TO_DATE(����[, ����])

SELECT TO_DATE('20210101', 'YYYYMMDD') FROM DUAL;

SELECT TO_DATE(20210101, 'YYYYMMDD') FROM DUAL;
--> ���������� ���ڿ��� �ٲ� �� �ٽ� DATE Ÿ������ �ٲ��.

SELECT TO_DATE('940104', 'YYMMDD') FROM DUAL; -- 90/01/16

SELECT TO_CHAR(TO_DATE('940104', 'YYMMDD'), 'YYYY-MM-DD') FROM DUAL; -- 2094-01-04
SELECT TO_CHAR(TO_DATE('940104', 'RRMMDD'), 'RRRR-MM-DD') FROM DUAL; -- 1994-01-04

/*
    TO_DATE�� �̿��� ��ȯ�� YY, RR�� ������
    -- YY : ���� ���⸦ ����(21C == 20XX���)
    -- RR : �о���� ���� 50�� �̻��̸� ���� ����(20C = 19XX���)
                          50�� �̸��̸� ���缼��(21C == 20XX���) ����
*/

-- EMPLOYEE ���̺���
-- 2000�⵵ ���Ŀ� �Ի��� ����� ���, �̸�, �Ի���
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE HIRE_DATE >= '00/01/01'; -- ������
WHERE HIRE_DATE >= TO_DATE('20000101', 'YYYYMMDD'); -- �����

--------------------------------------------------------------------------------

-- 5. NULL ó�� �Լ�

-- 1) NVL(�÷���, NULL�� ��� ��ü��)
--> �ش� �÷� ���� NULL�� ��� ��ü���� ����Ѵ�.

-- EMPLOYEE ���̺���
-- BONUS�� NULL�� ����� �÷����� 0���� ��ȯ�Ͽ�
-- �����, �޿�, BONUS ��ȸ
SELECT EMP_NAME, SALARY, NVL(BONUS, 0) BONUS
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- �μ��ڵ尡 NULL�� ����� ���, �̸�, �μ��ڵ� ��ȸ
-- NULL�� �μ��ڵ� "�μ� ����" ��ȯ
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, '�μ� ����') DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- 2) NVL2(�÷���, NULL�� �ƴ� ��� ��ü��, NULL�� ��� ��ü��)
-- EMPLOYEE ���̺���
-- ������ ���ʽ��� ���� ���ϴ� ����� ���ʽ����� 0.3
-- ������ ���ʽ��� �޴� ����� 0.8�� �����Ͽ�
-- �����, ���� ���ʽ�, ����� ���ʽ� ��ȸ
SELECT EMP_NAME, NVL(BONUS, 0) "���� ���ʽ�", NVL2(BONUS, 0.8, 0.3) "����� ���ʽ�"
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- �������� ����� '������'
-- ����� ����� '���(�����)'�� �����Ͽ�
-- ���, �����, �������� ��ȸ
SELECT EMP_ID, EMP_NAME, NVL2(ENT_DATE, '���('||ENT_DATE||')', '������') ��������
FROM EMPLOYEE
ORDER BY EMP_ID DESC;

-- ������ �Լ� ���� ����

--1. EMPLOYEE ���̺���
--  ������� �ֹι�ȣ�� ��ȸ
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1, 8), 14, '*')
FROM EMPLOYEE;


--2. EMPLOYEE ���̺���
--  ������, �����ڵ�, ����(��) ��ȸ
--  ��, �Ѽ��ɾ��� ��57,000,000 ���� ǥ��
--  (�Ѽ��ɾ��� ���ʽ��� ����� 1��ġ �޿�)
SELECT EMP_NAME, JOB_CODE, TO_CHAR((SALARY+(SALARY*NVL(BONUS, 0)))*12, 'L999,999,999')
FROM EMPLOYEE;

-- 3. EMPLOYEE ���̺���
--   �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--	 ��� ����� �μ��ڵ� �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR DEPT_CODE = 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

-- 4. EMPLOYEE ���̺���
--   ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--   ��, �Ի��� ���� �ٹ��ϼ��� �����ؼ� +1 �� ��
SELECT EMP_NAME, HIRE_DATE,
    LAST_DAY(HIRE_DATE)-HIRE_DATE+1 "�Ի�� �ٹ� �ϼ�"
FROM EMPLOYEE;


--5. EMPLOYEE ���̺���
--  ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--  ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, ���.
SELECT EMP_NAME �̸�, DEPT_CODE �μ��ڵ�,
    TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6)), 'YY"��" MM"��" DD"��"') �������,
    FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'))/12) "����(��)"
    -- FLOOR((SYSDATE - TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'))/365) "����(���ϼ�)"
    -- CEIL(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6)))/12) "����(�޼�)"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 6. ���� �Լ�
-- �������� ��쿡 ���� ������ �� �� �ִ� ����� �����ϴ� �Լ�

-- 1) DECODE(�÷��� | ����, ���1, ����1, ���2, ����2, ���3, ����3, ..., ������)
-- ���� �Ǵ� �÷� ���� ����� ��ġ�ϸ� �ش� ���� ���� ��ȯ
-- (Java switch�� ���)

-- EMPLOYEE ���̺���
-- ���, �̸�, �ֹε�Ϲ�ȣ, ����(��/��) ��ȸ
SELECT EMP_ID, EMP_NAME, EMP_NO,
    DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '2', '����') "����(��/��)"
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- ������ �޿��� �λ��ϰ��� �Ѵ�.
-- �����ڵ尡 'J7'�� ������ 10%�λ�
-- 'J6'�� ������ 15%�λ�
-- 'J5'�� ������ 20%�λ�
-- �׿� ������ 5%�� �λ�
-- �̶� �����, �����ڵ�, �����޿�, �λ�޿��� �����ڵ� ������������ ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY,
    DECODE(JOB_CODE, 'J7', SALARY*1.1,
                    'J6', SALARY*1.15,
                    'J7', SALARY*1.2,
                     SALARY*1.05) �λ�޿�
FROM EMPLOYEE
ORDER BY JOB_CODE;

-- 2) CASE��
/* [�ۼ���]

    CASE WHEN ���ǽ� THEN ���1
         WHEN ���ǽ� THEN ���2
         WHEN ���ǽ� THEN ���3
         ...
         ELSE ������ ���
    END
    
*/

-- EMPLOYEE ���̺���
-- ������ �޿��� �λ��ϰ��� �Ѵ�.
-- �����ڵ尡 'J7'�� ������ 10%�λ�
-- 'J6'�� ������ 15%�λ�
-- 'J5'�� ������ 20%�λ�
-- �׿� ������ 5%�� �λ�
-- �̶� �����, �����ڵ�, �����޿�, �λ�޿��� �����ڵ� ������������ ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY,
    CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
         WHEN JOB_CODE = 'J6' THEN SALARY*1.15
         WHEN JOB_CODE = 'J5' THEN SALARY*1.2
         ELSE SALARY*1.05
    END �λ�޿�
FROM EMPLOYEE
ORDER BY 2;

-- EMPLOYEE ���̺��� ���, �̸�, �޿�, ������ ��� ��ȸ
-- ������ ��� ����
-- �޿� 500�� �̻� : '���'
-- �޿� 500�� �̸�, 300�� �̻� : '�߱�'
-- �޿� 300�� �̸� : '�ʱ�'
SELECT EMP_ID, EMP_NAME, SALARY,
    CASE WHEN SALARY > 5000000 THEN '���'
         WHEN SALARY >= 3000000 THEN '�߱�'
         ELSE '�ʱ�'
    END "������ ���"
FROM EMPLOYEE;
         
--------------------------------------------------------------------------------

-- [�׷� �Լ�]
-- �ϳ� �̻��� ���� �׷����� ���� ������ �� �ϳ��� ����� ��ȯ�ϴ� �Լ�

-- 1) SUM(���ڰ� ��ϵ� �÷���) : �ش� �÷��� ������ ��ȯ

-- EMPLOYEE ���̺��� ��� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY) �޿�����
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���� ����� �޿� ���� ��ȸ
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') �޿�����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE ���̺���
-- �μ��ڵ尡 'D5'�� ������ ���ʽ� ���� ���� ���� ��ȸ
SELECT TO_CHAR(SUM(SALARY*(1+NVL(BONUS, 0))*12), 'L999,999,999') ���ʽ����Կ���D5
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2) AVG(���ڰ� ��ϵ� �÷���) : �ش� �÷��� ����� ��ȯ
-- EMPLOYEE ���̺��� ��� ������ �޿� ��, ��� ��ȸ
SELECT SUM(SALARY), FLOOR(AVG(SALARY))
FROM EMPLOYEE;

-- 3) MIN(�÷���) : �׷� �� ������ �÷����� ���� ���� �� ��ȯ
--    MAX(�÷���) : �׷� �� ������ �÷����� ���� ū �� ��ȯ

-- EMPLOYEE ���̺��� �̸� ������ ���� ���� �����, ������ ��� ��ȸ
SELECT MIN(EMP_NAME), MAX(EMP_NAME)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �̸��� ������ ���� ���� �����, ������ ��� ��ȸ
SELECT MIN(EMAIL), MAX(EMAIL)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �޿��� ���� ���� �����, ���� ��� ��ȸ
SELECT MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �Ի����� ���� ���� �����, ���� ��� ��ȸ
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE ���̺���
-- ��ü �޿� ��,
-- ���, 
-- ���� ���� �޴»�� �޿�, 
-- ���� ���� ��� �޿� ��ȸ
SELECT SUM(SALARY), FLOOR(AVG(SALARY)), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 4) COUNT(* || [DISTINCT]�÷���) : 
-- COUNT(*) : NULL�� ������ ��� ���� ������ ��ȯ
-- COUNT(�÷���) : �ش� �÷��� �÷� �� �� NULL�� ������ ������ ��ȯ
-- COUNT(DISTINCT �÷���) : �ߺ��� �� ���� + NULL ������ ���� ����

-- EMPLOYEE ���̺���
-- ��� ����� ��
-- �μ��ڵ尡 �ִ� ����� ��
-- ����� �����ִ� �μ��� ��
SELECT COUNT(*) �����, COUNT(DEPT_CODE) �μ��ִ»��, COUNT(DISTINCT DEPT_CODE) ����ִºμ�
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �޿��� 300�� �̻��� ����� �� ��ȸ
SELECT COUNT(*) ���ڳ��
FROM EMPLOYEE
WHERE SALARY >= 3000000;
