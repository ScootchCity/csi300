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

SELECT
    departments.name AS department_name,
    CONCAT (departments.building, ' ', departments.floor) AS location,
    COUNT(doctor_id) AS doctor_count
FROM doctors
RIGHT OUTER JOIN departments ON doctors.department_id = departments.department_id
GROUP BY departments.name, location
ORDER BY doctor_count DESC, department_name;

-- Problem 3.2 (4 points)
-- RIGHT JOIN: Specializations with Certified Doctors
-- Return: specialization_name, category, doctor_name (or 'No certified doctors')
-- Include: All specializations, even those with no certified doctors
-- Order by: category, specialization name
-- Tables: doctors, doctor_specializations, specializations
-- Tip: Use COALESCE for the default message
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    specializations.name AS specialization_name,
    specializations.category,
    COALESCE(
        --use nullif to make sure the concat isn't just the space
        NULLIF(CONCAT(doctors.first_name, ' ', doctors.last_name), ' '),
        'No certified doctors'
    ) AS doctor_name
FROM doctors
RIGHT OUTER JOIN doctor_specializations ON doctors.doctor_id = doctor_specializations.doctor_id
RIGHT OUTER JOIN specializations ON doctor_specializations.specialization_id = specializations.specialization_id
ORDER BY specializations.category, specializations.name;

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

SELECT
    insurance_providers.name,
    CONCAT(patients.first_name, ' ', patients.last_name),
    CASE
        WHEN 
    END
    AS relationship_status
FROM insurance_providers
FULL OUTER JOIN patients ON insurance_providers.provider_id = patients.insurance_id
ORDER BY

-- Problem 3.4 (4 points)
-- FULL OUTER JOIN: Department-Specialization Coverage
-- Return: department_name, specialization_name, category
-- Join: specializations.category = departments.name
-- Order by: department name, then specialization name
-- Tables: departments, specializations
-- Tip: FULL OUTER JOIN on s.category = d.name
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
