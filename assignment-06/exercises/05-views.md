# Exercise 5: Views and Materialized Views (20 points)

## Learning Objectives

- Create and use views for query abstraction
- Understand updatable vs read-only views
- Implement materialized views for performance
- Apply appropriate refresh strategies

## Concept Overview

### What is a View?

A view is a virtual table based on a SELECT query. It doesn't store data itself - it runs the query each time it's accessed.

```sql
CREATE VIEW active_pets_summary AS
SELECT 
    p.pet_id,
    p.pet_name,
    s.species_name,
    o.first_name || ' ' || o.last_name AS owner_name
FROM pets p
JOIN species s ON p.species_id = s.species_id
JOIN owners o ON p.owner_id = o.owner_id
WHERE p.is_active = true;
```

### Using Views

```sql
-- Query it like a table
SELECT * FROM active_pets_summary WHERE species_name = 'Dog';

-- Join with other tables
SELECT aps.pet_name, a.scheduled_at
FROM active_pets_summary aps
JOIN appointments a ON aps.pet_id = a.pet_id;
```

### Updatable Views

Simple views can allow INSERT, UPDATE, DELETE:

```sql
CREATE VIEW owner_contact_info AS
SELECT owner_id, first_name, last_name, email, phone
FROM owners;

-- This can work if the view is simple enough
UPDATE owner_contact_info 
SET phone = '555-0199' 
WHERE owner_id = 1;
```

### WITH CHECK OPTION

Ensures modifications through the view still satisfy the view's WHERE clause:

```sql
CREATE VIEW vermont_owners AS
SELECT * FROM owners WHERE state = 'VT'
WITH CHECK OPTION;

-- This would fail because the new row wouldn't be in the view
INSERT INTO vermont_owners (first_name, last_name, state) 
VALUES ('Test', 'User', 'NY');  -- Error!
```

### Materialized Views

A materialized view stores the query results physically:

```sql
CREATE MATERIALIZED VIEW monthly_revenue_summary AS
SELECT 
    DATE_TRUNC('month', created_at) AS month,
    clinic_id,
    SUM(total) AS total_revenue,
    COUNT(*) AS invoice_count
FROM invoices
GROUP BY DATE_TRUNC('month', created_at), clinic_id;
```

### Refreshing Materialized Views

```sql
-- Full refresh (locks the view during refresh)
REFRESH MATERIALIZED VIEW monthly_revenue_summary;

-- Concurrent refresh (requires unique index, allows reads during refresh)
REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_revenue_summary;
```

---

## Exercise Tasks

### Task 5.1: Create Basic Views (4 points)

Create the following views:

**View A: `v_pet_directory`**
A comprehensive pet directory showing:
- `pet_id`, `pet_name`, `species_name`, `breed`
- `owner_name` (full name)
- `owner_email`, `owner_phone`
- `primary_clinic` (clinic name where most appointments occurred)

**View B: `v_staff_directory`**
A staff directory showing:
- `staff_id`, `full_name`, `role`, `specialization`
- `clinic_name`
- `email`, `phone`
- `manager_name` (their manager's full name, NULL if none)

### Task 5.2: Create Updatable View (4 points)

Create an updatable view called `v_owner_updates` that allows updating owner contact information. Include:
- `owner_id`
- `first_name`, `last_name`
- `email`, `phone`
- `address`, `city`, `state`, `zip_code`

Test your view by:
1. Running a SELECT to verify it works
2. Writing an UPDATE statement (you don't have to execute it) that would change an owner's phone number
3. Explain in a comment why this view is updatable

### Task 5.3: View with CHECK OPTION (4 points)

Create a view called `v_active_appointments` for scheduling staff that:
- Shows only appointments with status 'scheduled' or 'confirmed'
- Includes: `appointment_id`, `pet_name`, `owner_phone`, `vet_name`, `clinic_name`, `scheduled_at`, `status`

Use WITH CHECK OPTION and explain in a comment what would happen if someone tried to update an appointment's status to 'completed' through this view.

### Task 5.4: Materialized View for Performance (4 points)

Create a materialized view called `mv_clinic_performance` that pre-calculates clinic metrics. Include:
- `clinic_id`, `clinic_name`
- `total_appointments` (all time)
- `completed_appointments`
- `cancellation_rate` (percentage)
- `total_revenue`
- `avg_invoice_amount`
- `unique_patients` (distinct pets seen)
- `unique_vets` (distinct vets who worked there)

After creating the view, create a unique index on `clinic_id` to allow concurrent refresh.

Write the REFRESH command for this view.

### Task 5.5: Comparing Regular vs Materialized Views (4 points)

**Part A**: Create a regular view called `v_vet_productivity` and a materialized view called `mv_vet_productivity` with the same content:

- `vet_id`, `vet_name`
- `total_appointments`
- `total_treatments`
- `total_prescriptions`
- `avg_appointments_per_month`
- `most_common_procedure` (the procedure they perform most)

**Part B**: In SQL comments, explain:
1. When would you choose the regular view over the materialized view?
2. When would you choose the materialized view?
3. How would you keep the materialized view up-to-date in a production system?

---

## Expected Output Hints

### Task 5.1
`v_pet_directory` should return ~55 rows (one per pet).
`v_staff_directory` should return ~45 rows (one per staff member).

### Task 5.2
The updatable view should allow changes to contact fields but not structural changes.

### Task 5.3
With CHECK OPTION, attempts to change status to anything other than 'scheduled' or 'confirmed' will fail.

### Task 5.4
`mv_clinic_performance` should return 5 rows (one per clinic) with aggregated metrics.

### Task 5.5
Both views should return the same data, but with different performance characteristics.

---

## View Management Commands

```sql
-- List all views
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_type = 'VIEW';

-- View definition
SELECT pg_get_viewdef('v_pet_directory', true);

-- Drop view
DROP VIEW IF EXISTS v_pet_directory;

-- Drop materialized view
DROP MATERIALIZED VIEW IF EXISTS mv_clinic_performance;

-- Check if materialized view needs refresh
SELECT relname, last_vacuum, last_analyze 
FROM pg_stat_user_tables;
```

---

## Submission

Save your solutions in `sql/exercise05.sql` with each task clearly labeled with comments.
