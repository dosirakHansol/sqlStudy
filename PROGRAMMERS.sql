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


/*
    3월에 태어난 여성 회원 목록 출력하기
    -- 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성
    1. 전화번호가 NULL인 경우는 출력대상에서 제외
    2. 회원 ID를 기준으로 오름차순 정렬
*/
SELECT 
    MEMBER_ID
    , MEMBER_NAME
    , GENDER
    , TO_CHAR(DATE_OF_BIRTH, 'YYYY-MM-DD') AS DATE_OF_BIRTH
FROM
    MEMBER_PROFILE
WHERE 1=1
    AND GENDER = 'W'
    AND TO_CHAR(DATE_OF_BIRTH, 'MM') = '03'
    AND TLNO IS NOT NULL
ORDER BY
    MEMBER_ID ASC
/*
    오프라인/온라인 판매 데이터 통합하기
    -- ONLINE_SALE 테이블과 OFFLINE_SALE 테이블에서 
    2022년 3월의 오프라인/온라인 상품 판매 데이터의 
    판매 날짜, 상품ID, 유저ID, 판매량을 
    출력하는 SQL문을 작성해주세요. 
    OFFLINE_SALE 테이블의 판매 데이터의 USER_ID 값은 NULL 로 표시해주세요. 
    결과는 판매일을 기준으로 오름차순 정렬해주시고 
    판매일이 같다면 상품 ID를 기준으로 오름차순, 
    상품ID까지 같다면 유저 ID를 기준으로 오름차순 정렬해주세요.
*/
SELECT 
    TO_CHAR(SALES_DATE, 'YYYY-MM-DD') AS SALES_DATE
    , PRODUCT_ID
    , CASE WHEN USER_ID = 0 THEN NULL ELSE USER_ID END AS USER_ID
    , SALES_AMOUNT
FROM
(
SELECT
    SALES_DATE
    , PRODUCT_ID
    , USER_ID
    , SALES_AMOUNT
FROM
    ONLINE_SALE
UNION ALL
SELECT
    SALES_DATE
    , PRODUCT_ID
    , 0
    , SALES_AMOUNT
FROM
    OFFLINE_SALE
)
WHERE 1=1
    AND TO_CHAR(SALES_DATE, 'MM') = '03'
ORDER BY
    SALES_DATE ASC
    , PRODUCT_ID ASC
    , USER_ID ASC
    
/*
    동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성
    - 결과는 아이디 순으로 조회
*/
SELECT
    ANIMAL_ID
    , NAME
FROM
    ANIMAL_INS
WHERE 1=1
    AND INTAKE_CONDITION = 'Sick'
ORDER BY
    ANIMAL_ID ASC
/*
    동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성
    - 결과는 아이디 순으로 조회
*/
SELECT
    ANIMAL_ID
    , NAME
FROM
    ANIMAL_INS
WHERE 1=1
    AND INTAKE_CONDITION != 'Aged'
ORDER BY
    ANIMAL_ID ASC
/*
    동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성
    - 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
*/
SELECT
    ANIMAL_ID
    , NAME
    , DATETIME
FROM
    ANIMAL_INS
ORDER BY
    NAME ASC
    , DATETIME DESC
/*
    동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
*/
SELECT
    NAME
FROM
(
    SELECT
        NAME
    FROM
        ANIMAL_INS
    ORDER BY 
        DATETIME ASC
) 
WHERE 1=1
    AND ROWNUM = 1
    
/*
    테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요.
*/
SELECT
    COUNT(*)
FROM
    USER_INFO
WHERE 1=1
    AND AGE >= 20
    AND AGE <= 29
    AND TO_CHAR(JOINED, 'YYYY') = '2021'
    
/*
    FOOD_PRODUCT 테이블에서 가격이 제일 비싼 식품의 
    식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.
*/
SELECT
    PRODUCT_ID
    , PRODUCT_NAME
    , PRODUCT_CD
    , CATEGORY
    , PRICE
FROM
(
    SELECT
        PRODUCT_ID
        , PRODUCT_NAME
        , PRODUCT_CD
        , CATEGORY
        , PRICE
    FROM
        FOOD_PRODUCT
    ORDER BY
        PRICE DESC
) 
WHERE 1=1
    AND ROWNUM = 1
    
/*
    가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
*/
SELECT
    DATETIME
FROM
(
    SELECT
        *
    FROM
        ANIMAL_INS
    ORDER BY
        DATETIME DESC
)
WHERE 1=1
    AND ROWNUM = 1
    
/*
    BOOK 테이블에서 2021년에 출판된 '인문' 카테고리에 속하는 도서 리스트를 찾아서 
    도서 ID(BOOK_ID), 출판일 (PUBLISHED_DATE)을 출력하는 SQL문을 작성해주세요.
    결과는 출판일을 기준으로 오름차순 정렬해주세요.
*/
SELECT
    BOOK_ID
    , TO_CHAR(PUBLISHED_DATE, 'YYYY-MM-DD')
FROM
    BOOK
WHERE 1=1
    AND CATEGORY = '인문'
    AND TO_CHAR(PUBLISHED_DATE, 'YYYY') = '2021'
ORDER BY
    PUBLISHED_DATE ASC
    
/*
    REST_INFO와 REST_REVIEW 테이블에서 
    서울에 위치한 식당들의 
    식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회하는 SQL문을 작성해주세요. 
    이때 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고 
    결과는 평균점수를 기준으로 내림차순 정렬해주시고, 
    평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬해주세요.
*/

SELECT
    REST_INFO.REST_ID
    , REST_INFO.REST_NAME
    , REST_INFO.FOOD_TYPE
    , REST_INFO.FAVORITES
    , REST_INFO.ADDRESS
    , ROUND(AVG(REST_REVIEW.REVIEW_SCORE), 2) AS SCORE
FROM REST_INFO 
    INNER JOIN REST_REVIEW 
        ON REST_REVIEW.REST_ID = REST_INFO.REST_ID
WHERE 1=1
    AND ADDRESS LIKE '%서울%'
GROUP BY
    REST_INFO.REST_ID
    , REST_INFO.REST_NAME
    , REST_INFO.FOOD_TYPE
    , REST_INFO.FAVORITES
    , REST_INFO.ADDRESS
ORDER BY
    SCORE DESC
    , FAVORITES DESC
;