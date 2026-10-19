## Analysis 1 — Overall Order Performance

### Business Question
What is the overall order performance?

### Approach
Aggregated order items by `order_id` to calculate order value and AOV.

### Key Metrics
- **Total Orders:** 98,666
- **Total Sales:** 13,591,643.70
- **AOV:** 137.75

### SQL
```sql
WITH order_summary AS (
    SELECT
        order_id,
        COUNT(order_id) AS total_items,
        ROUND(SUM(price), 2) AS total_price_per_order
    FROM olist_order_items_dataset
    GROUP BY order_id
)

SELECT
    *,
    ROUND(AVG(total_price_per_order) OVER (), 2) AS AOV
FROM order_summary;



SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_sales,
    ROUND(SUM(price) / COUNT(DISTINCT order_id), 2) AS AOV
FROM olist_order_items_dataset;
```

## Analysis 2 — Sales by Product Category

### Business Question
Which product categories generate the most sales?

### Approach
Joined product and order-item data using `product_id`, then grouped sales by product category.

### Key Metrics
- **Top Category:** beleza_saude
- **Top Category Sales:** 1,258,681.34
- **2nd:** relogios_presentes — 1,205,005.68
- **3rd:** cama_mesa_banho — 1,036,988.68

### SQL
```sql
SELECT
    p.product_category_name,
    ROUND(SUM(o.price), 2) AS total_category_sales
FROM olist_products_dataset p
JOIN olist_order_items_dataset o
    ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_category_sales DESC;
```
## Analysis 3 — Orders per Customer

### Business Question
How many orders does the average customer place?

### Approach
Joined orders with customer data, calculated orders per unique customer, then averaged the customer-level order counts.

### Key Metrics
- **Unique Customers:** 99,441
- **Average Orders per Customer:** 1.03

### SQL
```sql
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    AVG(total_orders) AS avg_orders_per_customer
FROM customer_orders;

```

## Analysis 4 — Highest-Spending Customers

### Business Question

Which customers generate the highest total spending?

### Approach

Joined customer, order, and order-item data to calculate total spending for each unique customer.

### Key Metrics

- **Top Customer Spending:** 13,440
- **2nd Highest:** 7,388
- **3rd Highest:** 7,160

### SQL

```sql
SELECT
    c.customer_unique_id,
    SUM(x.price) AS total_spending
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset x
    ON x.order_id = o.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spending DESC;
```

## Analysis 5 — Seller Sales Performance

### Business Question
Which sellers generate the highest sales?

### Approach
Aggregated order-item sales by `seller_id` and ranked sellers by total sales.

### Key Metrics
- **Top Seller:** 4869f7... — 229,472.63
- **2nd:** 532435... — 222,776.05
- **3rd:** 4a3ca9... — 200,472.92

### SQL
```sql
SELECT
    seller_id,
    ROUND(SUM(price), 2) AS seller_sales
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY seller_sales DESC
LIMIT 3;
```

## Analysis 6 — Order Status Performance

### Business Question
What is the distribution of orders by order status?

### Approach
Grouped orders by `order_status` and counted the number of orders in each status.

### Key Metrics
- **Delivered:** 96,478
- **Shipped:** 1,107
- **Canceled:** 625
- **Unavailable:** 609
- **Invoiced:** 314
- **Processing:** 301
- **Created:** 5
- **Approved:** 2

### SQL
```sql
SELECT
    order_status,
    COUNT(order_id) AS status_count
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY status_count DESC;
```
## Analysis 7 — Payment Behavior

### Business Question
Which payment types are used most frequently?

### Approach
Grouped payment records by `payment_type` and counted the number of records for each payment method.

### Key Metrics
- **Credit Card:** 76,795
- **Boleto:** 19,784
- **Voucher:** 5,775
- **Debit Card:** 1,529
- **Not Defined:** 3

### SQL
```sql
SELECT
    payment_type,
    COUNT(*) AS payment_count
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY payment_count DESC;
```

## Analysis 8 — Product Sales Performance

### Business Question
Which products generate the highest sales?

### Approach
Joined product and order-item data using `product_id` and ranked products by total sales.

### Key Metrics
- **Top Product:** `bb50f...` — 63,885
- **2nd:** `6cd538...` — 54,730.20
- **3rd:** `d6160f...` — 48,899.34

### SQL
```sql
SELECT
    o.product_id,
    p.product_category_name,
    ROUND(SUM(o.price), 2) AS product_sales
FROM olist_order_items_dataset o
JOIN olist_products_dataset p
    ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_category_name
ORDER BY product_sales DESC
LIMIT 3;
```
## Analysis 9 — Repeat Customer Behavior

### Business Question
What percentage of customers made more than one purchase?

### Approach
Calculated the number of orders for each unique customer, then identified customers with more than one order and calculated their percentage of the total customer base.

### Key Metrics
- **Repeat Customer Percentage:** 3.12%

### SQL
```sql
WITH customer_behaviour AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(CASE WHEN order_count > 1 THEN 1 END)
    / COUNT(customer_unique_id) * 100 AS repeat_customer_percentage
FROM customer_behaviour;

```

## Analysis 10 — Average Customer Spending

### Business Question
What is the average spending per customer?

### Approach
Calculated total spending for each unique customer, then averaged the customer-level spending.

### Key Metrics
- **Average Customer Spending:** 142.44

### SQL
```sql
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




