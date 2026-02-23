-- =============================================================================
-- Exercise 4: Self-Joins and Cross Joins
-- MedCare Health Clinic - SQL Joins Assignment
-- =============================================================================


-- Problem 4.1 (4 points)
-- Basic Self-Join: Doctor-Supervisor Pairs
-- Return: doctor_name, supervisor_name
-- Include: All doctors, even those without supervisors
-- Order by: supervisor last_name (NULLS FIRST), then doctor last_name
-- Table: doctors (self-join)
-- Tip: Join doctors to itself using supervisor_id
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    CONCAT(supervisors.first_name, ' ', supervisors.last_name) AS supervisor_name
FROM doctors
LEFT JOIN doctors supervisors ON doctors.supervisor_id = supervisors.doctor_id
ORDER BY supervisors.last_name NULLS FIRST, doctors.last_name;

-- Problem 4.2 (4 points)
-- Organizational Hierarchy: Multiple Levels
-- Return: doctor_name, level_1_supervisor, level_2_supervisor, level_3_supervisor
-- Show: Up to 3 levels of management chain
-- Order by: hierarchy depth, then doctor last_name
-- Table: doctors (multiple self-joins)
-- Tip: Use LEFT JOINs for each level: d -> l1 -> l2 -> l3
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    CONCAT(l1s.first_name, ' ', l1s.last_name) AS level_1_supervisor,
    CONCAT(l2s.first_name, ' ', l2s.last_name) AS level_2_supervisor,
    CONCAT(l3s.first_name, ' ', l3s.last_name) AS level_3_supervisor
FROM doctors
LEFT JOIN doctors l1s ON doctors.supervisor_id = l1s.doctor_id
LEFT JOIN doctors l2s ON l1s.supervisor_id = l2s.doctor_id
LEFT JOIN doctors l3s ON l2s.supervisor_id = l3s.doctor_id
ORDER BY l3s.last_name, l2s.last_name, l1s.last_name, doctors.last_name;

-- Problem 4.3 (4 points)
-- Self-Join: Counting Direct Reports
-- Return: supervisor_name, department_name, direct_report_count
-- Filter: Only active doctors
-- Order by: direct_report_count descending, then last_name
-- Tables: doctors (self-join), departments
-- Tip: Count active doctors who report to each supervisor
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 4.4 (4 points)
-- Cross Join: Department-Specialization Combinations
-- Return: department_name, specialization_category, doctor_count
-- Show: All possible combinations of departments and specialization categories
-- Tables: departments, specializations (for categories), doctors, doctor_specializations
-- Tip: CROSS JOIN generates all combinations, then LEFT JOIN for counts
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 4.5 (4 points)
-- Self-Join: Finding Peer Doctors
-- Return: doctor_name, peer_name, shared_supervisor
-- Filter: Active doctors who share the same supervisor
-- Order by: supervisor last_name, then first doctor last_name
-- Table: doctors (self-join)
-- Tip: Join d1.supervisor_id = d2.supervisor_id with d1.id < d2.id to avoid duplicates
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here
