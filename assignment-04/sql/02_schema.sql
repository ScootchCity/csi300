-- =============================================================================
-- EduLearn LMS - Normalized Schema (3NF)
-- Assignment 04: Database Normalization
-- Student: Lloyd Ivester
-- Date: 2/9/2026
-- =============================================================================

-- All tables are created in the public schema (default)
-- changing this since i want them in the edulearn schema
-- CREATE SCHEMA IF NOT EXISTS edulearn;
-- SET search_path TO edulearn, public;
-- decided not to for compatability with verify.sh

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

CREATE TABLE IF NOT EXISTS departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE NOT NULL,
    building VARCHAR,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- INSTRUCTORS
-- Stores instructor information
-- Depends on: departments
-- Columns needed: instructor_id (PK), email (unique), name, office, 
--                 department_id (FK), created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS instructors (
    instructor_id SERIAL PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,
    name VARCHAR NOT NULL,
    office VARCHAR,
    department_id INT REFERENCES departments(department_id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- STUDENTS
-- Stores student information (without multi-valued phone - that goes in separate table)
-- Columns needed: student_id (PK), email (unique), name, created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS students (
    student_id SERIAL PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,
    name VARCHAR NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- STUDENT_PHONES
-- Multi-valued attribute separated for 1NF compliance
-- Depends on: students
-- Columns needed: phone_id (PK), student_id (FK), phone_number, is_primary
-- Tip: Add UNIQUE constraint on (student_id, phone_number)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS student_phones (
    phone_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    phone_number VARCHAR,
    is_primary BOOLEAN,
    CONSTRAINT uq_phones UNIQUE(student_id, phone_number)
);

-- =============================================================================
-- COURSES
-- Stores course catalog information
-- Depends on: instructors
-- Columns needed: course_id (PK), code (unique), title, description, 
--                 credits (1-6), instructor_id (FK), created_at
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS courses (
    course_id SERIAL PRIMARY KEY,
    code VARCHAR UNIQUE NOT NULL,
    title VARCHAR,
    description VARCHAR,
    credits INT,
    instructor_id INT REFERENCES instructors(instructor_id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- MODULES
-- Course modules/units (separated from multi-valued column)
-- Depends on: courses
-- Columns needed: module_id (PK), course_id (FK), title, order_position
-- Tip: Add UNIQUE constraint on (course_id, order_position)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS modules (
    module_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    title VARCHAR,
    order_position INT,
    CONSTRAINT uq_modules UNIQUE(course_id, order_position)
);

-- =============================================================================
-- ASSIGNMENTS
-- Course assignments (separated from multi-valued column)
-- Depends on: courses
-- Columns needed: assignment_id (PK), course_id (FK), name, due_date, points (>0)
-- Tip: Add UNIQUE constraint on (course_id, name)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS course_assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    name VARCHAR,
    due_date DATE,
    points INT CHECK(points > 0),
    CONSTRAINT uq_assignments UNIQUE(course_id, name)
);

-- =============================================================================
-- ENROLLMENTS
-- Junction table for student-course many-to-many relationship
-- Depends on: students, courses
-- Columns needed: enrollment_id (PK), student_id (FK), course_id (FK), enrollment_date
-- Tip: Add UNIQUE constraint on (student_id, course_id)
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    enrollment_date DATE,
    CONSTRAINT uq_enrollments UNIQUE(student_id, course_id)
);

-- =============================================================================
-- GRADES
-- Stores grade information for completed enrollments
-- Has 1:1 relationship with enrollments (enrollment_id is both PK and FK)
-- Columns needed: enrollment_id (PK, FK), grade, grade_points, completion_date
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS grades (
    enrollment_id INT PRIMARY KEY REFERENCES enrollments(enrollment_id) ON DELETE CASCADE,
    grade VARCHAR,
    grade_points FLOAT,
    completion_date DATE
);

-- =============================================================================
-- CERTIFICATES
-- Stores certificate information for course completions
-- Depends on: enrollments
-- Columns needed: certificate_id (PK), enrollment_id (FK, unique), issued_date
-- =============================================================================
-- TODO: Write your CREATE TABLE statement here

CREATE TABLE IF NOT EXISTS  certificates (
    certificate_id SERIAL PRIMARY KEY,
    enrollment_id INT REFERENCES enrollments(enrollment_id) ON DELETE CASCADE UNIQUE,
    issued_date DATE
);