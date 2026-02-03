-- =============================================================================
-- EduLearn LMS - Index Definitions
-- Assignment 04: Database Normalization
-- =============================================================================
-- This file creates appropriate indexes for common query patterns
-- =============================================================================

-- All tables are in the public schema (default)

-- =============================================================================
-- FOREIGN KEY INDEXES (Required for JOIN performance)
-- 
-- PostgreSQL does NOT automatically create indexes on foreign key columns.
-- Create indexes on FK columns to speed up joins and cascade operations.
-- =============================================================================

-- 1. Instructors -> Departments
-- Justification: Supports queries filtering instructors by department
-- TODO: CREATE INDEX IF NOT EXISTS idx_instructors_department ON ...


-- 2. Student Phones -> Students
-- Justification: Supports cascade deletes and phone lookups by student
-- TODO: CREATE INDEX IF NOT EXISTS idx_student_phones_student ON ...


-- 3. Courses -> Instructors
-- Justification: Supports "show all courses by instructor" queries
-- TODO: CREATE INDEX IF NOT EXISTS idx_courses_instructor ON ...


-- 4. Modules -> Courses
-- Justification: Essential for loading course content pages
-- TODO: CREATE INDEX IF NOT EXISTS idx_modules_course ON ...


-- 5. Assignments -> Courses
-- Justification: Required for course assignment pages
-- TODO: CREATE INDEX IF NOT EXISTS idx_assignments_course ON ...


-- 6. Enrollments -> Students
-- Justification: Critical for student dashboard showing enrolled courses
-- TODO: CREATE INDEX IF NOT EXISTS idx_enrollments_student ON ...


-- 7. Enrollments -> Courses
-- Justification: Essential for instructor viewing enrolled students
-- TODO: CREATE INDEX IF NOT EXISTS idx_enrollments_course ON ...


-- =============================================================================
-- QUERY OPTIMIZATION INDEXES (Based on common access patterns)
-- =============================================================================

-- 8. Assignments by due date
-- Justification: Supports "upcoming assignments" queries
-- TODO: CREATE INDEX IF NOT EXISTS idx_assignments_due_date ON ...


-- 9. Grades by grade value
-- Justification: Supports grade distribution reports
-- TODO: CREATE INDEX IF NOT EXISTS idx_grades_grade ON ...


-- =============================================================================
-- COMPOSITE INDEXES (For multi-column query optimization)
-- =============================================================================

-- 10. Modules by course and order
-- Justification: Optimizes: SELECT * FROM modules WHERE course_id = ? ORDER BY order_position
-- TODO: CREATE INDEX IF NOT EXISTS idx_modules_course_order ON ...


-- 11. Enrollments with date for reporting
-- Justification: Supports enrollment trend reports by course over time
-- TODO: CREATE INDEX IF NOT EXISTS idx_enrollments_course_date ON ...


-- =============================================================================
-- ADDITIONAL INDEXES (Performance tuning)
-- =============================================================================

-- 12. Students by name (for search functionality)
-- Justification: Supports autocomplete and search-as-you-type
-- TODO: CREATE INDEX IF NOT EXISTS idx_students_name ON ...


-- 13. Certificates by issue date
-- Justification: Supports "certificates issued this month" reports
-- TODO: CREATE INDEX IF NOT EXISTS idx_certificates_issued_date ON ...


-- =============================================================================
-- INDEX ANALYSIS QUERY
-- Run this to view all indexes in the edulearn schema
-- =============================================================================
SELECT 
    t.relname AS table_name,
    i.relname AS index_name,
    a.attname AS column_name,
    ix.indisunique AS is_unique,
    ix.indisprimary AS is_primary
FROM 
    pg_class t
    JOIN pg_index ix ON t.oid = ix.indrelid
    JOIN pg_class i ON i.oid = ix.indexrelid
    JOIN pg_attribute a ON a.attrelid = t.oid AND a.attnum = ANY(ix.indkey)
    JOIN pg_namespace n ON n.oid = t.relnamespace
WHERE 
    n.nspname = 'edulearn'
    AND t.relkind = 'r'
ORDER BY 
    t.relname, i.relname;


-- =============================================================================
-- INDEX USAGE NOTES
-- =============================================================================

/*
IMPORTANT INDEX CONSIDERATIONS:

1. UNIQUE Constraints Create Indexes Automatically:
   - departments.name (UNIQUE)
   - instructors.email (UNIQUE)
   - students.email (UNIQUE)
   - courses.code (UNIQUE)
   - enrollments(student_id, course_id) (UNIQUE)
   - certificates.enrollment_id (UNIQUE)
   - modules(course_id, order_position) (UNIQUE)

2. Primary Keys Create Indexes Automatically:
   - All _id columns have indexes

3. When to Add Indexes:
   - Columns used in WHERE clauses
   - Columns used in JOIN conditions
   - Columns used in ORDER BY
   - Foreign key columns

4. When NOT to Add Indexes:
   - Tables with few rows
   - Columns rarely queried
   - Columns with low cardinality (few unique values)
   - Tables with frequent INSERT/UPDATE/DELETE operations
*/
