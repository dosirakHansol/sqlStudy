/*
    PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판매가를 출력하는 SQL문을 작성해주세요. 
    이때 컬럼명은 MAX_PRICE로 지정해주세요.
*/
SELECT
    MAX(PRICE) AS MAX_PRICE
FROM PRODUCT;

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
    AND ROWNUM = 1;
    
/*
    동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
*/
SELECT MIN(DATETIME)
FROM
(
SELECT 
    DATETIME
FROM ANIMAL_INS
ORDER BY DATETIME ASC
)

/*
    동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
*/
SELECT
    COUNT(*)
FROM ANIMAL_INS

/*
    동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 
    이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
*/
SELECT
    COUNT(CASE WHEN NAME IS NOT NULL THEN 1 END)
FROM
(
SELECT
    NAME
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
)