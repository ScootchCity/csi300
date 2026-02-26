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


-- Task 2.2: EXISTS - Active Vets (4 points)
-- Find veterinarians who completed at least one appointment in 2024
-- Return: staff_id, first_name, last_name, specialization
-- Filter: role = 'veterinarian'
-- Tables: staff, appointments
-- Tip: WHERE EXISTS (SELECT 1 FROM appointments WHERE vet_id = s.staff_id AND ...)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Task 2.3: NOT EXISTS - Species Without Vaccines (4 points)
-- Find species that have no vaccines defined
-- Return: species_id, species_name, category
-- Tables: species, vaccines
-- Tip: WHERE NOT EXISTS (SELECT 1 FROM vaccines WHERE species_id = s.species_id)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Task 2.4: ANY Operator - Above Emergency Minimum (4 points)
-- Find invoices greater than at least one emergency clinic invoice (i.e., > min emergency total)
-- Return: invoice_number, total, clinic_name
-- Filter: Exclude emergency clinic (clinic_id = 4) from results
-- Order by: total descending
-- Tables: invoices, appointments, clinics
-- Tip: WHERE total > ANY (SELECT total FROM invoices WHERE clinic_id = 4)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


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
