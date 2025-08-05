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



