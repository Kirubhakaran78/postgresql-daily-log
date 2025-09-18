/* Day-3 Practice */

/* TimeZone 
Default - operating system's timezone
*/

-- to set timezone
Set timezone='Asia/Kolkata';
select now();

-- to show timezone
show timezone;

-- format current date
select to_char(now() at time zone 'utc','yyyy-mm-dd');
select to_char(now() at time zone 'utc','yyyy-mm-dd');

-- formate current date and time with millisecond
select to_char(now() at time zone 'Asia/Kolkata','Dy, mon yyyy HH12:MI:SS.MS');

-- change timezone utc to ist
-- syntax : select timezone('target_timezone',now() at time zone 'timestamp_without_timezone') AS alias;
SELECT timezone('Asia/Kolkata', now() AT TIME ZONE 'UTC') AS "ist_time";

-- Interval
select current_date + interval '7 days';

select current_timestamp - interval '2 hours';

select current_timestamp + interval '1 month 15 days';

select current_time - interval '30mins';

-- how many days left
select('2025-12-18' - current_date);

select current_timestamp + interval '15 days';

select timestamp '2025-09-18 14:30:00' - interval '2 weeks';

/* Index */
/* Used to retrieve data faster from the column where we created index */
create index idx_name on productsTbl(productName);

/* Default Index - primary key column */
/* Types of Index: 
1.Clustered Index – Only one allowed per table. It stores the actual table data in sorted order of the key column. By default, the primary key creates a clustered index unless specified otherwise.
2. NonClustered Index – Stored separately from the table data. 
	Contains the indexed column(s) plus a pointer to the data. Multiple non-clustered indexes can exist on a table.
3. Filtered Index – A special type of nonclustered index that applies only to rows that satisfy a condition
	(WHERE clause).
4. Unique Index – Ensures that no two rows have duplicate values in the indexed column(s). 
	This can be either clustered or nonclustered.
5. Composite Index - Adding multiple columns in the nonclustered index 
(if selecting both columns with where condition using and operator then the order of should also be same 
ex: 
	create index idx_cus on customerTbl(cus_id,cus_name); 
	select * from customers where cus_id=101 and cus_name='ravi';
)
Important - 1. All PostgreSQL indexes are separate structures (like non-clustered).
			2. You can manually CLUSTER a table on an index, but that just rearranges the table data once, 
			it’s not maintained automatically like SQL Server clustered index.
*/

create table emp(
empId int primary key,
empName varchar(30)
);

insert into emp values(32,'dravid'),(2,'ram'),(1,'mohan');

select * from emp;

create index idx_empName on emp(empName);

SELECT * FROM emp WHERE empName = 'ram'; 

-- Physically reorder the table by empName
cluster emp using idx_empName; -- after only it will reorder the column

insert into emp values(4,'aswin');

/* JOINS - Self, left, right, full outer */

select * from productsTbl,orderdetails;

select productsTbl.productid, productsTbl.productname, orderdetails.quantity
from productsTbl
left join orderdetails
on productsTbl.productid=orderdetails.productid;

select productsTbl.productid, productsTbl.productname, orderdetails.quantity
from orderdetails
right join productsTbl
on productsTbl.productid=orderdetails.productid;

select productsTbl.productid, productsTbl.productname, orderdetails.quantity
from productsTbl
full outer join orderdetails
on productsTbl.productid=orderdetails.productid;

/* Group by Having */
/* Group by ofter used with the aggregate functions */
/* 
SELECT aggregate_function(column), other_columns
FROM table_name
WHERE row_condition
GROUP BY grouping_column
HAVING aggregate_condition;
*/

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

INSERT INTO students VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(20),
    score INT
);

INSERT INTO marks VALUES
(1, 1, 'Math', 80),
(2, 1, 'Science', 90),
(3, 2, 'Math', 60),
(4, 2, 'Science', 65),
(5, 3, 'Math', 95),
(6, 3, 'Science', 92);

-- show average score of each student
select subject,avg(score) as avg_score
from marks
group by subject;

	
select subject,avg(score) as avg_score
from marks
group by subject
having avg(score)>80;

-- create table As (Postgresql version of Select into) - create new table and copy
/*
create table new_tablename as
select column_name(s)
from existing_tablename
where condition
*/
create table top_students as
select student_id,subject,score
from marks
where score>80;

select * from top_students;

-- Insert into....select - copy to existing table from another table
/*
insert into existing_tablename_going_to-add
select column_name(s)
from tablename_from_where_we_arecopying
where condition;
*/

insert into top_students
select student_id,subject,score
from marks
where subject='Math';
