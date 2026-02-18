# Assignment 04 — Database Normalization: EduLearn LMS

## Overview

In this assignment, you will analyze a poorly designed database, identify normalization problems, and design a properly normalized schema for **EduLearn**, an online Learning Management System (LMS). You will apply normalization theory to eliminate data anomalies and create an efficient, maintainable database structure.

**Scenario:** You've been hired as a database consultant for EduLearn, a growing online education platform. Their current database is a mess—data is duplicated everywhere, updates cause inconsistencies, and the development team is frustrated. Your task is to analyze the problems, apply normalization principles, and design a clean, normalized schema.

## Learning Objectives

By completing this assignment, you will demonstrate proficiency in:

- Identifying functional dependencies in data
- Recognizing normalization violations (1NF, 2NF, 3NF)
- Detecting update, insert, and delete anomalies
- Decomposing tables to achieve Third Normal Form (3NF)
- Designing proper entity relationships (1:1, 1:N, M:N)
- Creating junction tables for many-to-many relationships
- Implementing appropriate indexes for common queries
- Writing DDL that implements a normalized schema

## Prerequisites

1. Complete Assignments 01-03
2. Read the Week 04 course materials on normalization, entity relationships, and indexing
3. Understand functional dependencies and normal forms (1NF, 2NF, 3NF, BCNF)

## Setup

1. Navigate to the `assignment-04` folder in your terminal
2. Run `docker-compose up -d` to start PostgreSQL and Adminer
3. Connect via Adminer (`http://localhost:8080`) or your preferred client
4. Review the problematic data in `data/unnormalized_lms.csv`

## File Structure

```
assignment-04/
├── docker-compose.yml          # Provided - PostgreSQL on port 5432
├── README.md                   # This file
├── verify.sh                   # Grading script (DO NOT MODIFY)
├── data/
│   └── unnormalized_lms.csv    # Problematic spreadsheet to analyze
├── exercises/
│   ├── 01-analysis.md          # Identify problems & dependencies
│   ├── 02-normalization.md     # Design normalized schema
│   ├── 03-implementation.md    # Write DDL & seed data
│   └── 04-indexing.md          # Add appropriate indexes
└── sql/                        # Your solutions go here
    ├── 02_schema.sql           # Normalized DDL
    ├── 03_seed.sql             # Insert statements
    └── 04_indexes.sql          # Index definitions
```

## The Problem: EduLearn's Messy Database

The EduLearn team has been storing all their data in a single spreadsheet-like table. Review `data/unnormalized_lms.csv` to see the current state:

| enrollment_id | student_email | student_name | student_phone | course_code | course_title | instructor_email | instructor_name | instructor_department | module_titles | assignment_names | enrollment_date | grade | certificate_issued |
|--------------|---------------|--------------|---------------|-------------|--------------|------------------|-----------------|----------------------|---------------|------------------|-----------------|-------|-------------------|
| 1 | alice@uni.edu | Alice Johnson | 555-1234, 555-5678 | CS101 | Intro to Programming | prof.smith@edu.com | Dr. Sarah Smith | Computer Science | Variables, Loops, Functions | HW1, HW2, Quiz1 | 2026-01-15 | A | Yes |
| 2 | alice@uni.edu | Alice Johnson | 555-1234, 555-5678 | DB200 | Database Design | prof.jones@edu.com | Dr. Mike Jones | Information Systems | ER Modeling, Normalization, SQL | Project1, Midterm | 2026-01-15 | B+ | No |
| 3 | bob@uni.edu | Bob Williams | 555-9999 | CS101 | Intro to Programming | prof.smith@edu.com | Dr. Sarah Smith | Computer Science | Variables, Loops, Functions | HW1, HW2, Quiz1 | 2026-02-01 | B | Yes |

**This table violates every normal form!** Your job is to fix it.

## Exercises

Complete each exercise in order:

| Exercise | File to Create | Topic | Points |
|----------|----------------|-------|--------|
| [Exercise 1](exercises/01-analysis.md) | Canvas Quiz | Identify anomalies & functional dependencies | 25 |
| [Exercise 2](exercises/02-normalization.md) | `sql/02_schema.sql` | Design normalized schema (3NF) | 35 |
| [Exercise 3](exercises/03-implementation.md) | `sql/03_seed.sql` | Populate with seed data | 20 |
| [Exercise 4](exercises/04-indexing.md) | `sql/04_indexes.sql` | Create appropriate indexes | 20 |

## Grading Rubric

| Criterion | Points | Description |
|-----------|--------|-------------|
| Problem Analysis | 25 | Correctly identify all anomalies and functional dependencies |
| Schema Design | 35 | Proper normalization to 3NF, correct relationships, appropriate data types |
| Seed Data | 20 | Data correctly distributed across normalized tables |
| Indexing | 20 | Appropriate indexes for common queries with justification |

**Total: 100 points**

## Key Concepts to Apply

### Functional Dependencies to Identify
- What determines what?
- `student_email → student_name, student_phone`
- `course_code → course_title, instructor_email`
- `instructor_email → instructor_name, instructor_department`

### Normalization Checklist
- [ ] **1NF**: No multi-valued attributes (phone numbers, module titles, assignments)
- [ ] **2NF**: No partial dependencies (all non-key attributes depend on the FULL key)
- [ ] **3NF**: No transitive dependencies (no non-key → non-key dependencies)

### Expected Entities After Normalization
You should end up with approximately these entities:
- Students
- Instructors
- Departments
- Courses
- Modules
- Assignments
- Enrollments
- Student Phone Numbers (multi-valued attribute)
- Grades/Certificates

## Testing Your Work

```bash
# Start containers
docker-compose up -d

# Run verification via docker compose
docker-compose run --rm verify

# Manual testing via docker compose
docker-compose exec -T postgres psql -U postgres -d postgres -f /sql/02_schema.sql
```

## Submission

1. Complete all files in the `sql/` folder
2. Run `./verify.sh` to validate your work
3. Commit and push to your repository
4. The GitHub Actions workflow will run automated tests

## Common Mistakes to Avoid

- Keeping multi-valued attributes in a single column
- Creating tables that still have partial dependencies
- Forgetting junction tables for M:N relationships
- Not identifying transitive dependencies
- Over-normalizing (splitting data that belongs together)
- Forgetting foreign key constraints
- Creating indexes on every column (be strategic!)
- Not using appropriate data types

