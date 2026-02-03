# Assignment 02 — SQL Fundamentals: DDL, DQL & DML

## Overview

In this assignment, you will design and implement a **fintech banking system** database schema from scratch. You will practice DDL (Data Definition Language), DQL (Data Query Language), and DML (Data Manipulation Language) operations while applying proper constraints, data types, and idempotency patterns.

**Scenario:** You are the database architect for **NeoBank**, a modern digital banking platform. Your task is to create the core database schema and write queries to manage customer accounts, transactions, and financial products.

## Prerequisites

1. Complete Assignment 01 (Docker + PostgreSQL setup)
2. Have PostgreSQL running via Docker
3. Read the Week 02 course materials on DDL, DQL, DML, constraints, and idempotency

## Setup

1. Navigate to the `assignment-02` folder in your terminal
2. Run `docker-compose up -d` to start PostgreSQL and Adminer
3. Connect to the database via Adminer (`http://localhost:8080`) or DataGrip
4. Create your SQL files in the `sql/` folder as specified in the exercises

## File Structure

You will create the following files:

```
assignment-02/
├── docker-compose.yml          # Provided
├── README.md                   # This file
├── verify.sh                   # Grading script (DO NOT MODIFY)
├── exercises/                  # Exercise descriptions (read these)
│   ├── 01-schema.md
│   ├── 02-seed-data.md
│   ├── 03-queries.md
│   └── 04-modifications.md
└── sql/                        # Your solutions go here
    ├── 01_schema.sql           # You create this
    ├── 02_seed.sql             # You create this
    ├── 03_queries.sql          # You create this
    └── 04_modifications.sql    # You create this
```

## ⚠️ Important: Automated Grading

Your assignment will be graded by an **automated verification script** (`verify.sh`) that:

1. **Drops the entire database** to start fresh
2. **Runs your `01_schema.sql` TWICE** to verify idempotency
3. **Runs your `02_seed.sql`** to populate data
4. **Runs your queries and modifications**
5. **Checks that specific tables, columns, and constraints exist**

If your schema script is not idempotent (i.e., fails on the second run), **you will lose significant points**. Read the idempotency section in the course materials carefully!

### What the script checks:

- ✅ Schema `neobank` exists
- ✅ All required tables exist with correct names
- ✅ All columns have correct data types
- ✅ All constraints are properly defined
- ✅ Script can run multiple times without errors

## Exercises

Complete each exercise by reading the corresponding markdown file in `exercises/` and creating your SQL solution in the `sql/` folder.

| Exercise | File to Create | Topic |
|----------|----------------|-------|
| [Exercise 1](exercises/01-schema.md) | `sql/01_schema.sql` | DDL: Schema & Table Creation (must be idempotent!) |
| [Exercise 2](exercises/02-seed-data.md) | `sql/02_seed.sql` | DML: INSERT Operations |
| [Exercise 3](exercises/03-queries.md) | `sql/03_queries.sql` | DQL: SELECT Queries |
| [Exercise 4](exercises/04-modifications.md) | `sql/04_modifications.sql` | DML: UPDATE & DELETE |

## Grading Rubric

| Criterion | Points | Description |
|-----------|--------|-------------|
| Schema Design | 30 | Correct data types, constraints, relationships, **and idempotency** |
| Seed Data | 20 | Realistic, varied data that satisfies all constraints |
| Queries | 25 | Correct SELECT syntax, proper filtering, sorting, limiting |
| Data Modifications | 20 | Correct UPDATE/DELETE with proper conditions |
| Code Quality | 5 | Consistent formatting, helpful comments, organized |

**Total: 100 points**

**Idempotency penalty:** If your `01_schema.sql` fails when run twice, you will lose up to **15 points** from the Schema Design category.

## Submission

1. Ensure all SQL files are in the `sql/` folder
2. Run `./verify.sh` locally to test your work before submitting
3. The GitHub Actions will run the same verification script
4. Commit and push to your repository
5. Submit the repository link on Canvas

## Testing Your Work Locally

Before submitting, run the verification script:

```bash
# Make sure Docker is running
docker-compose up -d

# Run the verification script via docker compose
docker-compose run --rm verify

# Or test manually - run schema twice to check idempotency:
docker-compose exec -T postgres psql -U postgres -d postgres -f sql/01_schema.sql
docker-compose exec -T postgres psql -U postgres -d postgres -f sql/01_schema.sql  # Should NOT fail!
docker-compose exec -T postgres psql -U postgres -d postgres -f sql/02_seed.sql
```

## Common Mistakes to Avoid

- Using `CREATE TABLE` without `IF NOT EXISTS` (not idempotent!)
- Using `CREATE SCHEMA` without `IF NOT EXISTS` (not idempotent!)
- Using INTEGER for monetary values (use DECIMAL)
- Forgetting NOT NULL on required fields
- Missing foreign key constraints
- Hardcoding dates instead of using relative dates
- Not handling NULL values in WHERE clauses
- Running DELETE before checking foreign key dependencies
- Forgetting the schema prefix (`neobank.`) on table names

