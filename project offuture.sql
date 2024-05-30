-- TABLE CREATION, GRANTING PERMISSIONS AND DROPPING INCORRECT COLUMN



/*drop table if exists student.offuture;
create table student.offuture
(row_id int,
order_id varchar(50),
order_date varchar(20),
ship_date varchar(20),
ship_mode varchar(50),
cusomer_id varchar(50),
customer_name varchar(50),
segment varchar(50),
city varchar(50),
state varchar(50),
country varchar(50),
postal_code varchar(20),
market varchar(50),
region varchar(50),
product_id varchar(60),
category varchar(50),
sub_category varchar(50),
product_name varchar(500),
sales numeric,
quantity int,
discount numeric,
profit numeric,
shipping_cost numeric,
order_priority varchar(50)
);


select * from student.offuture;


grant all on student.offuture to da10_jaan, da10_akam, da10_egdu;


-- typo in create table so dropped column
alter table student.offuture drop column cusomer_id;*/


-- [SQL01] COUNT OF ROWS

SELECT
	count(row_id)
FROM
	student.offuture;
-- counts number of rows using row_id
-- [SQL02] COUNT OF DISTINCT ROWS 

SELECT
	count(DISTINCT(row_id))
FROM
	student.offuture;
-- counts number of distinct rows using row_id


-- [SQL03] COUNT OF COLUMNS 

SELECT 
	COUNT(*)
FROM 
	information_schema.columns
WHERE 
	table_schema = 'student'
	AND 
	table_name = 'offuture';
-- counts all the column names listed in the information schema


-- [SQL04] SUM OF COLUMN SUMS 

SELECT 
	  SUM(row_id)
	+ SUM(sales)
	+ SUM(quantity) 
	+ SUM(discount) 
	+ SUM(profit)
	+ SUM(shipping_cost)
FROM 
	student.offuture;
-- sums each numeric column then all sums the totals


-- [SQL05] SUM OF ROW SUMS

SELECT 
	SUM
	( row_id 
	+ sales 
	+ quantity 
	+ discount 
	+ profit 
	+ shipping_cost)
FROM 
	student.offuture;
-- sums the numeric values from each row then sums all the totals


-- [SQL06] SUM, MIN, MAX
-- some values were rounded to match Excel format

SELECT
	SUM(row_id) 
,
	ROUND(SUM(sales),3)
,
	SUM(quantity)  
,
	ROUND(SUM(discount),3)
,
	ROUND(SUM(profit),3)
,
	ROUND(SUM(shipping_cost),3)
FROM
	student.offuture;
-- finds the sum of each numeric column

SELECT
	MAX(row_id) 
,
	ROUND(MAX(sales),3)
,
	MAX(quantity)  
,
	ROUND(MAX(discount),3)
,
	ROUND(MAX(profit),3)
,
	MAX(shipping_cost)
FROM
	student.offuture;
-- finds maximum values for all numeric columns

SELECT
	MIN(row_id) 
,
	ROUND(MIN(sales),3)
,
	MIN(quantity)  
,
	ROUND(MIN(discount),3)
,
	ROUND(MIN(profit),3)
,
	MIN(shipping_cost)
FROM
	student.offuture;
-- finds minimum values for all numeric columns

-- min max for dates
SELECT 
	min(to_date(o.order_date, 'dd/mm/yyyy') ),
	max(to_date(o.order_date, 'dd/mm/yyyy') )
FROM
	student.offuture o ;
-- converts order_date to date format and finds the minimum and maximum values
SELECT 
	min(to_date(o.ship_date , 'dd/mm/yyyy') ),
	max(to_date(o.ship_date , 'dd/mm/yyyy') )
FROM
	student.offuture o ;
-- converts ship_date to date format and finds the minimum and maximum values


-- [SQL07] COUNT OF DISTINCT ENTRIES PER COLUMN 

SELECT 
	COUNT(DISTINCT(row_id)), 
	COUNT(DISTINCT(order_id)),  
	COUNT(DISTINCT(order_date)),  
	COUNT(DISTINCT(ship_date)),  
	COUNT(DISTINCT(ship_mode)),  
	COUNT(DISTINCT(customer_id)),  
	COUNT(DISTINCT(customer_name)),  
	COUNT(DISTINCT(segment)),  
	COUNT(DISTINCT(city)),  
	COUNT(DISTINCT(state)), 
	COUNT(DISTINCT(country)),  
	COUNT(DISTINCT(postal_code)),  
	COUNT(DISTINCT(market)),  
	COUNT(DISTINCT(region)),  
	COUNT(DISTINCT(product_id)),  
	COUNT(DISTINCT(category)),  
	COUNT(DISTINCT(sub_category)),  
	COUNT(DISTINCT(product_name)),  
	COUNT(DISTINCT(sales)) ,  
	COUNT(DISTINCT(quantity)),  
	COUNT(DISTINCT(discount)) ,  
	COUNT(DISTINCT(profit)),  
	COUNT(DISTINCT(shipping_cost)),  
	COUNT(DISTINCT(order_priority))
FROM 
	STUDENT.OFFUTURE ;

-- [SQL08] COUNT OF NULLS

SELECT
	COUNT(ROW_ID) - COUNT(ROW_ID),
	COUNT(ROW_ID) - COUNT(order_id),
	COUNT(ROW_ID) - COUNT(order_date),
	COUNT(ROW_ID) - COUNT(ship_date),
	COUNT(ROW_ID) - COUNT(ship_mode),
	COUNT(ROW_ID) - COUNT(customer_id),
	COUNT(ROW_ID) - COUNT(customer_name),
	COUNT(ROW_ID) - COUNT(segment),
	COUNT(ROW_ID) - COUNT(city),
	COUNT(ROW_ID) - COUNT(state),
	COUNT(ROW_ID) - COUNT(country),
	COUNT(ROW_ID) - COUNT(postal_code),
	COUNT(ROW_ID) - COUNT(market),
	COUNT(ROW_ID) - COUNT(region),
	COUNT(ROW_ID) - COUNT(product_id),
	COUNT(ROW_ID) - COUNT(category),
	COUNT(ROW_ID) - COUNT(sub_category),
	COUNT(ROW_ID) - COUNT(product_name),
	COUNT(ROW_ID) - COUNT(sales) ,
	COUNT(ROW_ID) - COUNT(quantity),
	COUNT(ROW_ID) - COUNT(discount) ,
	COUNT(ROW_ID) - COUNT(profit),
	COUNT(ROW_ID) - COUNT(shipping_cost),
	COUNT(ROW_ID) - COUNT(order_priority)
FROM
	STUDENT.OFFUTURE
-- count of total rows minus the count of entries for each column gives number of null values
	
	
-- [SQL09] CHECK FOR FORMAT CONSISTENCY IN ORDER_ID, CUSTOMER_ID, PRODUCT_ID

-- order_id
SELECT
	count(order_id)
FROM
	student.offuture
WHERE
	substring(order_id
FROM
	3 FOR 1) = '-' ;
-- checks how many entries have a - as the 3rd charachter in order_id


SELECT
	count(order_id)
FROM
	student.offuture
WHERE
	substring(order_id
FROM
	8 FOR 1) = '-' ;
-- checks how many entries have a - as the 8th charachter in order_id

WITH number_dashes (n_d)
AS 
	(SELECT 
		length(order_id) - length(REPLACE(order_id,'-','')) -- count OF number OF dashes IN order id
	 FROM
		student.offuture o ) 

SELECT 
	DISTINCT(n_d) ---shows ALL the distinct number OF dashes
FROM 
	number_dashes ;   -----This shows 2---> which means every id has only 2 dashes
   

-- product_id

	SELECT
	count(product_id)
FROM
	student.offuture
WHERE
	substring(product_id
FROM
	4 FOR 1) = '-' ;
-- checks how many entries have a - as the 4th character in product_id

SELECT
	count(product_id)
FROM
	student.offuture
WHERE
	substring(product_id
FROM
	8 FOR 1) = '-'
	OR substring(product_id
FROM
	7 FOR 1) = '-';
-- checks how many entries have a - as the 7th or 8th character in product_id


WITH number_dashes (n_d)
AS 
	(
SELECT 
		length(product_id) - length(REPLACE(product_id,
	'-',
	''))
-- count OF number OF dashes IN product id
FROM
		student.offuture o ) 
		
SELECT 
	DISTINCT(n_d)
---shows ALL the different number OF dashes
FROM 
	number_dashes ;
-----This shows 2---> which means every row has only 2 dashes


-- customer_id

SELECT
	count(customer_id)
FROM
	student.offuture
WHERE
	substring(customer_id
FROM
	3 FOR 1) = '-' ;
-- checks how many entries have a - as the 3rd charachter in order_id
WITH number_dashes (n_d)
AS 
	(SELECT 
		length(customer_id) - length(REPLACE(customer_id,'-','')) -- count OF number OF dashes IN EACH order id
	 FROM
		student.offuture o ) 

SELECT 
	DISTINCT(n_d) ---shows ALL the distinct number OF dashes
FROM 
	number_dashes ;   -----This shows 1---> which means every id has only 1 dashes

-- [SQL10] EYEBALL CHECK 

SELECT
	*
FROM
	student.offuture o
WHERE
	row_id = 23988;
-- selects just row 23988

SELECT
	*
FROM
	student.offuture o
WHERE
	row_id = 11407;
-- selects just row 11407

SELECT
	*
FROM
	student.offuture o
WHERE
	row_id = 4278;
-- selects just row 4278

SELECT
	*
FROM
	student.offuture o
WHERE
	row_id = 15850;
-- selects just row 15850

SELECT
	*
FROM
	student.offuture o
WHERE
	row_id = 46370;
-- selects just row 46370




-- [SQL11] COUNT OF ROWS WHERE ORDER DATE IS BEFORE OR EQUAL TO SHIP DATE 

SELECT
	count(row_id)
FROM
	student.offuture o
WHERE
	(to_date(o.ship_date,
	'dd/mm/yyyy') - to_date(o.order_date,
	'dd/mm/yyyy')) >= 0;
-- converts ship_date and order_date to date format and order_date from ship_date. Counts all rows where order_date is before or the same as ship_date



--[SQL12] DECIMAL PRECISION CHECKS
----max number of digits after decimal point---
/*
 (1) CASTing column_name as varchars since thats the format required for the functions to work
 (2) Using the POSITION() function to find where the decimal is then adding 1 so that the SUBSTRING() function gives all the digits after the decimal
 (3) taking the LENGTH() of that substring
 (4) find the MAX() length of the substring to find the maximum postion
 (5)if the POSITION() function returns 0 then its an integer so don't include that  in the calculation
 */

--id
SELECT 
	max(length(substring(CAST(o.row_id AS varchar) FROM POSITION ('.' IN CAST(o.row_id AS varchar)) + 1)))  --- (1-4) OF COMMENTS above
FROM 
	student.offuture o 
WHERE 
	POSITION ('.' IN CAST(o.row_id AS varchar)) != 0 ;  --- (5) OF COMMENTS above

--sales
SELECT 
	max(length(substring(CAST(o.sales AS varchar) FROM POSITION ('.' IN CAST(o.sales AS varchar)) + 1)))  --- (1-4) OF COMMENTS above
FROM 
	student.offuture o 
WHERE 
	POSITION ('.' IN CAST(o.sales AS varchar)) != 0 ;  --- (5) OF COMMENTS above

	--quantity
SELECT 
	max(length(substring(CAST(o.quantity AS varchar) FROM POSITION ('.' IN CAST(o.quantity AS varchar)) + 1)))  --- (1-4) OF COMMENTS above
FROM 
	student.offuture o 
WHERE 
	POSITION ('.' IN CAST(o.quantity AS varchar)) != 0 ;   --- (5) OF COMMENTS above

--discount
SELECT 
	max(length(substring(CAST(o.discount AS varchar) FROM POSITION ('.' IN CAST(o.discount AS varchar)) + 1)))  --- (1-4) OF COMMENTS above
FROM 
	student.offuture o 
WHERE 
	POSITION ('.' IN CAST(o.discount AS varchar)) != 0 ;   --- (5) OF COMMENTS above

--profit
SELECT 
	max(length(substring(CAST(o.profit AS varchar) FROM POSITION ('.' IN CAST(o.profit AS varchar)) + 1)))  --- (1-4) OF COMMENTS above
FROM 
	student.offuture o 
WHERE 
	POSITION ('.' IN CAST(o.profit AS varchar)) != 0 ;  --- (5) OF COMMENTS above

--shipping cost
 SELECT 
	max(length(substring(CAST(o.shipping_cost AS varchar) FROM POSITION ('.' IN CAST(o.shipping_cost AS varchar)) + 1)))  --- (1-4) OF COMMENTS above
FROM 
	student.offuture o 
WHERE 
	POSITION ('.' IN CAST(o.shipping_cost AS varchar)) != 0 ;  --- (5) OF COMMENTS above
