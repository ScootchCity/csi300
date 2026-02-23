# Exercise 3: RIGHT and FULL OUTER JOINs (20 points)

## Learning Objectives
- Understand when to use RIGHT OUTER JOIN vs LEFT OUTER JOIN
- Apply FULL OUTER JOIN to find all unmatched records from both tables
- Recognize that RIGHT JOIN can always be rewritten as LEFT JOIN
- Identify data integrity issues using FULL OUTER JOIN

## Background

### RIGHT OUTER JOIN

A `RIGHT OUTER JOIN` returns **all rows from the right table** and the matching rows from the left table. It's the mirror image of LEFT JOIN.

```sql
SELECT columns
FROM table_a
RIGHT JOIN table_b ON table_a.column = table_b.column;
```

**Note:** Any RIGHT JOIN can be rewritten as a LEFT JOIN by swapping the table order. Most SQL developers prefer LEFT JOIN for consistency.

### FULL OUTER JOIN

A `FULL OUTER JOIN` returns **all rows from both tables**, with NULL values where there's no match on either side.

```sql
SELECT columns
FROM table_a
FULL OUTER JOIN table_b ON table_a.column = table_b.column;
```

**Use Cases for FULL OUTER JOIN:**
- Comparing two data sets for differences
- Finding orphaned records on both sides
- Data reconciliation between systems
- Identifying missing relationships in either direction

## Schema Reference

Key tables for this exercise:
- `departments` - All clinic departments
- `doctors` - Doctors assigned to departments
- `specializations` - Medical specialties
- `doctor_specializations` - Doctors with certifications
- `insurance_providers` - Insurance companies
- `patients` - Patient records with insurance links

## Problems

### Problem 3.1 (4 points)
**RIGHT JOIN: All Departments with Doctor Counts**

Using a RIGHT JOIN, write a query that shows **all departments** and the count of doctors in each department. Departments with no doctors should show a count of 0.

Note: This could easily be written as a LEFT JOIN with tables swapped—practice both approaches mentally.

**Expected columns:** `department_name`, `location`, `doctor_count`

Order by doctor count descending, then by department name.

<details>
<summary>💡 Hint</summary>

RIGHT JOIN from `doctors` to `departments`, then use COUNT with a GROUP BY. Remember that COUNT(column) doesn't count NULLs, so use COUNT(doctors.id) instead of COUNT(*).

</details>

---

### Problem 3.2 (4 points)
**RIGHT JOIN: Specializations with Certified Doctors**

Using a RIGHT JOIN, list **all specializations** and the doctors certified in each one. Include specializations that have no certified doctors. For specializations without doctors, show 'No certified doctors' in the doctor name column.

**Expected columns:** `specialization_name`, `category`, `doctor_name` (or 'No certified doctors')

Order by category, then specialization name.

<details>
<summary>💡 Hint</summary>

Use RIGHT JOIN from `doctors` through `doctor_specializations` to `specializations`. Use COALESCE or CASE to handle NULL doctor names.

</details>

---

### Problem 3.3 (4 points)
**FULL OUTER JOIN: Insurance Provider Coverage Analysis**

Write a query using FULL OUTER JOIN to analyze the relationship between insurance providers and patients. Find:
1. Insurance providers with no patients enrolled
2. Patients with no insurance (already covered, but include for completeness)
3. Insurance providers with patients

Create a `relationship_status` column that indicates:
- 'Provider has no patients' when provider exists but no patients
- 'Patient is uninsured' when patient exists but no provider
- 'Active relationship' when both exist

**Expected columns:** `provider_name`, `patient_name`, `relationship_status`

Order by relationship status, then by provider name.

<details>
<summary>💡 Hint</summary>

FULL OUTER JOIN `insurance_providers` with `patients` on `insurance_id`. Use a CASE statement to determine the status based on which side has NULLs.

</details>

---

### Problem 3.4 (4 points)
**FULL OUTER JOIN: Department-Specialization Coverage**

Using FULL OUTER JOIN, create a query that shows how departments and specializations relate to each other. Each specialization has a `category` column that corresponds to a department name (e.g., category 'Cardiology' maps to the Cardiology department).

Join `departments` and `specializations` on `specializations.category = departments.name` to see which departments have specializations and list all matches.

**Expected columns:** `department_name`, `specialization_name`, `category`

Order by department name, then by specialization name.

<details>
<summary>💡 Hint</summary>

Use: `FULL OUTER JOIN specializations s ON s.category = d.name`. Since every specialization category maps to a department in this dataset, you won't see unmatched rows—but the FULL OUTER JOIN ensures they would appear if the data changed.

</details>

---

### Problem 3.5 (4 points)
**Data Reconciliation: Insurance Claims Check**

Write a query to identify potential data issues between appointments and insurance claims. Use FULL OUTER JOIN to find:

1. Appointments that should have claims but don't (completed appointments with insured patients but no claim)
2. Claims that reference appointments (normal case)

Focus on **completed** appointments only. Show the appointment ID, patient name, whether a claim exists, and flag any issues.

**Expected columns:** `appointment_id`, `patient_name`, `has_claim`, `claim_status`, `issue_flag`

Where `issue_flag` is 'Missing claim' if a completed appointment for an insured patient has no claim record.

<details>
<summary>💡 Hint</summary>

Join `appointments` with `claims` on `appointment_id`. Also join `patients` to check insurance status. Use CASE to flag issues where appointments are completed, patient has insurance, but claim is NULL.

</details>

---

## Submission

Save your solutions in `sql/03-right-full-joins.sql`. Each solution should be clearly commented with the problem number.

```sql
-- Problem 3.1
-- Your solution here

-- Problem 3.2
-- Your solution here

-- (etc.)
```
