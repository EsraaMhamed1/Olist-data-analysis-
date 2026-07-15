
-------------------------
--1. Customer 
-------------------------
-- show cols.
SELECT *
FROM   customers;

go

--number of rows 
SELECT Count(*) AS total_rows
FROM   customers;

go

-- check null values 
SELECT *
FROM   customers
WHERE  customer_id IS NULL;

go

SELECT Count(customer_unique_id) AS count_u_id
FROM   customers;

go

SELECT*
FROM   customers
WHERE  customer_unique_id IS NULL;

go

SELECT Sum(CASE
             WHEN customer_id IS NULL THEN 1
             ELSE 0
           END) AS customer_id_nulls,
       Sum(CASE
             WHEN customer_unique_id IS NULL THEN 1
             ELSE 0
           END) AS customer_unique_id_nulls,
       Sum(CASE
             WHEN customer_city IS NULL THEN 1
             ELSE 0
           END) AS customer_city_nulls,
       Sum(CASE
             WHEN customer_state IS NULL THEN 1
             ELSE 0
           END) AS customer_state_nulls
FROM   customers;

go

-- destinct city 
SELECT DISTINCT customer_city
FROM   customers
ORDER  BY customer_city ASC;

go

-- destinct city
SELECT DISTINCT customer_state
FROM   customers
ORDER  BY customer_state ASC;

go

-- uniqueness
SELECT Count(DISTINCT customer_id) AS cust_rows
FROM   customers;

go

SELECT Count(*)                           AS total_rows,
       Count(DISTINCT customer_id)        AS distinct_customer_id,
       Count(DISTINCT customer_unique_id) AS distinct_customer_unique_id
FROM   customers;
go

-------------------------------------------------------------------------
-------------------------------------------------------------------------
------------------------
--2. Orders 
------------------------
go

-- show data 
SELECT *
FROM   orders;

go

-- numbers of rows 
SELECT Count(*) AS total_rows
FROM   orders;

go

-- uniqueness
SELECT Count(DISTINCT order_id) AS unique_id
FROM   orders;

go

SELECT Sum(CASE
             WHEN order_id IS NULL THEN 1
             ELSE 0
           END) AS order_id_nulls,
       Sum(CASE
             WHEN customer_id IS NULL THEN 1
             ELSE 0
           END) AS customer_id_nulls,
       Sum(CASE
             WHEN order_status IS NULL THEN 1
             ELSE 0
           END) AS order_status_nulls,
       Sum(CASE
             WHEN order_purchase_timestamp IS NULL THEN 1
             ELSE 0
           END) AS purchase_timestamp_nulls,
       Sum(CASE
             WHEN order_approved_at IS NULL THEN 1
             ELSE 0
           END) asorder_approved_at_nulls,
       Sum(CASE
             WHEN order_estimated_delivery_date IS NULL THEN 1
             ELSE 0
           END) AS estimated_delivery_date_nulls,
       Sum(CASE
             WHEN order_delivered_carrier_date IS NULL THEN 1
             ELSE 0
           END) AS delivered_carrier_nulls,
       Sum(CASE
             WHEN order_delivered_customer_date IS NULL THEN 1
             ELSE 0
           END) AS order_customer_date_nulls
FROM   orders;

go

-- order_status 
SELECT DISTINCT order_status
FROM   orders;

go

SELECT order_status,
       Count(order_id) AS num_of_orders_each_status
FROM   orders
GROUP  BY order_status;

go

-- ensure null values 
SELECT order_status,
       Count(order_id) AS num_orders
FROM   orders
WHERE  order_delivered_customer_date IS NULL
GROUP  BY order_status;

go

SELECT order_id,
       order_status,
       order_purchase_timestamp,
       order_delivered_customer_date
FROM   orders
WHERE  order_status = 'delivered'
       AND order_delivered_customer_date IS NULL;

go

-- test Dates 
SELECT Count(*)
FROM   orders
WHERE  order_approved_at < order_purchase_timestamp;

go

SELECT Count(*)
FROM   orders
WHERE  Cast(order_delivered_carrier_date AS DATE) < Cast(
       order_approved_at AS DATE);

go

SELECT Count(*)
FROM   orders
WHERE  Cast(order_delivered_customer_date AS DATE) < Cast(
       order_delivered_carrier_date AS DATE);

go

SELECT Count(*)
FROM   orders
WHERE  order_estimated_delivery_date < order_purchase_timestamp;

go 

-- Referential Integrity Check
SELECT *
FROM   orders o
       LEFT JOIN customers c
              ON o.customer_id = c.customer_id
WHERE  c.customer_id IS NULL; 
go

-----------------------------------------------------------------
-----------------------------------------------------------------

--------------------
--3. Order_items
--------------------
go

--show data 
SELECT *
FROM   order_items;

go

-- row count
SELECT Count(*) AS total_rows
FROM   order_items;

go

-- uniqueness 
SELECT Count(DISTINCT order_item_id) AS u_order_item
FROM   order_items;

go

SELECT Count(DISTINCT order_id) AS u_order
FROM   order_items;

go

-- composit key !
SELECT order_id,
       order_item_id,
       Count(*) AS ctn
FROM   order_items
GROUP  BY order_id,
          order_item_id
HAVING Count(*) > 1;

go

-- check nulls 
SELECT Sum(CASE
             WHEN order_id IS NULL THEN 1
             ELSE 0
           END) AS order_id_nulls,
       Sum(CASE
             WHEN order_item_id IS NULL THEN 1
             ELSE 0
           END) AS order_item_id_nulls,
       Sum(CASE
             WHEN product_id IS NULL THEN 1
             ELSE 0
           END) AS produc_id_nulls,
       Sum(CASE
             WHEN seller_id IS NULL THEN 1
             ELSE 0
           END) AS seller_id_nulls,
       Sum(CASE
             WHEN shipping_limit_date IS NULL THEN 1
             ELSE 0
           END) AS shipping_limit_date_nulls,
       Sum(CASE
             WHEN price IS NULL THEN 1
             ELSE 0
           END) AS price_nulls,
       Sum(CASE
             WHEN freight_value IS NULL THEN 1
             ELSE 0
           END) AS freight_value_nulls
FROM   order_items;

go

-- Business Roles 
go

SELECT Count(*) AS no_price
FROM   order_items
WHERE  price <= 0;

go

go

SELECT Count(*) AS zero_freight_val
FROM   order_items
WHERE  freight_value < 0;

go

SELECT Count(*) AS free
FROM   order_items
WHERE  freight_value = 0;

-- Referential Integrity
SELECT *
FROM   order_items oi
       LEFT JOIN orders o
              ON oi.order_id = o.order_id
WHERE  o.order_id IS NULL;

go

SELECT *
FROM   order_items AS oi
       LEFT JOIN products p
              ON oi.product_id = p.product_id
WHERE  p.product_id IS NULL;

go

SELECT *
FROM   order_items oi
       LEFT JOIN sellers s
              ON oi.seller_id = s.seller_id
WHERE  s.seller_id IS NULL;

go 


---------------------------------------------------------
---------------------------------------------------------

------------------------
--4. products 
------------------------
go

-- show data 
SELECT *
FROM   products;

go

-- count row 
SELECT Count(*) AS total_rows
FROM   products;

go

-- uniqueness
SELECT Count(*)                   AS total_rows,
       Count(DISTINCT product_id) AS dist_product_id
FROM   products;

go

-- check nulls
SELECT Sum(CASE
             WHEN product_id IS NULL THEN 1
             ELSE 0
           END) AS product_id_nulls,
       Sum(CASE
             WHEN product_category_name IS NULL THEN 1
             ELSE 0
           END) AS product_category_name_nulls,
       Sum(CASE
             WHEN product_name_lenght IS NULL THEN 1
             ELSE 0
           END) AS product_name_lenght_nulls,
       Sum(CASE
             WHEN product_description_lenght IS NULL THEN 1
             ELSE 0
           END) AS product_description_lenght,
       Sum(CASE
             WHEN product_photos_qty IS NULL THEN 1
             ELSE 0
           END) AS product_photos_qty_nulls,
       Sum(CASE
             WHEN product_weight_g IS NULL THEN 1
             ELSE 0
           END) AS product_weight_g,
       Sum(CASE
             WHEN product_length_cm IS NULL THEN 1
             ELSE 0
           END) AS product_length_cm,
       Sum(CASE
             WHEN product_height_cm IS NULL THEN 1
             ELSE 0
           END) AS product_height_cm,
       Sum(CASE
             WHEN product_width_cm IS NULL THEN 1
             ELSE 0
           END) AS product_width_cm
FROM   products;

go

-- Business rules 
SELECT Count(*) AS zero_weight
FROM   products
WHERE  product_weight_g <= 0;

go

SELECT Count(*) AS zero_width
FROM   products
WHERE  product_width_cm <= 0;

go

SELECT Count(*) AS zero_height
FROM   products
WHERE  product_height_cm <= 0;

go

SELECT Count(*) AS zero_length
FROM   products
WHERE  product_length_cm <= 0;

go

SELECT Count(*) AS no_photos
FROM   products
WHERE  product_photos_qty <= 0;

go

-- num of categories 
SELECT Count(DISTINCT product_category_name) AS num_of_categories
FROM   products;

go

SELECT Count(*) AS category_nulls
FROM   products
WHERE  product_category_name IS NULL; 
go 

-------------------------------------------------------
-------------------------------------------------------

-------------------------
--5. sellers 
-------------------------
go

-- show data 
SELECT *
FROM   sellers;

go

-- uniqueness
SELECT Count(DISTINCT seller_id) AS unique_id
FROM   sellers;

go

--count rows
SELECT Count(*) AS count_row
FROM   sellers;

go

-- check nulls 
SELECT Sum(CASE
             WHEN seller_id IS NULL THEN 1
             ELSE 0
           END) AS seller_id_nulls,
       Sum(CASE
             WHEN seller_zip_code_prefix IS NULL THEN 1
             ELSE 0
           END) AS seller_zip_cod_nulls,
       Sum(CASE
             WHEN seller_city IS NULL THEN 1
             ELSE 0
           END) AS seller_city_nulls,
       Sum(CASE
             WHEN seller_state IS NULL THEN 1
             ELSE 0
           END) AS seller_state_nulls
FROM   sellers;

go

-- explor data 
SELECT seller_city,
       Count(*) AS num_cities
FROM   sellers
GROUP  BY seller_city;

go

SELECT DISTINCT seller_city
FROM   sellers;

go

SELECT seller_state,
       Count(*) AS num_of_states
FROM   sellers
GROUP  BY seller_state;

go 

SELECT seller_state,
       Count(seller_id) AS num_of_sellers
FROM   sellers
GROUP  BY seller_state; 
go 

----------------------------------------------
---------------------------------------------

------------------
--6.payments 
------------------
go

-- show data 
SELECT *
FROM   order_payments;

go

-- count rows 
SELECT Count(*) AS count_row
FROM   order_payments;

go

-- uniqueness 
SELECT Count(DISTINCT payment_sequential) AS test_for_pk
FROM   order_payments;

go

-- composit key
SELECT order_id,
       payment_sequential,
       Count(*) cnt
FROM   order_payments
GROUP  BY order_id,
          payment_sequential
HAVING Count(*) > 1;

go

-- check nulls 
SELECT Sum(CASE
             WHEN order_id IS NULL THEN 1
             ELSE 0
           END) AS order_id_nulls,
       Sum(CASE
             WHEN payment_sequential IS NULL THEN 1
             ELSE 0
           END) AS payment_sequential_nulls,
       Sum(CASE
             WHEN payment_type IS NULL THEN 1
             ELSE 0
           END) AS payment_typ_nulls,
       Sum(CASE
             WHEN payment_installments IS NULL THEN 1
             ELSE 0
           END) AS payment_installments_nulls,
       Sum(CASE
             WHEN payment_value IS NULL THEN 1
             ELSE 0
           END) AS payment_value_nulls
FROM   order_payments;

go

-- Business Rules 
SELECT Count(*) AS negative_payment_value
FROM   order_payments
WHERE  payment_value < 0;

go

SELECT Count(*) AS no_payment_value
FROM   order_payments
WHERE  payment_value = 0;

go

SELECT Count(*) AS payment_installments_zero
FROM   order_payments
WHERE  payment_installments = 0;

go

SELECT Count(*) AS negative_payment_installments
FROM   order_payments
WHERE  payment_installments < 0;

go

-- explore payment typs 
SELECT DISTINCT payment_type
FROM   order_payments;

go

-- the most popular type 
SELECT payment_type,
       Count(*) AS num_of_orders_paid
FROM   order_payments
GROUP  BY payment_type;

go

-- avg payment val 
SELECT payment_type,
       Avg(payment_value) AS avg_paymnet
FROM   order_payments
GROUP  BY payment_type;

go

-- installments 
SELECT payment_installments,
       Count(*) AS num_of_installments
FROM   order_payments
GROUP  BY payment_installments
ORDER  BY payment_installments ASC;

go

-- referntial integrity 
SELECT *
FROM   order_payments op
       LEFT JOIN orders o
              ON o.order_id = op.order_id
WHERE  o.order_id IS NULL;

go 
