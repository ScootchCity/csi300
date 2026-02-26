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


-- Task 3.2: UNION ALL - Appointment Timeline (4 points)
-- Create timeline of appointment scheduling and completion events in 2024
-- Return: event_date, event_type ('Scheduled' or 'Completed'), pet_name, clinic_name
-- Filter: Events from 2024 only
-- Order by: event_date, event_type
-- Tables: appointments, pets, clinics
-- Tip: UNION ALL keeps duplicates (same appointment appears twice with different event types)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Task 3.3: INTERSECT - Multi-Clinic Pets (4 points)
-- Find pets that visited both Burlington Downtown (clinic_id = 1) and Williston (clinic_id = 3) clinics
-- Return: pet_name, species_name, owner_name
-- Tables: pets, species, owners, appointments
-- Tip: Use INTERSECT to find pet_ids that appear in both clinic's appointments
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Task 3.4: EXCEPT - Unused Procedures (4 points)
-- Find procedures that have never been used
-- Return: procedure_name, category, base_price
-- Order by: category, procedure_name
-- Tables: procedures, treatments
-- Tip: All procedure_ids EXCEPT those in treatments
--      Alternative: NOT IN approach
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


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
