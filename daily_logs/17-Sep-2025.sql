/* Day 2 - Practice */

/*Distinct(Keyword) - Remove duplicate values in the query result*/
select Distinct brand from cars;
select count(Distinct brand) from cars;

/*Order By(Keyword) - sort the results in ascending or descending order*/
select brand,year from cars order by year asc;

/* AND and OR */
select * from cars where brand='tata' and model='xuv';

select * from cars where brand='suzuki' or brand='mahindra' order by year asc;

/* NOT - return the rows where the specific condition is false */
select * from cars where not brand='tata';

/* IS NULL - IS NOT NULL */
select * from cars where brand is not null;

/* Delete - Delete the specific row*/
-- Delete from table_name where condition;
Delete from cars where brand='tata';

select * from cars;

-- to delete all rows 
delete from cars;

-- to delete the entire table with structure and records
--drop table table_name;

drop table cars;

/* Select Top - Clause (Limit and offset are keywords(Reserved words))*/
Select * from cars
order by year asc
Limit 3 offset 2; -- offset skips first 2 rows, and gives 3rd row

/* Aggregate functions - Perform the calculation on a set of values and return a single value
Often used with Group by clause
*/
-- MAX() - returns the largest value in the selected column
-- select max(column_name) from table_name where condition;
select max(year) from cars;

-- MIN() - returns smallest value
select min(year) from cars;

-- Count() - return the numbers of rows that matches the specific condition
select count(distinct brand) as number_of_brand from cars where year>2014;

-- Sum() - returns the total sum of a numeric column
select sum(year) from cars;

-- Sum() with an expression using joins

create table productsTbl(
productID int primary key,
productName varchar(30),
price decimal(10,2)
);

create table orderDetails(
OrderDetailID int primary key,
orderId int,
productId int,
quantity int,
foreign key(productId) references productsTbl(productId)
);

Insert into productsTbl values (1,'laptop',25000.00);
Insert into productsTbl values (2,'mouse',250.00);
Insert into productsTbl values (3,'keyboard',1000.00);
Insert into productsTbl values (4,'monitor',12000);

Insert into orderDetails values(1,101,1,2);
Insert into orderDetails values(2,102,2,10);
Insert into orderDetails values(3,103,3,7);
Insert into orderDetails values(4,104,4,1);

select * from productsTbl;
select * from orderDetails;

-- getting the total sales happened
select sum(quantity*price) as Profit_From_Sales
from orderDetails
left join productsTbl
on orderDetails.productId= productsTbl.productId;

-- AVG() - return the average value of the numeric column (null are ignored)
select avg(price) from productsTbl;

-- Like - an opertor used in the WHERE Clause to search for a specified pattern in a column
-- select column1,column2 from tablename where column_name LIKE pattern;
select * from productsTbl where productName LIKE 'm%';

/* Wildcards - 2 two types 
- percent sign(%) and 
- underscore sign(_)
*/
/* '_' -> represents a single character(character or number but only one)*/
select * from productsTbl where productName LIKE 'm_u%';

/* '%' -> represents any number of character(one,zero or multiple), even zero character also*/
select * from productsTbl where productName LIKE '%e';

-- contains 'o' in middle
select * from productsTbl where productName LIKE '%o%'; -- (case sensitive)

--without wildcard
select * from productsTbl where productName LIKE 'laptop';

-- using AND and OR operators
select * from productsTbl where productName LIKE '%op%' or productName LIKE '%oe%';

-- IN Operator allows us to specify multiple values in a WHERE Clause
-- IN operator is a shorthand for multiple OR conditions
select * from productsTbl where productName IN ('laptop','mouse');

-- NOT IN -> return all the records that are not any of the values in the list
select * from productsTbl where productName NOT IN ('laptop','mouse');

-- IN with a subquery in the WHERE clause
select productName from productsTbl where productID IN(select productID from orderDetails);

-- SubQuery “Get me all orderIds from orderDetails where the productId matches the IDs of products named laptop or mouse.”
select orderId 
from orderDetails
where productId In(
select productId from productsTbl where productName IN('laptop','mouse')
);

-- BETWEEN Operator selects values within a range, values can be numbers,text, or dates.
-- This operator is "Inclusive" , begin and end value are included.
select * from orderDetails where quantity between 1 and 4;

-- NOT BETWEEN - not in that range
select * from orderDetails where quantity not between 1 and 4;

-- BETWEEN with IN
select * from productsTbl where price between 1000.00 and 12000.00 and productId IN('3','4');

-- BETWEEN with Text
select * from productsTbl where productName between 'laptop' and 'mouse' order by productName asc;

-- BETWEEN with Dates
alter table orderDetails add orderDate date;
update orderDetails set orderDate='2025-09-06' where orderid=101;
update orderDetails set orderDate='2024-10-07' where orderid=102;
update orderDetails set orderDate='2025-08-05' where orderid=103;
update orderDetails set orderDate='2025-07-04' where orderid=104;

select * from orderDetails where orderDate Between '2025-09-06' and '2025-09-07';

-- Alias are used to give the table,or a column in a table a temporary name
-- It only in the time of query 
-- Created using "AS" Keyword

select * from productsTbl, orderDetails;

/* JOINS - combines rows from two or more table, based on the related column between them 
   INNER JOIN (Select records that have matching values in both table)
   INNER JOIN and JOIN are same, INNER is the default join type for JOIN, 
   so when you write JOIN the parser actually writes INNER JOIN.
   
   Syntax : 
	Select table_name.col_name(s)
	from table1
	inner join table2
	on table1.common_col_name = table2.common_col_name;
*/
Select orderDetails.orderid,productsTbl.productid,productsTbl.productName
from orderDetails
inner join 
productsTbl
on orderDetails.productid=productsTbl.productid;

-- JOIN with Three Tables
/* Syntax

	select tab_name.col_name(s)
	from table1
	join table2 on table1.common_col_name=table2.common_col_name
	join table3 on table1.common_col_name=table3.common_col_name

	-- if table3 has relationship with table1 then use above join query or change into
	'table2.common_col_name=table3.common_col_name' Decide based on the relationship(look at foreign key)
*/

create table shippers(
shipperid serial primary key,
shippername varchar(30),
productid int,
foreign key (productid) references productsTbl(productid)
);

Insert into shippers values (201,'SSS Packers',1);
Insert into shippers values (202,'ABC Packers',2);
Insert into shippers values (203,'XYZ Packers',3);
Insert into shippers values (204,'ASDF Packers',4);

select * from shippers;

Select productsTbl.productName,orderdetails.orderid,shippers.shippername
from productsTbl
join orderdetails on productsTbl.productid=orderdetails.productid
join shippers on productsTbl.productid=shippers.productid
