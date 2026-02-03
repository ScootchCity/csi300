-- ============================================
-- Exercise 4: Basic Aggregation Functions
-- ============================================

-- Task 4.1: Order Statistics (4 points)
-- Calculate overall order statistics
-- Return single row with:
--   - total_orders: COUNT(*)
--   - total_revenue: SUM(total_amount)
--   - average_order_value: AVG(total_amount) rounded to 2 decimals
--   - largest_order: MAX(total_amount)
--   - smallest_order: MIN(total_amount)
-- Tip: Use ROUND(AVG(...), 2) for rounding
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS average_order_value,
    MAX(total_amount) AS largest_order,
    MIN(total_amount) AS smallest_order
FROM orders;

-- Task 4.2: Customer Count by Tier (4 points)
-- Count customers in each tier using conditional counting
-- Return single row with:
--   - total_customers: total count
--   - bronze_customers: count where tier = 'bronze'
--   - silver_customers: count where tier = 'silver'
--   - gold_customers: count where tier = 'gold'
--   - platinum_customers: count where tier = 'platinum'
-- Tip: Use COUNT(CASE WHEN tier = 'value' THEN 1 END)
--      or SUM(CASE WHEN tier = 'value' THEN 1 ELSE 0 END)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN tier = 'bronze' THEN 1 END) AS bronze_customers,
    COUNT(CASE WHEN tier = 'silver' THEN 1 END) AS silver_customers,
    COUNT(CASE WHEN tier = 'gold' THEN 1 END) AS gold_customers,
    COUNT(CASE WHEN tier = 'platinum' THEN 1 END) AS platinum_customers
FROM customers;

-- Task 4.3: Product Catalog Summary (4 points)
-- Generate product catalog summary
-- Return single row with:
--   - total_products: COUNT(*)
--   - active_products: count where is_active = TRUE
--   - avg_price: AVG(price) rounded to 2 decimals
--   - price_range: MAX(price) - MIN(price)
--   - unique_categories: COUNT(DISTINCT category_id)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    COUNT(*) AS total_products,
    COUNT(CASE WHEN is_active = TRUE THEN 1 END),
    ROUND(AVG(price), 2) AS avg_price,
    MAX(price) - MIN(price) AS price_range,
    COUNT(DISTINCT category_id) AS unique_categories
FROM products;

-- Task 4.4: Review Metrics (4 points)
-- Calculate review statistics
-- Return single row with:
--   - total_reviews: COUNT(*)
--   - average_rating: AVG(rating) rounded to 1 decimal
--   - verified_reviews: count where is_verified_purchase = TRUE
--   - reviews_with_comments: COUNT(comment) - counts non-NULL only
--   - five_star_reviews: count where rating = 5
-- Tip: COUNT(column) only counts non-NULL values
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    COUNT(*) AS total_reviews,
    ROUND(AVG(rating), 1) AS average_rating,
    COUNT(CASE WHEN is_verified_purchase = TRUE THEN 1 END) AS average_rating,
    COUNT(comment) AS reviews_with_comments,
    COUNT(CASE WHEN rating = 5 THEN 1 END) AS five_star_reviews
FROM product_reviews;

-- Task 4.5: Inventory Health Check (4 points)
-- Assess inventory levels
-- Return single row with:
--   - total_stock_units: SUM(quantity)
--   - unique_products_stocked: COUNT(DISTINCT product_id)
--   - avg_stock_per_product: AVG(quantity) rounded to 0 decimals
--   - out_of_stock_entries: count where quantity = 0
--   - low_stock_entries: count where quantity > 0 AND quantity <= reorder_level
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    SUM(quantity) AS total_stock_units,
    COUNT(DISTINCT product_id) AS unique_product_reviews,
    ROUND(AVG(quantity), 0) AS avg_stock_per_product,
    COUNT(CASE WHEN quantity = 0 THEN 1 END) AS out_of_stock_entries,
    COUNT(CASE WHEN quantity > 0 AND quantity <= reserved_quantity THEN 1 END) AS low_stock_entries
FROM inventory;
