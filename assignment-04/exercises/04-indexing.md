# Exercise 4: Indexing Strategy (20 points)

## Objective

Create appropriate indexes to optimize common queries in the EduLearn LMS. You'll need to think about which columns are frequently used in WHERE clauses, JOIN conditions, and ORDER BY clauses.

## Instructions

Create `sql/04_indexes.sql` with index definitions and justifications for each index.

---

## Common Query Patterns

Consider these typical LMS queries when designing your indexes:

### 1. Student Lookups
```sql
-- Find student by email
SELECT * FROM students WHERE email = 'alice.johnson@university.edu';

-- Get all of a student's enrollments
SELECT * FROM enrollments WHERE student_id = 5;
```

### 2. Course Queries
```sql
-- Find course by code
SELECT * FROM courses WHERE code = 'CS101';

-- Get all courses taught by an instructor
SELECT * FROM courses WHERE instructor_id = 1;

-- List courses in a department
SELECT c.* FROM courses c
JOIN instructors i ON c.instructor_id = i.instructor_id
WHERE i.department_id = 1;
```

### 3. Enrollment Reports
```sql
-- Get all enrollments for a course
SELECT * FROM enrollments WHERE course_id = 2;

-- Find enrollments by date range
SELECT * FROM enrollments 
WHERE enrollment_date BETWEEN '2026-01-01' AND '2026-02-01';

-- Get enrollments with grades
SELECT e.*, g.grade, g.grade_points
FROM enrollments e
JOIN grades g ON e.enrollment_id = g.enrollment_id
WHERE g.grade_points >= 3.0;
```

### 4. Module and Assignment Queries
```sql
-- Get modules for a course in order
SELECT * FROM modules WHERE course_id = 1 ORDER BY order_position;

-- Get upcoming assignments
SELECT * FROM assignments 
WHERE due_date > CURRENT_DATE 
ORDER BY due_date;
```

### 5. Instructor Lookups
```sql
-- Find instructor by email
SELECT * FROM instructors WHERE email = 'sarah.smith@university.edu';

-- Get instructors in a department
SELECT * FROM instructors WHERE department_id = 1;
```

---

## Index Types to Consider

### B-Tree Indexes (Default)
Best for: equality comparisons, range queries, sorting
```sql
CREATE INDEX idx_name ON table(column);
```

### Unique Indexes
Best for: enforcing uniqueness + fast lookups
```sql
CREATE UNIQUE INDEX idx_name ON table(column);
```

### Composite Indexes
Best for: queries filtering on multiple columns
```sql
CREATE INDEX idx_name ON table(col1, col2);
```

### Partial Indexes
Best for: queries that only need a subset of rows
```sql
CREATE INDEX idx_name ON table(column) WHERE condition;
```

---

## Requirements

Create indexes for the following scenarios (minimum 10 indexes):

### Required Indexes

| # | Table | Column(s) | Purpose |
|---|-------|-----------|---------|
| 1 | `students` | `email` | Fast student lookup by email |
| 2 | `instructors` | `email` | Fast instructor lookup by email |
| 3 | `courses` | `code` | Fast course lookup by code |
| 4 | `courses` | `instructor_id` | Find courses by instructor |
| 5 | `enrollments` | `student_id` | Find student's enrollments |
| 6 | `enrollments` | `course_id` | Find course's enrollments |
| 7 | `enrollments` | `enrollment_date` | Date range queries |
| 8 | `modules` | `(course_id, order_position)` | Ordered module retrieval |
| 9 | `assignments` | `course_id` | Find course assignments |
| 10 | `assignments` | `due_date` | Upcoming assignment queries |

### Additional Indexes (choose 2-3)

Add indexes based on your analysis of likely query patterns:
- Grades by grade_points?
- Instructors by department?
- Composite index on enrollments?
- Partial index for active enrollments?

---

## Template

```sql
-- =============================================================================
-- EduLearn LMS - Index Definitions
-- Assignment 04: Database Normalization
-- Student: [Your Name]
-- =============================================================================

-- =============================================================================
-- STUDENT INDEXES
-- =============================================================================

-- Index: idx_students_email
-- Purpose: Fast lookup of students by email address
-- Query pattern: WHERE email = ?
-- Justification: Email is frequently used to identify students during login
--                and profile lookups. High selectivity makes this effective.
CREATE INDEX IF NOT EXISTS idx_students_email 
ON students(email);

-- =============================================================================
-- INSTRUCTOR INDEXES
-- =============================================================================

-- [Continue for all indexes...]

-- =============================================================================
-- COURSE INDEXES
-- =============================================================================

-- =============================================================================
-- ENROLLMENT INDEXES
-- =============================================================================

-- =============================================================================
-- MODULE INDEXES
-- =============================================================================

-- =============================================================================
-- ASSIGNMENT INDEXES
-- =============================================================================

-- =============================================================================
-- ADDITIONAL INDEXES
-- =============================================================================
```

---

## Justification Requirements

For each index, include:
1. **Purpose**: What queries does this optimize?
2. **Query pattern**: Example WHERE/JOIN clause
3. **Justification**: Why is this index beneficial?

Example:
```sql
-- Index: idx_enrollments_date
-- Purpose: Optimize date range queries for enrollment reports
-- Query pattern: WHERE enrollment_date BETWEEN ? AND ?
-- Justification: Semester reports frequently filter by date range.
--                B-tree index allows efficient range scans.
CREATE INDEX IF NOT EXISTS idx_enrollments_date 
ON enrollments(enrollment_date);
```

---

## Anti-Patterns to Avoid

❌ **Don't index every column** - indexes have maintenance costs

❌ **Don't create redundant indexes** - if you have `idx(a, b)`, you don't need `idx(a)`

❌ **Don't index low-selectivity columns alone** - e.g., boolean flags

❌ **Don't forget composite index column order matters** - put most selective first

---

## Grading Rubric

| Criterion | Points |
|-----------|--------|
| All 10 required indexes created | 10 |
| 2-3 additional appropriate indexes | 4 |
| Justifications provided for each | 4 |
| Idempotent (IF NOT EXISTS) | 1 |
| No anti-patterns | 1 |
| **Total** | **20** |
