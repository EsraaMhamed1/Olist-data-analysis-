-- KPIS
--------
go

-- Total orders 
SELECT Count(*) AS total_orders
FROM   orders;

go

--  successful orders  received 
SELECT Count(*) AS successful_orders
FROM   orders
WHERE  order_status = 'delivered';

go

-- successful order rate
SELECT Count(*)                             AS total_orders,
       Sum(CASE
             WHEN order_status = 'delivered' THEN 1
             ELSE 0
           END)                             AS successful_orders,
       Round(Sum(CASE
                   WHEN order_status = 'delivered' THEN 1
                   ELSE 0
                 END) * 100.0 / Count(*), 2)AS successful_rate
FROM   orders;

go 

-- Total Revenue
SELECT Sum(price) AS total_revenue
FROM   order_items oi
       JOIN orders o
         ON o.order_id = oi.order_id
WHERE  o.order_status = 'delivered';

go

       ----------------------------------------
SELECT *
FROM   products;

go

SELECT *
FROM   order_items;

go

SELECT Count(*)
FROM   category_translation
      -------------------------------------------
go

-- product categories generate the highest revenue
SELECT ct.[product_category_name_english] AS Category,
       Round(Sum(oi.price), 2)             AS Revenue
FROM   order_items oi
       JOIN orders o
         ON o.order_id = oi.order_id
       JOIN products p
         ON oi.product_id = p.product_id
       JOIN category_translation ct
         ON p.product_category_name = ct.product_category_name
WHERE  order_status = 'delivered'
GROUP  BY ct.[product_category_name_english]
ORDER  BY revenue DESC;

go 





