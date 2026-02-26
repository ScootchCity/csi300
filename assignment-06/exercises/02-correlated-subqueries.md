# Exercise 2: Correlated Subqueries and Comparison Operators (20 points)

## Learning Objectives

- Understand the difference between correlated and non-correlated subqueries
- Use EXISTS and NOT EXISTS effectively
- Apply ANY and ALL operators for comparisons
- Recognize performance implications of correlated subqueries

## Concept Overview

### Correlated vs Non-Correlated Subqueries

**Non-correlated subquery**: Executes once, independently of the outer query:

```sql
-- Same subquery result used for all rows
SELECT * FROM pets 
WHERE weight_kg > (SELECT AVG(weight_kg) FROM pets);
```

**Correlated subquery**: References the outer query and executes once per row:

```sql
-- Different calculation for each pet's species
SELECT p.pet_name, p.weight_kg
FROM pets p
WHERE p.weight_kg > (
    SELECT AVG(p2.weight_kg) 
    FROM pets p2 
    WHERE p2.species_id = p.species_id  -- References outer query
);
```

### EXISTS and NOT EXISTS

`EXISTS` returns TRUE if the subquery returns any rows:

```sql
-- Find owners who have at least one pet
SELECT o.first_name, o.last_name
FROM owners o
WHERE EXISTS (
    SELECT 1 
    FROM pets p 
    WHERE p.owner_id = o.owner_id
);
```

`NOT EXISTS` returns TRUE if the subquery returns NO rows:

```sql
-- Find owners with no pets
SELECT o.first_name, o.last_name
FROM owners o
WHERE NOT EXISTS (
    SELECT 1 
    FROM pets p 
    WHERE p.owner_id = o.owner_id
);
```

### ANY and ALL Operators

`ANY` (or `SOME`) - returns TRUE if comparison is true for ANY value:

```sql
-- Find pets heavier than ANY cat
SELECT pet_name, weight_kg
FROM pets
WHERE weight_kg > ANY (
    SELECT weight_kg FROM pets WHERE species_id = 2
);
```

`ALL` - returns TRUE if comparison is true for ALL values:

```sql
-- Find pets heavier than ALL cats
SELECT pet_name, weight_kg
FROM pets
WHERE weight_kg > ALL (
    SELECT weight_kg FROM pets WHERE species_id = 2
);
```

---

## Exercise Tasks

### Task 2.1: Correlated Subquery - Pet Rankings (4 points)

For each pet, show their weight ranking within their own species. Display:
- `pet_name`
- `species_name`
- `weight_kg`
- `weight_rank` (1 = heaviest in species, calculated using a correlated subquery to count heavier pets)

Order by species, then by weight rank.

Hint: Count how many pets of the same species weigh more, then add 1.

### Task 2.2: EXISTS - Active Vets (4 points)

Find all veterinarians (role = 'veterinarian') who have completed at least one appointment in 2024. Display:
- `staff_id`
- `first_name`
- `last_name`
- `specialization`

Use EXISTS, not a JOIN with DISTINCT.

### Task 2.3: NOT EXISTS - Species Without Vaccines (4 points)

Find all species that have NO vaccines defined for them in the vaccines table. Display:
- `species_id`
- `species_name`
- `category`

Use NOT EXISTS.

### Task 2.4: ANY Operator - Above Emergency Minimum (4 points)

Find invoices whose total is **greater than at least one** emergency clinic invoice. In other words: invoices that beat the *cheapest* emergency visit (since emergency visits tend to be expensive, this filters for the higher-priced invoices).

Display:
- `invoice_number`
- `total`
- `clinic_name` (from the appointment's clinic)

Exclude invoices from the emergency clinic itself (clinic_id = 4).
Order by total descending.

Hint: `> ANY (subquery)` is true when the value is greater than the **minimum** returned by the subquery.

### Task 2.5: ALL Operator - Top Performers (4 points)

Find staff members whose total number of treatments performed is greater than ALL receptionists' treatment counts (which should be 0 since receptionists don't perform treatments). 

More challenging: Find the vet(s) who have performed more treatments than ALL other individual vets. Display:
- `staff_id`
- `first_name`
- `last_name`
- `treatment_count`

Hint: Use a correlated subquery with ALL to compare each vet's count against all other vets' counts.

---

## Expected Output Hints

### Task 2.1
Each pet gets a rank within their species. Multiple pets can share the same rank if they have equal weights.

### Task 2.2
Should return veterinarians who saw patients in 2024 - likely 4-5 vets based on the data.

### Task 2.3
Returns species like reptiles, amphibians, or exotic pets that may not have specific vaccines in the system.

### Task 2.4
Returns the higher-priced invoices (non-emergency only) whose total exceeds the cheapest emergency visit. Expect a smaller result set since the bar is high.

### Task 2.5
The top-performing vet(s) - may return 1 or more if there are ties.

---

## Performance Note

Correlated subqueries execute once for each row in the outer query, which can be slow for large tables. In production, consider:
- Rewriting as JOINs when possible
- Using window functions (covered in advanced SQL)
- Ensuring proper indexing on correlated columns

---

## Submission

Save your solutions in `sql/exercise02.sql` with each task clearly labeled with comments.
