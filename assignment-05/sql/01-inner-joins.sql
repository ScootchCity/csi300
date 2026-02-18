-- =============================================================================
-- Exercise 1: INNER JOINs
-- MedCare Health Clinic - SQL Joins Assignment
-- =============================================================================


-- Problem 1.1 (4 points)
-- Basic Two-Table Join: Completed appointments with patient and doctor names
-- Return: patient_name (full name), doctor_name (full name), scheduled_at, visit_type, reason
-- Filter: Only completed appointments
-- Order by: scheduled_at descending
-- Tables: appointments, patients, doctors
-- Tip: Use CONCAT(first_name, ' ', last_name) for full names
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ',  patients.last_name) AS patient_name,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    scheduled_at,
    visit_type,
    reason
FROM medcare.appointments
INNER JOIN medcare.patients ON appointments.patient_id = patients.patient_id
INNER JOIN medcare.doctors ON appointments.doctor_id = doctors.doctor_id
ORDER BY scheduled_at DESC;

-- Problem 1.2 (4 points)
-- Join with Department Information: Active doctors with their departments
-- Return: doctor_name, department_name, location, hire_date
-- Filter: Only active doctors (is_active = true)
-- Order by: department name, then last_name
-- Tables: doctors, departments
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    departments.name AS department_name,
    CONCAT(departments.building, ' ', departments.floor) AS location, --TODO: check what is meant by location
    doctors.hire_date
FROM medcare.doctors
INNER JOIN medcare.departments ON doctors.department_id = departments.department_id
WHERE doctors.is_active = TRUE
ORDER BY departments.name, doctors.last_name;

-- Problem 1.3 (4 points)
-- Many-to-Many Join: Doctors and their specializations
-- Return: doctor_name, specialization_name, is_primary, certified_date
-- Order by: doctor last_name, is_primary descending, specialization name
-- Tables: doctors, doctor_specializations, specializations
-- Tip: Many-to-many requires joining through the junction table
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    specializations.name AS specialization_name,
    doctor_specializations.is_primary,
    doctor_specializations.certified_at AS certified_date
FROM medcare.doctors
INNER JOIN medcare.doctor_specializations ON doctors.doctor_id = doctor_specializations.doctor_id
INNER JOIN medcare.specializations ON doctor_specializations.specialization_id = specializations.specialization_id
ORDER BY doctors.last_name, doctor_specializations,is_primary, specializations.name;

-- Problem 1.4 (4 points)
-- Join with Filtering: Cardiology appointments in 2024
-- Return: patient_name, doctor_name, scheduled_at, visit_type, reason
-- Filter: Cardiology department, year 2024
-- Tables: appointments, patients, doctors, departments
-- Tip: Use EXTRACT(YEAR FROM scheduled_at) = 2024
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_name,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    appointments.scheduled_at,
    appointments.visit_type,
    appointments.reason
FROM medcare.appointments
INNER JOIN medcare.patients ON appointments.patient_id = patients.patient_id
INNER JOIN medcare.doctors ON appointments.doctor_id = doctors.doctor_id
INNER JOIN medcare.departments ON doctors.department_id = departments.department_id
WHERE departments.name = 'Cardiology' AND EXTRACT(YEAR FROM appointments.scheduled_at) = 2024;

-- Problem 1.5 (4 points)
-- Multiple Joins with Aggregation: Doctor appointments by department
-- Return: department_name, doctor_name, appointment_count
-- Filter: Only departments with more than 5 total appointments
-- Order by: department_name, appointment_count descending
-- Tables: departments, doctors, appointments
-- Tip: Join all three tables, use GROUP BY doctor, then filter with HAVING
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT

FROM medcare.departments
INNER JOIN medcare.doctors ON departments.department_id = doctors.department_id
INNER JOIN medcare.appointments ON doctors.doctor_id = appointments.doctor_id
GROUP BY doctors.doctor_id
HAVING COUNT(appointments) > 5
ORDER BY departments.name, COUNT(appointments) DESC