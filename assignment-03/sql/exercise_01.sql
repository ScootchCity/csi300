-- ============================================
-- Exercise 1: Basic Filtering with WHERE
-- ============================================

-- Task 1.1: Premium Products (4 points)
-- Find all products with a price of $500 or more
-- Return: product_id, name, price
-- Order by: price descending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT id, name, price FROM products
WHERE price > 500
ORDER BY price DESC;

-- Task 1.2: Budget-Friendly Options (4 points)
-- Find all products priced between $20 and $100 (inclusive)
-- Return: product_id, name, price, category_id
-- Order by: price ascending
-- Tip: Use BETWEEN operator
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT id, name, price, category_id FROM products
WHERE price BETWEEN 20 AND 100
ORDER BY price;

-- Task 1.3: Electronics Department (4 points)
-- Find all products in Electronics category or its subcategories
-- Return: product_id, name, category_id, price
-- Order by: name ascending
-- Tip: First query the categories table to find the IDs for Electronics and its subcategories
--      Then use IN operator with those explicit category IDs (e.g., category_id IN (1, 2, 3))
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT id, name, category_id, price FROM products
WHERE category_id = 1 OR (category_id IN (
    SELECT c.id FROM categories c
            WHERE c.parent_id = 1
            )
    )
ORDER BY name;

-- Task 1.4: Order Status Filter (4 points)
-- Find orders that are pending, confirmed, or processing
-- Return: order_id, order_number, status, total_amount, created_at
-- Order by: created_at descending
-- Tip: Use IN operator
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT id, order_number, status, total_amount, created_at FROM orders
WHERE status IN ('pending', 'confirmed', 'processing')
ORDER BY created_at DESC;

-- Task 1.5: High-Value Completed Orders (4 points)
-- Find delivered orders with total > $1000
-- Return: order_id, order_number, customer_id, total_amount, delivered_at
-- Order by: total_amount descending
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT id, order_number, customer_id, total_amount, delivered_at FROM orders
WHERE total_amount >= 1000
ORDER BY total_amount DESC;