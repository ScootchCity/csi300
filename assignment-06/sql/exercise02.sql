-- =============================================================================
-- Exercise 2: Correlated Subqueries and Comparison Operators
-- PawCare Veterinary Clinic
-- =============================================================================

-- Task 2.1: Correlated Subquery - Pet Rankings (4 points)
-- Show each pet's weight ranking within their species
-- Return: pet_name, species_name, weight_kg, weight_rank
-- Filter: Only pets with weight recorded
-- Order by: species_name, weight_rank
-- Tables: pets, species
-- Tip: Rank = COUNT(*) + 1 of pets with greater weight in same species
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    p.pet_name,
    s.species_name,
    p.weight_kg,
    (
        SELECT COUNT(*)
        FROM pets p2
        WHERE p2.species_id = p.species_id
          AND p2.weight_kg > p.weight_kg
          AND p2.weight_kg IS NOT NULL
    ) + 1 AS weight_rank
FROM pets p
JOIN species s ON p.species_id = s.species_id
WHERE p.weight_kg IS NOT NULL
ORDER BY s.species_name, weight_rank;

-- Task 2.2: EXISTS - Active Vets (4 points)
-- Find veterinarians who completed at least one appointment in 2024
-- Return: staff_id, first_name, last_name, specialization
-- Filter: role = 'veterinarian'
-- Tables: staff, appointments
-- Tip: WHERE EXISTS (SELECT 1 FROM appointments WHERE vet_id = s.staff_id AND ...)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    s.specialization
FROM staff s
WHERE s.role = 'veterinarian'
  AND EXISTS (
      SELECT 1
      FROM appointments a
      WHERE a.vet_id = s.staff_id
        AND a.status = 'completed'
        AND EXTRACT(YEAR FROM a.scheduled_at) = 2024
  );

-- Task 2.3: NOT EXISTS - Species Without Vaccines (4 points)
-- Find species that have no vaccines defined
-- Return: species_id, species_name, category
-- Tables: species, vaccines
-- Tip: WHERE NOT EXISTS (SELECT 1 FROM vaccines WHERE species_id = s.species_id)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    s.species_id,
    s.species_name,
    s.category
FROM species s
WHERE NOT EXISTS (
    SELECT 1
    FROM vaccines v
    WHERE v.species_id = s.species_id
);

-- Task 2.4: ANY Operator - Above Emergency Minimum (4 points)
-- Find invoices greater than at least one emergency clinic invoice (i.e., > min emergency total)
-- Return: invoice_number, total, clinic_name
-- Filter: Exclude emergency clinic (clinic_id = 4) from results
-- Order by: total descending
-- Tables: invoices, appointments, clinics
-- Tip: WHERE total > ANY (SELECT total FROM invoices WHERE clinic_id = 4)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    i.invoice_number,
    i.total,
    c.clinic_name
FROM invoices i
JOIN medical_records mr ON i.record_id = mr.record_id
JOIN appointments a      ON mr.appointment_id = a.appointment_id
JOIN clinics c           ON a.clinic_id = c.clinic_id
WHERE a.clinic_id != 4
  AND i.total > ANY (
      SELECT i2.total
      FROM invoices i2
      JOIN medical_records mr2 ON i2.record_id = mr2.record_id
      JOIN appointments a2     ON mr2.appointment_id = a2.appointment_id
      WHERE a2.clinic_id = 4
  )
ORDER BY i.total DESC;

-- Task 2.5: ALL Operator - Top Performers (4 points)
-- Find the vet(s) who performed more treatments than ALL other individual vets
-- Return: staff_id, first_name, last_name, treatment_count
-- Filter: role = 'veterinarian'
-- Order by: treatment_count descending
-- Tables: staff, treatments
-- Tip: Use HAVING COUNT(*) >= ALL (SELECT COUNT(*) ... GROUP BY staff_id)
--      Or use MAX() in a subquery approach
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    COUNT(t.treatment_id) AS treatment_count
FROM staff s
JOIN medical_records mr ON mr.vet_id = s.staff_id
JOIN treatments t       ON t.record_id = mr.record_id
WHERE s.role = 'veterinarian'
GROUP BY s.staff_id, s.first_name, s.last_name
HAVING COUNT(t.treatment_id) >= ALL (
    SELECT COUNT(t2.treatment_id)
    FROM staff s2
    JOIN medical_records mr2 ON mr2.vet_id = s2.staff_id
    JOIN treatments t2       ON t2.record_id = mr2.record_id
    WHERE s2.role = 'veterinarian'
    GROUP BY s2.staff_id
)
ORDER BY treatment_count DESC;