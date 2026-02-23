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

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    patients.date_of_birth,
    patients.phone
FROM patients
LEFT OUTER JOIN insurance_providers ON patients.insurance_id = insurance_providers.provider_id
WHERE patients.insurance_id IS NULL
ORDER BY patients.last_name;

-- Problem 2.2 (4 points)
-- Patients Without Appointments
-- Return: patient_name, email, created_at, days_since_registration
-- Filter: Patients who have never had an appointment
-- Order by: last_name
-- Tables: patients, appointments
-- Tip: Calculate days using CURRENT_DATE - created_at::date
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    patients.email,
    patients.created_at,
    CURRENT_DATE - patients.created_at::date AS days_since_registration
FROM patients
LEFT OUTER JOIN appointments ON patients.patient_id = appointments.patient_id
WHERE appointment_id IS NULL;

-- Problem 2.3 (4 points)
-- Medications Never Prescribed
-- Return: medication_name, category, is_controlled
-- Filter: Medications that have never been prescribed
-- Order by: category, medication name
-- Tables: medications, prescriptions
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    medications.name AS medication_name,
    medications.category,
    medications.controlled_substance AS is_controlled
FROM medications
LEFT OUTER JOIN prescriptions ON medications.medication_id = prescriptions.prescription_id
WHERE prescriptions.prescription_id IS NULL
ORDER BY medications.category, medications.name;

-- Problem 2.4 (4 points)
-- All Patients with Their Insurance Status
-- Return: patient_name, provider_name, plan_type, insurance_status
-- insurance_status: 'Uninsured' if no insurance, 'Insured' otherwise
-- Order by: uninsured first, then by last_name
-- Tables: patients, insurance_providers
-- Tip: Use CASE to determine insurance_status
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    insurance_providers.name AS provider_name,
    insurance_providers.plan_type,
    CASE
        WHEN insurance_providers.plan_type IS NULL THEN 'Uninsured'
        WHEN insurance_providers.plan_type IS NOT NULL THEN 'Insured'
    END
    AS insurance_status
FROM patients
LEFT OUTER JOIN insurance_providers ON patients.insurance_id = insurance_providers.provider_id
ORDER BY insurance_status DESC, patients.last_name; -- just used desc for status. is this fine?

-- Problem 2.5 (4 points)
-- Lab Tests Never Ordered
-- Return: test_name, category, base_price, turnaround_hours
-- Filter: Lab tests that have never been ordered
-- Order by: category, base_price descending
-- Tables: lab_tests, lab_results
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    lab_tests.name AS test_name,
    lab_tests.category,
    lab_tests.base_cost AS base_price,
    lab_tests.turnaround_hours
FROM lab_tests
LEFT OUTER JOIN lab_results ON lab_tests.test_id = lab_results.test_id
WHERE lab_results.test_id IS NULL
ORDER BY lab_tests.category, lab_tests.base_cost DESC;