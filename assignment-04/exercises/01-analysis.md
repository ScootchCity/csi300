# Exercise 1: Data Analysis Quiz (25 points)

DO THIS EXERCISE ON CANVAS ONLY. DO NOT SUBMIT ANY FILES HERE.

## Objective

Analyze the unnormalized LMS data in `../data/unnormalized_lms.csv` to identify problems, anomalies, and functional dependencies.

**Instructions:** Review the CSV file and answer the following multiple-choice questions.

## Part 1.1: Update Anomalies (4 points)

**Q1.1.1** (1 pt): If Dr. Sarah Smith changes her office from "Room 301" to "Room 305", how many rows need to be updated?

- [ ] A) 3
- [ ] B) 5
- [ ] C) 7
- [ ] D) 9

**Q1.1.2** (1 pt): If the course title for CS101 changes from "Introduction to Programming" to "Programming Fundamentals", how many rows need to be updated?

- [ ] A) 2
- [ ] B) 4
- [ ] C) 6
- [ ] D) 8

**Q1.1.3** (1 pt): If Alice Johnson changes her name to Alice Smith, how many rows need to be updated?

- [ ] A) 1
- [ ] B) 2
- [ ] C) 3
- [ ] D) 4

**Q1.1.4** (1 pt): If the Computer Science department moves from "Tech Building" to "Engineering Building", how many rows need to be updated?

- [ ] A) 6
- [ ] B) 8
- [ ] C) 10
- [ ] D) 12

## Part 1.2: Insert Anomalies (3 points)

**Q1.2.1** (1 pt): Can we add a new instructor "Dr. Jane Doe" who hasn't been assigned any courses yet?

- [ ] A) Yes, we can add a row with just instructor information
- [ ] B) No, we need enrollment_id which requires a student enrollment
- [ ] C) Yes, if we leave student fields NULL
- [ ] D) No, but we can add them to a separate instructors table

**Q1.2.2** (1 pt): Can we add a new department "Data Science" in "Analytics Building" without any courses or students?

- [ ] A) Yes, departments are independent entities in this structure
- [ ] B) No, department info only exists as part of instructor records tied to enrollments
- [ ] C) Yes, by adding a row with NULL enrollment_id
- [ ] D) No, but we can use a placeholder student

**Q1.2.3** (1 pt): To add a new module "Advanced Topics" to course ML400, what must we do?

- [ ] A) Add a new row with module information only
- [ ] B) Update the module_id, module_title, module_order columns in ALL ML400 rows
- [ ] C) Add a new enrollment with the new module
- [ ] D) Modules can be added independently without any issues

## Part 1.3: Delete Anomalies (3 points)

**Q1.3.1** (1 pt): If Frank Garcia (enrollment_id 11) withdraws from CS101, what information is lost?

- [ ] A) Only the enrollment record
- [ ] B) Frank Garcia's existence as a student (his only enrollment)
- [ ] C) The CS101 course information
- [ ] D) Dr. Sarah Smith's information

**Q1.3.2** (1 pt): If we delete ALL enrollments for course STAT250 (rows 8 and 13), what unique instructor information would be lost?

- [ ] A) Dr. Sarah Smith's information
- [ ] B) Dr. Michael Jones's information
- [ ] C) Dr. Robert Chen's information (only teaches STAT250)
- [ ] D) No instructor information would be lost

**Q1.3.3** (1 pt): What happens if we delete enrollment_id 4 (Bob Williams in WEB300)?

- [ ] A) We lose Bob Williams as a student entirely
- [ ] B) We lose the WEB300 course information
- [ ] C) Bob Williams still exists (enrolled in CS101), no course info lost
- [ ] D) Dr. Jennifer Lee's information is lost

## Part 2.1: First Normal Form (1NF) Violations (2 points)

**Q2.1.1** (1 pt): Which columns violate 1NF by containing multiple comma-separated values? (Select ALL that apply)

- [ ] A) student_email
- [ ] B) student_phone
- [ ] C) course_code
- [ ] D) module_id
- [ ] E) module_title
- [ ] F) module_order
- [ ] G) assignment_names
- [ ] H) assignment_due_dates
- [ ] I) assignment_points

**Q2.1.2** (1 pt): How many columns in total violate 1NF (contain multi-valued data)?

- [ ] A) 4
- [ ] B) 5
- [ ] C) 6
- [ ] D) 7

## Part 2.2: Second Normal Form (2NF) Violations (3 points)

*Consider (student_email, course_code) as a composite candidate key for enrollment data.*

**Q2.2.1** (1 pt): Which attribute depends ONLY on student_email (partial dependency)?

- [ ] A) enrollment_date
- [ ] B) student_name
- [ ] C) grade
- [ ] D) completion_date

**Q2.2.2** (1 pt): Which attribute depends ONLY on course_code (partial dependency)?

- [ ] A) grade_points
- [ ] B) certificate_issued
- [ ] C) course_credits
- [ ] D) enrollment_date

**Q2.2.3** (1 pt): Which attributes depend on the FULL composite key (student_email, course_code)?

- [ ] A) student_name, student_phone
- [ ] B) course_title, course_description
- [ ] C) enrollment_date, grade, completion_date
- [ ] D) instructor_email, instructor_name

## Part 2.3: Third Normal Form (3NF) Violations (3 points)

**Q2.3.1** (1 pt): In the dependency chain: course_code → instructor_email → instructor_name, what type of dependency does instructor_name have on course_code?

- [ ] A) Direct dependency
- [ ] B) Partial dependency
- [ ] C) Transitive dependency
- [ ] D) No dependency

**Q2.3.2** (1 pt): Which shows a transitive dependency through instructor_department?

- [ ] A) course_code → instructor_department → department_building
- [ ] B) student_email → course_code → instructor_department
- [ ] C) enrollment_id → student_email → student_name
- [ ] D) instructor_email → instructor_department → department_building

**Q2.3.3** (1 pt): How many "hops" are in this transitive chain: enrollment_id → course_code → instructor_email → instructor_department → department_building?

- [ ] A) 2
- [ ] B) 3
- [ ] C) 4
- [ ] D) 5

## Part 3: Functional Dependencies (7 points)

**Q3.1** (1 pt): Which is the correct functional dependency for students?

- [ ] A) student_name → student_email, student_phone
- [ ] B) student_email → student_name, student_phone
- [ ] C) student_phone → student_email, student_name
- [ ] D) enrollment_id → student_email only

**Q3.2** (1 pt): Which is the correct functional dependency for instructors?

- [ ] A) instructor_name → instructor_email, instructor_office, instructor_department
- [ ] B) instructor_department → instructor_email, instructor_name, instructor_office
- [ ] C) instructor_email → instructor_name, instructor_office, instructor_department
- [ ] D) instructor_office → instructor_email, instructor_name

**Q3.3** (1 pt): Which is the correct functional dependency for courses?

- [ ] A) course_title → course_code, course_description, course_credits, instructor_email
- [ ] B) course_code → course_title, course_description, course_credits, instructor_email
- [ ] C) course_credits → course_code, course_title, course_description
- [ ] D) instructor_email → course_code, course_title

**Q3.4** (1 pt): What does module_id functionally determine?

- [ ] A) module_id → module_title, module_order, course_code
- [ ] B) module_id → module_title, module_order only
- [ ] C) module_id → course_code only
- [ ] D) module_title → module_id, module_order

**Q3.5** (1 pt): What is the correct dependency for enrollment-specific data?

- [ ] A) student_email → enrollment_date, grade, completion_date
- [ ] B) course_code → enrollment_date, grade, completion_date
- [ ] C) enrollment_id → student_email, course_code, enrollment_date, grade, completion_date
- [ ] D) grade → enrollment_id, grade_points

**Q3.6** (1 pt): What does instructor_department functionally determine?

- [ ] A) instructor_department → instructor_email, instructor_name
- [ ] B) instructor_department → department_building
- [ ] C) department_building → instructor_department
- [ ] D) instructor_department → course_code

**Q3.7** (1 pt): The composite key (student_email, course_code) determines which of the following?

- [ ] A) student_name, student_phone
- [ ] B) course_title, course_description
- [ ] C) grade, grade_points, enrollment_date, completion_date
- [ ] D) instructor_email, instructor_name
