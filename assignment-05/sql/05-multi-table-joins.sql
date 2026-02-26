-- =============================================================================
-- Exercise 5: Multi-Table Complex Joins
-- MedCare Health Clinic - SQL Joins Assignment
-- =============================================================================


-- Problem 5.1 (4 points)
-- Comprehensive Patient Visit Report
-- Return: patient_name, insurance_provider (or 'Self-Pay'), doctor_name, 
--         department, appointment_date, visit_type, primary_diagnosis
-- Filter: Completed appointments only
-- Order by: scheduled_at descending
-- Limit: 50 rows
-- Tables: appointments, patients, insurance_providers, doctors, departments, diagnoses
-- Tip: Use COALESCE for 'Self-Pay' default, filter diagnoses by is_primary = true
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    COALESCE(insurance_providers.name, 'Self-Pay') AS insurance_provider,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    departments.name AS department_name,
    appointments.scheduled_at AS appointment_date,
    appointments.visit_type,
    diagnoses.description AS primary_diagnosis
FROM appointments
LEFT JOIN patients ON appointments.patient_id = patients.patient_id
LEFT JOIN insurance_providers ON patients.insurance_id = insurance_providers.provider_id
INNER JOIN doctors ON appointments.doctor_id = doctors.doctor_id
INNER JOIN departments ON doctors.department_id = departments.department_id
LEFT JOIN diagnoses ON appointments.appointment_id = diagnoses.appointment_id AND diagnoses.is_primary = TRUE
WHERE appointments.status = 'completed'
ORDER BY appointments.scheduled_at DESC
LIMIT 50;

-- Problem 5.2 (4 points)
-- Doctor Productivity Dashboard
-- Return: doctor_name, department, total_appointments, completed_appointments,
--         unique_patients, prescriptions_written, supervisor_name
-- Filter: Active doctors only
-- Order by: completed_appointments descending
-- Tables: doctors, departments, appointments, diagnoses, prescriptions
-- Tip: Use COUNT(DISTINCT ...) for unique patients
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    departments.name AS department,
    COUNT(appointments.appointment_id) AS total_appointments,
    COUNT(CASE WHEN appointments.status = 'completed' THEN 1 END) AS completed_appointments,
    COUNT(DISTINCT appointments.patient_id) AS unique_patients,
    COUNT(prescriptions.prescription_id) AS prescriptions_written,
    CONCAT(supervisors.first_name, ' ', supervisors.last_name) AS supervisor_name
FROM doctors
INNER JOIN departments ON doctors.department_id = departments.department_id
LEFT JOIN doctors supervisors ON doctors.supervisor_id = supervisors.doctor_id
LEFT JOIN appointments ON doctors.doctor_id = appointments.doctor_id
LEFT JOIN diagnoses ON appointments.appointment_id = diagnoses.appointment_id
LEFT JOIN prescriptions ON diagnoses.diagnosis_id = prescriptions.diagnosis_id
GROUP BY doctor_name, department, supervisor_name
ORDER BY completed_appointments DESC;

-- Problem 5.3 (4 points)
-- Insurance Claims Analysis
-- Return: provider_name, plan_type, patient_count, total_claims, 
--         total_billed, total_paid, avg_payment_pct, denied_claims
-- Order by: total_billed descending
-- Tables: insurance_providers, patients, claims
-- Tip: Calculate payment percentage as (SUM(amount_paid) / SUM(amount_billed) * 100)
--      Use NULLIF to avoid division by zero
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    insurance_providers.name AS provider_name,
    insurance_providers.plan_type,
    COUNT(DISTINCT patients.patient_id) AS patient_count,
    COUNT(DISTINCT claims.claim_id) AS total_claims,
    SUM(claims.amount_billed) AS total_billed,
    SUM(claims.amount_covered) AS total_paid,
    ROUND((SUM(claims.amount_covered) / NULLIF(SUM(claims.amount_billed), 0) * 100), 2) AS avg_payment_pct,
    COUNT(CASE WHEN claims.status = 'denied' THEN 1 END) AS denied_claims
FROM insurance_providers
LEFT JOIN patients ON insurance_providers.provider_id = patients.insurance_id
LEFT JOIN claims ON patients.patient_id = claims.patient_id
GROUP BY provider_name, insurance_providers.plan_type
ORDER BY total_billed DESC NULLS LAST;

-- Problem 5.4 (4 points)
-- Complete Prescription Chain
-- Return: patient_name, appointment_date, doctor_name, department,
--         icd_code, diagnosis, medication_name, med_category, 
--         dosage, frequency, duration_days
-- Order by: scheduled_at descending, patient last_name
-- Tables: patients, appointments, doctors, departments, diagnoses, prescriptions, medications
-- Tip: This requires 7 table joins following the relationship chain
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    appointments.scheduled_at AS appointment_date,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    departments.name AS department,
    diagnoses.icd_code,
    diagnoses.description AS diagnosis,
    medications.name AS medication_name,
    medications.category AS med_category,
    prescriptions.dosage,
    prescriptions.frequency,
    prescriptions.duration_days
FROM patients
LEFT JOIN appointments ON patients.patient_id = appointments.patient_id
INNER JOIN doctors ON appointments.doctor_id = doctors.doctor_id
INNER JOIN departments ON doctors.department_id = departments.department_id
LEFT JOIN diagnoses ON appointments.appointment_id = diagnoses.appointment_id
LEFT JOIN prescriptions ON patients.patient_id = prescriptions.patient_id
INNER JOIN medications ON prescriptions.medication_id = medications.medication_id
ORDER BY appointments.scheduled_at DESC, patients.last_name;

-- Problem 5.5 (4 points)
-- Lab Results with Full Context
-- Return: patient_name, blood_type, doctor_name, department, test_name,
--         test_category, result_value, reference_range, is_abnormal,
--         appointment_date, appointment_reason
-- Filter: Completed lab results only
-- Order by: collected_at descending
-- Tables: lab_results, patients, doctors, departments, lab_tests, appointments
-- Tip: is_abnormal is TRUE when abnormal_flag IS NOT NULL
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    patients.blood_type,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    departments.name AS department,
    lab_tests.name AS test_name,
    lab_tests.category AS test_category,
    lab_results.result_value,
    lab_tests.normal_range AS reference_range,
    lab_results.is_abnormal,
    appointments.scheduled_at AS appointment_date,
    appointments.reason AS appointment_reason
FROM lab_results
INNER JOIN patients ON lab_results.patient_id = patients.patient_id
INNER JOIN doctors ON lab_results.doctor_id = doctors.doctor_id
INNER JOIN departments ON doctors.department_id = departments.department_id
INNER JOIN lab_tests ON lab_results.test_id = lab_tests.test_id
LEFT JOIN appointments ON lab_results.appointment_id = appointments.appointment_id
WHERE lab_results.status = 'completed'
ORDER BY lab_results.collected_at DESC;

-- =============================================================================
-- BONUS CHALLENGE: The Ultimate Healthcare Query
-- =============================================================================
-- For each department, find:
--   1. The most common diagnosis made in 2024
--   2. The medication most frequently prescribed for that diagnosis
--   3. The doctor in that department who wrote the most prescriptions
--
-- Tip: Use CTEs (WITH clause) to break this into manageable parts:
--   - CTE 1: Count diagnoses by department
--   - CTE 2: Count medications by diagnosis
--   - CTE 3: Count prescriptions by doctor per department
-- Then JOIN the CTEs together for the final result.
-- -----------------------------------------------------------------------------
-- TODO: Write your bonus query here (optional)