# Exercise 3: CASE Expressions and Date Filtering (20 points)

## Learning Objectives
- Use `CASE` expressions for conditional logic
- Filter by date ranges
- Extract parts of dates using `EXTRACT` or `DATE_PART`
- Work with date comparisons

## Context

The business intelligence team needs reports with derived columns and date-specific analysis. You'll create calculated fields and filter by time periods.

## Tasks

### Task 3.1: Product Price Tiers (4 points)
Categorize products into price tiers:
- **Budget**: price < $50
- **Mid-Range**: price >= $50 AND price < $200
- **Premium**: price >= $200 AND price < $500
- **Luxury**: price >= $500

**Return:** `id`, `name`, `price`, `price_tier`  
**Order by:** `price` ascending

### Task 3.2: Order Status Labels (4 points)
Create human-readable status labels:
- `pending` → "Awaiting Confirmation"
- `confirmed` → "Order Confirmed"
- `processing` → "Being Prepared"
- `shipped` → "In Transit"
- `delivered` → "Completed"
- `cancelled` → "Cancelled"
- `refunded` → "Refunded"

**Return:** `id`, `order_number`, `status`, `status_label`  
**Order by:** `id` ascending

### Task 3.3: Black Friday Orders (4 points)
Find all orders placed during Black Friday week 2024 (November 25-29, 2024).

**Return:** `id`, `order_number`, `customer_id`, `total_amount`, `created_at`  
**Order by:** `created_at` ascending

### Task 3.4: Monthly Order Distribution 2024 (4 points)
Find all orders from 2024 and include the month name.

**Return:** 
- `id`
- `order_number`
- `order_month` (month number 1-12)
- `total_amount`

**Order by:** `order_month` ascending, `id` ascending

> **Hint:** Use `EXTRACT(MONTH FROM created_at)` to get the month number.

### Task 3.5: Review Sentiment Categories (4 points)
Categorize reviews by sentiment:
- Rating 1-2 → "Negative"
- Rating 3 → "Neutral"
- Rating 4-5 → "Positive"

Include whether the review has a written comment.

**Return:** 
- `id`
- `product_id`
- `rating`
- `sentiment`
- `has_comment` (TRUE if comment is not NULL, FALSE otherwise)

**Order by:** `rating` descending, `id` ascending

## Submission

Save your queries in `sql/exercise_03.sql` with each query labeled.

## Hints

- `CASE WHEN condition THEN result ELSE default END`
- Date comparisons: `created_at >= '2024-11-25' AND created_at < '2024-11-30'`
- `EXTRACT(YEAR FROM date_column)` returns the year as a number
- `comment IS NOT NULL` returns a boolean
- You can use `CASE` to convert boolean to TRUE/FALSE explicitly
