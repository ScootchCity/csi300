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

INSERT INTO departments (name, building)
VALUES
    ('Computer Science', 'Tech Building'),
    ('Information Sciences', 'Business Building'),
    ('Mathematics', 'Science Building')
ON CONFLICT (name) DO NOTHING;

-- =============================================================================
-- INSTRUCTORS (extract unique instructors from CSV)
-- 
-- From the CSV, identify unique instructors with their details.
-- Use subquery to get department_id by name.
-- =============================================================================
-- TODO: Write your INSERT statements here
-- Tip: Use subquery: (SELECT department_id FROM edulearn.departments WHERE name = '...')

INSERT INTO  instructors (email, name, office, department_id)
VALUES
    ('sarah.smith@university.edu', 'Dr. Sarah Smith', 'Room 301', (SELECT department_id FROM departments WHERE name = 'Computer Science')),
    ('michael.jones@university.edu', 'Dr. Michael Jones', 'Room 205', (SELECT department_id FROM departments WHERE name = 'Information Science')),
    ('jennifer.lee@university.edu', 'Dr. Jennifer Lee', 'Room 402', (SELECT department_id FROM departments WHERE name = 'Computer Science')),
    ('robert.chen@university.edu', 'Dr. Robert Chen', 'Room 150', (SELECT department_id FROM departments WHERE name = 'Mathematics'))
ON CONFLICT DO NOTHING;
-- =============================================================================
-- STUDENTS (extract unique students from CSV)
-- 
-- From the CSV, identify unique students by email.
-- =============================================================================
-- TODO: Write your INSERT statements here

INSERT INTO students (email, name)
VALUES
    ('alice.johnson@university.edu', 'Alice Johnson'),
    ('bob.williams@university.edu', 'Bob Williams'),
    ('carol.davis@university.edu', 'Carol Davis'),
    ('david.miller@university.edu', 'David Miller'),
    ('emma.wilson@university.edu', 'Emma Wilson'),
    ('frank.garcia@university.edu', 'Frank Garcia'),
    ('grace.hernandez@university.edu', 'Grace Hernandez'),
    ('henry.lopez@university.edu', 'Henry Lopez')
ON CONFLICT DO NOTHING;

-- =============================================================================
-- STUDENT_PHONES (split multi-valued phone column)
-- 
-- From the CSV, split the comma-separated phone numbers into individual rows.
-- Mark the first phone number as is_primary = TRUE.
-- =============================================================================
-- TODO: Write your INSERT statements here
-- Tip: Use a VALUES clause with JOIN to students table

INSERT INTO student_phones (student_id, phone_number, is_primary)
VALUES
    ((SELECT student_id FROM students WHERE email = 'alice.johnson@university.edu'), '555-1234', TRUE),
    ((SELECT student_id FROM students WHERE email = 'alice.johnson@university.edu'), '555-5678', FALSE),
    ((SELECT student_id FROM students WHERE email = 'bob.williams@university.edu'), '555-9999', TRUE),
    ((SELECT student_id FROM students WHERE email = 'carol.davis@university.edu'), '555-4444', TRUE),
    ((SELECT student_id FROM students WHERE email = 'carol.davis@university.edu'), '555-4445', FALSE),
    ((SELECT student_id FROM students WHERE email = 'carol.davis@university.edu'), '555-4446', FALSE),
    ((SELECT student_id FROM students WHERE email = 'david.miller@university.edu'), '555-7777', TRUE),
    ((SELECT student_id FROM students WHERE email = 'emma.wilson@university.edu'), '555-8888', TRUE),
    ((SELECT student_id FROM students WHERE email = 'emma.wilson@university.edu'), '555-8889', FALSE),
    ((SELECT student_id FROM students WHERE email = 'grace.hernandez@university.edu'), '555-2222', TRUE),
    ((SELECT student_id FROM students WHERE email = 'henry.lopez@university.edu'), '555-3333', TRUE),
    ((SELECT student_id FROM students WHERE email = 'henry.lopez@university.edu'), '555-3334', FALSE)
ON CONFLICT DO NOTHING;

-- =============================================================================
-- COURSES (extract unique courses from CSV)
-- 
-- From the CSV, identify unique courses with their details.
-- Link to instructor using subquery on instructor email.
-- =============================================================================
-- TODO: Write your INSERT statements here

INSERT INTO courses (code, title, description, credits, instructor_id)
VALUES
    ('CS101', 'Introduction to Programming', 'Learn the fundamentals of programming using Python', 3,
     (SELECT instructor_id FROM instructors WHERE email = 'sarah.smith@university.edu')),
    ('DB200', 'Database Design and Implementation', 'Master relational database design and SQL', 4,
     (SELECT instructor_id FROM instructors WHERE email = 'michael.jones@university.edu')),
    ('ML400', 'Machine Learning Fundamentals', 'Introduction to machine learning algorithms and applications', 4,
     (SELECT instructor_id FROM instructors WHERE email = 'sarah.smith@university.edu')),
    ('STAT250', 'Statistics for Data Science', 'Statistical methods and probability for data analysis', 3,
     (SELECT instructor_id FROM instructors WHERE email = 'robert.chen@university.edu')),
    ('WEB300', 'Full-Stack Web Development', 'Build modern web applications with React and Node.js', 4,
     (SELECT instructor_id FROM instructors WHERE email = 'jennifer.lee@university.edu'))
ON CONFLICT DO NOTHING;

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
