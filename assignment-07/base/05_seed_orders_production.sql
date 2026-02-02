-- =============================================================================
-- PrecisionParts Manufacturing - Seed Data: Orders & Production
-- =============================================================================


-- Production Orders
INSERT INTO production_orders (order_number, customer_name, customer_po, status, priority, order_date, due_date, shipped_date, total_amount, notes, created_by) VALUES
-- Completed orders
('PO-2024-001', 'Boeing Commercial', 'BA-PO-445566', 'shipped', 'high', '2024-01-15', '2024-02-28', '2024-02-25', 125000.00, 'Quarterly brake caliper order', 2),
('PO-2024-002', 'SpaceX', 'SPX-2024-0012', 'shipped', 'urgent', '2024-02-01', '2024-03-15', '2024-03-10', 89500.00, 'Dragon capsule components', 2),
('PO-2024-003', 'General Motors', 'GM-MFG-78901', 'shipped', 'normal', '2024-02-15', '2024-04-01', '2024-03-28', 45000.00, 'Performance piston batch', 2),
('PO-2024-004', 'Medtronic', 'MDT-SURG-2024', 'shipped', 'high', '2024-03-01', '2024-04-15', '2024-04-12', 168000.00, 'Spinal fusion cage order', 2),
('PO-2024-005', 'Lockheed Martin', 'LM-AERO-5567', 'shipped', 'urgent', '2024-03-20', '2024-05-01', '2024-04-28', 210000.00, 'F-35 component batch', 2),

-- Completed recently
('PO-2024-006', 'Ford Motor Company', 'FMC-PERF-001', 'completed', 'normal', '2024-06-01', '2024-07-15', NULL, 52000.00, 'Mustang performance parts', 2),
('PO-2024-007', 'Stryker', 'STK-ORT-2024-05', 'completed', 'high', '2024-07-10', '2024-08-30', NULL, 95000.00, 'Orthopedic instruments', 2),

-- In production
('PO-2024-008', 'Northrop Grumman', 'NG-DEF-8890', 'in_production', 'urgent', '2024-09-01', '2024-12-15', NULL, 175000.00, 'Defense contract - classified', 2),
('PO-2024-009', 'Tesla', 'TSLA-GF-2024', 'in_production', 'high', '2024-09-15', '2024-12-01', NULL, 68000.00, 'Model S performance upgrade parts', 2),
('PO-2024-010', 'Johnson & Johnson', 'JNJ-MED-4455', 'in_production', 'normal', '2024-10-01', '2025-01-15', NULL, 142000.00, 'Surgical instrument handles', 2),

-- Quality check
('PO-2024-011', 'Raytheon', 'RTX-MIS-7788', 'quality_check', 'urgent', '2024-10-15', '2024-12-20', NULL, 225000.00, 'Missile guidance components', 2),

-- Confirmed/Pending
('PO-2024-012', 'BMW M Division', 'BMW-M-PERF-01', 'confirmed', 'normal', '2024-11-01', '2025-02-01', NULL, 78000.00, 'M3 performance brake components', 2),
('PO-2024-013', 'Airbus', 'AIR-A350-COMP', 'confirmed', 'high', '2024-11-15', '2025-03-01', NULL, 320000.00, 'A350 wing components', 2),
('PO-2024-014', 'Intuitive Surgical', 'ISI-DAVI-2025', 'pending', 'high', '2024-12-01', '2025-04-01', NULL, 185000.00, 'da Vinci robot components', 1),
('PO-2024-015', 'Porsche', 'POR-GT3-2025', 'pending', 'normal', '2024-12-15', '2025-03-15', NULL, 95000.00, '911 GT3 suspension components', 1),

-- Cancelled order for testing
('PO-2024-016', 'Cancelled Customer', 'CANC-001', 'cancelled', 'low', '2024-08-01', '2024-10-01', NULL, 25000.00, 'Customer cancelled - budget issues', 2)
ON CONFLICT (order_number) DO NOTHING;

-- Order Items
INSERT INTO order_items (order_id, part_id, quantity, unit_price, quantity_completed, quantity_rejected) VALUES
-- PO-2024-001 (Boeing)
(1, 1, 50, 2500.00, 50, 2),  -- Aerospace Brake Caliper Housing
(1, 4, 100, 450.00, 100, 3), -- Bushing Sleeve Assembly

-- PO-2024-002 (SpaceX)
(2, 2, 25, 3200.00, 25, 1),  -- Wing Hinge Assembly Mount
(2, 3, 200, 85.00, 200, 5),  -- Hydraulic Fitting AN-8

-- PO-2024-003 (GM)
(3, 6, 250, 180.00, 250, 8), -- Performance Piston Assembly

-- PO-2024-004 (Medtronic)
(4, 11, 150, 850.00, 150, 4), -- Spinal Fusion Cage
(4, 14, 500, 65.00, 500, 10), -- Orthopedic Screw

-- PO-2024-005 (Lockheed)
(5, 1, 40, 2500.00, 40, 1),  -- Aerospace Brake Caliper Housing
(5, 2, 30, 3200.00, 30, 2),  -- Wing Hinge Assembly Mount
(5, 5, 100, 320.00, 100, 3), -- Structural Mounting Plate

-- PO-2024-006 (Ford)
(6, 6, 200, 180.00, 200, 6), -- Performance Piston Assembly
(6, 9, 300, 35.00, 300, 5),  -- Suspension A-Arm Bushing

-- PO-2024-007 (Stryker)
(7, 12, 300, 125.00, 300, 8), -- Surgical Instrument Handle
(7, 15, 200, 280.00, 200, 5), -- Surgical Drill Guide

-- PO-2024-008 (Northrop) - In production
(8, 1, 35, 2500.00, 20, 1),
(8, 2, 25, 3200.00, 15, 0),
(8, 3, 300, 85.00, 200, 8),

-- PO-2024-009 (Tesla) - In production
(9, 8, 400, 150.00, 250, 10),  -- Racing Brake Rotor Hat
(9, 9, 500, 35.00, 350, 8),    -- Suspension A-Arm Bushing

-- PO-2024-010 (J&J) - In production
(10, 12, 500, 125.00, 300, 12), -- Surgical Instrument Handle
(10, 13, 300, 420.00, 150, 5),  -- Bone Plate Fixation

-- PO-2024-011 (Raytheon) - Quality check
(11, 1, 45, 2500.00, 45, 2),
(11, 5, 150, 320.00, 150, 5),

-- PO-2024-012 (BMW) - Confirmed
(12, 8, 300, 150.00, 0, 0),
(12, 9, 400, 35.00, 0, 0),

-- PO-2024-013 (Airbus) - Confirmed
(13, 2, 50, 3200.00, 0, 0),
(13, 4, 200, 450.00, 0, 0),

-- PO-2024-014 (Intuitive) - Pending
(14, 12, 600, 125.00, 0, 0),
(14, 15, 400, 280.00, 0, 0),

-- PO-2024-015 (Porsche) - Pending
(15, 9, 600, 35.00, 0, 0),
(15, 10, 400, 28.00, 0, 0)
ON CONFLICT (order_id, part_id) DO NOTHING;

-- Production Runs
INSERT INTO production_runs (run_number, order_id, order_item_id, machine_id, operator_id, supervisor_id, status, planned_quantity, quantity_produced, quantity_scrapped, scheduled_start, actual_start, actual_end, machine_hours, notes) VALUES
-- Completed runs for PO-2024-001
('RUN-2024-0001', 1, 1, 3, 13, 7, 'completed', 50, 52, 2, '2024-01-20 06:00:00', '2024-01-20 06:15:00', '2024-02-10 18:00:00', 168.5, 'Completed ahead of schedule'),
('RUN-2024-0002', 1, 2, 5, 14, 7, 'completed', 100, 103, 3, '2024-01-25 06:00:00', '2024-01-25 06:30:00', '2024-02-15 16:00:00', 85.0, NULL),

-- Completed runs for PO-2024-003
('RUN-2024-0003', 3, 5, 6, 15, 8, 'completed', 250, 258, 8, '2024-02-20 06:00:00', '2024-02-20 07:00:00', '2024-03-20 17:00:00', 120.0, 'Minor tool wear issues'),

-- Completed runs for PO-2024-006
('RUN-2024-0004', 6, 11, 5, 16, 7, 'completed', 200, 206, 6, '2024-06-10 06:00:00', '2024-06-10 06:00:00', '2024-07-01 15:00:00', 95.5, NULL),
('RUN-2024-0005', 6, 12, 7, 17, 8, 'completed', 300, 305, 5, '2024-06-15 06:00:00', '2024-06-15 06:30:00', '2024-07-05 14:00:00', 42.0, NULL),

-- In-progress runs for PO-2024-008
('RUN-2024-0006', 8, 13, 3, 13, 7, 'running', 35, 20, 1, '2024-11-01 06:00:00', '2024-11-01 06:00:00', NULL, NULL, 'High priority defense order'),
('RUN-2024-0007', 8, 14, 1, 14, 7, 'running', 25, 15, 0, '2024-11-05 06:00:00', '2024-11-05 07:00:00', NULL, NULL, NULL),
('RUN-2024-0008', 8, 15, 6, 15, 8, 'running', 300, 200, 8, '2024-11-10 06:00:00', '2024-11-10 06:00:00', NULL, NULL, NULL),

-- In-progress runs for PO-2024-009
('RUN-2024-0009', 9, 16, 2, 16, 7, 'running', 400, 250, 10, '2024-10-01 06:00:00', '2024-10-01 06:30:00', NULL, NULL, 'Tesla rush order'),
('RUN-2024-0010', 9, 17, 7, 17, 8, 'paused', 500, 350, 8, '2024-10-05 06:00:00', '2024-10-05 06:00:00', NULL, NULL, 'Paused for material delivery'),

-- In-progress runs for PO-2024-010
('RUN-2024-0011', 10, 18, 5, 18, 7, 'running', 500, 300, 12, '2024-10-15 06:00:00', '2024-10-15 06:15:00', NULL, NULL, NULL),
('RUN-2024-0012', 10, 19, 6, 19, 8, 'setup', 300, 150, 5, '2024-11-01 06:00:00', NULL, NULL, NULL, 'Setting up for second batch'),

-- Quality check runs for PO-2024-011
('RUN-2024-0013', 11, 20, 3, 13, 7, 'completed', 45, 47, 2, '2024-10-20 06:00:00', '2024-10-20 06:00:00', '2024-11-15 17:00:00', 145.0, 'Awaiting final QC'),
('RUN-2024-0014', 11, 21, 1, 14, 7, 'completed', 150, 155, 5, '2024-10-25 06:00:00', '2024-10-25 07:00:00', '2024-11-20 16:00:00', 72.0, NULL),

-- Scheduled runs
('RUN-2024-0015', 12, 22, 2, 15, 7, 'scheduled', 300, 0, 0, '2025-01-05 06:00:00', NULL, NULL, NULL, 'BMW order'),
('RUN-2024-0016', 13, 24, 3, 16, 7, 'scheduled', 50, 0, 0, '2025-01-15 06:00:00', NULL, NULL, NULL, 'Airbus high priority')
ON CONFLICT (run_number) DO NOTHING;

-- Quality Checks
INSERT INTO quality_checks (run_id, inspector_id, check_type, sample_size, result, defects_found, defect_types, measurements, notes, checked_at) VALUES
-- Completed run quality checks
(1, 10, 'first_article', 1, 'pass', 0, '[]', '{"dim_a": 125.02, "dim_b": 85.01, "surface": 15}', 'First article approved', '2024-01-21 10:00:00'),
(1, 11, 'in_process', 10, 'pass', 0, '[]', '{"dim_a_avg": 125.01, "dim_b_avg": 85.00}', 'Mid-run inspection OK', '2024-02-01 14:00:00'),
(1, 10, 'final', 25, 'pass', 2, '["surface_scratch", "dimension_out"]', '{"pass_rate": 92}', 'Final inspection complete', '2024-02-10 16:00:00'),

(2, 11, 'first_article', 1, 'pass', 0, '[]', '{}', NULL, '2024-01-26 09:00:00'),
(2, 12, 'final', 20, 'pass', 3, '["burr", "surface_scratch"]', '{}', NULL, '2024-02-15 15:00:00'),

(3, 10, 'first_article', 1, 'pass', 0, '[]', '{"bore_dia": 86.002}', 'Bore within spec', '2024-02-21 08:00:00'),
(3, 11, 'in_process', 25, 'pass', 2, '["surface_defect"]', '{}', NULL, '2024-03-05 10:00:00'),
(3, 10, 'final', 50, 'pass', 6, '["surface_defect", "dimension_out"]', '{"yield": 97.6}', NULL, '2024-03-20 14:00:00'),

-- In-progress run quality checks
(6, 10, 'first_article', 1, 'pass', 0, '[]', '{}', NULL, '2024-11-02 09:00:00'),
(6, 11, 'in_process', 5, 'pass', 1, '["minor_scratch"]', '{}', 'Continuing production', '2024-11-10 11:00:00'),

(9, 12, 'first_article', 1, 'pass', 0, '[]', '{}', 'Tesla spec approved', '2024-10-02 08:00:00'),
(9, 10, 'in_process', 25, 'conditional', 3, '["burr", "surface_finish"]', '{}', 'Rework required on 3 units', '2024-10-20 14:00:00'),

-- Quality check pending runs
(13, 10, 'first_article', 1, 'pass', 0, '[]', '{}', NULL, '2024-10-21 09:00:00'),
(13, 11, 'in_process', 10, 'pass', 1, '["minor_defect"]', '{}', NULL, '2024-11-01 10:00:00'),
(13, 12, 'final', 45, 'pending', 0, '[]', '{}', 'Awaiting final measurements', '2024-11-20 16:00:00'),

(14, 10, 'first_article', 1, 'pass', 0, '[]', '{}', NULL, '2024-10-26 09:00:00'),
(14, 11, 'final', 30, 'pending', 0, '[]', '{}', 'Final QC in progress', '2024-11-21 10:00:00')
ON CONFLICT DO NOTHING;
