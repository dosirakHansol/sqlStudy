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