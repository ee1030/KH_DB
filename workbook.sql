-- SQL01_SELECT(basic).pdf 풀기
-- 3번, 10번 제외
-- 집에서 깃헙 실습 하려고 만든 주석

-- 1번 문제
SELECT DEPARTMENT_NAME 학과명, CATEGORY 계열
FROM TB_DEPARTMENT;

-- 2번 문제
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' 학과별정원
FROM TB_DEPARTMENT;

-- 3번 문제
SELECT STUDENT_NAME
FROM TB_STUDENT, TB_DEPARTMENT
WHERE TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO
AND TB_DEPARTMENT.DEPARTMENT_NAME = '국어국문학과'
AND TB_STUDENT.ABSENCE_YN = 'Y'
AND TB_STUDENT.STUDENT_SSN LIKE '_______2%';

-- 4번 문제
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NO DESC;

-- 5번문제
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6번 문제
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7번문제
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8번 문제
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9번 문제
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 10번 문제
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ENTRANCE_DATE LIKE '02%'
AND STUDENT_ADDRESS LIKE '전주%'
AND ABSENCE_YN = 'N';