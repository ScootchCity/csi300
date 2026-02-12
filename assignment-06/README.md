# Assignment 6: Subqueries, CTEs & Views

## Overview

In this assignment, you'll work with **PawCare Veterinary Clinic's** database system. PawCare is a multi-location veterinary practice that manages pet health records, appointments, treatments, prescriptions, and billing. Unlike previous assignments where you built the schema, here you'll query an existing database to extract complex insights using advanced SQL techniques.

## Learning Objectives

By completing this assignment, you will:
- Write scalar and table subqueries
- Use subqueries with IN, EXISTS, ANY, and ALL operators
- Distinguish between correlated and non-correlated subqueries
- Apply set operations (UNION, INTERSECT, EXCEPT)
- Create Common Table Expressions (CTEs) for readable queries
- Implement recursive CTEs for hierarchical data
- Design and query Views and Materialized Views

## Database Schema

The PawCare database contains the following tables:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│     owners      │     │      pets       │     │    species      │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ owner_id (PK)   │◄────│ owner_id (FK)   │     │ species_id (PK) │
│ first_name      │     │ pet_id (PK)     │────►│ name            │
│ last_name       │     │ species_id (FK) │     │ category        │
│ email           │     │ breed           │     └─────────────────┘
│ phone           │     │ name            │
│ address         │     │ date_of_birth   │
│ city            │     │ weight_kg       │
│ registered_at   │     │ is_neutered     │
└─────────────────┘     │ microchip_id    │
                        │ created_at      │
                        └────────┬────────┘
                                 │
        ┌────────────────────────┼────────────────────────┐
        │                        │                        │
        ▼                        ▼                        ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  appointments   │     │ medical_records │     │  vaccinations   │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ appointment_id  │     │ record_id (PK)  │     │ vaccination_id  │
│ pet_id (FK)     │     │ pet_id (FK)     │     │ pet_id (FK)     │
│ vet_id (FK)     │     │ vet_id (FK)     │     │ vaccine_id (FK) │
│ clinic_id (FK)  │     │ appointment_id  │     │ administered_by │
│ scheduled_at    │     │ visit_date      │     │ administered_at │
│ duration_mins   │     │ chief_complaint │     │ next_due_date   │
│ status          │     │ diagnosis       │     │ batch_number    │
│ visit_type      │     │ notes           │     └─────────────────┘
│ created_at      │     │ weight_kg       │
└─────────────────┘     │ temperature_f   │     ┌─────────────────┐
                        │ created_at      │     │    vaccines     │
┌─────────────────┐     └────────┬────────┘     ├─────────────────┤
│     staff       │              │              │ vaccine_id (PK) │
├─────────────────┤              │              │ name            │
│ staff_id (PK)   │              │              │ manufacturer    │
│ first_name      │              ▼              │ species_id (FK) │
│ last_name       │     ┌─────────────────┐     │ validity_months │
│ role            │     │   treatments    │     └─────────────────┘
│ specialization  │     ├─────────────────┤
│ license_number  │     │ treatment_id    │     ┌─────────────────┐
│ email           │     │ record_id (FK)  │     │   medications   │
│ phone           │     │ procedure_id    │     ├─────────────────┤
│ hire_date       │     │ medication_id   │     │ medication_id   │
│ salary          │     │ quantity        │     │ name            │
│ reports_to (FK) │     │ unit_price      │     │ category        │
│ clinic_id (FK)  │     │ notes           │     │ unit            │
│ is_active       │     └─────────────────┘     │ unit_price      │
└─────────────────┘                             │ requires_rx     │
                        ┌─────────────────┐     │ stock_quantity  │
┌─────────────────┐     │   procedures    │     └─────────────────┘
│    clinics      │     ├─────────────────┤
├─────────────────┤     │ procedure_id    │     ┌─────────────────┐
│ clinic_id (PK)  │     │ name            │     │    invoices     │
│ name            │     │ category        │     ├─────────────────┤
│ address         │     │ base_price      │     │ invoice_id (PK) │
│ city            │     │ duration_mins   │     │ owner_id (FK)   │
│ state           │     │ requires_anesthesia│  │ record_id (FK)  │
│ phone           │     └─────────────────┘     │ invoice_date    │
│ email           │                             │ subtotal        │
│ opens_at        │                             │ tax_amount      │
│ closes_at       │                             │ discount_amount │
└─────────────────┘                             │ total_amount    │
                                                │ status          │
                                                │ paid_at         │
                                                └─────────────────┘
```

## Getting Started

### Prerequisites
- Docker and Docker Compose installed
- Terminal access (bash, PowerShell, or similar)

### Setup Instructions

1. Navigate to the assignment directory:
   ```bash
   cd databases/06-subqueries-ctes-views/assignment
   ```

2. Start the database:
   ```bash
   docker-compose up -d
   ```

3. Wait for initialization (~30 seconds), then verify:
   ```bash
   docker-compose logs pawcare-db
   ```

4. Access the database:
   - **Adminer** (Web UI): http://localhost:8080
     - System: PostgreSQL
     - Server: postgres
     - Username: postgres
     - Password: postgres
     - Database: postgres
   
   - **psql** (Command line):
     ```bash
     docker-compose exec postgres psql -U postgres -d postgres
     ```

### Port Configuration

| Service | Port | Purpose |
|---------|------|---------|
| PostgreSQL | 5432 | Database connections |
| Adminer | 8080 | Web-based SQL interface |

> **Note:** These ports differ from previous assignments to allow running multiple databases simultaneously.

## Exercises

Complete all 5 exercises for a total of 100 points.

| Exercise | Topic | Points |
|----------|-------|--------|
| [Exercise 1](exercises/01-subqueries-basics.md) | Subqueries: Scalar and Table | 20 |
| [Exercise 2](exercises/02-correlated-subqueries.md) | Correlated Subqueries & EXISTS | 20 |
| [Exercise 3](exercises/03-set-operations.md) | Set Operations: UNION, INTERSECT, EXCEPT | 20 |
| [Exercise 4](exercises/04-ctes.md) | Common Table Expressions (CTEs) | 20 |
| [Exercise 5](exercises/05-views.md) | Views and Materialized Views | 20 |

## Submission

1. Create your SQL files in the `sql/` directory following the naming convention
2. Test your queries against the running database
3. Run the verification script via docker compose:
   ```bash
   docker-compose run --rm verify
   ```
4. Submit your `sql/` directory

## Grading Rubric

| Criteria | Points |
|----------|--------|
| **Correctness** | 60 |
| Queries return expected results | 40 |
| Proper use of subquery/CTE/view syntax | 20 |
| **Code Quality** | 25 |
| Readable formatting and indentation | 10 |
| Appropriate use of aliases | 10 |
| Comments explaining complex logic | 5 |
| **Efficiency** | 15 |
| Appropriate subquery type selection | 10 |
| Avoiding unnecessary complexity | 5 |

## Common Mistakes to Avoid

1. **Confusing correlated and non-correlated subqueries** — Correlated subqueries reference the outer query and execute once per row
2. **Using subqueries where JOINs are clearer** — Sometimes a JOIN is more readable
3. **Forgetting column aliases in CTEs** — CTE column lists must match the SELECT
4. **UNION vs UNION ALL** — UNION removes duplicates (slower), UNION ALL keeps all rows
5. **Not refreshing materialized views** — Data becomes stale without REFRESH

## Resources

- [PostgreSQL Subquery Documentation](https://www.postgresql.org/docs/current/functions-subquery.html)
- [PostgreSQL WITH Queries (CTEs)](https://www.postgresql.org/docs/current/queries-with.html)
- [PostgreSQL CREATE VIEW](https://www.postgresql.org/docs/current/sql-createview.html)
- [PostgreSQL Materialized Views](https://www.postgresql.org/docs/current/sql-creatematerializedview.html)

## Cleanup

When finished, stop and remove containers:
```bash
docker-compose down -v
```
