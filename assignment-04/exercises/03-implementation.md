# Exercise 3: Seed Data Implementation (20 points)

## Objective

Populate your normalized schema with the data from the original unnormalized CSV file. This exercise tests your understanding of how data should be distributed across normalized tables.

## Instructions

Create `sql/03_seed.sql` with INSERT statements that populate all your tables with data equivalent to the original CSV.

---

## Requirements

### Data Mapping

Transform the 15 rows from `unnormalized_lms.csv` into properly normalized data:

| Original Data | Target Tables |
|--------------|---------------|
| Unique departments | `departments` |
| Unique instructors | `instructors` |
| Unique students | `students` |
| Student phone numbers | `student_phones` |
| Unique courses | `courses` |
| Course modules | `modules` |
| Course assignments | `assignments` |
| Enrollments | `enrollments` |
| Grades | `grades` |
| Certificates | `certificates` |

### Expected Record Counts

After running your seed script:

| Table | Expected Count | Notes |
|-------|----------------|-------|
| `departments` | 3 | Computer Science, Information Systems, Mathematics |
| `instructors` | 4 | Dr. Smith, Dr. Jones, Dr. Lee, Dr. Chen |
| `students` | 8 | Alice, Bob, Carol, David, Emma, Frank, Grace, Henry |
| `student_phones` | 12 | Alice(2), Bob(1), Carol(3), David(1), Emma(2), Grace(1), Henry(2) |
| `courses` | 5 | CS101, DB200, WEB300, ML400, STAT250 |
| `modules` | 16 | 3+3+4+3+3 per course |
| `assignments` | 16 | Varies per course |
| `enrollments` | 15 | Same as original rows |
| `grades` | 9 | Only completed enrollments with grades |
| `certificates` | 7 | Only enrollments with certificates issued |

### Data Integrity

Your INSERT statements must:
1. Insert data in the correct order (parents before children)
2. Use consistent IDs that match your foreign keys
3. Handle NULL values appropriately (Frank has no phone)
4. Preserve all original information

---

## Insertion Order

Insert data in this order to satisfy foreign key constraints:

```sql
-- 1. Independent tables first (no foreign keys)
INSERT INTO departments ...
INSERT INTO students ...

-- 2. Tables with one level of dependency
INSERT INTO instructors ...  -- depends on departments
INSERT INTO student_phones ... -- depends on students

-- 3. Tables with multiple dependencies
INSERT INTO courses ... -- depends on instructors

-- 4. Course-related tables
INSERT INTO modules ... -- depends on courses
INSERT INTO assignments ... -- depends on courses

-- 5. Enrollment-related tables
INSERT INTO enrollments ... -- depends on students, courses
INSERT INTO grades ... -- depends on enrollments
INSERT INTO certificates ... -- depends on enrollments
```

---

## Handling Multi-Valued Data

The original data has comma-separated values that need to be split:

### Phone Numbers
Original: `"555-1234, 555-5678"`

Becomes:
```sql
INSERT INTO student_phones (student_id, phone_number) VALUES
(1, '555-1234'),
(1, '555-5678');
```

### Modules
Original: `"Variables and Data Types, Control Flow, Functions"`

Becomes:
```sql
INSERT INTO modules (course_id, title, order_position) VALUES
(1, 'Variables and Data Types', 1),
(1, 'Control Flow', 2),
(1, 'Functions', 3);
```

### Assignments
Original: `"HW1, HW2, Quiz1, HW3"` with due dates `"2026-02-01, 2026-02-15, 2026-02-20, 2026-03-01"` and points `"100, 100, 50, 100"`

Becomes:
```sql
INSERT INTO assignments (course_id, name, due_date, points) VALUES
(1, 'HW1', '2026-02-01', 100),
(1, 'HW2', '2026-02-15', 100),
(1, 'Quiz1', '2026-02-20', 50),
(1, 'HW3', '2026-03-01', 100);
```

---

## Template

```sql
-- =============================================================================
-- EduLearn LMS - Seed Data
-- Assignment 04: Database Normalization
-- Student: [Your Name]
-- =============================================================================

-- =============================================================================
-- DEPARTMENTS (3 records)
-- =============================================================================
INSERT INTO departments (department_id, name, building) VALUES
(1, 'Computer Science', 'Tech Building'),
(2, 'Information Systems', 'Business Building'),
(3, 'Mathematics', 'Science Building')
ON CONFLICT DO NOTHING;

-- =============================================================================
-- STUDENTS (8 records)
-- =============================================================================
INSERT INTO students (student_id, email, name) VALUES
-- Your data here
ON CONFLICT DO NOTHING;

-- Continue for all tables...
```

---

## Tips

1. **Use ON CONFLICT DO NOTHING** for idempotency
2. **Extract unique values** from the CSV before writing INSERTs
3. **Verify counts** after insertion match expected values
4. **Test foreign keys** by trying to insert invalid references

---

## Grading Rubric

| Criterion | Points |
|-----------|--------|
| All tables populated | 5 |
| Correct record counts | 5 |
| Multi-valued data properly split | 4 |
| Correct insertion order (no FK violations) | 3 |
| Data integrity maintained | 2 |
| Idempotent (ON CONFLICT handling) | 1 |
| **Total** | **20** |
