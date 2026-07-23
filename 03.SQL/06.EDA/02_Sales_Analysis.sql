
-- 1. revenue by category
-------------------------
select ct.[ product_category_name_english] as Category  ,
round(sum(oi.price ),2) as Revenue 
from order_items oi 
join orders o 
on o.order_id = oi.order_id 
join products p 
on oi.product_id = p.product_id 
join category_translation ct 
on p.product_category_name = ct.product_category_name
where order_status = 'delivered'
group by ct.[ product_category_name_english]
order by Revenue desc; 
go
  

-- 2. revenue contribution by category
---------------------------------------
with category_revenue as 
(
select ct.[ product_category_name_english] as category_name, 
sum(oi.price) as revenue
from order_items oi 
join orders o 
on o.order_id = oi.order_id 
join products p 
on p.product_id = oi.product_id 
join category_translation ct
on ct.product_category_name = p.product_category_name 
where o.order_status = 'delivered'
group by ct.[ product_category_name_english]
)
select category_name, revenue ,
round(
revenue *100.0  / sum(revenue) over(),2
) as revenue_contribution_pct 
from category_revenue
order by revenue desc ; 
go

-- 3. monthly revenue trend
---------------------------
select * from order_items ; 
go 

select * from orders; 
go 

select year(o.order_purchase_timestamp ) as order_year, 
month(o.order_purchase_timestamp ) as order_month, round( sum(oi.price) ,2) as revenue 
from order_items oi
join orders o 
on oi.order_id = o.order_id
where o.order_status = 'delivered'
group by  year(o.order_purchase_timestamp) , month(o.order_purchase_timestamp )
order by year(o.order_purchase_timestamp) , month(o.order_purchase_timestamp );
go 


-- 4. top 10 selling categories
-------------------------------
go 

select * from order_items; 
go 

select * from products ; 
go 

select * from orders ; 
go 

select * from category_translation ; 
go 

select top(10) ct.[ product_category_name_english] , count(oi.product_id) as products_sold 
from orders o 
join order_items oi 
on o.order_id = oi.order_id 
join products p 
on oi.product_id = p.product_id
join category_translation ct
on p.product_category_name = ct.product_category_name
where o.order_status = 'delivered' 
group by ct.[ product_category_name_english]
 order by products_sold desc; 

go 


-- 5. revenue by state
----------------------
go 

select *  from order_items ; 
go 

select * from customers ; 
go 

select * from orders; 
go 

select c.customer_state , round(sum(oi.price),2) as revenue 
from customers c 
join orders o 
on o.customer_id = c.customer_id 
join order_items oi 
on o.order_id = oi.order_id 
where order_status = 'delivered'
group by c.customer_state 
order by revenue desc; 
go 


  
-- 6. revenue by city
---------------------
go 

select * from orders ; 
go 

select * from order_items ; 
go 

select  * from customers  ; 
go 

select c.customer_city , round(sum(oi.price),2) as revenue 
from customers c 
join orders o 
on c.customer_id = o.customer_id 
join order_items oi 
on o.order_id = oi.order_id
where order_status = 'delivered' 
group by c.customer_city 
order by revenue desc; 
go 

-- 7. average product price by category
---------------------------------------
go 

select * from order_items ; 
go 

select * from products ; 
go 

select * from orders ; 
go 

select * from category_translation ; 
go 

select ct.[ product_category_name_english] , round(avg(oi.price), 2)  as avg_price 
from category_translation ct 
join products p 
on p.product_category_name = ct.product_category_name
join order_items oi 
on p.product_id= oi.product_id
join orders o 
on o.order_id = oi.order_id
where o.order_status = 'delivered' 
group by ct.[ product_category_name_english] 
order by avg_price desc ; 
go 



