/* Analaysis#1
Overall sales performance */

WITH order_summary as 
(SELECT
order_id, 
count(order_id) total_items,
ROUND(sum(price),2) total_price_per_order
FROM olist_order_items_dataset
GROUP BY order_id)

SELECT *, 
ROUND(avg(total_price_per_order) over(), 2) AOV
FROM order_summary;

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_sales,
    ROUND(SUM(price) / COUNT(DISTINCT order_id), 2) AS AOV
FROM olist_order_items_dataset;


/* Analaysis#2
sales by product category */

SELECT * FROM olist_products_dataset;
SELECT * FROM olist_order_items_dataset;

SELECT 
p.product_category_name,
ROUND(sum(o.price),2) total_category_sales
FROM olist_products_dataset p
JOIN  olist_order_items_dataset o
  ON o.product_id= p.product_id
GROUP BY p.product_category_name
ORDER BY total_category_sales DESC;

/* Analaysis#3
Customer purchase behaviour */

SELECT * FROM olist_orders_dataset;
SELECT * FROM olist_customers_dataset;
SELECT count(customer_unique_id) Unique_customers
 FROM olist_customers_dataset;
 
 SELECT * FROM olist_customers_dataset;

with unique_customer as ( 
 SELECT c.customer_unique_id,
 count(DISTINCT order_id) total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id)

SELECT
avg(total_orders) avg_orders_per_customer
FROM unique_customer;

/* Analaysis#4
Customer purchase behaviour */

SELECT * FROM olist_customers_dataset;
SELECT * FROM olist_order_items_dataset;
SELECT * FROM olist_orders_dataset;


SELECT 
c.customer_unique_id,
SUM(x.price) total_spending
 FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset x
ON x.order_id = o.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spending DESC
LIMIT 3;

/* Analaysis#5
sellers sales performance */

SELECT 
seller_id,
ROUND(sum(price),2) seller_sales
FROM olist_order_items_dataset 
GROUP BY seller_id
ORDER BY seller_sales DESC
LIMIT 3;


/* Analaysis#6
Order status performance*/

SELECT 
order_status,
count(order_id) status_count
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY status_count DESC;

/* Analaysis#7
Payment behaviour*/

SELECT 
payment_type,
count(*) payment_count
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY payment_count DESC;

/* Analaysis#8
product performance*/

SELECT * FROM olist_order_items_dataset;
SELECT * FROM olist_products_dataset;

SELECT 
o.product_id,
p.product_category_name,
ROUND(SUM(o.price),2) product_sales
FROM olist_order_items_dataset o
JOIN olist_products_dataset p
ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_category_name
ORDER BY product_sales DESC
LIMIT 3;


/* Analaysis#9
Repeat Customer Behavior*/

WITH customer_behaviour as (
SELECT 
c.customer_unique_id,
COUNT(DISTINCT order_id) Order_count
FROM olist_customers_dataset c
JOIN  olist_orders_dataset o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id)

SELECT 
COUNT(CASE WHEN order_count > 1 THEN 1 END)/
COUNT(customer_unique_id)* 100 as repeat_customer_percentage
FROM customer_behaviour;

/* Analaysis#10
 Customer value*/
 
WITH customer_spending AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(x.price), 2) AS total_spending
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
    JOIN olist_order_items_dataset x
        ON x.order_id = o.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    ROUND(AVG(total_spending), 2) AS avg_customer_spending
FROM customer_spending;




