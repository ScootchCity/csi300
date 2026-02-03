# Assignment 5: SQL Joins

## Overview

In this assignment, you'll practice SQL joins using **MedCare Health Clinic**, a comprehensive healthcare database. You'll work with patient records, doctor schedules, appointments, diagnoses, prescriptions, lab tests, and insurance claims to master all types of SQL joins.

## Learning Objectives

By completing this assignment, you will be able to:

- Write INNER JOINs to combine related tables
- Use LEFT and RIGHT OUTER JOINs to include unmatched rows
- Apply FULL OUTER JOINs for complete data comparisons
- Implement self-joins for hierarchical relationships
- Combine multiple tables in complex queries
- Understand when to use each type of join

## Database: MedCare Health Clinic

MedCare is a multi-specialty health clinic managing:

- **Patients**: Demographics, contact info, insurance
- **Doctors**: Specializations, departments, schedules
- **Departments**: Cardiology, Neurology, Orthopedics, etc.
- **Appointments**: Patient-doctor visits
- **Diagnoses**: Medical conditions identified
- **Medications**: Drug catalog
- **Prescriptions**: Medications prescribed to patients
- **Lab Tests**: Available laboratory tests
- **Lab Results**: Test results for patients
- **Insurance Providers**: Health insurance companies
- **Claims**: Insurance billing records

## Schema Diagram

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   departments   │       │  specializations│       │  insurance_     │
│─────────────────│       │─────────────────│       │  providers      │
│ department_id   │◄──┐   │ specialization_ │       │─────────────────│
│ name            │   │   │   id            │       │ provider_id     │
│ building        │   │   │ name            │       │ name            │
│ floor           │   │   │ description     │       │ plan_type       │
└─────────────────┘   │   └────────┬────────┘       └────────┬────────┘
                      │            │                         │
                      │            ▼                         │
┌─────────────────┐   │   ┌─────────────────┐       ┌────────▼────────┐
│    doctors      │───┘   │ doctor_         │       │    patients     │
│─────────────────│       │ specializations │       │─────────────────│
│ doctor_id       │◄──────│─────────────────│       │ patient_id      │
│ first_name      │       │ doctor_id       │       │ first_name      │
│ last_name       │       │ specialization_ │       │ last_name       │
│ email           │       │   id            │       │ date_of_birth   │
│ phone           │       │ is_primary      │       │ email           │
│ department_id   │       └─────────────────┘       │ phone           │
│ hire_date       │                                 │ address         │
│ supervisor_id   │──┐                              │ insurance_id    │
└────────┬────────┘  │                              │ emergency_      │
         │           │                              │   contact       │
         └───────────┘ (self-join)                  └────────┬────────┘
                                                             │
┌─────────────────┐       ┌─────────────────┐                │
│  appointments   │       │   diagnoses     │                │
│─────────────────│       │─────────────────│                │
│ appointment_id  │◄──────│ diagnosis_id    │                │
│ patient_id      │───────│ appointment_id  │◄───────────────┘
│ doctor_id       │       │ icd_code        │
│ scheduled_at    │       │ description     │
│ duration_mins   │       │ severity        │
│ status          │       │ notes           │
│ visit_type      │       └─────────────────┘
│ reason          │
│ notes           │       ┌─────────────────┐       ┌─────────────────┐
└─────────────────┘       │  medications    │       │    lab_tests    │
                          │─────────────────│       │─────────────────│
┌─────────────────┐       │ medication_id   │       │ test_id         │
│  prescriptions  │       │ name            │       │ name            │
│─────────────────│       │ generic_name    │       │ category        │
│ prescription_id │       │ category        │       │ description     │
│ diagnosis_id    │       │ dosage_form     │       │ normal_range    │
│ medication_id   │───────│ strength        │       │ unit            │
│ doctor_id       │       │ manufacturer    │       │ turnaround_hrs  │
│ dosage          │       └─────────────────┘       └────────┬────────┘
│ frequency       │                                          │
│ duration_days   │       ┌─────────────────┐                │
│ refills         │       │   lab_results   │                │
│ instructions    │       │─────────────────│                │
└─────────────────┘       │ result_id       │                │
                          │ patient_id      │────────────────┘
┌─────────────────┐       │ test_id         │
│     claims      │       │ doctor_id       │
│─────────────────│       │ ordered_at      │
│ claim_id        │       │ collected_at    │
│ patient_id      │       │ result_value    │
│ appointment_id  │       │ status          │
│ provider_id     │       │ notes           │
│ amount_billed   │       └─────────────────┘
│ amount_covered  │
│ amount_owed     │
│ status          │
│ filed_at        │
└─────────────────┘
```

## Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Terminal/Command Line access
- SQL client (Adminer provided, or use psql)

### Setup Instructions

1. Navigate to the assignment directory:
   ```bash
   cd 05-joins/assignment
   ```

2. Start the database:
   ```bash
   docker-compose up -d
   ```

3. Wait for initialization (~15 seconds), then verify:
   ```bash
   docker-compose run --rm verify
   ```

4. Access the database:
   - **Adminer**: http://localhost:8080
     - System: PostgreSQL
     - Server: postgres
     - Username: postgres
     - Password: postgres
     - Database: postgres
   - **psql**: 
     ```bash
     docker-compose exec postgres psql -U postgres -d postgres
     ```

## Exercises

| Exercise | Topic | Points |
|----------|-------|--------|
| [Exercise 1](exercises/01-inner-joins.md) | INNER JOINs | 20 |
| [Exercise 2](exercises/02-left-joins.md) | LEFT OUTER JOINs | 20 |
| [Exercise 3](exercises/03-right-full-joins.md) | RIGHT & FULL OUTER JOINs | 20 |
| [Exercise 4](exercises/04-self-joins.md) | Self-Joins & Cross Joins | 20 |
| [Exercise 5](exercises/05-multi-table-joins.md) | Multi-Table Complex Joins | 20 |

**Total Points: 100**

## Submission Requirements

1. Create SQL files in the `sql/` directory:
   - `exercise01.sql`
   - `exercise02.sql`
   - `exercise03.sql`
   - `exercise04.sql`
   - `exercise05.sql`

2. Each file should:
   - Include comments identifying each task
   - Contain working SQL queries
   - Be properly formatted

3. Test your queries before submitting

## Grading Rubric

| Criteria | Points |
|----------|--------|
| Query correctness | 60 |
| Proper join type usage | 20 |
| Query efficiency | 10 |
| Code formatting & comments | 10 |

## Tips for Success

- **Understand the relationships**: Study the schema diagram before writing queries
- **Start with INNER JOIN**: It's the most common and intuitive
- **Think about NULL handling**: Outer joins introduce NULLs for non-matches
- **Use table aliases**: Makes queries more readable (e.g., `p` for patients)
- **Test incrementally**: Build complex joins step by step
- **Check row counts**: Verify your joins return expected number of rows

## Cleanup

When finished, stop and remove containers:

```bash
docker-compose down -v
```

## Resources

- [PostgreSQL JOIN Documentation](https://www.postgresql.org/docs/current/tutorial-join.html)
- Course materials: `join-fundamentals.md` and `outer-joins-and-advanced-patterns.md`
