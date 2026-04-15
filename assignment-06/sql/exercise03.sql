-- =============================================================================
-- Exercise 3: Set Operations
-- PawCare Veterinary Clinic
-- =============================================================================

-- Task 3.1: UNION - Contact Directory (4 points)
-- Create combined contact directory of owners and staff
-- Return: full_name, email, phone, contact_type ('Owner' or 'Staff')
-- Order by: contact_type, full_name
-- Tables: owners, staff
-- Tip: UNION removes duplicates; use || for string concatenation
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    first_name || ' ' || last_name AS full_name,
    email,
    phone,
    'Owner' AS contact_type
FROM owners
UNION
SELECT
    first_name || ' ' || last_name,
    email,
    phone,
    'Staff'
FROM staff
ORDER BY contact_type, full_name;

-- Task 3.2: UNION ALL - Appointment Timeline (4 points)
-- Create timeline of appointment scheduling and completion events in 2024
-- Return: event_date, event_type ('Scheduled' or 'Completed'), pet_name, clinic_name
-- Filter: Events from 2024 only
-- Order by: event_date, event_type
-- Tables: appointments, pets, clinics
-- Tip: UNION ALL keeps duplicates (same appointment appears twice with different event types)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    a.created_at   AS event_date,
    'Scheduled'    AS event_type,
    p.pet_name,
    c.clinic_name
FROM appointments a
JOIN pets   p ON a.pet_id   = p.pet_id
JOIN clinics c ON a.clinic_id = c.clinic_id
WHERE EXTRACT(YEAR FROM a.created_at) = 2024

UNION ALL

SELECT
    a.scheduled_at AS event_date,
    'Completed'    AS event_type,
    p.pet_name,
    c.clinic_name
FROM appointments a
JOIN pets   p ON a.pet_id   = p.pet_id
JOIN clinics c ON a.clinic_id = c.clinic_id
WHERE EXTRACT(YEAR FROM a.scheduled_at) = 2024

ORDER BY event_date, event_type;

-- Task 3.3: INTERSECT - Multi-Clinic Pets (4 points)
-- Find pets that visited both Burlington Downtown (clinic_id = 1) and Williston (clinic_id = 3) clinics
-- Return: pet_name, species_name, owner_name
-- Tables: pets, species, owners, appointments
-- Tip: Use INTERSECT to find pet_ids that appear in both clinic's appointments
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    p.pet_name,
    s.species_name,
    o.first_name || ' ' || o.last_name AS owner_name
FROM pets p
JOIN species s ON p.species_id = s.species_id
JOIN owners  o ON p.owner_id   = o.owner_id
WHERE p.pet_id IN (
    SELECT pet_id FROM appointments WHERE clinic_id = 1
    INTERSECT
    SELECT pet_id FROM appointments WHERE clinic_id = 3
);

-- Task 3.4: EXCEPT - Unused Procedures (4 points)
-- Find procedures that have never been used
-- Return: procedure_name, category, base_price
-- Order by: category, procedure_name
-- Tables: procedures, treatments
-- Tip: All procedure_ids EXCEPT those in treatments
--      Alternative: NOT IN approach
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT p.name AS procedure_name, p.category, p.base_price
FROM procedures p
WHERE p.procedure_id IN (
    SELECT procedure_id FROM procedures
    EXCEPT
    SELECT procedure_id FROM treatments WHERE procedure_id IS NOT NULL
)
ORDER BY p.category, p.name;

-- Task 3.5: Complex Set Operations (4 points)
-- Medication usage patterns analysis:
-- Part A: Medications prescribed but never given as treatment
-- Part B: Medications given as treatment but never prescribed (in-clinic only)
--
-- Return: medication_name, category, usage_pattern
-- usage_pattern: 'Prescription Only' or 'Given In-Clinic Only'
-- Order by: category, medication_name
-- Tables: medications, prescriptions, treatments
-- Tip: Use UNION to combine two separate queries
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

-- Part A: prescribed but never used in treatments
SELECT m.name AS medication_name, m.category, 'Prescription Only' AS usage_pattern
FROM medications m
WHERE m.medication_id IN (
    SELECT medication_id FROM prescriptions
    EXCEPT
    SELECT medication_id FROM treatments WHERE medication_id IS NOT NULL
)

UNION

-- Part B: used in treatments but never prescribed
SELECT m.name, m.category, 'Given In-Clinic Only'
FROM medications m
WHERE m.medication_id IN (
    SELECT medication_id FROM treatments WHERE medication_id IS NOT NULL
    EXCEPT
    SELECT medication_id FROM prescriptions
)

ORDER BY category, medication_name;