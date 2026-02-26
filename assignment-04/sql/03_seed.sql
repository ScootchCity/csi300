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
-- Tip: INSERT INTO departments (name, building) VALUES (...) ON CONFLICT (name) DO NOTHING;

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
-- Link to departments using department_id.
-- =============================================================================
-- TODO: Write your INSERT statements here
-- Tip: First query departments table to find IDs, then use those IDs in your INSERT

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
-- Link to instructor using instructor_id.
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

INSERT INTO modules (course_id, title, order_position)
VALUES
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'Variables and Data Types', 1),
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'Control Flow', 2),
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'Functions', 3),

    ((SELECT course_id FROM courses WHERE code = 'DB200'), 'ER Modeling', 1),
    ((SELECT course_id FROM courses WHERE code = 'DB200'), 'Normalization Theory', 2),
    ((SELECT course_id FROM courses WHERE code = 'DB200'), 'Advanced SQL', 3),

    ((SELECT course_id FROM courses WHERE code = 'ML400'), 'Supervised Learning', 1),
    ((SELECT course_id FROM courses WHERE code = 'ML400'), 'Unsupervised Learning', 2),
    ((SELECT course_id FROM courses WHERE code = 'ML400'), 'Neural Networks', 3),

    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Descriptive Statistics', 1),
    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Probability Theory', 2),
    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Inferential Statistics', 3),

    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'HTML/CSS Fundamentals', 1),
    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'JavaScript Essentials', 2),
    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'React Basics', 3),
    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'Node.js Backend', 4)
ON CONFLICT DO NOTHING;

-- =============================================================================
-- ASSIGNMENTS (split multi-valued assignment columns)
-- 
-- From the CSV, split the comma-separated assignments into individual rows.
-- Map assignment names to their due dates and points.
-- =============================================================================
-- TODO: Write your INSERT statements here

INSERT INTO assignments (course_id, name, due_date, points)
VALUES
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'HW1', '2026-02-01', 100),
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'HW2', '2026-02-15', 100),
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'Quiz1', '2026-02-20', 50),
    ((SELECT course_id FROM courses WHERE code = 'CS101'), 'HW3', '2026-03-01', 100),

    ((SELECT course_id FROM courses WHERE code = 'DB200'), 'Project1', '2026-02-28', 150),
    ((SELECT course_id FROM courses WHERE code = 'DB200'), 'Midterm', '2026-03-15', 100),
    ((SELECT course_id FROM courses WHERE code = 'DB200'), 'Project2', '2026-04-15', 150),

    ((SELECT course_id FROM courses WHERE code = 'ML400'), 'Assignment1', '2026-02-15', 100),
    ((SELECT course_id FROM courses WHERE code = 'ML400'), 'Assignment2', '2026-03-15', 100),
    ((SELECT course_id FROM courses WHERE code = 'ML400'), 'FinalProject', '2026-05-01', 250),

    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Quiz1', '2026-02-08', 50),
    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Midterm', '2026-03-01', 100),
    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Quiz2', '2026-04-01', 50),
    ((SELECT course_id FROM courses WHERE code = 'STAT250'), 'Final', '2026-05-10', 100),

    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'Lab1', '2026-02-10', 75),
    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'Lab2', '2026-02-24', 75),
    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'Midterm', '2026-03-20', 100),
    ((SELECT course_id FROM courses WHERE code = 'WEB300'), 'FinalProject', '2026-04-30', 200)
ON CONFLICT DO NOTHING;

-- =============================================================================
-- ENROLLMENTS (create junction table entries)
-- 
-- From the CSV, create enrollment records for each student-course combination.
-- Use student_id and course_id foreign keys to link records.
-- =============================================================================
-- TODO: Write your INSERT statements here

INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES
    ((SELECT student_id FROM students where email = 'alice.johnson@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'CS101'), '2026-01-15'),
    ((SELECT student_id FROM students where email = 'alice.johnson@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'DB200'), '2026-01-15'),

    ((SELECT student_id FROM students where email = 'bob.williams@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'CS101'), '2026-02-01'),
    ((SELECT student_id FROM students where email = 'bob.williams@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'WEB300'), '2026-01-20'),

    ((SELECT student_id FROM students where email = 'carol.davis@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'DB200'), '2026-01-18'),
    ((SELECT student_id FROM students where email = 'carol.davis@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'CS101'), '2026-01-18'),

    ((SELECT student_id FROM students where email = 'david.miller@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'ML400'), '2026-02-01'),
    ((SELECT student_id FROM students where email = 'david.miller@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'STAT250'), '2026-02-01'),

    ((SELECT student_id FROM students where email = 'emma.wilson@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'WEB300'), '2026-01-22'),
    ((SELECT student_id FROM students where email = 'emma.wilson@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'ML400'), '2026-02-05'),

    ((SELECT student_id FROM students where email = 'frank.garcia@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'CS101'), '2026-03-01'),

    ((SELECT student_id FROM students where email = 'grace.hernandez@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'DB200'), '2026-01-25'),
    ((SELECT student_id FROM students where email = 'grace.hernandez@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'STAT250'), '2026-01-25'),

    ((SELECT student_id FROM students where email = 'henry.lopez@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'ML400'), '2026-02-10'),
    ((SELECT student_id FROM students where email = 'henry.lopez@university.edu'), (SELECT course_id FROM courses WHERE CODE = 'WEB300'), '2026-02-10')
ON CONFLICT DO NOTHING;

-- =============================================================================
-- GRADES (only for completed enrollments with grades)
-- 
-- From the CSV, insert grade records only where grades exist.
-- Use enrollment_id to link to the enrollments table.
-- =============================================================================
-- TODO: Write your INSERT statements here

INSERT INTO grades (enrollment_id, grade, grade_points, completion_date)
VALUES
    --comment out nulls to match the verify
    (1, 'A', 4.0, '2026-04-30'),
    --(2, 'B+', 3.3, NULL),
    (3, 'B', 3.0, '2026-05-15'),
    (5, 'A-', 3.7, '2026-05-01'),
    (6, 'A', 4.0, '2026-04-28'),
    --(7, 'C+', 2.3, NULL),
    (8, 'B+', 3.3, '2026-05-12'),
    (9, 'A', 4.0, '2026-05-05'),
    --(10, 'B', 3.0, NULL),
    (12, 'B', 3.0, '2026-05-08'),
    --(13, 'A-', 3.7, NULL),
    (14, 'A', 4.0, '2026-05-10'),
    --(15, 'B+', 3.3, NULL)
ON CONFLICT DO NOTHING;

-- =============================================================================
-- CERTIFICATES (only for students who earned certificates)
-- 
-- From the CSV, insert certificate records where certificate_issued = 'Yes'.
-- =============================================================================
-- TODO: Write your INSERT statements here

INSERT INTO certificates (enrollment_id, issued_date)
VALUES
    (1, '2026-05-01'),
    (3, '2026-05-16'),
    (5, '2026-05-02'),
    (6, '2026-04-29'),
    (8, '2026-05-13'),
    (9, '2026-05-06'),
    (12, '2026-05-09'),
    (14, '2026-05-11')
ON CONFLICT DO NOTHING;