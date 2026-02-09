# Exercise 2: Pattern Matching and NULL Handling (20 points)

## Learning Objectives
- Use `LIKE` and `ILIKE` for pattern matching
- Use wildcards `%` and `_`
- Handle `NULL` values with `IS NULL` and `IS NOT NULL`
- Use `COALESCE` to provide default values

## Context

The customer support team needs to find specific records and clean up data reports. Some queries need to handle missing data gracefully.

## Tasks

### Task 2.1: Product Search (4 points)
Find all products whose name contains the word "Pro" (case-insensitive).

**Return:** `id`, `name`, `price`  
**Order by:** `name` ascending

### Task 2.2: Email Domain Analysis (4 points)
Find all customers with Gmail email addresses (emails ending in `@gmail.com`).

**Return:** `id`, `first_name`, `last_name`, `email`  
**Order by:** `last_name` ascending

### Task 2.3: Customers Without Phone Numbers (4 points)
Find all customers who have not provided a phone number.

**Return:** `id`, `first_name`, `last_name`, `email`  
**Order by:** `id` ascending

### Task 2.4: Reviews Without Comments (4 points)
Find all product reviews where the customer left a rating but no written comment.

**Return:** `id`, `product_id`, `customer_id`, `rating`, `title`  
**Order by:** `rating` descending, `id` ascending

### Task 2.5: Contact List with Default Phone (4 points)
Generate a customer contact list that displays "No phone on file" for customers without a phone number.

**Return:** 
- `id`
- `full_name` (concatenate `first_name` and `last_name` with a space)
- `contact_phone` (phone or "No phone on file" if NULL)

**Order by:** `last_name` ascending

## Submission

Save your queries in `sql/exercise_02.sql` with each query labeled.

## Hints

- `LIKE` is case-sensitive, `ILIKE` is case-insensitive (PostgreSQL)
- `%` matches any sequence of characters
- `_` matches exactly one character
- `WHERE column IS NULL` (not `= NULL`)
- `COALESCE(column, 'default')` returns the first non-NULL value
- Use `||` for string concatenation: `first_name || ' ' || last_name`
