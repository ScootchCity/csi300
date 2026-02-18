-- =============================================================================
-- Exercise 2: LEFT OUTER JOINs
-- MedCare Health Clinic - SQL Joins Assignment
-- =============================================================================


-- Problem 2.1 (4 points)
-- Finding Patients Without Insurance
-- Return: patient_name (full name), date_of_birth, phone
-- Filter: Patients with no insurance (NULL insurance_id)
-- Order by: last_name
-- Tables: patients, insurance_providers
-- Tip: LEFT JOIN and check for NULL on right table
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 2.2 (4 points)
-- Patients Without Appointments
-- Return: patient_name, email, created_at, days_since_registration
-- Filter: Patients who have never had an appointment
-- Order by: last_name
-- Tables: patients, appointments
-- Tip: Calculate days using CURRENT_DATE - created_at::date
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 2.3 (4 points)
-- Medications Never Prescribed
-- Return: medication_name, category, is_controlled
-- Filter: Medications that have never been prescribed
-- Order by: category, medication name
-- Tables: medications, prescriptions
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 2.4 (4 points)
-- All Patients with Their Insurance Status
-- Return: patient_name, provider_name, plan_type, insurance_status
-- insurance_status: 'Uninsured' if no insurance, 'Insured' otherwise
-- Order by: uninsured first, then by last_name
-- Tables: patients, insurance_providers
-- Tip: Use CASE to determine insurance_status
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 2.5 (4 points)
-- Lab Tests Never Ordered
-- Return: test_name, category, base_price, turnaround_hours
-- Filter: Lab tests that have never been ordered
-- Order by: category, base_price descending
-- Tables: lab_tests, lab_results
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here
