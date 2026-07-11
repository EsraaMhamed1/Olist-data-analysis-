
-------------------------
--1- customer 
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

-----------------------------------
----------------------------------

