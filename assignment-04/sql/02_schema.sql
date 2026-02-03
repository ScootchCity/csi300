-- =============================================================================
-- EduLearn LMS - Normalized Schema (3NF)
-- Assignment 04: Database Normalization
-- =============================================================================

-- All tables are created in the public schema (default)

-- =============================================================================
-- ENTITY RELATIONSHIP DIAGRAM
-- 
-- Design your tables based on this structure:
--
-- departments (1) ----< (N) instructors
-- instructors (1) ----< (N) courses
-- students (1) ----< (N) student_phones
-- courses (1) ----< (N) modules
-- courses (1) ----< (N) assignments
-- courses (N) >----< (N) students [through enrollments]
-- enrollments (1) ---- (0..1) grades
-- enrollments (1) ---- (0..1) certificates
--
-- Legend:
--   (1) ----< (N)  = One-to-Many
--   (N) >----< (N) = Many-to-Many (junction table)
--   (1) ---- (0..1) = One-to-Zero-or-One (optional)
-- =============================================================================

-- =============================================================================
-- DEPARTMENTS
-- Stores academic departments
-- Purpose: Eliminates transitive dependency (instructor_department -> department_building)
-- Columns needed: department_id (PK), name (unique), building, created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- INSTRUCTORS
-- Stores instructor information
-- Depends on: departments
-- Columns needed: instructor_id (PK), email (unique), name, office, 
--                 department_id (FK), created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- STUDENTS
-- Stores student information (without multi-valued phone - that goes in separate table)
-- Columns needed: student_id (PK), email (unique), name, created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- STUDENT_PHONES
-- Multi-valued attribute separated for 1NF compliance
-- Depends on: students
-- Columns needed: phone_id (PK), student_id (FK), phone_number, is_primary
-- Tip: Add UNIQUE constraint on (student_id, phone_number)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- COURSES
-- Stores course catalog information
-- Depends on: instructors
-- Columns needed: course_id (PK), code (unique), title, description, 
--                 credits (1-6), instructor_id (FK), created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- MODULES
-- Course modules/units (separated from multi-valued column)
-- Depends on: courses
-- Columns needed: module_id (PK), course_id (FK), title, order_position
-- Tip: Add UNIQUE constraint on (course_id, order_position)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- ASSIGNMENTS
-- Course assignments (separated from multi-valued column)
-- Depends on: courses
-- Columns needed: assignment_id (PK), course_id (FK), name, due_date, points (>0)
-- Tip: Add UNIQUE constraint on (course_id, name)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- ENROLLMENTS
-- Junction table for student-course many-to-many relationship
-- Depends on: students, courses
-- Columns needed: enrollment_id (PK), student_id (FK), course_id (FK), enrollment_date
-- Tip: Add UNIQUE constraint on (student_id, course_id)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- GRADES
-- Stores grade information for completed enrollments
-- Has 1:1 relationship with enrollments (enrollment_id is both PK and FK)
-- Columns needed: enrollment_id (PK, FK), grade, grade_points, completion_date
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here


-- =============================================================================
-- CERTIFICATES
-- Stores certificate information for course completions
-- Depends on: enrollments
-- Columns needed: certificate_id (PK), enrollment_id (FK, unique), issued_date
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here
