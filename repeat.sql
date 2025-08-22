-- 복습 --
-- 또 틀림; --
select DISTINCT d.ID, d.EMAIL, d.FIRST_NAME, d.LAST_NAME from developers d
-- distinct를 하지 않으면 중복행이 나옴. 한 명의 개발자를 뽑는 것이기 때문에 distinct 중요.--
join skillcodes s
    on (d.skill_code & s.code) > 0 -- 비트 연산자는 &고 논리연산자는 and임 --
where category = "Front end"
order by ID asc;