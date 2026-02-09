# Exercise 1: Basic Filtering with WHERE (20 points)

## Learning Objectives
- Use comparison operators (`=`, `<>`, `<`, `>`, `<=`, `>=`)
- Filter with `IN` and `NOT IN`
- Use `BETWEEN` for range queries
- Combine conditions with `AND` and `OR`

## Context

ShopFlow's marketing team needs specific product and order data to plan upcoming campaigns. Your job is to write queries that extract exactly the data they need.

## Tasks

### Task 1.1: Premium Products (4 points)
Find all products with a price of $500 or more.

**Return:** `id`, `name`, `price`  
**Order by:** `price` descending

### Task 1.2: Budget-Friendly Options (4 points)
Find all products priced between $20 and $100 (inclusive).

**Return:** `id`, `name`, `price`, `category_id`  
**Order by:** `price` ascending

### Task 1.3: Electronics Department (4 points)
Find all products in the Electronics category (category_id = 1) or any of its subcategories.

> **Hint:** First, find all category IDs that have `parent_id = 1` or have `id = 1`.

**Return:** `id`, `name`, `category_id`, `price`  
**Order by:** `name` ascending

### Task 1.4: Order Status Filter (4 points)
Find all orders that are either `pending`, `confirmed`, or `processing` (not yet shipped).

**Return:** `id`, `order_number`, `status`, `total_amount`, `created_at`  
**Order by:** `created_at` descending

### Task 1.5: High-Value Completed Orders (4 points)
Find all delivered orders with a `total_amount` greater than $1000.

**Return:** `id`, `order_number`, `customer_id`, `total_amount`, `delivered_at`  
**Order by:** `total_amount` descending

## Submission

Save your queries in `sql/exercise_01.sql` with each query labeled:
```sql
-- Task 1.1: Premium Products
SELECT ...

-- Task 1.2: Budget-Friendly Options
SELECT ...
```

## Hints

- Use `>=` for "greater than or equal to"
- `BETWEEN a AND b` is inclusive of both endpoints
- `IN (value1, value2, ...)` is cleaner than multiple `OR` conditions
- Remember: `status = 'delivered'` uses single quotes for strings
