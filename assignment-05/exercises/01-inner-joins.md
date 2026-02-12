# Exercise 1: INNER JOINs (20 points)

## Learning Objectives
- Understand the fundamental concept of INNER JOIN
- Combine data from two tables based on matching values
- Select specific columns from multiple joined tables
- Use table aliases for cleaner query syntax

## Background

The `INNER JOIN` is the most common type of join in SQL. It returns only the rows where there is a match in both tables based on the join condition. If a row in one table doesn't have a corresponding match in the other table, that row is excluded from the result.

**Syntax:**
```sql
SELECT columns
FROM table1
INNER JOIN table2 ON table1.column = table2.column;
```

**Key Points:**
- The `ON` clause specifies the condition for matching rows
- Only matching rows from both tables appear in the result
- You can use table aliases (e.g., `FROM patients p`) for cleaner code
- Column names that exist in both tables must be qualified with the table name

## Schema Reference

For this exercise, you'll work primarily with these tables:
- `patients` - Patient demographic information
- `doctors` - Doctor information including department
- `departments` - Department names and descriptions
- `appointments` - Appointment records linking patients and doctors
- `specializations` - Medical specialty definitions
- `doctor_specializations` - Many-to-many relationship between doctors and specializations

## Problems

### Problem 1.1 (4 points)
**Basic Two-Table Join**

Write a query that returns all **completed** appointments with the patient's full name (first and last name combined as `patient_name`) and the doctor's full name (as `doctor_name`). Sort the results by the appointment date (`scheduled_at`) in descending order.

**Expected columns:** `patient_name`, `doctor_name`, `scheduled_at`, `visit_type`, `reason`

<details>
<summary>💡 Hint</summary>

You'll need to join three tables: `appointments`, `patients`, and `doctors`. Use `CONCAT()` or `||` to combine first and last names.

</details>

---

### Problem 1.2 (4 points)
**Join with Department Information**

Write a query that lists all doctors along with their department name and location. Include only doctors who are currently active (`is_active = true`). Order the results by department name, then by doctor's last name.

**Expected columns:** `doctor_name` (full name), `department_name`, `location`, `hire_date`

<details>
<summary>💡 Hint</summary>

Join `doctors` with `departments` using the `department_id` foreign key.

</details>

---

### Problem 1.3 (4 points)
**Many-to-Many Join**

Write a query that shows all doctors and their specializations. Each doctor may have multiple specializations, so a doctor might appear multiple times in the results. Include the certification date and whether each specialization is the doctor's primary specialty.

Order by doctor's last name, then by `is_primary` (primary first), then by specialization name.

**Expected columns:** `doctor_name`, `specialization_name`, `is_primary`, `certified_date`

<details>
<summary>💡 Hint</summary>

You'll need to join three tables: `doctors` → `doctor_specializations` → `specializations`. The junction table `doctor_specializations` connects doctors to their specializations.

</details>

---

### Problem 1.4 (4 points)
**Join with Filtering**

Write a query to find all appointments in the **Cardiology** department that occurred in **2024**. Include the patient name, doctor name, appointment date, and visit type.

**Expected columns:** `patient_name`, `doctor_name`, `scheduled_at`, `visit_type`, `reason`

<details>
<summary>💡 Hint</summary>

You need to join `appointments` → `doctors` → `departments` and filter by department name and year. Use `EXTRACT(YEAR FROM scheduled_at) = 2024` or a date range comparison.

</details>

---

### Problem 1.5 (4 points)
**Multiple Joins with Aggregation**

Write a query that counts the number of appointments each doctor has had, grouped by department. Show only departments with more than 5 total appointments across all their doctors.

**Expected columns:** `department_name`, `doctor_name`, `appointment_count`

Order by department name, then by appointment count descending.

<details>
<summary>💡 Hint</summary>

Join `departments` → `doctors` → `appointments`, then use `GROUP BY` on doctor level and `HAVING` to filter. You may need to calculate department totals using window functions or an additional aggregate.

</details>

---

## Submission

Save your solutions in `sql/01-inner-joins.sql`. Each solution should be clearly commented with the problem number.

```sql
-- Problem 1.1
-- Your solution here

-- Problem 1.2
-- Your solution here

-- (etc.)
```
