# Datasets used: AirlineDetails.csv, passengers.csv and senior_citizen.csv
-- -----------------------------------------------------
-- Schema Airlines
-- -----------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United King10dom, USA, India, Canada and Singapore should be accepted
-- -- Q4. Assign primary key to Flight_ID'?

create table if not exists airline_details
(
flight_id int not null,
Airline varchar(50) null unique,
country varchar(50) null check (country in ('United Kingdom', 'USA', 'India', 'Canada', 'Singapore')),
punctuality float null,
service_quality float null,
airhelp_score float null,
primary key(flight_id)
);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Only passengers having age greater than 18 are allowed.
-- -- Q3. Assign primary key to Traveller_ID

create table if not exists passenger
(
traveller_id varchar(10) not null,
name varchar(10) not null,
pnr varchar(10) not null,
age int check (age>18),
flight_id int not null,
ticket_price int not null,
primary key(Traveller_id)
);
 
-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique and should not be null.
-- -- Q4. Flight Id should not be null.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
alter table passengers modify pnr varchar(10) unique;
alter table passengers modify Flight_ID int not null;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Column Traveller_ID should not contain any null value.
-- -- Q2. Assign primary key to Traveller_ID
-- -- Q3. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- --  Also deletion of any row from passenger table should not be allowed.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

Create table if not exists senior_citizen_details
(
Traveller_id varchar(10) not null,
senior_citizen varchar(10) null,
discounted_price varchar(10) null,
primary key(Traveller_id),
constraint fk_passenger_senior_citizen
foreign key (Traveller_id) references passengers(traveller_id)
on update cascade on delete restrict
);

-- -----------------------------------------------------
-- Table Senior_Citizen_Details
-- -- Q6. Create a new column Age in Passengers table that takes values greater than 18. 
 alter table passengers add column age int check (age>18);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Qa. The cost should not be less than or equal to 0.
-- -- Qb. The cost column should not be null.
-- -- Qc. Assign a primary key to the column books_no.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists books
(
books_no int not null,
description varchar(50),
author_name varchar(10) not null,
cost int not null check(cost>0),
primary key(books_no)
);

# Q8. Update the table 'books' such that the values in the columns 'description' and author' must be unique.

alter table books add constraint new_desc1 unique (description, author);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
-- --------------------------------------------------------------------------
-- Use the following comands to insert the values in the table bike_sales
/*('1','Pulsar','1','2001','7');
('2','yamaha','3','2002','3');
('3','Splender','2','2004','5');
('4','KTM','2','2003','1');
('5','Hero','1','2005','9');
('6','Royal Enfield','2','2001','3');
('7','Bullet','1','2005','7');
('8','Revolt RV400','2','2010','7');
('9','Jawa 42','1','2011','5');*/
-- --------------------------------------------------------------------------

CREATE TABLE BIKE_SALES
(
ID INT AUTO_INCREMENT, 
PRODUCT VARCHAR(20) NOT NULL, 
QUANTITY INT NOT NULL, 
RELEASE_YEAR VARCHAR(4) NOT NULL, 
RELEASE_MONTH INT NOT NULL,
PRIMARY KEY (ID), 
CHECK (RELEASE_MONTH BETWEEN 1 AND 12), 
CHECK (RELEASE_YEAR BETWEEN 2000 AND 2010), 
CHECK (QUANTITY > 0 )
);
DESC BIKE_SALES;
SHOW CREATE TABLE BIKE_SALES;

INSERT INTO BIKE_SALES VALUES
('1','Pulsar','1','2001','7'),('2','yamaha','3','2002','3'),('3','Splender','2','2004','5'),('4','KTM','2','2003','1'),('5','Hero','1','2005','9'),
('6','Royal Enfield','2','2001','3'),('7','Bullet','1','2005','7'),('8','Revolt RV400','2','2010','7'),
#ERROR - Check constraint 'bike_sales_chk_2' is violated
('9','Jawa 42','1','2011','5');

SELECT * FROM BIKE_SALES;

