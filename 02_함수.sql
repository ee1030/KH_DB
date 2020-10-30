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


