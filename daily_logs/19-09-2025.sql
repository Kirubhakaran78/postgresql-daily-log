/* Day 4 - Task*/
create table marketing(
serial_no int primary key,
emp_id int,
emp_name varchar(40),
emp_Role varchar(40),
emp_salary varchar(40),
joining_date date
);

create table sale(
serial_no int,
emp_id int,
emp_name varchar(40),
emp_Role varchar(40),
emp_salary varchar(40),
joining_date date,
foreign key(serial_no) references marketing(serial_no)
);

create table implementation_dept(
emp_id int,
emp_name varchar(40),
emp_Role varchar(40),
emp_salary varchar(40),
joining_date date
);

insert into marketing values(1,201,'kirubhakaran','junior','25,000','2023-09-08');
insert into marketing values(2,202,'sam','senior','35,000','2022-07-10');
insert into marketing values(3,203,'kishore','intern','15,000','2022-04-11');
insert into marketing values(4,204,'nelson','junior','25,000','2024-09-07');
insert into marketing values(5,205,'sridivya','senior','35,000','2020-08-09');

truncate table marketing,sale;

select * from marketing;

insert into sale values(1,101,'ravi','junior','45,000','2023-09-08');
insert into sale values(2,102,'ram','senior','95,000','2022-07-10');
insert into sale values(3,103,'kumar','intern','15,000','2022-04-11');
insert into sale values(4,104,'melson','junior','55,000','2024-09-07');
insert into sale values(5,105,'bharani','senior','85,000','2020-08-09');

insert into implementation_dept values(301,'siva','junior','67000','2023-09-08');
insert into implementation_dept values(302,'surya','senior','93000','2022-07-10');
insert into implementation_dept values(303,'karthi','intern','11000','2022-04-11');
insert into implementation_dept values(304,'jyothika','junior','46000','2024-09-07');
insert into implementation_dept values(305,'simbu','senior','100000','2020-08-09');

/*
1.Top 3 highest salary in 3 table - we can't use orderby and limit because if 2 employees are with same salary rank 3 then only
will appear, So we are using union and window functions
*/
with all_employees as(
select emp_name,emp_salary, 'sale' as dept from sale
union all
select emp_name,emp_salary, 'marketing' as dept from marketing
union all
select emp_name,emp_salary, 'implementation' as dept from implementation_dept
),
ranked as(
select emp_name,emp_salary,dept, 
	rank() over(order by emp_salary desc) as salary_rank 
from all_employees
)
select *
from ranked
where salary_rank <=3;



select *
from SALE

SELECT *FROM MARKETING;


/* 2.Min salary for the three table */
alter table sale alter column emp_salary type int
using replace(emp_salary,',','')::int;

alter table marketing alter column emp_salary type int
using replace(emp_salary,',','')::int;

alter table implementation_dept alter column emp_salary type int
using replace(emp_salary,',','')::int;

-- Actual Query
-- to get overall min salary by department
select dept,min(emp_salary) as min_salary
from (
select emp_salary,'sale' as dept from sale
union all 
select emp_salary,'marketing' as dept from marketing
union all 
select emp_salary,'implementation_dept' as dept from implementation_dept
) as all_employees
group by dept;

-- to get overall min salary from the three table(single value)
select dept,emp_salary as min_salary
from(
select emp_salary,'sale' as dept from sale
union all
select emp_salary,'marketing' as dept from marketing
union all
select emp_salary,'implementation_dept' as dept from implementation_dept
) as all_employees
order by emp_salary asc
limit 1;

/*3.Get the total employee count from 3 table with duplicate handling */
-- Get result by department wise
select dept,count(distinct emp_id) as total_employees
from(
select emp_id,'sale' as dept from sale
union all
select emp_id,'marketing' as dept  from marketing
union all
select emp_id,'implementation_dept' as dept  from implementation_dept
) group by dept;

SELECT * from implementation_dept;

-- To Get overall result(Total_employees with unique)
select count(distinct emp_id) from
(
select emp_id from sale
union all
select emp_id from marketing
union all
select emp_id from implementation_dept
) as Total_employees;

/*4.Group by same role*/
select emp_Role,count(emp_role) as total_count_per_role
from(
select emp_id,emp_name,emp_Role,emp_salary,joining_date from sale
union all 
select emp_id,emp_name,emp_Role,emp_salary,joining_date from marketing
union all
select emp_id,emp_name,emp_Role,emp_salary,joining_date from implementation_dept
) group by emp_Role;

-- Using join for the sale, and marketing table (only get marketing table emp_role)
select m.emp_role,count(s.emp_role) as total_emps
from sale s
join marketing m on s.serial_no=m.serial_no
group by m.emp_role;


/*5. Getting Joining_date between the date range using conversion of the utc to asia/kolkata */
set timezone='utc';

show timezone;

select dept,emp_name,
		(joining_date::timestamp at time zone 'utc' at time zone 'Asia/Kolkata') as joining_date_ist
from (
select 'sale' as dept,emp_name,joining_date from sale
union all
select 'marketing' as dept,emp_name,joining_date from marketing
union all
select 'implementation_dept' as dept,emp_name,joining_date from implementation_dept
) as all_employees
where joining_date between '2020-08-09' and '2023-10-10';
