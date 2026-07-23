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

  
--2. Customers by City
----------------------
go 

select * from customers ; 
go 

select customer_city , count(distinct customer_unique_id) as total_customers
from customers 
group by customer_city 
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


--4. Top Customers by Number of Orders 
--------------------------------------  
go 

select  * from orders ; 
go 

select * from customers  ; 
go 

select top(10) customer_unique_id, count(o.order_id ) as num_of_orders 
from orders o 
join customers c 
on o.customer_id = c.customer_id 
where o.order_status = 'delivered' 
group by customer_unique_id 
order by num_of_orders desc; 
go


  
--4. New vs Returning Customers
-------------------------------
go 

select * from orders ;
go 

select * from customers ; 
go 

with total_orders as (
select customer_unique_id , count(order_id) as num_of_orders 
from orders o 
join customers c 
on o.customer_id = c.customer_id 
where o.order_status = 'delivered'
group by customer_unique_id 
) 
select count(customer_unique_id ) as total_customers , 
case  when num_of_orders  = 1 then 'New Customer' else 'Returning Customer' end  as customer_status
from total_orders
group by case  when num_of_orders  = 1 then 'New Customer' else 'Returning Customer' end  

; 
go 





--7. Average Orders per Customer
--------------------------------
