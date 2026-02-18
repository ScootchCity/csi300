-- =============================================================================
-- Exercise 3: RIGHT and FULL OUTER JOINs
-- MedCare Health Clinic - SQL Joins Assignment
-- =============================================================================


-- Problem 3.1 (4 points)
-- RIGHT JOIN: All Departments with Doctor Counts
-- Return: department_name, location, doctor_count
-- Include: All departments, even those with no doctors
-- Order by: doctor_count descending, department name
-- Tables: doctors, departments
-- Tip: RIGHT JOIN ensures all departments appear
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 3.2 (4 points)
-- RIGHT JOIN: Specializations with Certified Doctors
-- Return: specialization_name, category, doctor_name (or 'No certified doctors')
-- Include: All specializations, even those with no certified doctors
-- Order by: category, specialization name
-- Tables: doctors, doctor_specializations, specializations
-- Tip: Use COALESCE for the default message
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 3.3 (4 points)
-- FULL OUTER JOIN: Insurance Provider Coverage Analysis
-- Return: provider_name, patient_name, relationship_status
-- relationship_status values:
--   - 'Provider has no patients' (provider exists but no patients)
--   - 'Patient is uninsured' (patient exists but no provider)
--   - 'Active relationship' (both exist)
-- Order by: relationship_status priority, then provider name
-- Tables: insurance_providers, patients
-- Tip: FULL OUTER JOIN preserves unmatched rows from both tables
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 3.4 (4 points)
-- FULL OUTER JOIN: Department-Specialization Matrix
-- Return: department_name, specialization_name, match_status
-- match_status values:
--   - 'Matched' (both exist and match)
--   - 'Department only' (department has no matching specialization)
--   - 'Specialization only' (specialization has no matching department)
-- Order by: match_status priority, department name, specialization name
-- Tables: departments, specializations
-- Tip: Match using pattern matching (ILIKE) on names
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 3.5 (4 points)
-- Data Reconciliation: Insurance Claims Check
-- Return: appointment_id, patient_name, has_claim (boolean), claim_status, issue_flag
-- issue_flag: 'Missing claim' for completed appointments with insured patients but no claim
-- Filter: Only completed appointments
-- Order by: issues first (missing claims), then by scheduled_at descending
-- Tables: appointments, patients, claims
-- Tip: Use CASE to identify missing claims
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here
