-- SQL queries for UPI growth and payments analysis

-- Topic Database and data exploration

-- Q. How many records in database
select count(month) as total_record
from india;

-- Q. What is the date range 
select min(month) as first_date, max(month) as last_date
from india;

-- Topic Data Cleaning

-- Q. Identify duplicates records
select month,count(*)
from india
group by month
having count(*)>1;

-- Q. Removing duplicates records
delete from india
where month not in(
  select month
  from(
  select min(month) as month
  from india
  group by month
  ) as temp
);

-- Q  Check null values in records
select month
from india
where month is null;

-- Q. Handle null values
update india
set month = 'N/A'
where month is null;

-- Topic Summary Statistics

-- Q. What is the total value 
select sum(value) as total_value
from india;

-- Q what is the total number of banks in upi
select count(banks) as total_no_banks_in_upi
from india;

-- Q What is the Average values
select avg(value) as avg_value
from india;

-- Q What is the total value and bank count
select sum(value) as total_value,count(*) as bank_count
from india;


-- Topic: Time Trend Analysis

-- Q. find monthly growth 
select 
  month,
  value,
  value-lag(value) over(partition by month order by value) as monthly_growth
from india;

-- Q Find highest volume month
select month,max(volume)
from india
group by month
limit 1;


-- Topic Window Function

-- Q. Rank bank by value
select
  value,
  banks,
  rank() over(order by value) bnk_rnk
from india;

-- Q Find monthly volume
select
  month,
  volume,
  lag(volume) over(order by month) as monthly_volume
from india;

-- Q.Find value of each bank
select
  banks,
  volume,
  sum(value) over(partition by banks order by value) as value_each_bnk
from india;
  
