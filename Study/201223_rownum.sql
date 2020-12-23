/*****************************************
* rownum
******************************************/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.

--rownum 이 order by 보다 먼저 생겨서 번호가 섞인다
select  rownum,
        employee_id,
        first_name,
        salary
from employees
order by salary desc; 

-- 정렬하고 rownum 을 사용
select  rownum,
        o.employee_id,
        o.first_name,
        o.salary
from (select  emp.employee_id,
              emp.first_name,
              emp.salary
      from employees emp
      order by salary desc) o;  -- salary 로 정렬되어 있는 테이블 사용

-- 일련번호주고 바로 조건을 판단해서 
select ro.rnum,
       ro.employee_id,
       ro.first_name,
       ro.salary
from (select  rownum rnum,
              o.employee_id,
              o.first_name,
              o.salary
      from (select  emp.employee_id,
                    emp.first_name,
                    emp.salary
            from employees emp
            order by salary desc) o
      ) ro
where rnum >=1     
and rnum <=5;


--예제)
--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 

select  ro.rn,
        ro.employee_id,
        ro.first_name,
        ro.salary,
        ro.hire_date
from (select rownum rn,
             o.employee_id,
             o.first_name,
             o.salary,
             o.hire_date
      from (select  employee_id,
                    first_name,
                    salary,
                    hire_date
            from employees
            where hire_date >= '07/01/01'
            and hire_date <= '07/12/31'
            order by salary desc)o
      ) ro     
where ro.rn >=1
and ro.rn <=7;


