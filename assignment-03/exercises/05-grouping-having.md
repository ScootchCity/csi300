# Exercise 5: Grouping and HAVING (20 points)

## Learning Objectives
- Group data using `GROUP BY`
- Filter groups using `HAVING`
- Combine `WHERE` and `HAVING` correctly
- Use multiple grouping columns

## Context

Management needs segmented reports showing metrics broken down by category, status, or time period. You'll create grouped aggregations and filter the groups.

## Tasks

### Task 5.1: Orders by Status (4 points)
Count orders and calculate total revenue for each order status.

**Return:** `status`, `order_count`, `total_revenue`  
**Order by:** `order_count` descending

### Task 5.2: Top Product Categories by Revenue (4 points)
Calculate total revenue from order items grouped by product category. Only include categories with more than $5000 in total revenue.

> **Note:** You'll need to work with `order_items` and `products` tables. Get the `category_id` from products and sum the `line_total` from order_items.

**Return:** `category_id`, `total_revenue`, `items_sold`  
**Order by:** `total_revenue` descending

> **Hint:** Use multiple tables with comma syntax: `FROM order_items oi, products p WHERE oi.product_id = p.id`

### Task 5.3: Customer Order Frequency (4 points)
Find customers who have placed 3 or more orders. Count their orders and calculate their total spending.

**Return:** `customer_id`, `order_count`, `total_spent`  
**Order by:** `total_spent` descending

### Task 5.4: Monthly Revenue 2024 (4 points)
Calculate monthly revenue for 2024. Only include months with revenue over $2000.

**Return:** 
- `order_month` (month number 1-12)
- `order_count`
- `monthly_revenue` (sum of total_amount)

**Order by:** `order_month` ascending

### Task 5.5: Product Rating Summary (4 points)
Calculate the average rating and review count for each product. Only include products with at least 3 reviews.

**Return:** 
- `product_id`
- `review_count`
- `avg_rating` (rounded to 2 decimal places)
- `five_star_count`: number of 5-star reviews

**Order by:** `avg_rating` descending, `review_count` descending

## Submission

Save your queries in `sql/exercise_05.sql` with each query labeled.

## Hints

- `WHERE` filters rows BEFORE grouping
- `HAVING` filters groups AFTER aggregation
- Every non-aggregated column in SELECT must be in GROUP BY
- You can use aggregate functions in HAVING: `HAVING COUNT(*) >= 3`
- For Task 5.2, the implicit join syntax is: `FROM table1, table2 WHERE table1.col = table2.col`
- `EXTRACT(MONTH FROM created_at)` works in GROUP BY
