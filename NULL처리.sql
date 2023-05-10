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