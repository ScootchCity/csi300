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
