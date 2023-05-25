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