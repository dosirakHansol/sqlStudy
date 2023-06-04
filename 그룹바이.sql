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


/*
    USER_INFO 테이블과 ONLINE_SALE 테이블에서 
    년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요.
    결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요.
    이때, 성별 정보가 없는 경우 결과에서 제외해주세요.
*/
SELECT 
    A.YEAR
    , A.MONTH
    , A.GENDER
    , COUNT(DISTINCT A.USER_ID) AS COUNT
FROM
(
SELECT
    extract (YEAR from SALES_DATE) AS YEAR
    , extract (MONTH from SALES_DATE) AS MONTH
    , U.GENDER
    , O.USER_ID
FROM ONLINE_SALE O
LEFT JOIN USER_INFO U
    ON U.USER_ID = O.USER_ID
) A
GROUP BY YEAR, MONTH, GENDER
HAVING A.GENDER IS NOT NULL
ORDER BY YEAR, MONTH, GENDER

/*
    0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 
    이때 결과는 시간대 순으로 정렬해야 합니다.
*/
SELECT HOUR, COUNT(T1.DATETIME) AS COUNT
FROM
(
    SELECT LEVEL-1 AS HOUR
    FROM DUAL
    CONNECT BY LEVEL <= 24
) T2 
LEFT JOIN ANIMAL_OUTS T1
    ON T2.HOUR = TO_CHAR(T1.DATETIME, 'HH24')
GROUP BY HOUR
ORDER BY HOUR ASC


/*
    2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.
*/
SELECT 
    C.AUTHOR_ID
    , C.AUTHOR_NAME
    , B.CATEGORY
    , SUM(A.SALES * B.PRICE) as TOTAL_SALES
FROM BOOK_SALES A, BOOK B, AUTHOR C
WHERE A.BOOK_ID=B.BOOK_ID 
    AND  B.AUTHOR_ID=C.AUTHOR_ID 
    AND EXTRACT(YEAR FROM SALES_DATE) = 2022 
    AND EXTRACT(MONTH FROM SALES_DATE) = 1
GROUP BY C.AUTHOR_ID,C.AUTHOR_NAME,B.CATEGORY 
ORDER BY C.AUTHOR_ID ASC, B.CATEGORY DES

/*
CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
*/

SELECT CAR_ID, CASE WHEN AP = 0 THEN '대여 가능' ELSE '대여중' END AS AVAILABILITY
FROM (SELECT CAR_ID, 
             SUM(CASE WHEN TO_DATE('2022-10-16', 'YYYY-MM-DD') 
                 BETWEEN START_DATE AND END_DATE THEN 1 ELSE 0 END) AS AP
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        GROUP BY CAR_ID
    )
ORDER BY CAR_ID DESC;

/*
    2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 카테고리명을 기준으로 오름차순 정렬해주세요.
*/
SELECT B.CATEGORY, SUM(I.SALES)
FROM BOOK_SALES I, BOOK B
WHERE B.BOOK_ID = I.BOOK_ID
AND TO_CHAR(SALES_DATE, 'MM') = '01'
GROUP BY B.CATEGORY
ORDER BY B.CATEGORY

/*
    CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
*/
SELECT EXTRACT(MONTH FROM R.START_DATE) AS MONTH, R.CAR_ID, COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY R
WHERE R.CAR_ID IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE START_DATE BETWEEN TO_DATE('2022-08-01', 'YYYY-MM-DD') AND TO_DATE('2022-10-31', 'YYYY-MM-DD')
    GROUP BY CAR_ID
    HAVING COUNT(*) >= 5
)
AND R.START_DATE BETWEEN TO_DATE('2022-08-01', 'YYYY-MM-DD') AND TO_DATE('2022-10-31', 'YYYY-MM-DD')
GROUP BY EXTRACT(MONTH FROM R.START_DATE), R.CAR_ID
HAVING COUNT(*) > 0
ORDER BY EXTRACT(MONTH FROM R.START_DATE), R.CAR_ID DESC;