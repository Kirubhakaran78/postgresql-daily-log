/* Day 1 - Practice */

select version();

/*Table Creation*/
create table cars(
brand VARCHAR(30),
model varchar(30),
year int
);

/*INSERT QUERIES*/
INSERT INTO cars(brand,model,year) Values ('tata','xuv',2023);
INSERT INTO cars Values ('mahindra','abc',2025);
Insert into cars values ('suzuki','xyz',2014);


/* Alter Queries*/
/*1.Add column*/
alter table cars add purchased date;
/*2.Drop column*/
alter table cars drop column purchased;
/*3.Rename column*/
alter table cars rename column brand_name to brand;
/*4.Change datatype*/
alter table cars alter column brand type varchar(40);
/*5.Change Tablename*/
alter table car rename to cars;

/*Update Queries*/
/* update table_name set column_name=value where column_name=value; */
Update cars set purchased='12-09-2025' where brand='tata';
Update cars set purchased='2025-08-13' where brand='suzuki';
Update cars set purchased='2025-07-14' where brand='mahindra';

/*Constraints*/
/*1.Not Null - Column cannot have a NULL value*/
create table employees(
id int not null,
name varchar(30)
);

/*2.UNIQUE - All values in the column are unique*/
alter table employees add email varchar(30) unique;

/*3.Primary key - combines both not null and unique.Its uniquely identify each record in the table */
create table products(
productId int primary key
);


/*4.Foreign Key - Establish a relationship between two tables linking a column from one table to the primary key in another table*/
create table orders(
orderId int primary key,
ProductId int,
foreign key (productId) references products(productId)
);

/*5.Check - ensures all values in the column statisfies the specific condition*/
create table person(
id int primary key,
age int check(age>=18)
)

/*6.Default - assign a default value to a column if value is not provided*/
alter table orders add status varchar(20) default 'active'

/*7.INDEX - Improves the speed of data retrieval but does not enforce data integrity*/
create index idx_name on cars(brand);

/*Stored Procedure*/
create table Customers(
CustomerID int generated always as identity primary key,
CustomerName varchar(50),
ContactName	 varchar(50),
Address varchar(80),
City varchar(50),
PostalCode varchar(50),
Country varchar(50)
);

insert into Customers(CustomerName,ContactName,Address,City,PostalCode,Country) 
values 
('Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
('Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
('Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
('Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
('Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');

/*Stored Procedure -> Insert into cars*/
CREATE OR REPLACE PROCEDURE InsertCars(car_brand varchar,car_model varchar,car_year int)
AS $$
BEGIN
 INSERT INTO cars (brand,model,year) values (car_brand,car_model,car_year);
 EXCEPTION WHEN others THEN 
 RAISE NOTICE 'Error during insert';
END;
$$ LANGUAGE plpgsql;

/*fetch all cars using procedures using cursor*/
CREATE OR REPLACE PROCEDURE GetCars(INOUT ref refcursor)
AS $$
BEGIN
	OPEN ref FOR SELECT * FROM cars;
END;
$$ LANGUAGE plpgsql;

/*second table creation to make sp more complex*/
create table newcars(
brand VARCHAR(30),
model varchar(30),
year int
);

Create or replace procedure InsertCarWithCheck(car_brand varchar,car_model varchar,car_year int)
as $$
declare car_exists boolean; -- define a local variable
begin
	/* check if exist in first table*/
	select exists(
	select 1 from cars
	where brand=car_brand and model=car_model and year=car_year
	)into car_exists; -- Stores the result(true or false)

	-- If exist then add into cars table
	if car_exists then
	insert into cars(brand,model,year) Values (car_brand,car_model,car_year);
	RAISE NOTICE 'Inserted into cars table (Duplicates are allowed)'; -- print a message on the console

	-- If not then add in newcars table
	else
	insert into newcars(brand,model,year) Values (car_brand,car_model,car_year);
	RAISE NOTICE 'Inserted into newcars table';
	end if;
end;
$$ language plpgsql;


/*Functions Usually used for retrieval*/
/*Creates a Function that selects all records from the 'Customers' table*/
CREATE OR REPLACE FUNCTION SelectAllCustomers()
RETURNS TABLE(CustomerID INT,
CustomerName varchar,
ContactName	 varchar,
Address varchar,
City varchar,
PostalCode varchar,
Country varchar)
AS $$
BEGIN 
RETURN QUERY SELECT * from Customers;
END;
$$ LANGUAGE plpgsql;



/*Select Query*/
select * from cars;
select * from newcars;
select * from orders;
select * from Customers;

select * from SelectCustomers();
select * from SelectAllCustomers();

call InsertCars('MG','cylester',2020);

BEGIN;
call GetCars('car_cursor');
FETCH ALL FROM car_cursor;
COMMIT;

call InsertCarWithCheck('tata','xuv',2023);

call InsertCarWithCheck('abc','abc',2025);
