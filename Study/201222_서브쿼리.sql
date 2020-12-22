/************************************
조인 리뷰 정리
*************************************/
from절 where절 표현방법, (+)<--오라클
left/right/full outer join ~ on  / inner join ~on


inner join --> null 은 제외
 inner join ~ on

select first_name, em.department_id, 
       department_name, de.department_id
from   employees em, departments de
where  em.department_id = de.department_id;

select  first_name, 
        em.department_id, 
        department_name, 
        de.department_id
from employees em inner join departments de
on em.department_id = de.department_id;



outer join --> 기준이 되는 쪽은 포함 비교되는쪽은 null 표시
 left outer join ~ on
 right outer join ~ on --> left outer join ~ on 
 full outer join ~ on
 


/***************************************
*Sub Query 서브 쿼리
****************************************/
--11000 보다 급여를 많은 사람의 이름과 급여는?
select  employee_id,
        first_name,
        salary
from employees
where salary > 11000;


--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
--1.‘Den’의 급여?
select  employee_id,
        first_name,
        salary
from employees
where first_name = 'Den';  --> 11000

--2.‘Den’ 보다 급여 높은사람
select  employee_id,
        first_name,
        salary
from employees
where salary > 11000;

--1개의 질문으로 해결
select  employee_id,
        first_name,
        salary
from employees
where salary > (select salary
                from employees
                where first_name = 'Den');


--예제)
--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1. 가장 적은 급여 액수 --> 2100
--2. 2100을 받는 직원의 이름, 급여, 사원번호는?
--3. 질문 조합

--1. 가장 적은 급여 액수 --> 2100
select min(salary)
from employees;

--2. 2100을 받는 직원의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from employees
where salary = 2100;

--3. 질문 조합
select  first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);

--예제)
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균급여   3000
--2. 3000보다 작은 사람 리스트
--3. 조합

--1. 평균급여   6461.83
select avg(salary)
from employees;

--2. 6461.83보다 작은 사람 리스트
select  first_name,
        salary
from employees
where salary < 6461.83;

--3. 조합
select  first_name,
        salary
from employees
where salary = (select avg(salary)
                from employees);


--예제
--부서번호가 110인 직원의 급여와 같은 모든 직원의 
--사번, 이름, 급여를 출력하세요

--1. 부서번호 110인 직원의 이름,급여... 리스트
select  first_name,
        salary,
        department_id
from employees
where department_id = 110;


--2. 전체직원 중 급여가 12008, 8300 인 직원
select  employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300;

--3. 조합
select  employee_id,
        first_name,
        salary
from employees
where salary in (select  salary
                 from employees
                 where department_id = 110);

--예제
--각 부서별로 최고급여를 받는 사원을 출력하세요

--1. 부서별 최고 급여 얼마인지?  누구는 못구함
select  --employee_id   --누구는 못구함
        department_id, 
        max(salary)
from employees
group by department_id;

--2. 전체사원테이블에서 부서번호와 급여 같은 사람을 찾는다
--   부서별 최고 급여 리스트 기준으로

select  first_name,
        employee_id,
        salary,
        department_id
from employees
where (department_id, salary) in (select  department_id, 
                                          max(salary)
                                  from employees
                                  group by department_id);


--예제
--부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
--사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰

--부서번호 100 인 직원의 급여 리스트
select *
from employees
where department_id = 110;  --12008, 8300


select  employee_id,
        first_name,
        salary
from employees
where salary >any (select salary  
                   from employees
                   where department_id = 110);  -- 12008, 8300


select  employee_id,
        first_name,
        salary
from employees
where salary >all (select salary  
                   from employees
                   where department_id = 110);  -- 12008, 8300

--Sub Quesry 로 테이블 만들기 --> join으로 사용
--각 부서별로 최고급여를 받는 사원을 출력하세요 
--1. 각 부서별로 최고 급여 테이블
select  department_id,
        max(salary)
from employees
group by department_id;

--2. 직원테이블  1번의 테이블을 join 한다.
select  e.employee_id,
        e.first_name,
        e.salary eSalary,
        e.department_id ed_id,
        s.department_id sd_id,
        s.salary sSalary
from employees e, (select  department_id,
                           max(salary) salary
                   from employees
                   group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;



select
        em.employee_id,
        em.first_name,
        em.salary
from employees em, (select 
                salary salary
                from employees
                where job_id = 'ST_MAN'
                ) ss
where em.salary <all (ss.salary)
;
