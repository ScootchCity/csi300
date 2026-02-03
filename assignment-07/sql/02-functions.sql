-- =============================================================================
-- Exercise 2: SQL Functions
-- PrecisionParts Manufacturing Database
-- =============================================================================

-- Problem 2.1: Calculate Material Value (4 points)
-- Create a function that calculates the total inventory value for a given material
-- 
-- Function: calculate_material_value(p_material_id INTEGER)
-- Returns: NUMERIC(12,2)
-- Logic:
--   - Find the material by ID (excluding soft-deleted)
--   - Calculate: quantity_in_stock * unit_cost
--   - Return 0 if material not found or is soft-deleted
-- 
-- Test cases to consider:
--   - Valid material with stock
--   - Soft-deleted material (should return 0)
--   - Non-existent material ID (should return 0)
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- Problem 2.2: Production Run Duration (4 points)
-- Create a function that calculates how long a production run took (or is taking)
-- 
-- Function: get_run_duration_hours(p_run_id INTEGER)
-- Returns: NUMERIC(10,2)
-- Logic:
--   - If run not found, return 0
--   - If run hasn't started yet (start_time > NOW), return 0
--   - If completed (end_time IS NOT NULL), calculate end_time - start_time
--   - If in progress, calculate NOW - start_time
--   - Convert to hours using: EXTRACT(EPOCH FROM interval) / 3600
--   - Round to 2 decimal places
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- Problem 2.3: Part Production Cost Estimate (5 points)
-- Create a function that estimates the production cost for a part
-- 
-- Function: estimate_part_cost(p_part_id INTEGER, p_quantity INTEGER DEFAULT 1)
-- Returns: NUMERIC(12,2)
-- Logic:
--   - Sum material costs from bill of materials (part_materials table)
--   - For each material: quantity_required * unit_cost (exclude soft-deleted materials)
--   - Multiply by requested quantity
--   - Add 15% overhead (multiply by 1.15)
--   - Return 0 if part has no materials
-- 
-- Tables: part_materials, materials
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- Problem 2.4: Quality Pass Rate (4 points)
-- Create a function that returns the quality pass rate for a specific part
-- 
-- Function: get_part_quality_rate(p_part_number VARCHAR)
-- Returns: NUMERIC(5,2) (percentage)
-- Logic:
--   - Count total quality checks for the part
--   - Count passed checks (result IN ('pass', 'conditional'))
--   - Calculate: (passed / total) * 100
--   - Return 100.00 if no checks exist (assume perfect if untested)
-- 
-- Tables: quality_checks, production_runs, parts
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here


-- Problem 2.5: Generate Part Number (3 points)
-- Create a function that generates a standardized part number
-- 
-- Function: generate_part_number(p_category VARCHAR, p_sequence INTEGER)
-- Returns: VARCHAR
-- Logic:
--   - Format: {CATEGORY}-{SEQUENCE}-{CHECKSUM}
--   - CATEGORY: First 4 chars, uppercase
--   - SEQUENCE: 4-digit zero-padded number
--   - CHECKSUM: Last 2 digits of (sequence * 7 + ASCII of first char)
-- 
-- Example: generate_part_number('aerospace', 42) -> 'AERO-0042-23'
-- -----------------------------------------------------------------------------
-- TODO: Write your CREATE OR REPLACE FUNCTION statement here
