/*
https://school.programmers.co.kr/learn/courses/30/lessons/284530
*/
SELECT YEAR(YM) AS YEAR,
       ROUND(AVG(PM_VAL1), 2) AS "PM10",
       ROUND(AVG(PM_VAL2), 2) AS "PM2.5"
FROM AIR_POLLUTION
WHERE LOCATION2 = '수원'
GROUP BY YEAR(YM)
ORDER BY YEAR(YM);
/* 실수 
1. round(col, 2) : 반올림 2자리까지
2. avg(col) : 평균
3. year(col) : 년도 추출
4. group by : 그룹화
5. order by : 정렬
*/

/*
https://school.programmers.co.kr/learn/courses/30/lessons/298516
*/
select count(*) as 'FISH_COUNT' from fish_info
where YEAR(TIME) = 2021

/*
https://school.programmers.co.kr/learn/courses/30/lessons/299308
*/
select CONCAT(QUARTER(DIFFERENTIATION_DATE),"Q") as "QUARTER", count(*) as ECOLI_COUNT from ECOLI_DATA
group by CONCAT(QUARTER(DIFFERENTIATION_DATE),"Q")
order by CONCAT(QUARTER(DIFFERENTIATION_DATE),"Q");

/*
https://school.programmers.co.kr/learn/courses/30/lessons/164668
*/
-- 코드를 입력하세요
SELECT USER_ID, NICKNAME, sum(price) as TOTAL_SALES from used_goods_board b
join used_goods_user u
    on b.writer_id = u.user_id
where status = 'DONE'
group by writer_id
having sum(price) >= 700000
order by TOTAL_SALES

/*
https://school.programmers.co.kr/learn/courses/30/lessons/59040
*/
-- 코드를 입력하세요
SELECT ANIMAL_TYPE, count(*) as count from animal_ins
group by animal_type
order by ANIMAL_TYPE

/*
https://school.programmers.co.kr/learn/courses/30/lessons/59041
*/
-- 코드를 입력하세요
SELECT NAME, count(*) as COUNT from animal_ins
where NAME is not null
group by NAME
having COUNT >=2
order by NAME;
/* is not null : null이 아닌 것들을 필터링한다. */

/*
https://school.programmers.co.kr/learn/courses/30/lessons/131532
*/
-- 코드를 입력하세요
SELECT year(sales_date) as YEAR, month(sales_date) as MONTH, GENDER, count(distinct u.user_id) as USERS from user_info u
join online_sale s
    on u.USER_ID = s.USER_ID
where u.GENDER is not null
group by year(sales_date), month(sales_date), gender
order by year(sales_date), month(sales_date), gender
/* 실수: 
유저는 여러개의 상품을 구매할 수 있음. 따라서 distinct를 사용해야 함.
*/



/*
https://school.programmers.co.kr/learn/courses/30/lessons/276035
*/
SELECT DISTINCT D.ID, D.EMAIL, D.FIRST_NAME, D.LAST_NAME
FROM DEVELOPERS D
JOIN SKILLCODES S
  ON D.SKILL_CODE & S.CODE != 0
WHERE S.CATEGORY = 'Front End'
ORDER BY D.ID;

/* 오답 */
/* 비트 연산자를 사용해야하며, join을 사용해야함. 복습 필요 !!
*/


/*
https://school.programmers.co.kr/learn/courses/30/lessons/284528
*/
SELECT 
  DISTINCT(g.EMP_NO), e.EMP_NAME,
  CASE
    WHEN g.SCORE >= 96 THEN 'S'
    WHEN g.SCORE >= 90 THEN 'A'
    WHEN g.SCORE >= 80 THEN 'B'
    ELSE 'C'
  END AS "GRADE",
  CASE
    WHEN SCORE >= 96 THEN e.SAL * 0.2
    WHEN SCORE >= 90 THEN e.SAL * 0.15
    WHEN SCORE >= 80 THEN e.SAL * 0.1
    ELS  E 0
      END AS "BONUS"

FROM (select emp_no, avg(score) as "SCORE" from hr_grade
    group by emp_no
) g
join HR_EMPLOYEES e
    on g.EMP_NO = e.EMP_NO
order by EMP_NO;

/* 성과금 연봉 기준이라면 평균 grade로 추출? 음..
이게 합리적이라고 할 수 있는 건가?
성과금을 선정할 때, 반기별로 나온 GRADE를 평균으로 추출하는 것이 합리적인가? */

/* 난이도 좀 있네..*/
/*https://school.programmers.co.kr/learn/courses/30/lessons/151141*/
with rent as 
(select history.history_id, history.car_id, c.car_type, c.daily_fee,
datediff(history.end_date, history.start_date) + 1 as days,
case
    when datediff(history.end_date, history.start_date) + 1 >= 90 then '90일 이상'
    when datediff(history.end_date, history.start_date) + 1 >= 30 then '30일 이상'
    when datediff(history.end_date, history.start_date) + 1 >= 7 then '7일 이상'
else '7일 미만' end as duration_type
from car_rental_company_rental_history history
join car_rental_company_car c
    on history.car_id = c.car_id
where car_type='트럭')
select r.history_id,
    floor((1- (ifnull(p.discount_rate,0) / 100)) * r.daily_fee * r.days) as fee
from rent r
left join car_rental_company_discount_plan p
on r.car_type = p.car_type
and r.duration_type = p.duration_type
order by fee desc, r.history_id desc;

/* with 절을 사용해서 rent 테이블을 먼저 정의하고,
그 다음에 rent 테이블을 사용해서 fee를 계산하는 방식으로 작성
구체적으로, rent 테이블은 car_rental_company_rental_history와 car_rental_company_car 테이블을 조인하여
차량의 대여 정보를 가져오고, 대여 기간에 따라 duration_type을 분류 */

/* 젇수는 floor로 표시 */

--dwd
-- https://school.programmers.co.kr/learn/courses/30/lessons/144856
with temp1 as (SELECT * from book_sales
where sales_date >= "2022-01-01" and sales_date < "2022-02-01") 
,
temp2 as (
select temp1.book_id, temp1.sales, b.category, b.author_id, b.price from 
    temp1
    join book b
        on temp1.book_id = b.book_id
)

select a.author_id, author_name, temp2.category, sum(sales * price) as "TOTAL_SALES" from temp2
join author a
    on temp2.author_id = a.author_id
group by a.author_name, temp2.category
order by   a.author_id ASC, temp2.category DESC;

-- 좀 더 쉽게?
select author.author_id, author.author_name, book.category, sum(sales*price) as "TOTAL_SALES" from book_sales sales
join book 
    on sales.book_id = book.book_id
join author
    on author.author_id = book.author_id
where sales_date >= '2022-01-01' and sales_date < '2022-02-01'
group by author.author_id, author.author_name, book.category
order by author_id asc, category desc;

-- join을 두 번 사용해서 book_sales와 book, author 테이블을 연결
-- 왜 sum(sales) * price가 아닌 sum(sales * price)인지?
-- sales * price를 먼저 계산한 후에 합산하는 것이 더 정확한 결과를 제공
-- 반대로, sum(sales) * price는 sales의 합계를 구한 후에 price를 곱하는 방식으로,
-- 이 경우, price가 고정된 값이 아니라면 잘못된 결과를 초래할 수 있음


-- https://school.programmers.co.kr/learn/courses/30/lessons/62284
-- 코드를 입력하세요
select cart_id from
(SELECT cart_id, group_concat(name) as names from cart_products
group by cart_id
having names like '%Milk%' and names like '%Yogurt%') t1
-- group concat 처음 알았음.
-- 다르게 풀자면
SELECT
  cart_id
FROM cart_products
GROUP BY cart_id
having 
    sum(case
        when name = "Milk" then 1 else 0 end) > 0
    and
    sum(case
        when name = "Yogurt" then 1 else 0 end) > 0
order by cart_id

--https://school.programmers.co.kr/learn/courses/30/lessons/131532
-- 코드를 입력하세요
SELECT year(s.sales_date) as YEAR, month(s.sales_date) as MONTH, ui.GENDER, count(distinct s.user_id) as USERS
from online_sale s
join user_info ui
    on s.user_id = ui.user_id
where GENDER is not null
group by year(s.sales_date), month(s.sales_date), ui.gender
order by YEAR, MONTH, GENDER asc;

--https://school.programmers.co.kr/learn/courses/30/lessons/131530
with cte as (SELECT 
    product_id,
    product_code,
    price,
    CASE
        WHEN price >= 0     AND price < 10000 THEN '0'
        WHEN price >= 10000 AND price < 20000 THEN '10000'
        WHEN price >= 20000 AND price < 30000 THEN '20000'
        WHEN price >= 30000 AND price < 40000 THEN '30000'
        WHEN price >= 40000 AND price < 50000 THEN '40000'
        WHEN price >= 50000 AND price < 60000 THEN '50000'
        WHEN price >= 60000 AND price < 70000 THEN '60000'
        WHEN price >= 70000 AND price < 80000 THEN '70000'
        WHEN price >= 80000 AND price < 90000 THEN '80000'
        ELSE '초과'
    END AS PRICE_GROUP
FROM product)

select PRICE_GROUP, count(*) as PRODUCTS
from cte
group by PRICE_GROUP
order by PRICE_GROUP asc;

-- 더 쉽게 (floor -> 내림인데, round랑 비슷한 개념이다. 반올림은 round, 내림은 floor)
-- ceiling은 올림
select floor(price/10000)*10000 as PRICE_GROUP, count(*)
from product
group by PRICE_GROUP
order by PRICE_GROUP asc;

--window 함수 공부--
SELECT
 dept,
 name,
 salary
 RANK() OVER (PARTITION BY dept ORDER BY salary desc) AS dept_rank
FROM employees;