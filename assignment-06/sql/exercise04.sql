-- =============================================================================
-- Exercise 4: Common Table Expressions (CTEs)
-- PawCare Veterinary Clinic
-- =============================================================================

-- Task 4.1: Basic CTE - Monthly Revenue Analysis (4 points)
-- Calculate monthly revenue with running totals and comparison to average
-- Return: month_name, monthly_revenue, running_total, above_average (boolean)
-- Filter: Year 2024, paid invoices only
-- Tables: invoices
-- Tip: Use TO_CHAR(invoice_date, 'Month') or EXTRACT(MONTH FROM invoice_date) to get
--       the month, and GROUP BY that expression — do NOT group by invoice_date itself,
--       or you'll get one row per date instead of one row per month.
--       Use WITH clause for monthly_revenue, then calculate running total with window function
-- -----------------------------------------------------------------------------
-- TODO: Write your CTE and SELECT statement here

WITH monthly_revenue AS (
    SELECT
        EXTRACT(MONTH FROM invoice_date)         AS month_num,
        TRIM(TO_CHAR(invoice_date, 'Month'))     AS month_name,
        SUM(total)                               AS monthly_revenue
    FROM invoices
    WHERE EXTRACT(YEAR FROM invoice_date) = 2024
      AND status = 'paid'
    GROUP BY EXTRACT(MONTH FROM invoice_date), TO_CHAR(invoice_date, 'Month')
),
with_stats AS (
    SELECT
        month_num,
        month_name,
        monthly_revenue,
        SUM(monthly_revenue) OVER (ORDER BY month_num) AS running_total,
        AVG(monthly_revenue) OVER ()                   AS avg_revenue
    FROM monthly_revenue
)
SELECT
    month_name,
    monthly_revenue,
    running_total,
    monthly_revenue > avg_revenue AS above_average
FROM with_stats
ORDER BY month_num;

-- Task 4.2: Multiple CTEs - Pet Health Summary (4 points)
-- Create comprehensive pet health summary using multiple CTEs
-- Return: pet_name, owner_name, visit_count, vaccine_count, treatment_count, health_score
-- health_score = visit_count + vaccine_count + treatment_count
-- Order by: health_score descending
-- Tables: pets, owners, appointments, vaccinations, medical_records, treatments
-- Tip: Create separate CTEs for visits, vaccines, and treatments, then JOIN them
-- -----------------------------------------------------------------------------
-- TODO: Write your CTEs and SELECT statement here

WITH pet_visits AS (
    SELECT pet_id, COUNT(*) AS visit_count
    FROM appointments
    GROUP BY pet_id
),
pet_vaccines AS (
    SELECT pet_id, COUNT(*) AS vaccine_count
    FROM vaccinations
    GROUP BY pet_id
),
pet_treatments AS (
    SELECT mr.pet_id, COUNT(t.treatment_id) AS treatment_count
    FROM medical_records mr
    JOIN treatments t ON t.record_id = mr.record_id
    GROUP BY mr.pet_id
)
SELECT
    p.pet_name,
    o.first_name || ' ' || o.last_name                                          AS owner_name,
    COALESCE(pv.visit_count, 0)                                                 AS visit_count,
    COALESCE(pvc.vaccine_count, 0)                                              AS vaccine_count,
    COALESCE(pt.treatment_count, 0)                                             AS treatment_count,
    COALESCE(pv.visit_count, 0) + COALESCE(pvc.vaccine_count, 0)
        + COALESCE(pt.treatment_count, 0)                                       AS health_score
FROM pets p
JOIN owners o              ON p.owner_id  = o.owner_id
LEFT JOIN pet_visits pv    ON p.pet_id    = pv.pet_id
LEFT JOIN pet_vaccines pvc ON p.pet_id    = pvc.pet_id
LEFT JOIN pet_treatments pt ON p.pet_id   = pt.pet_id
ORDER BY health_score DESC;

-- Task 4.3: Recursive CTE - Staff Hierarchy (5 points)
-- Display complete staff hierarchy with management chain
-- Return: staff_id, full_name, role, level (1-based), management_chain
-- management_chain: Concatenated names from top to current (e.g., "CEO > Manager > Employee")
-- Order by: level, full_name
-- Tables: staff
-- Tip: Base case = staff with reports_to IS NULL
--      Recursive case = JOIN on reports_to = sh.staff_id
-- -----------------------------------------------------------------------------
-- TODO: Write your recursive CTE here

WITH RECURSIVE staff_hierarchy AS (
    -- Base case: top of the org (no manager)
    SELECT
        staff_id,
        first_name || ' ' || last_name         AS full_name,
        role,
        1                                       AS level,
        first_name || ' ' || last_name          AS management_chain
    FROM staff
    WHERE reports_to IS NULL

    UNION ALL

    -- Recursive case: employees who report to someone in the CTE
    SELECT
        s.staff_id,
        s.first_name || ' ' || s.last_name,
        s.role,
        sh.level + 1,
        sh.management_chain || ' > ' || s.first_name || ' ' || s.last_name
    FROM staff s
    JOIN staff_hierarchy sh ON s.reports_to = sh.staff_id
)
SELECT staff_id, full_name, role, level, management_chain
FROM staff_hierarchy
ORDER BY level, full_name;

-- Task 4.4: Recursive CTE - Organizational Tree (3 points)
-- Count direct and total reports per manager
-- Return: manager_name, role, direct_reports, total_reports
--   direct_reports = number of staff who report directly to this manager
--   total_reports  = number of all subordinates (direct + indirect, at any depth)
-- Order by: total_reports descending
-- Tables: staff
-- Tip: Build the recursive CTE walking DOWNWARD through the tree. Each row should
--       carry the original manager_id so you can attribute deep subordinates back
--       to their top-level manager. Base case: all (manager, direct_report) pairs.
--       Recursive case: find each subordinate's own reports, keeping the original
--       manager_id. Then GROUP BY manager to count total_reports.
--       direct_reports can be a simple count of staff WHERE reports_to = manager_id.
-- -----------------------------------------------------------------------------
-- TODO: Write your recursive CTE here

-- Part A: Direct and total reports per manager
WITH RECURSIVE subordinates AS (
    -- Base case: all direct manager -> report pairs
    SELECT reports_to AS manager_id, staff_id AS subordinate_id
    FROM staff
    WHERE reports_to IS NOT NULL

    UNION ALL

    -- Recursive case: go one level deeper, keeping original manager_id
    SELECT s.manager_id, st.staff_id
    FROM subordinates s
    JOIN staff st ON st.reports_to = s.subordinate_id
)
SELECT
    m.first_name || ' ' || m.last_name                      AS manager_name,
    m.role,
    (SELECT COUNT(*) FROM staff WHERE reports_to = m.staff_id) AS direct_reports,
    COUNT(sub.subordinate_id)                               AS total_reports
FROM staff m
JOIN subordinates sub ON sub.manager_id = m.staff_id
GROUP BY m.staff_id, m.first_name, m.last_name, m.role
ORDER BY total_reports DESC;

-- Part B: Maximum depth of the org chart
WITH RECURSIVE depth AS (
    SELECT staff_id, 1 AS level
    FROM staff
    WHERE reports_to IS NULL

    UNION ALL

    SELECT s.staff_id, d.level + 1
    FROM staff s
    JOIN depth d ON s.reports_to = d.staff_id
)
SELECT MAX(level) AS max_depth FROM depth;

-- Task 4.5: CTE for Readability - Complex Business Query (4 points)
-- Find the top 3 clinics by revenue in 2024, show their most common procedure,
-- busiest vet, and average patient weight.
-- Return: clinic_name, total_revenue, most_common_procedure, busiest_vet, avg_patient_weight
-- Filter: Year 2024
-- Tables: clinics, appointments, invoices, medical_records, treatments, procedures, staff, pets
-- Tip: Use at least 3 named CTEs to break down this query logically
-- -----------------------------------------------------------------------------
-- TODO: Write your CTEs and SELECT statement here

WITH top_clinics AS (
    -- Top 3 clinics by 2024 revenue
    SELECT
        a.clinic_id,
        c.clinic_name,
        SUM(i.total) AS total_revenue
    FROM invoices i
    JOIN medical_records mr ON i.record_id     = mr.record_id
    JOIN appointments a     ON mr.appointment_id = a.appointment_id
    JOIN clinics c          ON a.clinic_id      = c.clinic_id
    WHERE EXTRACT(YEAR FROM a.scheduled_at) = 2024
    GROUP BY a.clinic_id, c.clinic_name
    ORDER BY total_revenue DESC
    LIMIT 3
),
top_procedures AS (
    -- Most-used procedure per clinic (in 2024)
    SELECT DISTINCT ON (a.clinic_id)
        a.clinic_id,
        p.name AS procedure_name
    FROM appointments a
    JOIN medical_records mr ON mr.appointment_id = a.appointment_id
    JOIN treatments t       ON t.record_id        = mr.record_id
    JOIN procedures p       ON t.procedure_id     = p.procedure_id
    WHERE EXTRACT(YEAR FROM a.scheduled_at) = 2024
      AND a.clinic_id IN (SELECT clinic_id FROM top_clinics)
    GROUP BY a.clinic_id, p.procedure_id, p.name
    ORDER BY a.clinic_id, COUNT(*) DESC
),
busiest_vets AS (
    -- Vet with most appointments per clinic (in 2024)
    SELECT DISTINCT ON (a.clinic_id)
        a.clinic_id,
        s.first_name || ' ' || s.last_name AS vet_name
    FROM appointments a
    JOIN staff s ON a.vet_id = s.staff_id
    WHERE EXTRACT(YEAR FROM a.scheduled_at) = 2024
      AND a.clinic_id IN (SELECT clinic_id FROM top_clinics)
    GROUP BY a.clinic_id, s.staff_id, s.first_name, s.last_name
    ORDER BY a.clinic_id, COUNT(*) DESC
),
avg_weights AS (
    -- Average patient weight per clinic (in 2024)
    SELECT
        a.clinic_id,
        ROUND(AVG(p.weight_kg)::NUMERIC, 2) AS avg_patient_weight
    FROM appointments a
    JOIN pets p ON a.pet_id = p.pet_id
    WHERE EXTRACT(YEAR FROM a.scheduled_at) = 2024
      AND a.clinic_id IN (SELECT clinic_id FROM top_clinics)
      AND p.weight_kg IS NOT NULL
    GROUP BY a.clinic_id
)
SELECT
    tc.clinic_name,
    tc.total_revenue,
    tp.procedure_name   AS most_common_procedure,
    bv.vet_name         AS busiest_vet,
    aw.avg_patient_weight
FROM top_clinics tc
LEFT JOIN top_procedures tp ON tp.clinic_id = tc.clinic_id
LEFT JOIN busiest_vets bv   ON bv.clinic_id = tc.clinic_id
LEFT JOIN avg_weights aw    ON aw.clinic_id = tc.clinic_id
ORDER BY tc.total_revenue DESC;