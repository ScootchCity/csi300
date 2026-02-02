-- =============================================================================
-- EduLearn LMS - Seed Data for Normalized Schema
-- Assignment 04: Database Normalization
-- =============================================================================
-- This file populates the normalized tables with data from the original CSV
-- Use ON CONFLICT DO NOTHING for idempotency
-- =============================================================================

-- All tables are in the public schema (default)

-- =============================================================================
-- DEPARTMENTS (extract unique departments from CSV)
-- 
-- From the CSV, identify unique department names and their buildings.
-- Example departments: Computer Science (Tech Building), Business (Commerce Hall), etc.
-- =============================================================================
-- TODO: Write your INSERT statements here
-- Tip: INSERT INTO edulearn.departments (name, building) VALUES (...) ON CONFLICT (name) DO NOTHING;


-- =============================================================================
-- INSTRUCTORS (extract unique instructors from CSV)
-- 
-- From the CSV, identify unique instructors with their details.
-- Use subquery to get department_id by name.
-- =============================================================================
-- TODO: Write your INSERT statements here
-- Tip: Use subquery: (SELECT department_id FROM edulearn.departments WHERE name = '...')


-- =============================================================================
-- STUDENTS (extract unique students from CSV)
-- 
-- From the CSV, identify unique students by email.
-- =============================================================================
-- TODO: Write your INSERT statements here


-- =============================================================================
-- STUDENT_PHONES (split multi-valued phone column)
-- 
-- From the CSV, split the comma-separated phone numbers into individual rows.
-- Mark the first phone number as is_primary = TRUE.
-- =============================================================================
-- TODO: Write your INSERT statements here
-- Tip: Use a VALUES clause with JOIN to students table


-- =============================================================================
-- COURSES (extract unique courses from CSV)
-- 
-- From the CSV, identify unique courses with their details.
-- Link to instructor using subquery on instructor email.
-- =============================================================================
-- TODO: Write your INSERT statements here


-- =============================================================================
-- MODULES (split multi-valued module columns)
-- 
-- From the CSV, split the comma-separated module titles into individual rows.
-- Maintain the order_position based on original order.
-- =============================================================================
-- TODO: Write your INSERT statements here


-- =============================================================================
-- ASSIGNMENTS (split multi-valued assignment columns)
-- 
-- From the CSV, split the comma-separated assignments into individual rows.
-- Map assignment names to their due dates and points.
-- =============================================================================
-- TODO: Write your INSERT statements here


-- =============================================================================
-- ENROLLMENTS (create junction table entries)
-- 
-- From the CSV, create enrollment records for each student-course combination.
-- Use subqueries to get student_id and course_id from email and code.
-- =============================================================================
-- TODO: Write your INSERT statements here


-- =============================================================================
-- GRADES (only for completed enrollments with grades)
-- 
-- From the CSV, insert grade records only where grades exist.
-- Use complex subquery to get enrollment_id from student email and course code.
-- =============================================================================
-- TODO: Write your INSERT statements here


-- =============================================================================
-- CERTIFICATES (only for students who earned certificates)
-- 
-- From the CSV, insert certificate records where certificate_issued = 'Yes'.
-- =============================================================================
-- TODO: Write your INSERT statements here
