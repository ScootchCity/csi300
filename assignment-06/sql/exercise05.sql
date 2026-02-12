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


-- View B: v_staff_directory
-- Purpose: Staff contact information with manager
-- Columns: staff_id, full_name, role, specialization, clinic_name,
--          email, phone, manager_name
-- Tables: staff, clinics
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_staff_directory AS ...


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


-- Task 5.3: View with CHECK OPTION (4 points)
-- 
-- View: v_active_appointments
-- Purpose: Show and manage only scheduled/confirmed appointments
-- Columns: appointment_id, pet_name, owner_phone, vet_name, clinic_name,
--          scheduled_at, status
-- Filter: status IN ('scheduled', 'confirmed')
-- Add: WITH CHECK OPTION
--
-- Explain in a comment what happens if someone tries to UPDATE the status
-- to 'completed' through this view:
-- -----------------------------------------------------------------------------
-- TODO: CREATE OR REPLACE VIEW v_active_appointments AS ...


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


-- Task 5.5: Refresh Materialized View (2 points)
-- 
-- Write the command to refresh the materialized view:
-- Option A: Full refresh (blocks queries during refresh)
-- Option B: Concurrent refresh (allows queries during refresh, requires unique index)
-- -----------------------------------------------------------------------------
-- TODO: Write REFRESH commands here


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
