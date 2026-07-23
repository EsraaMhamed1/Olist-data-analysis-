--1. Customers by State
-----------------------
go 

select * from customers ; 
go 

select customer_state , count(distinct customer_unique_id) as total_customers
from customers 
group by customer_state 
order by total_customers desc; 
go 


--3. Top 10 Cities by Customers
-------------------------------
go 

select * from customers ; 
go 

select top(10) customer_city , count(distinct customer_unique_id) as total_customers
from customers 
group by customer_city 
order by total_customers desc; 
go 

--4. New vs Returning Customers
-------------------------------

--5. Customer Distribution by State
-----------------------------------

--6. Customers per Order
------------------------

--7. Average Orders per Customer
--------------------------------
