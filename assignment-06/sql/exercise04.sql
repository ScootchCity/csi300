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


-- Task 4.2: Multiple CTEs - Pet Health Summary (4 points)
-- Create comprehensive pet health summary using multiple CTEs
-- Return: pet_name, owner_name, visit_count, vaccine_count, treatment_count, health_score
-- health_score = visit_count + vaccine_count + treatment_count
-- Order by: health_score descending
-- Tables: pets, owners, appointments, vaccinations, medical_records, treatments
-- Tip: Create separate CTEs for visits, vaccines, and treatments, then JOIN them
-- -----------------------------------------------------------------------------
-- TODO: Write your CTEs and SELECT statement here


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


-- Task 4.5: CTE for Complex Calculations (4 points)
-- Clinic performance comparison with rankings
-- Return: clinic_name, monthly metrics (revenue, appointments, unique_pets),
--         rankings for each metric, overall_rank
-- Filter: Year 2024
-- Tables: clinics, appointments, invoices
-- Tip: Use CTEs to calculate metrics, then window functions for rankings
-- -----------------------------------------------------------------------------
-- TODO: Write your CTEs and SELECT statement here
