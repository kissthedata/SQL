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