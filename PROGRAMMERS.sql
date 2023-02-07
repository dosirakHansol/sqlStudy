-----------------------------------------
-- PROGRAMMERS
-----------------------------------------
-- 평균 일일 대여 요금 구하기
-- 조건부 WHERE 절
-- CAST 사용하여 소수점 제거
SELECT 
    CAST(AVG(DAILY_FEE)AS INTEGER) 
FROM CAR_RENTAL_COMPANY_CAR 
WHERE CAR_TYPE = 'SUV';

-- 모든 레코드 조회하기
-- ORDER BY 로 정렬
SELECT
    *
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;
 