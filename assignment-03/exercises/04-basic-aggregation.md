# Exercise 4: Basic Aggregation Functions (20 points)

## Learning Objectives
- Use `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- Understand `COUNT(*)` vs `COUNT(column)`
- Use `DISTINCT` with aggregations
- Apply `ROUND` for formatting numbers

## Context

The finance and operations teams need summary statistics for reporting. You'll calculate totals, averages, and counts across the entire dataset.

## Tasks

### Task 4.1: Order Statistics (4 points)
Calculate overall order statistics.

**Return a single row with:**
- `total_orders`: Count of all orders
- `total_revenue`: Sum of all order `total_amount` values
- `average_order_value`: Average `total_amount` (rounded to 2 decimal places)
- `largest_order`: Maximum `total_amount`
- `smallest_order`: Minimum `total_amount`

### Task 4.2: Customer Count by Tier (4 points)
Count the total number of customers and the number of customers in each tier.

**Return a single row with:**
- `total_customers`: Total count
- `bronze_customers`: Count where tier = 'bronze'
- `silver_customers`: Count where tier = 'silver'
- `gold_customers`: Count where tier = 'gold'
- `platinum_customers`: Count where tier = 'platinum'

> **Hint:** Use `COUNT(CASE WHEN tier = 'bronze' THEN 1 END)` or `SUM(CASE WHEN tier = 'bronze' THEN 1 ELSE 0 END)`

### Task 4.3: Product Catalog Summary (4 points)
Generate a summary of the product catalog.

**Return a single row with:**
- `total_products`: Count of all products
- `active_products`: Count where `is_active = TRUE`
- `avg_price`: Average price (rounded to 2 decimal places)
- `price_range`: Difference between max and min prices
- `unique_categories`: Count of distinct category IDs

### Task 4.4: Review Metrics (4 points)
Calculate review statistics.

**Return a single row with:**
- `total_reviews`: Count of all reviews
- `average_rating`: Average rating (rounded to 1 decimal place)
- `verified_reviews`: Count where `is_verified_purchase = TRUE`
- `reviews_with_comments`: Count where comment is NOT NULL
- `five_star_reviews`: Count where rating = 5

### Task 4.5: Inventory Health Check (4 points)
Assess inventory levels across all warehouses.

**Return a single row with:**
- `total_stock_units`: Sum of all quantity values
- `unique_products_stocked`: Count of distinct product IDs
- `avg_stock_per_product`: Average quantity (rounded to 0 decimals)
- `out_of_stock_entries`: Count where quantity = 0
- `low_stock_entries`: Count where quantity > 0 AND quantity <= 10

## Submission

Save your queries in `sql/exercise_04.sql` with each query labeled.

## Hints

- `COUNT(*)` counts all rows
- `COUNT(column)` counts non-NULL values only
- `COUNT(DISTINCT column)` counts unique non-NULL values
- `ROUND(value, decimal_places)` for formatting
- Conditional counting: `COUNT(CASE WHEN condition THEN 1 END)`
- Alternative: `SUM(CASE WHEN condition THEN 1 ELSE 0 END)`
