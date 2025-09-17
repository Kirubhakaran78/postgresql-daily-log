/*Table Creation*/
create table cars(
brand VARCHAR(30),
model varchar(30),
year int
);

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

/*Select Query*/
select * from cars;
select * from newcars;

/*Insert Query*/
INSERT INTO cars(brand,model,year) Values ('tata','xuv',2023);
INSERT INTO cars Values ('mahindra','abc',2025);
Insert into cars values ('suzuki','xyz',2014);

call InsertCarWithCheck('tata','xuv',2023);
