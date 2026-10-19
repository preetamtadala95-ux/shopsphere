
# ShopSphere — E-commerce Revenue & Customer Analytics

## Project Overview

ShopSphere is a SQL-based e-commerce analytics project built using the Olist Brazilian E-commerce dataset.

The project analyzes sales, customers, products, sellers, orders, and payment behavior to answer key business questions and identify actionable insights.

## Business Objective

The objective is to use SQL to understand:

- Overall sales and order performance
- Top-performing product categories and products
- Customer purchasing behavior
- Highest-spending customers
- Seller performance
- Order status distribution
- Payment method usage
- Customer repeat-purchase behavior

## Dataset

The project uses the Olist Brazilian E-commerce dataset, which contains information about:

- Orders
- Customers
- Order items
- Products
- Sellers
- Payments

### Key Tables

| Table | Purpose |
|---|---|
| `olist_orders_dataset` | Order details and order status |
| `olist_order_items_dataset` | Products purchased, sellers, quantity and price |
| `olist_customers_dataset` | Customer information and customer identifiers |
| `olist_products_dataset` | Product and category information |
| `olist_sellers_dataset` | Seller information |
| `olist_order_payments_dataset` | Payment methods and payment details |

## Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- GitHub

## Analysis Performed

### 1. Overall Order Performance
Analyzed total orders, total sales, and average order value.

### 2. Sales by Product Category
Identified the product categories generating the highest sales.

### 3. Orders per Customer
Calculated the average number of orders placed by each unique customer.

### 4. Highest-Spending Customers
Identified customers generating the highest total spending.

### 5. Seller Sales Performance
Ranked sellers based on total sales generated.

### 6. Order Status Performance
Analyzed the distribution of orders across different order statuses.

### 7. Payment Behavior
Identified the most frequently used payment methods.

### 8. Product Sales Performance
Identified the products generating the highest sales.

### 9. Repeat Customer Behavior
Calculated the percentage of customers who made more than one purchase.

### 10. Average Customer Spending
Calculated the average spending per customer.

## Key Findings

- Total sales were **13.59M** across **98,666 orders**.
- Average order value was **137.75**.
- `beleza_saude` was the highest-selling product category.
- The top seller generated approximately **229K** in sales.
- Credit card was the most frequently used payment method.
- Only **3.12%** of customers made more than one purchase.
- Average customer spending was **142.44**.

## Key Business Takeaway

The analysis shows strong overall sales performance but relatively low repeat purchasing, with only **3.12% of customers making more than one purchase**. This highlights customer retention as an important potential area for further business analysis.

## SQL Concepts Demonstrated

This project demonstrates practical use of:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `DISTINCT`
- Aggregate functions
- `JOIN`
- Multiple-table joins
- CTEs
- Window functions
- `CASE WHEN`
- Data validation

## Project Structure

```text
shopsphere/
│
├── README.md
│
├── docs/
│   └── analysis.md
│
└── sql/
    └── analysis.sql
