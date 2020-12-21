/************************
*join
*************************/


--카티젼 프로덕트(Cartesian Product) --> where절이 없는 경우
select first_name, department_name
from employees, departments;

--uniq join
select first_name, em.department_id, 
       department_name, de.department_id
from   employees em, departments de
where  em.department_id = de.department_id;

--left join
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from employees emp left outer join departments dep
on emp.department_id = dep.department_id ; 

--left join --> 오라클 표현
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id(+); 

--right join
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from employees emp right outer join departments dep
on emp.department_id = dep.department_id ;

--right join --> 오라클 표현
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from employees emp, departments dep
where emp.department_id(+) = dep.department_id; 


--right join --> left join 으로 생각해도 동일한 결과
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from departments dep left outer join employees emp
on dep.department_id = emp.department_id ;


--right join --> left join --> 오라클 표현
select  emp.department_id, 
        emp.first_name, 
        dep.department_name
from departments dep, employees emp
where dep.department_id = emp.department_id(+) ;

-- full outer join
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em full outer join departments de
on em.department_id = de.department_id;


select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id(+) = de.department_id(+) ;   -- 사용X


--테이블 명 alias 설정하면 계속 사용해야 한다.
--정상
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;

--오류
select  employees.department_id, --테이블명 alias사용
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;

--join 실행순서 체크
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;    --order by 부분 이상할 수 있으니 생각해 볼것


--join 잘못된 사용예
select *
from employees em, locations lo
where em.salary = lo.location_id ;





