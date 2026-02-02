-- =============================================================================
-- PrecisionParts Manufacturing - Seed Data: Parts & Machines
-- =============================================================================


-- Parts catalog
INSERT INTO parts (part_number, name, description, category, current_version, base_price, production_time_mins, requires_certification) VALUES
-- Aerospace parts
('AERO-BRK-001', 'Aerospace Brake Caliper Housing', 'High-precision brake caliper housing for commercial aircraft', 'aerospace', 3, 2500.00, 480, true),
('AERO-HNG-002', 'Wing Hinge Assembly Mount', 'Titanium mounting bracket for wing hinge mechanism', 'aerospace', 2, 3200.00, 360, true),
('AERO-FIT-003', 'Hydraulic Fitting AN-8', 'AN-8 hydraulic fitting for aircraft systems', 'aerospace', 1, 85.00, 45, true),
('AERO-BUS-004', 'Bushing Sleeve Assembly', 'Precision bushing for landing gear assembly', 'aerospace', 2, 450.00, 120, true),
('AERO-PLT-005', 'Structural Mounting Plate', 'Aluminum mounting plate for avionics bay', 'aerospace', 1, 320.00, 90, true),

-- Automotive parts
('AUTO-PIS-001', 'Performance Piston Assembly', 'Forged aluminum piston for high-performance engines', 'automotive', 4, 180.00, 60, false),
('AUTO-VLV-002', 'Intake Valve Guide', 'Precision valve guide for 4-cylinder engines', 'automotive', 2, 45.00, 30, false),
('AUTO-BRK-003', 'Racing Brake Rotor Hat', 'Aluminum brake rotor hat for track use', 'automotive', 1, 150.00, 75, false),
('AUTO-SUS-004', 'Suspension A-Arm Bushing', 'Delrin suspension bushing for street/track', 'automotive', 3, 35.00, 20, false),
('AUTO-MNT-005', 'Motor Mount Insert', 'Polyurethane motor mount insert', 'automotive', 1, 28.00, 15, false),

-- Medical parts
('MED-IMP-001', 'Spinal Fusion Cage', 'PEEK interbody fusion cage for spine surgery', 'medical', 2, 850.00, 180, true),
('MED-INS-002', 'Surgical Instrument Handle', 'Ergonomic handle for surgical instruments', 'medical', 3, 125.00, 60, true),
('MED-PLA-003', 'Bone Plate Fixation', 'Titanium bone fixation plate', 'medical', 1, 420.00, 90, true),
('MED-SCR-004', 'Orthopedic Screw', 'Titanium orthopedic bone screw', 'medical', 2, 65.00, 25, true),
('MED-GUI-005', 'Surgical Drill Guide', 'Precision drill guide for orthopedic surgery', 'medical', 1, 280.00, 75, true),

-- Industrial parts
('IND-BRG-001', 'Precision Bearing Housing', 'Custom bearing housing for conveyor systems', 'industrial', 2, 220.00, 90, false),
('IND-GEA-002', 'Helical Gear Blank', 'Steel gear blank for custom gearboxes', 'industrial', 1, 180.00, 120, false),
('IND-SHF-003', 'Drive Shaft Coupling', 'Steel shaft coupling for industrial drives', 'industrial', 3, 145.00, 60, false),
('IND-PLT-004', 'Machine Base Plate', 'Heavy-duty base plate for machine mounting', 'industrial', 1, 95.00, 45, false),
('IND-BUS-005', 'Bronze Bushing', 'Oil-impregnated bronze bushing', 'industrial', 2, 25.00, 15, false),

-- Electronics enclosures
('ELC-ENC-001', 'RF Shielded Enclosure', 'Aluminum RF shielded enclosure', 'electronics', 2, 280.00, 90, false),
('ELC-HSK-002', 'Heat Sink Assembly', 'Finned aluminum heat sink', 'electronics', 1, 45.00, 30, false),
('ELC-PNL-003', 'Front Panel Bezel', 'Anodized aluminum front panel', 'electronics', 3, 65.00, 45, false),

-- Prototypes
('PROTO-001', 'Customer Prototype A', 'Prototype part for evaluation', 'prototype', 1, 500.00, 240, false),
('PROTO-002', 'Customer Prototype B', 'Second prototype iteration', 'prototype', 2, 650.00, 300, false)
ON CONFLICT (part_number) DO NOTHING;

-- Soft-delete some parts for testing
UPDATE parts 
SET deleted_at = '2024-07-15 11:00:00' 
WHERE part_number = 'PROTO-001';

-- Part versions
INSERT INTO part_versions (part_id, version, specifications, drawing_url, change_notes, approved_by, approved_at, created_by) VALUES
-- AERO-BRK-001 versions
(1, 1, '{"material": "AL7075-T6", "tolerance": "0.001", "surface_finish": "32", "weight_kg": 2.5}', 'drawings/AERO-BRK-001-v1.pdf', 'Initial release', 4, '2022-03-15 10:00:00', 5),
(1, 2, '{"material": "AL7075-T6", "tolerance": "0.0005", "surface_finish": "16", "weight_kg": 2.4}', 'drawings/AERO-BRK-001-v2.pdf', 'Improved surface finish, tighter tolerances', 4, '2023-01-20 14:00:00', 6),
(1, 3, '{"material": "AL7075-T6", "tolerance": "0.0005", "surface_finish": "16", "weight_kg": 2.3, "coating": "anodize"}', 'drawings/AERO-BRK-001-v3.pdf', 'Added anodizing, weight reduction', 4, '2024-02-10 09:00:00', 5),

-- AUTO-PIS-001 versions
(6, 1, '{"material": "AL2618", "tolerance": "0.002", "bore_mm": 86.0}', 'drawings/AUTO-PIS-001-v1.pdf', 'Initial release', 4, '2021-06-01 10:00:00', 5),
(6, 2, '{"material": "AL2618", "tolerance": "0.001", "bore_mm": 86.0}', 'drawings/AUTO-PIS-001-v2.pdf', 'Tighter bore tolerance', 4, '2022-02-15 11:00:00', 6),
(6, 3, '{"material": "AL2618", "tolerance": "0.001", "bore_mm": 86.0, "coating": "DLC"}', 'drawings/AUTO-PIS-001-v3.pdf', 'Added DLC coating option', 4, '2023-05-20 14:00:00', 5),
(6, 4, '{"material": "AL2618-T6", "tolerance": "0.0008", "bore_mm": 86.0, "coating": "DLC", "skirt_design": "barrel"}', 'drawings/AUTO-PIS-001-v4.pdf', 'New skirt design, improved material spec', 4, '2024-03-10 09:00:00', 6),

-- MED-IMP-001 versions
(11, 1, '{"material": "PEEK-OPTIMA", "porosity": "60%", "height_mm": 10}', 'drawings/MED-IMP-001-v1.pdf', 'Initial FDA submission', 4, '2022-08-01 10:00:00', 5),
(11, 2, '{"material": "PEEK-OPTIMA", "porosity": "65%", "height_mm": 10, "markers": "tantalum"}', 'drawings/MED-IMP-001-v2.pdf', 'Added tantalum markers for imaging', 4, '2023-11-15 14:00:00', 6)
ON CONFLICT (part_id, version) DO NOTHING;

-- Part materials (bill of materials)
INSERT INTO part_materials (part_id, material_id, quantity_needed, notes) VALUES
-- AERO-BRK-001: Aluminum sheet, fasteners
(1, 3, 2.0, 'Main housing material'),
(1, 18, 24, 'Assembly screws'),
(1, 21, 24, 'Hex nuts'),

-- AUTO-PIS-001: Aluminum rod
(6, 2, 0.5, 'Piston blank'),

-- MED-IMP-001: PEEK rod
(11, 11, 0.25, 'PEEK blank for machining'),

-- AERO-HNG-002: Titanium
(2, 6, 1.5, 'Titanium sheet for bracket'),
(2, 7, 0.5, 'Titanium rod for pins')
ON CONFLICT (part_id, material_id) DO NOTHING;

-- Machines
INSERT INTO machines (machine_code, name, type, manufacturer, model, serial_number, status, location, hourly_cost, maintenance_interval_hours, total_run_hours, last_maintenance_at, next_maintenance_due) VALUES
-- CNC Mills
('CNC-M-001', 'Haas VF-4 Vertical Mill', 'cnc_mill', 'Haas Automation', 'VF-4', 'HAS-VF4-2019-001', 'operational', 'Bay A-1', 85.00, 500, 4250.50, '2024-11-15 08:00:00', '2025-01-20 08:00:00'),
('CNC-M-002', 'Haas VF-2 Vertical Mill', 'cnc_mill', 'Haas Automation', 'VF-2', 'HAS-VF2-2020-002', 'operational', 'Bay A-2', 75.00, 500, 3100.25, '2024-12-01 08:00:00', '2025-02-15 08:00:00'),
('CNC-M-003', 'DMG MORI DMU 50', 'cnc_mill', 'DMG MORI', 'DMU 50', 'DMG-DMU50-2021-001', 'operational', 'Bay A-3', 120.00, 400, 2450.00, '2024-10-20 08:00:00', '2025-01-10 08:00:00'),
('CNC-M-004', 'Mazak VCN-530C', 'cnc_mill', 'Mazak', 'VCN-530C', 'MAZ-530C-2022-001', 'maintenance', 'Bay A-4', 95.00, 500, 1800.75, '2024-12-20 08:00:00', NULL),

-- CNC Lathes
('CNC-L-001', 'Haas ST-20 Lathe', 'cnc_lathe', 'Haas Automation', 'ST-20', 'HAS-ST20-2019-001', 'operational', 'Bay B-1', 70.00, 500, 5100.00, '2024-11-01 08:00:00', '2025-01-15 08:00:00'),
('CNC-L-002', 'Mazak QTN-250M', 'cnc_lathe', 'Mazak', 'QTN-250M', 'MAZ-QTN-2020-001', 'operational', 'Bay B-2', 90.00, 400, 3800.50, '2024-12-05 08:00:00', '2025-02-01 08:00:00'),
('CNC-L-003', 'Doosan Puma 2600', 'cnc_lathe', 'Doosan', 'Puma 2600', 'DOS-P2600-2021-001', 'operational', 'Bay B-3', 80.00, 500, 2600.25, '2024-11-20 08:00:00', '2025-01-25 08:00:00'),

-- Other equipment
('GRD-001', 'Studer S33 Cylindrical Grinder', 'grinder', 'Studer', 'S33', 'STU-S33-2018-001', 'operational', 'Bay C-1', 100.00, 300, 6200.00, '2024-12-10 08:00:00', '2025-01-20 08:00:00'),
('WLD-001', 'Miller TIG Welding Station', 'welder', 'Miller', 'Dynasty 400', 'MIL-D400-2020-001', 'operational', 'Bay D-1', 45.00, 200, 1500.00, '2024-12-15 08:00:00', '2025-01-30 08:00:00'),
('LSR-001', 'Trumpf TruLaser 3030', 'laser_cutter', 'Trumpf', 'TruLaser 3030', 'TRU-3030-2021-001', 'operational', 'Bay E-1', 150.00, 400, 2100.00, '2024-11-25 08:00:00', '2025-01-15 08:00:00'),
('3DP-001', 'EOS M290 Metal Printer', '3d_printer', 'EOS', 'M290', 'EOS-M290-2022-001', 'operational', 'Bay F-1', 200.00, 300, 850.00, '2024-12-01 08:00:00', '2025-02-01 08:00:00'),
('ASM-001', 'Assembly Station 1', 'assembly_station', 'Custom', 'AS-100', 'CUST-AS1-2019-001', 'operational', 'Bay G-1', 35.00, 1000, 8500.00, '2024-10-01 08:00:00', '2025-02-15 08:00:00'),
('INS-001', 'Zeiss CMM Inspection', 'inspection', 'Zeiss', 'Contura G2', 'ZEI-CG2-2020-001', 'operational', 'QC Room', 80.00, 500, 3200.00, '2024-12-05 08:00:00', '2025-02-10 08:00:00'),
('PRS-001', 'Hydraulic Press 50T', 'press', 'Dake', 'Force 50', 'DAK-F50-2018-001', 'offline', 'Bay H-1', 40.00, 500, 4800.00, '2024-06-15 08:00:00', NULL)
ON CONFLICT (machine_code) DO NOTHING;

-- Soft-delete a machine for testing
UPDATE machines 
SET deleted_at = '2024-10-01 09:00:00', status = 'retired' 
WHERE machine_code = 'PRS-001';
