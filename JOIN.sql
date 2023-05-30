/*
    FOOD_WAREHOUSE 테이블에서 경기도에 위치한 창고의 ID, 이름, 주소, 냉동시설 여부를 조회하는 SQL문을 작성해주세요.
    이때 냉동시설 여부가 NULL인 경우, 'N'으로 출력시켜 주시고 결과는 창고 ID를 기준으로 오름차순 정렬해주세요.
*/
SELECT 
    WAREHOUSE_ID
    , WAREHOUSE_NAME
    , ADDRESS
    , nvl(FREEZER_YN, 'N') as FREEZER_YN
from FOOD_WAREHOUSE
where SUBSTR(ADDRESS, 0, 3) = '경기도'
order by WAREHOUSE_ID;

/*
    동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 
    단, ID는 오름차순 정렬되어야 합니다.
*/
SELECT
    ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NULL
ORDER BY ANIMAL_ID ASC

/*
    동물 보호소에 들어온 동물 중, 이름이 있는 동물의 ID를 조회하는 SQL 문을 작성해주세요. 
    단, ID는 오름차순 정렬되어야 합니다.
*/
SELECT
    ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
ORDER BY ANIMAL_ID ASC

/*
    동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요.
    이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
*/
SELECT
    ANIMAL_TYPE
    , NVL(NAME,'No name') AS NAME
    , SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC

/*
    USER_INFO 테이블에서 나이 정보가 없는 회원이 몇 명인지 출력하는 SQL문을 작성해주세요. 
    이때 컬럼명은 USERS로 지정해주세요.
*/
SELECT
    COUNT(*) AS USERS
FROM USER_INFO
WHERE AGE IS NULL

/*
    관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 
    보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
    이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
*/
SELECT
    AI.ANIMAL_ID
    , AI.NAME
FROM ANIMAL_INS AI
LEFT JOIN ANIMAL_OUTS AO
    ON AO.ANIMAL_ID = AI.ANIMAL_ID
WHERE 1=1
    AND TO_CHAR(AI.DATETIME, 'YYYYMMDDHH24MISS') > TO_CHAR(AO.DATETIME, 'YYYYMMDDHH24MISS')
ORDER BY AI.DATETIME ASC;

/*
    아직 입양을 못 간 동물 중, 
    가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 
    이때 결과는 보호 시작일 순으로 조회해야 합니다.
*/
SELECT
    S.NAME
    , S.DATETIME
FROM
    (
    SELECT
        AI.NAME AS NAME
        , AI.DATETIME AS DATETIME
    FROM ANIMAL_INS AI
    LEFT JOIN ANIMAL_OUTS AO
        ON AO.ANIMAL_ID = AI.ANIMAL_ID
    WHERE AO.DATETIME IS NULL
    ORDER BY AI.DATETIME ASC
    ) S
WHERE ROWNUM < 4;

-- 틀린답 (프로그래머스 질문란)
SELECT NAME ,DATETIME
  FROM (
        SELECT M1.NAME, M1.DATETIME 
          FROM ANIMAL_INS M1
          LEFT JOIN ANIMAL_OUTS M2 ON M2.ANIMAL_ID = M1.ANIMAL_ID
                                  AND M2.DATETIME IS NULL
         ORDER BY M1.DATETIME  
       )
WHERE ROWNUM <= 3
/*
	LEFT JOIN은 OUTER JOIN 인데, 이는 합집합이므로, WHERE 조건 처럼 해당되는 값만 걸러주는 구문이 아니다.
	따라서 JOIN 문에 AND 조건을 걸어주는게 아닌, WHERE 조건을 걸어주는게 맞다.
*/

/*
    '경제' 카테고리에 속하는 도서들의 
    도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력하는 SQL문을 작성해주세요.
    결과는 출판일을 기준으로 오름차순 정렬해주세요.
*/
SELECT
    B.BOOK_ID,	
    A.AUTHOR_NAME,
    TO_CHAR(B.PUBLISHED_DATE, 'YYYY-MM-DD')
FROM BOOK B
    LEFT JOIN AUTHOR A
        ON A.AUTHOR_ID = B.AUTHOR_ID
WHERE 1=1
    AND B.CATEGORY = '경제'
ORDER BY B.PUBLISHED_DATE ASC

/*
    천재지변으로 인해 일부 데이터가 유실되었습니다. 
    입양을 간 기록은 있는데, 
    보호소에 들어온 기록이 없는 동물의 
    ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
*/
SELECT
    O.ANIMAL_ID
    ,O.NAME
FROM ANIMAL_OUTS O
    LEFT JOIN ANIMAL_INS I
        ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE 1=1
    AND I.ANIMAL_ID IS NULL
ORDER BY O.ANIMAL_ID ASC

/*
    보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 
    보호소에 들어올 당시에는 중성화1되지 않았지만,
    보호소를 나갈 당시에는 중성화된 동물의 
    아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
*/
SELECT
    I.ANIMAL_ID
    ,I.ANIMAL_TYPE
    , I.NAME
FROM ANIMAL_INS I
    LEFT JOIN ANIMAL_OUTS O
        ON O.ANIMAL_ID = I.ANIMAL_ID
WHERE 1=1
    AND I.SEX_UPON_INTAKE LIKE 'Intact%'
    AND O.SEX_UPON_OUTCOME NOT LIKE 'Intact%'
ORDER BY I.ANIMAL_ID ASC

/*
    PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요.
    결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
*/
SELECT 
    P.PRODUCT_CODE
    , S.AMOUNT * P.PRICE SALES
FROM PRODUCT P
INNER JOIN 
    (
        SELECT
            PRODUCT_ID
            , SUM(SALES_AMOUNT) AMOUNT
        FROM OFFLINE_SALE
        GROUP BY PRODUCT_ID
    ) S ON S.PRODUCT_ID = P.PRODUCT_ID
ORDER BY SALES DESC, PRODUCT_CODE ASC

/*
    USER_INFO 테이블과 ONLINE_SALE 테이블에서 2021년에 가입한 전체 회원들 중 
    상품을 구매한 회원수와 
    상품을 구매한 회원의 비율(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)을 
    년, 월 별로 출력하는 SQL문을 작성해주세요. 
    상품을 구매한 회원의 비율은 소수점 두번째자리에서 반올림하고, 
    전체 결과는 년을 기준으로 오름차순 정렬해주시고 년이 같다면 월을 기준으로 오름차순 정렬해주세요.
*/
SELECT TO_CHAR(SALES_DATE, 'YYYY') as YEAR,
       TO_NUMBER(TO_CHAR(SALES_DATE, 'MM')) as MONTH,
       COUNT(DISTINCT(I.USER_ID)) as PUCHASED_USERS,
       ROUND(COUNT(DISTINCT(I.USER_ID)) / 
             (SELECT COUNT(DISTINCT(USER_ID)) 
              FROM USER_INFO
              WHERE TO_CHAR(JOINED, 'YYYY') = '2021')
             ,1) as PUCHASED_RATIO       
FROM USER_INFO I RIGHT JOIN ONLINE_SALE S ON I.USER_ID = S.USER_ID
WHERE TO_CHAR(JOINED, 'YYYY') = '2021'
GROUP BY TO_CHAR(SALES_DATE, 'YYYY'), TO_CHAR(SALES_DATE, 'MM')
ORDER BY 1, 2;

/*
    FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 
    식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 
    이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 
    총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.
*/
SELECT PRODUCT_ID, PRODUCT_NAME, SUM(PRICE*AMOUNT) TOTAL_SALES
FROM FOOD_PRODUCT 
INNER JOIN FOOD_ORDER 
USING (PRODUCT_ID)
WHERE TO_CHAR(PRODUCE_DATE, 'MM') = '05'
GROUP BY PRODUCT_ID, PRODUCT_NAME
ORDER BY TOTAL_SALES DESC, PRODUCT_ID ASC;

/*
    7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 
    상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.
*/
SELECT
    C.FLAVOR
FROM
    (
        SELECT
            A.FLAVOR, SUM(A.TOTAL_ORDER + B.TOTAL_ORDER)
        FROM FIRST_HALF A
            LEFT JOIN JULY B
                ON B.FLAVOR = A.FLAVOR
        GROUP BY A.FLAVOR
        ORDER BY SUM(A.TOTAL_ORDER + B.TOTAL_ORDER) DESC
    ) C
WHERE ROWNUM < 4

/*
    MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 
    회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 
    결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.
*/
SELECT MEMBER_NAME, 
       REVIEW_TEXT, 
       TO_CHAR(REVIEW_DATE, 'YYYY-MM-DD')
FROM MEMBER_PROFILE
NATURAL JOIN (
    SELECT MEMBER_ID,
           DENSE_RANK() over (ORDER BY COUNT(MEMBER_ID) DESC) as RANK
    FROM REST_REVIEW
    GROUP BY MEMBER_ID
) A
WHERE A.RANK = 1
ORDER BY REVIEW_DATE, REVIEW_TEXT ASC