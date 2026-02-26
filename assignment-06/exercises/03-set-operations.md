# Exercise 3: Set Operations (20 points)

## Learning Objectives

- Understand and apply UNION and UNION ALL
- Use INTERSECT to find common elements
- Use EXCEPT to find differences between result sets
- Combine set operations with other SQL features

## Concept Overview

Set operations combine the results of two or more SELECT statements. The queries must be **union-compatible**:
- Same number of columns
- Compatible data types in corresponding positions

### UNION and UNION ALL

`UNION` combines results and removes duplicates:

```sql
SELECT first_name, last_name, 'Owner' AS role FROM owners
UNION
SELECT first_name, last_name, 'Staff' AS role FROM staff;
```

`UNION ALL` keeps all rows including duplicates (faster):

```sql
-- If you want to count all occurrences, use UNION ALL
SELECT pet_name FROM pets WHERE species_id = 1
UNION ALL
SELECT pet_name FROM pets WHERE weight_kg > 10;
```

### INTERSECT

Returns only rows that appear in BOTH result sets:

```sql
-- Find owners who are also registered as staff
SELECT first_name, last_name FROM owners
INTERSECT
SELECT first_name, last_name FROM staff;
```

### EXCEPT (MINUS in some databases)

Returns rows from the first query that are NOT in the second:

```sql
-- Find vaccines not yet given to any pet
SELECT vaccine_name FROM vaccines
EXCEPT
SELECT DISTINCT v.vaccine_name 
FROM vaccinations vc
JOIN vaccines v ON vc.vaccine_id = v.vaccine_id;
```

### Ordering Set Operations

You can only use ORDER BY at the end:

```sql
SELECT first_name FROM owners
UNION
SELECT first_name FROM staff
ORDER BY first_name;  -- Applies to the combined result
```

---

## Exercise Tasks

### Task 3.1: UNION - Contact Directory (4 points)

Create a combined contact directory of all owners and staff members. Display:
- `full_name` (first name + last name)
- `email`
- `phone`
- `contact_type` ('Owner' or 'Staff')

Use UNION to combine and remove any duplicate entries.
Order by contact_type, then by full_name.

### Task 3.2: UNION ALL - Appointment Timeline (4 points)

Create a timeline of all appointment-related events in 2024. Include:
1. When appointments were created (scheduled)
2. When appointments actually occurred (completed)

Display:
- `event_date` (created_at for scheduled, scheduled_at for completed)
- `event_type` ('Scheduled' or 'Completed')
- `pet_name`
- `clinic_name`

Use UNION ALL since the same appointment can appear twice.
Order by event_date.

### Task 3.3: INTERSECT - Multi-Clinic Pets (4 points)

Find pets that have visited BOTH the Burlington Downtown clinic (clinic_id = 1) AND the Williston branch (clinic_id = 3). 

Display:
- `pet_name`
- `species_name`
- `owner_name` (full name)

Use INTERSECT to find pets appearing in both clinic's appointment lists.

### Task 3.4: EXCEPT - Unused Procedures (4 points)

Find procedures that have NEVER been used in any treatment. Display:
- `procedure_name`
- `category`
- `base_price`

Use EXCEPT to find procedures not in the treatments table.
Order by category, then procedure_name.

### Task 3.5: Complex Set Operations (4 points)

Create a report showing medication usage patterns:

**Part A**: Find medications that have been prescribed but were NEVER given as part of a treatment.

**Part B**: Find medications that have been used in treatments but NEVER prescribed (given during visit only).

Combine both results with a label indicating which category they fall into.

Display:
- `medication_name`
- `category`
- `usage_pattern` ('Prescription Only' or 'Treatment Only')

Use a combination of EXCEPT and UNION.

---

## Expected Output Hints

### Task 3.1
Should return 90+ contacts (50 owners + 45 staff, minus any duplicates).

### Task 3.2
Should return a large timeline with both scheduling and completion events for 2024 appointments.

### Task 3.3
Pets that visited multiple clinics - should be a small number (maybe 2-4 pets).

### Task 3.4
Procedures never used - likely some specialized procedures in the catalog that haven't been performed.

### Task 3.5
Shows the difference between standing prescriptions and in-clinic treatments.

---

## Key Differences Summary

| Operation | Removes Duplicates | Description |
|-----------|-------------------|-------------|
| UNION | Yes | Combines unique rows from both sets |
| UNION ALL | No | Combines all rows, including duplicates |
| INTERSECT | Yes | Only rows appearing in both sets |
| EXCEPT | Yes | Rows in first set not in second set |

---

## Submission

Save your solutions in `sql/exercise03.sql` with each task clearly labeled with comments.
