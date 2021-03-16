-- 현재 계정 내에 어떤 테이블이 있는가?
--  TABLE : 실제 데이터가 담겨있는 공간
--  VIEW : 테이블의 데이터를 불러와서 표시 형식만 정의
SELECT * FROM tab;      --Ctrl + Enter

--  테이블의 구조 확인 DESC
DESC employees;

-- 모든 컬럼 확인
-- 테이블에 정의된 컬럼의 순서대로
SELECT * FROM employees;

DESC departments;

--SELECT * FROM department;

--  first_name, 전화번호, 입사일, 급여
SELECT first_name, phone_number, hire_date, salary FROM employees;

-- first_name, last_name, salary, 전화번호, 입사일
SELECT first_name,
    last_name,
    phone_number,
    hire_date,
    salary
FROM employees;

--  산술 연산 : 기본적인 산술 연산을 사용
SELECT 3.14159 * 3 * 3 FROM employees;  --   모든 레코드를 불러와서 산술연산을 수행
SELECT 3.14159 * 3 * 3 FROM dual;       --   단순 계산식은 dual(가상테이블)을 이용

SELECT first_name, 
    salary, 
    salary * 12     --  레코드 내 모든 salary 컬럼에 동일 산술연산을 수행
FROM employees;

--
SELECT job_id * 12   
FROM employees;      -- ERROR : 산술 연산은 수치 자료형에서만 가능

DESC employees;

--  사원의 이름, salary, commission_pct 출력
SELECT first_name, salary, commission_pct
FROM employees;

--  계산식에 null이 포함되어 있으면 결과는 null
SELECT first_name,
    salary,
    salary + (salary * commission_pct)
FROM employees;

--  nvl함수 : null -> 다른 기본값으로 치환
--  null 값을 처리할 때는 항상 유의
SELECT first_name,
    salary + (salary * nvl(commission_pct, 0))  --  commission_pct null -> 0
FROM employees;

--  문자열의 연결 (||)
--  별칭 (Alias)
--  as 는 없어도 된다
--  공백, 특수문자가 포함되어 있으면 별칭을 ""로 묶어준다
SELECT first_name || ' ' || last_name as "FULL NAME"
FROM employees;

/*
이름 : first_name last_name
입사일 : hire_date
전화번호 : phone_number
급여 : salary
연봉 : salary * 12
*/

SELECT first_name || ' ' || last_name as "이름",
    hire_date 입사일,
    phone_number 전화번호,
    salary 급여,
    salary * 12 연봉
FROM employees;

--------------
--  WHERE : 조건에 맞는 레코드 추출을 위한 조건 비교
--------------
/*
급여가 15000 이상인 사원들의 이름과 연봉을 출력하세요
07/01/01 이후 입사자들의 이름과 입사일을 출력하세요
이름이 'Lex'인 사원의 연봉과 입사일, 부서 ID를 출력하세요
부서 ID가 10인 사원의 명단이 필요합니다
*/

--  급여가 15000 이상인 사원들의 이름과 연봉을 출력하세요
SELECT first_name || ' ' || last_name 이름,
    salary * 12 연봉
FROM employees
WHERE salary >= 15000;

--  07/01/01 이후 입사자들의 이름과 입사일을 출력하세요
SELECT first_name || ' ' || last_name 이름,
    hire_date 입사일
FROM employees
WHERE hire_date >= '07/01/01';

--  이름이 'Lex'인 사원의 연봉과 입사일, 부서 ID를 출력하세요
SELECT first_name,
    salary * 12,
    hire_date,
    department_id
FROM employees
WHERE first_name = 'Lex';

--  부서 ID가 10인 사원의 명단이 필요합니다
SELECT * FROM employees
WHERE department_id = 10;


/*
급여가 14000 이하이거나 17000 이상인 사원의 이름과 급여를 출력하세요
부서 ID가 90인 사원 중, 급여가 20000 이상인 사원은 누구인가요 ?
*/
--  급여가 14000 이하이거나 17000 이상인 사원의 이름과 급여를 출력하세요
SELECT first_name, salary
FROM employees
WHERE salary <= 14000 OR salary >= 17000;

--  부서 ID가 90인 사원 중, 급여가 20000 이상인 사원은 누구인가요 ?
SELECT * FROM employees
WHERE department_id = 90 AND salary >= 20000;

--  급여가 14000 이상 17000 이하인 사원의 이름과 급여를 출력하세요
SELECT first_name, salary
FROM employees
WHERE salary >= 14000 AND salary <= 17000;

-- >= and <=    -> Between 으로
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 14000 and 17000;

--  입사일이 07/01/01 ~ 07/12/31 구간에 있는 사원의 목록을 출력해 봅시다
SELECT * FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';


/*
부서 ID가 10, 20, 40인 사원의 명단을 출력해 봅시다
MANAGER ID가 100, 120, 147인 사원의 명단을 출력해 봅시다
- 비교연산자 + 논리연산자를 이용하여 출력해 보고
- IN 연산자를 이용해 출력해 봅시다
- 두 쿼리를 비교해 보고 IN 연산자의 유용한 점을 생각해 봅시다
*/
--  부서 ID가 10, 20, 40인 사원의 명단을 출력해 봅시다
SELECT * FROM employees
WHERE department_id = 10 OR
    department_id = 20 OR
    department_id = 40;
    
SELECT * FROM employees
WHERE department_id IN (10, 20, 40);    --  department_id가 10, 20, 40 중에 하나

--  MANAGER ID가 100, 120, 147인 사원의 명단을 출력해 봅시다
SELECT * FROM employees
WHERE manager_id = 100 OR
    manager_id = 120 OR
    manager_id = 147;
    
SELECT * FROM employees
WHERE manager_id IN (100, 120, 147);


--  커미션을 받지 않는 사원의 목록 => commission_pct 가 null
-- is null
SELECT first_name, commission_pct FROM employees
WHERE commission_pct is null;

--  커미션을 받는 사원의 목록 => commission_pct 가 null 이 아닌 사원
SELECT first_name, commission_pct FROM employees
WHERE commission_pct is not null;


--  Like 연산
--  % 임의의 길이 (0일 수 있다)의 문자열
--  _ 1개의 임의의 문자

--  이름에 am을 포함한 모든 사원   %
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%am';

--  이름의 두 번째 글짜가 a인 모든 사원들
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '_a%';


/*
부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
급여가 10000 이상인 직원의 이름을 급여 내림차순 (높은 급여 -> 낮은 급여)로 출력하세요
부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차운, 급여 내림차순으로 출력하세요
*/
--  부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
SELECT first_name, salary, department_id
FROM employees
ORDER BY department_id ASC;     --  기본 정렬리 ASC 라 생략가능 (오름차순)

--  급여가 10000 이상인 직원의 이름을 급여 내림차순 (높은 급여 -> 낮은 급여)로 출력하세요
SELECT first_name, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary DESC;

--  부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차운, 급여 내림차순으로 출력하세요
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id ASC, salary DESC;


--------------
--  단일행 함수
--  개별 레코드에 적영되는 함수
--------------
--  문자열 단일행 함수
SELECT first_name, last_name,
    CONCAT(first_name, CONCAT(' ', last_name)) name,
    INITCAP(first_name || ' ' || last_name) name2,      --  각 단어의 첫글자를 대문자로
    LOWER(first_name),  --  전부 소문자
    UPPER(first_name),  --  전부 대문자
    LPAD(first_name, 10, '*'),  --  10글자 출력크기, 빈자리에 * 채우기
    RPAD(first_name, 10, '*')
FROM employees;

--  first_name 에 am이 포함된 사원의 이름
SELECT first_name FROM employees
WHERE first_name LIKE '%am%';

SELECT first_name FROM employees;

--  Upper, Lower는 대소문자 구분 없이 검색할 때 유용
SELECT first_name FROM employees
WHERE lower(first_name) LIKE '%am%';


--  정제
SELECT '   Oracle   ', '*****Database*****'
FROM dual;

SELECT LTRIM('    Oracle    '),     --  왼쪽에 있는 빈 공간을 지워줌
    RTRIM('    Oracle    '),        --  오른쪽에 있는 빈 공간을 지워줌
    TRIM('*' FROM '*****Database*****'),    --  문자열 내에서 특정 문자를 제거
    TRIM(' ' FROM '    Oracle    '),
    SUBSTR('Oracle Database', 8, 8),    --  문자열에서 8번째 글자부터 8문자 추출
    SUBSTR('Oracle Database', -8, 8)   --  뒤에서부터 8번쨰 글자부터 8문자 추출
FROM dual;


--  수치형 단일행 함수
SELECT ABS(-3.14),  --  절대값
    CEIL(3.14),     --  올림
    FLOOR(3.14),    --  내림
    FLOOR(7 / 3),   --  나눗셈의 몫
    MOD(7, 3),      --  나눗셈의 나머지
    POWER(2, 4),    --  제곱 : 2의 4제곱
    ROUND(3.5),     --  소수점 첫째자리 반올림
    ROUND(3.5678, 2),-- 소수점 둘째자리까지 표시. 세번째자리에서 반올림
    TRUNC(3.5),     --  소수점 버림
    TRUNC(3.5678, 2),-- 소수점 둘째자리까지 표시. 나머지는 버림
    SIGN(-10)       --  부호 함수 (음수 -1, 0, 양수 1)
FROM dual;

SELECT first_name,
    (salary + (salary * commission_pct)) * 12
FROM employees;


--  날짜형 단일행 함수
SELECT sysdate FROM dual;   --  시스템 가상 테이블 -> 1개

SELECT sysdate FROM employees;  --테이블 내의 레코드 갯수만큼 출력

SELECT sysdate,     --  시스템 날짜
    ADD_MONTHS(sysdate, 2), --  오늘부터 2개월 후
    MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'), sysdate),      --   ~개월 차
    ROUND(sysdate, 'MONTH'),    --  날짜 반올림
    TRUNC(sysdate, 'MONTH')    --
FROM dual;


--  employees 사원들의 입사 후 얼마나 지났는지 확인
SELECT first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date), 1) as months
FROM employees;


----------------
--  변환함수
----------------
/*
TO_CHAR(o, fmt) :   Number of Date -> Varchar
TO_NUMBER(s, fmt) :     Varchar -> Number
TO_DATAE(s, fmt) :  Varchar -> Date
*/

--  TO_CHAR
SELECT first_name,
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') 입사일
FROM employees;

--  현재 시간을 년-월-일 오전/오후 시:분:초 형식으로 출력
SELECT 
    sysdate,
    TO_CHAR(sysdate, 'YYYY-MM-DD PM HH:MI:SS')
FROM dual;