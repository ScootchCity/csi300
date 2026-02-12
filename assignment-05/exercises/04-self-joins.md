# Exercise 4: Self-Joins and Cross Joins (20 points)

## Learning Objectives
- Understand how to join a table to itself (self-join)
- Navigate hierarchical data structures using self-joins
- Apply CROSS JOIN for generating combinations
- Recognize appropriate use cases for each join type

## Background

### Self-Join

A **self-join** is when a table is joined with itself. This is useful for:
- Hierarchical data (employees → managers)
- Comparing rows within the same table
- Finding related records in the same table

```sql
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

**Key Points:**
- You MUST use different aliases for the two "copies" of the table
- Think of it as if you have two copies of the same table

### Cross Join

A `CROSS JOIN` produces the **Cartesian product** of two tables—every row from the first table paired with every row from the second table.

```sql
SELECT *
FROM table_a
CROSS JOIN table_b;
-- Results: (rows in A) × (rows in B) rows
```

**Use Cases:**
- Generating all possible combinations
- Creating date/time scaffolds
- Pairing all items for comparison
- Test data generation

⚠️ **Warning:** Cross joins can produce very large result sets. Always use with care!

## Schema Reference

The `doctors` table has a hierarchical structure:
- `supervisor_id` references another doctor's `id`
- The Chief Medical Officer (CMO) has `supervisor_id = NULL`
- Department heads report to the CMO
- Senior doctors report to department heads
- Staff doctors report to senior doctors

## Problems

### Problem 4.1 (4 points)
**Basic Self-Join: Doctor-Supervisor Pairs**

Write a query that shows each doctor along with their direct supervisor's name. Doctors without supervisors (like the CMO) should still appear with NULL for the supervisor name.

**Expected columns:** `doctor_name`, `doctor_title`, `supervisor_name`, `supervisor_title`

Order by supervisor name (NULLs first), then by doctor name.

<details>
<summary>💡 Hint</summary>

Use a LEFT JOIN from `doctors d` to `doctors s` (supervisor) where `d.supervisor_id = s.id`.

</details>

---

### Problem 4.2 (4 points)
**Organizational Hierarchy: Multiple Levels**

Write a query that shows the full reporting chain for each doctor, up to 3 levels:
- The doctor themselves
- Their direct supervisor (Level 1)
- Their supervisor's supervisor (Level 2)
- Their supervisor's supervisor's supervisor (Level 3)

This will reveal the organizational structure of MedCare.

**Expected columns:** `doctor_name`, `level_1_supervisor`, `level_2_supervisor`, `level_3_supervisor`

Order by the number of supervisors in the chain (doctors with fewer supervisors first).

<details>
<summary>💡 Hint</summary>

Use multiple LEFT JOINs:
```sql
FROM doctors d
LEFT JOIN doctors l1 ON d.supervisor_id = l1.id
LEFT JOIN doctors l2 ON l1.supervisor_id = l2.id
LEFT JOIN doctors l3 ON l2.supervisor_id = l3.id
```

</details>

---

### Problem 4.3 (4 points)
**Self-Join: Counting Direct Reports**

Write a query that shows how many direct reports each supervisor has. Include doctors who have no direct reports (show 0). Only include active doctors.

**Expected columns:** `supervisor_name`, `title`, `department_name`, `direct_report_count`

Order by direct report count descending, then by supervisor name.

<details>
<summary>💡 Hint</summary>

Join `doctors` to itself where one is the supervisor of the other. Use LEFT JOIN to include doctors with no reports. GROUP BY the supervisor and COUNT the reports.

</details>

---

### Problem 4.4 (4 points)
**Cross Join: Department-Specialization Combinations**

Using a CROSS JOIN, generate all possible combinations of departments and specialization categories. This could be used to analyze which specialty categories are represented in which departments.

Then, join with the doctors and specializations tables to count how many doctors actually have each department-category pairing.

**Expected columns:** `department_name`, `specialization_category`, `doctor_count`

Order by department name, then by category.

<details>
<summary>💡 Hint</summary>

```sql
SELECT d.name, sc.category, COUNT(...)
FROM departments d
CROSS JOIN (SELECT DISTINCT category FROM specializations) sc
LEFT JOIN doctors doc ON doc.department_id = d.id
LEFT JOIN doctor_specializations ds ON ds.doctor_id = doc.id
LEFT JOIN specializations s ON s.id = ds.specialization_id AND s.category = sc.category
GROUP BY d.name, sc.category
```

</details>

---

### Problem 4.5 (4 points)
**Self-Join: Finding Peer Doctors**

Write a query to find "peer" doctors—doctors who share the same supervisor (i.e., they're at the same level in the hierarchy). For each doctor, list one of their peers. Don't pair a doctor with themselves.

**Expected columns:** `doctor_name`, `peer_name`, `shared_supervisor`

Order by shared supervisor name, then by doctor name.

<details>
<summary>💡 Hint</summary>

Self-join `doctors` twice: once as `d1` and once as `d2`, where `d1.supervisor_id = d2.supervisor_id` AND `d1.id < d2.id` (to avoid duplicates and self-pairs).

</details>

---

## Submission

Save your solutions in `sql/04-self-joins.sql`. Each solution should be clearly commented with the problem number.

```sql
-- Problem 4.1
-- Your solution here

-- Problem 4.2
-- Your solution here

-- (etc.)
```
