-- =============================================================================
-- Exercise 3: Triggers
-- PrecisionParts Manufacturing Database
-- =============================================================================

-- Problem 3.1: Audit Log Trigger (5 points)
-- Create a trigger that logs all changes to the parts table
-- 
-- Trigger Function: audit_parts_changes()
-- Trigger: trg_audit_parts (AFTER INSERT OR UPDATE OR DELETE)
-- 
-- Requirements:
--   - Log to audit_log table
--   - Capture: table_name, record_id, action, old_data, new_data, 
--              changed_fields (array), performed_by, performed_at
--   - Get user ID from session setting: current_setting('app.current_user_id', true)
--   - For UPDATE: detect which fields actually changed
--   - Use row_to_json() to convert rows to JSONB
-- 
-- Tip: Use jsonb_object_keys() to iterate and compare old vs new values
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- TODO: Write your CREATE TRIGGER statement here


-- Problem 3.2: Inventory Movement Trigger (5 points)
-- Create a trigger that automatically logs material inventory changes
-- 
-- Trigger Function: log_inventory_changes()
-- Trigger: trg_log_inventory (AFTER UPDATE ON materials)
-- 
-- Requirements:
--   - Only fire if stock_quantity actually changed
--   - Log to inventory_log table
--   - Capture: material_id, change_type ('adjusted'), quantity_change,
--              quantity_before, quantity_after, unit_cost, reason, performed_by
-- 
-- Tip: Compare OLD.stock_quantity to NEW.stock_quantity
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- TODO: Write your CREATE TRIGGER statement here


-- Problem 3.3: Order Status History Trigger (4 points)
-- Create a trigger that tracks all status changes for production orders
-- 
-- Trigger Function: track_order_status()
-- Trigger: trg_order_status_history (AFTER UPDATE ON production_orders)
-- 
-- Requirements:
--   - Only fire if status actually changed
--   - Log to order_status_history table
--   - Capture: order_id, old_status, new_status, changed_by, changed_at
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- TODO: Write your CREATE TRIGGER statement here


-- Problem 3.4: Prevent Delete of Active Machines (3 points)
-- Create a trigger that prevents deletion of machines with active production runs
-- 
-- Trigger Function: prevent_active_machine_delete()
-- Trigger: trg_prevent_machine_delete (BEFORE DELETE ON machines)
-- 
-- Requirements:
--   - Check for production runs with status IN ('running', 'pending')
--   - If found, RAISE EXCEPTION with descriptive message
--   - Allow delete if no active runs
-- 
-- Tip: Use RAISE EXCEPTION 'Message: %', variable_name;
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- TODO: Write your CREATE TRIGGER statement here


-- Problem 3.5: Auto-Update Timestamps (3 points)
-- Create a reusable trigger function for updating 'updated_at' columns
-- 
-- Trigger Function: update_timestamp()
-- 
-- Requirements:
--   - Set NEW.updated_at = CURRENT_TIMESTAMP
--   - Return NEW
-- 
-- Then create triggers for: parts, materials, machines, employees
-- Naming convention: trg_{table_name}_timestamp
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- TODO: Write your CREATE TRIGGER statements for each table
