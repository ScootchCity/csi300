-- =============================================================================
-- Exercise 5: Views and Materialized Views
-- PawCare Veterinary Clinic
-- =============================================================================

-- Task 5.1: Create Basic Views (4 points)
--
-- View A: v_pet_directory
-- Purpose: Pet contact information with primary clinic
-- Columns: pet_id, pet_name, species_name, breed, owner_name,
--          owner_email, owner_phone, primary_clinic
-- primary_clinic: Clinic with most visits for this pet
-- Tables: pets, species, owners, appointments, clinics
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_pet_directory AS ...

CREATE OR REPLACE VIEW v_pet_directory AS
SELECT
    p.pet_id,
    p.pet_name,
    s.species_name,
    p.breed,
    o.first_name || ' ' || o.last_name AS owner_name,
    o.email                            AS owner_email,
    o.phone                            AS owner_phone,
    (
        SELECT c.clinic_name
        FROM appointments a
        JOIN clinics c ON a.clinic_id = c.clinic_id
        WHERE a.pet_id = p.pet_id
        GROUP BY c.clinic_id, c.clinic_name
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS primary_clinic
FROM pets p
JOIN species s ON p.species_id = s.species_id
JOIN owners  o ON p.owner_id   = o.owner_id;


-- View B: v_staff_directory
-- Purpose: Staff contact information with manager
-- Columns: staff_id, full_name, role, specialization, clinic_name,
--          email, phone, manager_name
-- Tables: staff, clinics
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_staff_directory AS ...

CREATE OR REPLACE VIEW v_staff_directory AS
SELECT
    s.staff_id,
    s.first_name || ' ' || s.last_name    AS full_name,
    s.role,
    s.specialization,
    c.clinic_name,
    s.email,
    s.phone,
    m.first_name || ' ' || m.last_name    AS manager_name
FROM staff s
LEFT JOIN clinics c ON s.clinic_id  = c.clinic_id
LEFT JOIN staff  m  ON s.reports_to = m.staff_id;


-- Task 5.2: Create Updatable View (4 points)
--
-- View: v_owner_updates
-- Purpose: Allow safe updates to owner contact information
-- Columns: owner_id, first_name, last_name, email, phone,
--          address, city, state, zip_code
-- Table: owners (single table for updatability)
--
-- Explain in a comment why this view is updatable:
-- (What conditions must a view meet to be updatable?)
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_owner_updates AS ...

-- This view is updatable because it:
--   1. References a single base table (owners) with no JOINs
--   2. Contains no aggregates, DISTINCT, GROUP BY, HAVING, LIMIT, or set operations
--   3. Uses no subqueries, window functions, or set-returning functions
--   4. Maps each output row 1-to-1 with a row in the base table
-- PostgreSQL can therefore translate an UPDATE/INSERT/DELETE on the view
-- directly into the equivalent DML on the underlying owners table.
CREATE OR REPLACE VIEW v_owner_updates AS
SELECT
    owner_id,
    first_name,
    last_name,
    email,
    phone,
    address,
    city,
    state,
    zip_code
FROM owners;

-- Verify the view works
SELECT * FROM v_owner_updates LIMIT 5;

-- Example UPDATE (not executed — remove the leading '--' to run):
-- UPDATE v_owner_updates SET phone = '555-0199' WHERE owner_id = 1;


-- Task 5.3: View with CHECK OPTION (4 points)
--
-- View: v_active_appointments
-- Purpose: Show and manage only scheduled/confirmed appointments
-- Columns: appointment_id, pet_name, owner_phone, vet_name, clinic_name,
--          scheduled_at, status
-- Filter: status IN ('scheduled', 'confirmed')
-- Add: WITH CHECK OPTION
--
-- IMPORTANT: WITH CHECK OPTION requires the view to be "automatically updatable",
-- which means the FROM clause must reference exactly ONE base table (no JOINs).
-- To still display pet_name, owner_phone, vet_name, and clinic_name, use
-- correlated scalar subqueries in the SELECT list instead of JOINs.
-- Example: (SELECT p.pet_name FROM pets p WHERE p.pet_id = a.pet_id) AS pet_name
--
-- Explain in a comment what happens if someone tries to UPDATE the status
-- to 'completed' through this view:
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_active_appointments AS ...

-- WITH CHECK OPTION behaviour:
-- If someone ran: UPDATE v_active_appointments SET status = 'completed' WHERE ...
-- PostgreSQL would reject it with an error like
--   "ERROR: new row violates check option for view v_active_appointments"
-- because the updated row's status ('completed') no longer satisfies the
-- view's WHERE condition (status IN ('scheduled', 'confirmed')), and
-- WITH CHECK OPTION prevents modifications that would cause the row to
-- disappear from the view.
CREATE OR REPLACE VIEW v_active_appointments AS
SELECT
    appointment_id,
    (SELECT p.pet_name FROM pets p WHERE p.pet_id = a.pet_id)                           AS pet_name,
    (SELECT o.phone FROM owners o JOIN pets p ON o.owner_id = p.owner_id
     WHERE p.pet_id = a.pet_id)                                                          AS owner_phone,
    (SELECT s.first_name || ' ' || s.last_name FROM staff s WHERE s.staff_id = a.vet_id) AS vet_name,
    (SELECT c.clinic_name FROM clinics c WHERE c.clinic_id = a.clinic_id)               AS clinic_name,
    scheduled_at,
    status
FROM appointments a
WHERE status IN ('scheduled', 'confirmed')
WITH CHECK OPTION;


-- Task 5.4: Materialized View for Performance (4 points)
--
-- Materialized View: mv_clinic_performance
-- Purpose: Pre-computed clinic performance metrics (expensive to calculate)
-- Columns: clinic_id, clinic_name, total_appointments, completed_appointments,
--          cancellation_rate (%), avg_invoice_amount, total_revenue,
--          unique_pets, unique_vets
-- Tables: clinics, appointments, invoices
--
-- This would be refreshed periodically (e.g., nightly) for dashboards
-- -----------------------------------------------------------------------------
-- TODO: CREATE MATERIALIZED VIEW mv_clinic_performance AS ...

CREATE MATERIALIZED VIEW mv_clinic_performance AS
SELECT
    c.clinic_id,
    c.clinic_name,
    COUNT(a.appointment_id)                                                AS total_appointments,
    COUNT(CASE WHEN a.status = 'completed'  THEN 1 END)                   AS completed_appointments,
    ROUND(
        COUNT(CASE WHEN a.status = 'cancelled' THEN 1 END) * 100.0
        / NULLIF(COUNT(a.appointment_id), 0),
        2
    )                                                                      AS cancellation_rate,
    SUM(i.total)                                                           AS total_revenue,
    ROUND(AVG(i.total)::NUMERIC, 2)                                       AS avg_invoice_amount,
    COUNT(DISTINCT a.pet_id)                                               AS unique_pets,
    COUNT(DISTINCT a.vet_id)                                               AS unique_vets
FROM clinics c
LEFT JOIN appointments   a  ON a.clinic_id  = c.clinic_id
LEFT JOIN medical_records mr ON mr.appointment_id = a.appointment_id
LEFT JOIN invoices        i  ON i.record_id = mr.record_id
GROUP BY c.clinic_id, c.clinic_name;

-- Unique index required for concurrent refresh
CREATE UNIQUE INDEX IF NOT EXISTS idx_mv_clinic_performance_clinic_id
    ON mv_clinic_performance(clinic_id);


-- Task 5.5: Refresh Materialized View (2 points)
--
-- Write the command to refresh the materialized view:
-- Option A: Full refresh (blocks queries during refresh)
-- Option B: Concurrent refresh (allows queries during refresh, requires unique index)
-- -----------------------------------------------------------------------------
-- TODO: Write REFRESH commands here

-- Option A: Full refresh (view is locked — queries must wait)
REFRESH MATERIALIZED VIEW mv_clinic_performance;

-- Option B: Concurrent refresh (queries can still read the view during refresh;
--           requires a unique index on the materialized view — created above)
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_clinic_performance;


-- Task 5.6: Views for Security (2 points)
--
-- View: v_patient_records_limited
-- Purpose: Provide access to medical records without sensitive financial data
-- Columns: pet_name, owner_name (anonymized: first initial + last name),
--          appointment_date, diagnosis, treatment
-- Exclude: All billing information, full owner details
-- Tables: appointments, pets, owners, medical_records
--
-- Explain how views provide security in a comment:
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_patient_records_limited AS ...

-- Views provide a security layer by:
--   1. Exposing only selected columns — financial data (invoices, totals, payment info)
--      and full PII never appear in this view.
--   2. Allowing DBAs to GRANT SELECT on the view without granting SELECT on the
--      underlying tables, so querying users never touch raw owner/billing data.
--   3. Anonymizing sensitive fields inline (first initial + last name instead of
--      full name), reducing exposure even for authorised readers.
--   4. Acting as a stable contract: the underlying schema can change (column renames,
--      table splits) without breaking the view's consumers or accidentally exposing
--      newly added sensitive columns.
CREATE OR REPLACE VIEW v_patient_records_limited AS
SELECT
    p.pet_name,
    LEFT(o.first_name, 1) || '. ' || o.last_name          AS owner_name,
    mr.visit_date                                          AS appointment_date,
    mr.diagnosis,
    (
        SELECT STRING_AGG(pr.name, ', ' ORDER BY pr.name)
        FROM treatments t
        JOIN procedures pr ON t.procedure_id = pr.procedure_id
        WHERE t.record_id = mr.record_id
    )                                                      AS treatment
FROM medical_records mr
JOIN pets   p ON mr.pet_id    = p.pet_id
JOIN owners o ON p.owner_id   = o.owner_id;