
                    /*==============================================
                              Sales Anaysis 
                    ================================================*/
go 

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

-- 4. top 10 selling categories
-------------------------------

-- 5. top 10 selling products
-----------------------------

-- 6. revenue by state
----------------------

-- 7. revenue by city
---------------------

-- 8. average product price by category
---------------------------------------

-- 9. highest priced products
-----------------------------

-- 10. lowest priced products
-----------------------------
