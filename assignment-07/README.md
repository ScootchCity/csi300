# Assignment 7: Schema Patterns, Functions & Transactions

## PrecisionParts Manufacturing Co.

![Manufacturing](https://images.unsplash.com/photo-1565043666747-69f6646db940?w=800)

## Overview

**PrecisionParts Manufacturing Co.** is a modern precision manufacturing facility that produces custom machined parts for aerospace, automotive, and medical device industries. They need a robust database system that implements enterprise-grade data integrity patterns.

In this assignment, you will work with a pre-built manufacturing database that includes:
- **Parts Catalog** with versioning and soft-delete
- **Materials & Inventory** tracking with audit trails
- **Production Orders** with workflow status management
- **Machines & Maintenance** schedules
- **Quality Control** inspections and defect tracking
- **Employees** with role-based access patterns

## Learning Objectives

By completing this assignment, you will:
1. Implement and query **soft-delete patterns** for data recovery
2. Create **SQL functions** for business logic encapsulation
3. Build **stored procedures** for complex operations
4. Design **triggers** for automatic audit trails
5. Use **transactions** to ensure data integrity
6. Understand **access control** with GRANT/REVOKE
7. *(Bonus)* Apply **Drizzle ORM** for type-safe database access

## Database Schema

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        PrecisionParts Manufacturing                              │
└─────────────────────────────────────────────────────────────────────────────────┘

┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│    materials     │     │   part_versions  │     │      parts       │
├──────────────────┤     ├──────────────────┤     ├──────────────────┤
│ id (PK)          │     │ id (PK)          │     │ id (PK)          │
│ name             │     │ part_id (FK)     │────▶│ part_number      │
│ type             │     │ version          │     │ name             │
│ unit_cost        │     │ specifications   │     │ current_version  │
│ stock_quantity   │     │ created_at       │     │ category         │
│ reorder_level    │     │ created_by (FK)  │     │ deleted_at ◄─────│── Soft Delete
│ deleted_at       │     └──────────────────┘     │ created_at       │
└──────────────────┘                              └──────────────────┘
        │                                                  │
        │                                                  │
        ▼                                                  ▼
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│  part_materials  │     │ production_orders│     │ order_items      │
├──────────────────┤     ├──────────────────┤     ├──────────────────┤
│ part_id (FK)     │     │ id (PK)          │     │ id (PK)          │
│ material_id (FK) │     │ order_number     │     │ order_id (FK)    │
│ quantity_needed  │     │ status           │     │ part_id (FK)     │
└──────────────────┘     │ priority         │     │ quantity         │
                         │ due_date         │     │ unit_price       │
                         │ created_by (FK)  │     └──────────────────┘
                         └──────────────────┘
                                  │
                                  ▼
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│    machines      │     │ production_runs  │     │ quality_checks   │
├──────────────────┤     ├──────────────────┤     ├──────────────────┤
│ id (PK)          │◀────│ machine_id (FK)  │     │ id (PK)          │
│ name             │     │ order_id (FK)    │     │ run_id (FK)      │
│ type             │     │ operator_id (FK) │     │ inspector_id (FK)│
│ status           │     │ quantity_produced│     │ result           │
│ maintenance_due  │     │ start_time       │     │ defects_found    │
│ deleted_at       │     │ end_time         │     │ notes            │
└──────────────────┘     └──────────────────┘     └──────────────────┘
                                  │
                                  │
                                  ▼
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│   employees      │     │   audit_log      │     │  inventory_log   │
├──────────────────┤     ├──────────────────┤     ├──────────────────┤
│ id (PK)          │     │ id (PK)          │     │ id (PK)          │
│ employee_number  │     │ table_name       │     │ material_id (FK) │
│ first_name       │     │ record_id        │     │ change_type      │
│ last_name        │     │ action           │     │ quantity_change  │
│ role             │     │ old_data (JSONB) │     │ reason           │
│ department       │     │ new_data (JSONB) │     │ performed_by (FK)│
│ is_active        │     │ performed_by (FK)│     │ created_at       │
│ deleted_at       │     │ performed_at     │     └──────────────────┘
└──────────────────┘     └──────────────────┘
```

## Getting Started

### Prerequisites
- Docker and Docker Compose installed
- Node.js 18+ (optional, for Drizzle ORM bonus exercise)
- A SQL client (Adminer is included, or use your preferred tool)

### Setup

1. **Navigate to the assignment directory:**
   ```bash
   cd 07-schema-patterns/assignment
   ```

2. **Start the database:**
   ```bash
   docker-compose up -d
   ```

3. **Access the database:**
   - **Adminer (Web UI):** http://localhost:8080
     - System: PostgreSQL
     - Server: postgres
     - Username: postgres
     - Password: postgres
     - Database: postgres
   - **Direct connection:** `postgresql://postgres:postgres@localhost:5432/postgres`

4. **Install Node.js dependencies (optional, for Bonus Exercise 5):**
   ```bash
   cd drizzle
   npm install
   ```

### Stopping the Environment

```bash
docker-compose down        # Stop containers
docker-compose down -v     # Stop and remove data volumes
```

## Exercises

| Exercise | Topic | Points |
|----------|-------|--------|
| [Exercise 1](exercises/01-soft-delete.md) | Soft Delete Patterns | 15 |
| [Exercise 2](exercises/02-functions.md) | SQL Functions | 20 |
| [Exercise 3](exercises/03-triggers.md) | Triggers & Audit Trails | 20 |
| [Exercise 4](exercises/04-transactions.md) | Transactions & ACID | 25 |
| [Bonus Exercise 5](exercises/05-drizzle-orm.md) | Drizzle ORM Integration | **+20 bonus** |
| **Total (required)** | | **80** |

## Submission

1. Complete all exercises in the `sql/` directory
2. *(Optional bonus)* Complete the Drizzle ORM exercise in `drizzle/src/`
3. Run `docker-compose run --rm verify` to validate your solutions
4. Commit and push your changes to GitHub

## Grading Rubric

| Criteria | Points |
|----------|--------|
| Soft-delete queries work correctly | 15 |
| Functions return expected results | 20 |
| Triggers properly maintain audit logs | 20 |
| Transactions handle rollback scenarios | 25 |
| Drizzle ORM queries are type-safe and functional | **Bonus 20** |
| Code is well-formatted and commented | Bonus 5 |

## Resources

- [Drizzle ORM Documentation](https://orm.drizzle.team/)
- [PostgreSQL Functions Documentation](https://www.postgresql.org/docs/current/sql-createfunction.html)
