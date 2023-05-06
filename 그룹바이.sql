/*
    상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 
    아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요.
    이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요.
*/
SELECT
    INGREDIENT_TYPE
    , SUM(TOTAL_ORDER) AS TOTAL_ORDER
FROM ICECREAM_INFO A
LEFT JOIN FIRST_HALF B ON B.FLAVOR = A.FLAVOR
GROUP BY INGREDIENT_TYPE

/*
    APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요.
    이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 
    결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 
    예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.
*/
SELECT
    MCDP_CD
    , COUNT(*)
FROM APPOINTMENT
WHERE TO_CHAR(APNT_YMD, 'MM') = '05'
GROUP BY MCDP_CD
ORDER BY COUNT(*), MCDP_CD

/*
    동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요.
    이때 고양이를 개보다 먼저 조회해주세요
*/
SELECT
    ANIMAL_TYPE
    , COUNT(*)
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE ASC

/*
    동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 
    해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 
    이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
*/  
SELECT
    NAME
    , COUNT(NAME) COUNT
FROM ANIMAL_INS
GROUP BY NAME
HAVING COUNT(NAME) > 1
ORDER BY NAME