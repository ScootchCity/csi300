-- =============================================================================
-- Exercise 4: Self-Joins and Cross Joins
-- MedCare Health Clinic - SQL Joins Assignment
-- =============================================================================


-- Problem 4.1 (4 points)
-- Basic Self-Join: Doctor-Supervisor Pairs
-- Return: doctor_name, doctor_title, supervisor_name, supervisor_title
-- Include: All doctors, even those without supervisors
-- Order by: supervisor last_name (NULLS FIRST), then doctor last_name
-- Table: doctors (self-join)
-- Tip: Join doctors to itself using supervisor_id
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 4.2 (4 points)
-- Organizational Hierarchy: Multiple Levels
-- Return: doctor_name, level_1_supervisor, level_2_supervisor, level_3_supervisor
-- Show: Up to 3 levels of management chain
-- Order by: hierarchy depth, then doctor last_name
-- Table: doctors (multiple self-joins)
-- Tip: Use LEFT JOINs for each level: d -> l1 -> l2 -> l3
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here


-- Problem 4.3 (4 points)
-- Self-Join: Counting Direct Reports
-- Return: supervisor_name, title, department_name, direct_report_count
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
