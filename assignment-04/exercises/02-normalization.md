# Exercise 2: Schema Normalization (35 points)

## Objective

Design a properly normalized database schema (3NF) for the EduLearn LMS based on your analysis from Exercise 1.

## Instructions

Create `sql/02_schema.sql` with DDL statements that implement your normalized design.

---

## Requirements

### Required Entities

Your schema must include tables for at least these entities:

| Entity | Description | Minimum Columns |
|--------|-------------|-----------------|
| `departments` | Academic departments | id, name, building |
| `instructors` | Course instructors | id, email, name, office, department_id |
| `students` | Enrolled students | id, email, name |
| `student_phones` | Student phone numbers (1NF fix) | student_id, phone_number |
| `courses` | Course catalog | id, code, title, description, credits, instructor_id |
| `modules` | Course modules/units | id, course_id, title, order_position |
| `assignments` | Course assignments | id, course_id, name, due_date, points |
| `enrollments` | Student-course enrollments | id, student_id, course_id, enrollment_date |
| `grades` | Enrollment grades | enrollment_id, grade, grade_points, completion_date |
| `certificates` | Issued certificates | id, enrollment_id, issued_date |

### Data Type Requirements

Choose appropriate data types:

| Type | Use For |
|------|---------|
| `SERIAL` or `INTEGER GENERATED ALWAYS AS IDENTITY` | Primary keys |
| `VARCHAR(n)` | Emails, names, codes |
| `TEXT` | Descriptions, longer text |
| `SMALLINT` | Credits, order positions |
| `INTEGER` | Points |
| `DECIMAL(3,1)` | Grade points (4.0 scale) |
| `CHAR(2)` or `VARCHAR(3)` | Letter grades (A, B+, etc.) |
| `DATE` | Dates without time |
| `BOOLEAN` | True/false flags |

### Constraint Requirements

Implement these constraints:

1. **Primary Keys**: Every table must have a primary key
2. **Foreign Keys**: All relationships must have FK constraints
3. **NOT NULL**: Required fields must be NOT NULL
4. **UNIQUE**: 
   - `student_email` must be unique
   - `instructor_email` must be unique
   - `course_code` must be unique
   - `(student_id, course_id)` combination must be unique in enrollments
5. **CHECK**:
   - `credits` must be between 1 and 6
   - `grade_points` must be between 0.0 and 4.0
   - `points` must be positive

### Idempotency

Your schema script must be **idempotent** - it should run multiple times without errors:
```sql
CREATE TABLE IF NOT EXISTS ...
```

---

## Normalization Checklist

Before submitting, verify your schema:

### First Normal Form (1NF)
- [ ] No multi-valued columns (phone numbers are in separate table)
- [ ] No repeating groups (modules, assignments are separate tables)
- [ ] All columns contain atomic values

### Second Normal Form (2NF)
- [ ] In 1NF
- [ ] No partial dependencies
- [ ] Every non-key attribute depends on the ENTIRE primary key

### Third Normal Form (3NF)
- [ ] In 2NF
- [ ] No transitive dependencies
- [ ] Non-key attributes depend ONLY on the primary key

---

## Entity Relationship Diagram

Create an ER diagram (ASCII or description) showing:
- All entities
- Primary keys
- Foreign key relationships
- Cardinality (1:1, 1:N, M:N)

Example format in comments:
```sql
/*
ENTITY RELATIONSHIP DIAGRAM

departments (1) ----< (N) instructors
instructors (1) ----< (N) courses
courses (1) ----< (N) modules
courses (1) ----< (N) assignments
students (1) ----< (N) student_phones
students (N) >----< (N) courses [through enrollments]
enrollments (1) ---- (1) grades
enrollments (1) ---- (0..1) certificates

Legend:
  (1) ----< (N)  = One-to-Many
  (N) >----< (N) = Many-to-Many (junction table)
  (1) ---- (0..1) = One-to-Zero-or-One (optional)
*/
```

---

## Template

```sql
-- =============================================================================
-- EduLearn LMS - Normalized Schema (3NF)
-- Assignment 04: Database Normalization
-- Student: [Your Name]
-- Date: [Date]
-- =============================================================================

/*
ENTITY RELATIONSHIP DIAGRAM
[Your ER diagram here]
*/

-- =============================================================================
-- DEPARTMENTS
-- Stores academic departments
-- =============================================================================
CREATE TABLE IF NOT EXISTS departments (
    -- Your columns here
);

-- =============================================================================
-- INSTRUCTORS
-- Stores instructor information
-- Depends on: departments
-- =============================================================================
CREATE TABLE IF NOT EXISTS instructors (
    -- Your columns here
);

-- Continue for all tables...
```

---

## Grading Rubric

| Criterion | Points |
|-----------|--------|
| All required tables present | 5 |
| Correct 1NF (no multi-valued columns) | 5 |
| Correct 2NF (no partial dependencies) | 5 |
| Correct 3NF (no transitive dependencies) | 5 |
| Appropriate data types | 5 |
| All constraints implemented (PK, FK, NOT NULL, UNIQUE, CHECK) | 5 |
| Idempotent (runs twice without error) | 3 |
| ER diagram included | 2 |
| **Total** | **35** |
