# Assignment 3: Filtering & Aggregation

## Overview

In this assignment, you will practice **advanced filtering** and **aggregation** techniques using SQL. Unlike previous assignments where you built the database schema, here you will work with a **pre-built e-commerce database** called **ShopFlow**.

You will analyze sales data, customer behavior, and product performance by writing queries that:
- Filter data using complex WHERE clauses
- Use pattern matching with LIKE
- Handle NULL values properly
- Apply CASE expressions for conditional logic
- Aggregate data with COUNT, SUM, AVG, MIN, MAX
- Group results with GROUP BY and filter groups with HAVING

## Learning Objectives

By completing this assignment, you will be able to:

1. Write complex WHERE clauses using AND, OR, NOT operators
2. Use LIKE patterns for text matching with wildcards
3. Apply IN, BETWEEN, and comparison operators effectively
4. Handle NULL values correctly with IS NULL, IS NOT NULL, COALESCE
5. Create conditional columns using CASE expressions
6. Calculate aggregates: COUNT, SUM, AVG, MIN, MAX
7. Use DISTINCT in both SELECT and aggregate functions
8. Group data with GROUP BY and filter groups with HAVING
9. Work with date/time functions for temporal filtering

## Prerequisites

- Assignment 2 completed (DDL, DQL, DML fundamentals)
- Docker and Docker Compose installed
- SQL client (DBeaver, DataGrip, or use Adminer)

## The ShopFlow E-Commerce Database

ShopFlow is an online retail platform with:

- **8 product categories** from Electronics to Home & Garden
- **500+ products** with varying prices, stock levels, and ratings
- **1,000+ customers** across different countries and tiers
- **10,000+ orders** spanning 2 years of sales data
- **25,000+ order items** with prices, quantities, and discounts

### Database Schema

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   categories    │     │    products     │     │    inventory    │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ id (PK)         │◄────│ category_id (FK)│     │ product_id (FK) │
│ name            │     │ id (PK)         │◄────│ warehouse_id    │
│ description     │     │ sku             │     │ quantity        │
│ parent_id (FK)  │     │ name            │     │ last_restock    │
│ is_active       │     │ description     │     └─────────────────┘
└─────────────────┘     │ price           │
                        │ cost            │     ┌─────────────────┐
                        │ weight_kg       │     │   warehouses    │
                        │ is_active       │     ├─────────────────┤
                        │ created_at      │     │ id (PK)         │
                        │ discontinued_at │     │ name            │
                        └─────────────────┘     │ country         │
                                                │ capacity        │
┌─────────────────┐     ┌─────────────────┐     └─────────────────┘
│    customers    │     │     orders      │
├─────────────────┤     ├─────────────────┤     ┌─────────────────┐
│ id (PK)         │◄────│ customer_id (FK)│     │   order_items   │
│ email           │     │ id (PK)         │◄────│ order_id (FK)   │
│ first_name      │     │ order_number    │     │ product_id (FK) │
│ last_name       │     │ status          │     │ quantity        │
│ phone           │     │ subtotal        │     │ unit_price      │
│ country         │     │ tax_amount      │     │ discount_pct    │
│ city            │     │ shipping_cost   │     │ line_total      │
│ tier            │     │ total_amount    │     └─────────────────┘
│ created_at      │     │ created_at      │
│ last_order_at   │     │ shipped_at      │     ┌─────────────────┐
└─────────────────┘     │ delivered_at    │     │ product_reviews │
                        │ shipping_method │     ├─────────────────┤
                        └─────────────────┘     │ product_id (FK) │
                                                │ customer_id (FK)│
                                                │ rating          │
                                                │ title           │
                                                │ comment         │
                                                │ is_verified     │
                                                │ created_at      │
                                                └─────────────────┘
```

## Getting Started

### Step 1: Start the Database

```bash
cd assignment
docker-compose up -d
```

This starts:
- **PostgreSQL 16** on port `5432`
- **Adminer** web UI on port `8080`

### Step 2: Load the Base Data

The database comes pre-loaded! The files in `base/` run automatically on container startup via Docker's `initdb.d` mechanism.

To verify the data loaded correctly:

```bash
# Connect to the database via docker compose
docker-compose exec postgres psql -U postgres -d postgres

# Check table counts
SELECT 'categories' as tbl, COUNT(*) FROM categories
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;
```

### Step 3: Access the Database

**Option A: Adminer (Web UI)**
- URL: http://localhost:8080
- System: PostgreSQL
- Server: postgres
- Username: postgres
- Password: postgres
- Database: postgres

**Option B: Command Line**
```bash
docker-compose exec postgres psql -U postgres -d postgres
```

**Option C: External Client (DBeaver, DataGrip)**
- Host: localhost
- Port: 5432
- Database: postgres
- User: postgres
- Password: postgres

## Exercises

Complete the following exercises by writing SQL queries:

| Exercise | Topic | Points |
|----------|-------|--------|
| 01 | Basic Filtering | 20 |
| 02 | Pattern Matching & NULL Handling | 20 |
| 03 | CASE Expressions & Date Functions | 20 |
| 04 | Basic Aggregation | 20 |
| 05 | GROUP BY & HAVING | 20 |
| **Total** | | **100** |

Read the detailed requirements in the `exercises/` folder:

1. [exercises/01-basic-filtering.md](exercises/01-basic-filtering.md)
2. [exercises/02-pattern-matching-nulls.md](exercises/02-pattern-matching-nulls.md)
3. [exercises/03-case-expressions-dates.md](exercises/03-case-expressions-dates.md)
4. [exercises/04-basic-aggregation.md](exercises/04-basic-aggregation.md)
5. [exercises/05-grouping-having.md](exercises/05-grouping-having.md)

## Deliverables

Create SQL files in the `sql/` folder:

```
sql/
├── exercise_01.sql      # Exercise 1: Basic Filtering
├── exercise_02.sql      # Exercise 2: Pattern Matching & NULLs
├── exercise_03.sql      # Exercise 3: CASE Expressions & Dates
├── exercise_04.sql      # Exercise 4: Basic Aggregation
└── exercise_05.sql      # Exercise 5: GROUP BY & HAVING
```

Each file should contain numbered queries matching the exercise requirements.

## Grading

### Automated Verification

Your submission will be tested using `verify.sh` via docker compose:

```bash
docker-compose run --rm verify
```

The script will:
1. Run each of your SQL files
2. Compare output against expected results
3. Check for correct row counts and values
4. Report your score

### Grading Criteria

- **Correctness (70%)**: Query returns expected results
- **Efficiency (15%)**: Appropriate use of operators and functions
- **Style (15%)**: Proper formatting, meaningful aliases

### Common Mistakes to Avoid

1. Forgetting that `NULL = NULL` is not TRUE (use `IS NULL`)
2. Using `WHERE column = NULL` instead of `WHERE column IS NULL`
3. Placing aggregate conditions in WHERE instead of HAVING
4. Forgetting to include non-aggregated columns in GROUP BY
5. Case sensitivity in LIKE patterns (PostgreSQL is case-sensitive!)
6. Integer division issues (cast to DECIMAL/NUMERIC for percentages)

## File Structure

```
assignment/
├── README.md                    # This file
├── docker-compose.yml           # Container configuration
├── verify.sh                    # Grading script
├── base/                        # Pre-built database (DO NOT MODIFY)
│   ├── 01_schema.sql
│   ├── 02_seed_categories.sql
│   ├── ...
│   └── 08_seed_inventory.sql
├── exercises/
│   ├── 01-basic-filtering.md
│   ├── 02-pattern-matching-nulls.md
│   ├── 03-case-expressions-dates.md
│   ├── 04-basic-aggregation.md
│   └── 05-grouping-having.md
└── sql/                         # YOUR WORK GOES HERE
    ├── exercise_01.sql
    ├── exercise_02.sql
    ├── exercise_03.sql
    ├── exercise_04.sql
    └── exercise_05.sql
```

## Tips for Success

### Filtering Tips
- Use parentheses to clarify AND/OR precedence
- Test boundary conditions for BETWEEN (it's inclusive)
- Remember: `LIKE` is case-sensitive in PostgreSQL, use `ILIKE` for case-insensitive

### Aggregation Tips
- `COUNT(*)` counts all rows; `COUNT(column)` excludes NULLs
- Use `DISTINCT` inside aggregates: `COUNT(DISTINCT category_id)`
- Always include non-aggregated columns in GROUP BY
- Use HAVING for conditions on aggregated values, WHERE for row-level filters

### Date/Time Tips
- Use `CURRENT_DATE` and `CURRENT_TIMESTAMP` for current date/time
- `EXTRACT(part FROM date)` gets year, month, day, etc.
- `DATE_TRUNC('month', date)` truncates to first of month
- Date arithmetic: `date + INTERVAL '30 days'`

## Submission

1. Ensure all 5 SQL files are in the `sql/` folder
2. Run `docker-compose run --rm verify` to check your work
3. Commit and push to your repository
4. GitHub Actions will run automated tests
