-- =============================================================================
-- PrecisionParts Manufacturing - Seed Data: Audit & Inventory Logs
-- =============================================================================


-- Inventory movement logs
INSERT INTO inventory_log (material_id, change_type, quantity_change, quantity_before, quantity_after, unit_cost, reference_type, reference_id, reason, performed_by, created_at) VALUES
-- Material receipts
(1, 'received', 100.00, 50.00, 150.00, 45.00, 'purchase_order', 1001, 'PO-MAT-2024-001 from MetalSource', 24, '2024-01-10 09:00:00'),
(2, 'received', 200.00, 300.00, 500.00, 8.50, 'purchase_order', 1001, 'PO-MAT-2024-001 from MetalSource', 24, '2024-01-10 09:00:00'),
(3, 'received', 50.00, 25.00, 75.00, 85.00, 'purchase_order', 1002, 'PO-MAT-2024-002 expedited', 24, '2024-01-15 10:00:00'),
(6, 'received', 20.00, 5.00, 25.00, 250.00, 'purchase_order', 1003, 'Titanium restock', 24, '2024-02-01 08:30:00'),

-- Material consumption for production
(3, 'consumed', -4.00, 75.00, 71.00, 85.00, 'production_run', 1, 'RUN-2024-0001 brake calipers', 13, '2024-01-20 06:30:00'),
(18, 'consumed', -48.00, 5000.00, 4952.00, 0.25, 'production_run', 1, 'RUN-2024-0001 assembly fasteners', 13, '2024-01-20 06:30:00'),
(2, 'consumed', -25.00, 500.00, 475.00, 8.50, 'production_run', 3, 'RUN-2024-0003 pistons', 15, '2024-02-20 07:30:00'),

-- Inventory adjustments
(18, 'adjusted', -50.00, 4952.00, 4902.00, 0.25, NULL, NULL, 'Cycle count adjustment - discrepancy found', 9, '2024-03-01 14:00:00'),
(21, 'adjusted', 100.00, 5900.00, 6000.00, 0.10, NULL, NULL, 'Cycle count - found extra stock', 9, '2024-03-01 14:30:00'),

-- Scrapped materials
(3, 'scrapped', -2.00, 71.00, 69.00, 85.00, 'quality_reject', 1, 'Material defect - voids found', 10, '2024-02-05 11:00:00'),
(6, 'scrapped', -1.00, 25.00, 24.00, 250.00, 'quality_reject', 5, 'Contamination in titanium sheet', 11, '2024-02-15 09:00:00'),

-- More recent activity
(1, 'consumed', -50.00, 150.00, 100.00, 45.00, 'production_run', 6, 'RUN-2024-0006 Northrop order', 13, '2024-11-01 07:00:00'),
(7, 'consumed', -12.50, 50.00, 37.50, 95.00, 'production_run', 7, 'RUN-2024-0007 titanium rods', 14, '2024-11-05 08:00:00'),
(2, 'consumed', -100.00, 475.00, 375.00, 8.50, 'production_run', 9, 'RUN-2024-0009 Tesla pistons', 16, '2024-10-01 07:00:00'),

-- Low stock received
(6, 'received', 15.00, 8.00, 23.00, 250.00, 'purchase_order', 1050, 'Emergency titanium order', 24, '2024-11-15 10:00:00'),
(17, 'received', 10.00, 12.00, 22.00, 180.00, 'purchase_order', 1050, 'Carbon fiber restock', 24, '2024-11-15 10:00:00')
ON CONFLICT DO NOTHING;

-- Order status history
INSERT INTO order_status_history (order_id, old_status, new_status, changed_by, change_reason, changed_at) VALUES
-- PO-2024-001 history
(1, NULL, 'pending', 2, 'Order created', '2024-01-15 09:00:00'),
(1, 'pending', 'confirmed', 2, 'Customer PO received', '2024-01-16 10:00:00'),
(1, 'confirmed', 'in_production', 7, 'Production started', '2024-01-20 06:00:00'),
(1, 'in_production', 'quality_check', 7, 'Production complete', '2024-02-12 16:00:00'),
(1, 'quality_check', 'completed', 3, 'QC passed', '2024-02-20 14:00:00'),
(1, 'completed', 'shipped', 2, 'Shipped via FedEx', '2024-02-25 09:00:00'),

-- PO-2024-008 history (in production)
(8, NULL, 'pending', 2, 'Order created', '2024-09-01 10:00:00'),
(8, 'pending', 'confirmed', 2, 'Defense contract confirmed', '2024-09-02 09:00:00'),
(8, 'confirmed', 'in_production', 7, 'High priority - started immediately', '2024-11-01 06:00:00'),

-- PO-2024-011 history (quality check)
(11, NULL, 'pending', 2, 'Order created', '2024-10-15 11:00:00'),
(11, 'pending', 'confirmed', 2, 'Confirmed by Raytheon', '2024-10-16 09:00:00'),
(11, 'confirmed', 'in_production', 7, 'Started production', '2024-10-20 06:00:00'),
(11, 'in_production', 'quality_check', 7, 'All parts complete, awaiting QC', '2024-11-20 17:00:00'),

-- PO-2024-016 history (cancelled)
(16, NULL, 'pending', 2, 'Order created', '2024-08-01 09:00:00'),
(16, 'pending', 'confirmed', 2, 'Initial confirmation', '2024-08-02 10:00:00'),
(16, 'confirmed', 'cancelled', 2, 'Customer cancelled - budget constraints', '2024-08-15 14:00:00')
ON CONFLICT DO NOTHING;

-- Maintenance logs
INSERT INTO maintenance_log (machine_id, maintenance_type, description, parts_replaced, labor_hours, cost, performed_by, completed_at, next_due_at, created_at) VALUES
-- Recent maintenance
(1, 'preventive', 'Scheduled 500-hour maintenance: spindle inspection, way lubrication, coolant change', '["coolant_filter", "way_lube_5gal"]', 4.0, 450.00, 21, '2024-11-15 12:00:00', '2025-01-20 08:00:00', '2024-11-15 08:00:00'),
(2, 'preventive', 'Scheduled maintenance: axis calibration, tool changer service', '["tool_gripper_spring"]', 3.0, 280.00, 22, '2024-12-01 12:00:00', '2025-02-15 08:00:00', '2024-12-01 08:00:00'),
(3, 'calibration', 'Annual calibration and accuracy verification', '[]', 6.0, 800.00, 21, '2024-10-20 16:00:00', '2025-10-20 08:00:00', '2024-10-20 08:00:00'),
(4, 'corrective', 'Spindle bearing replacement - vibration detected', '["spindle_bearing_set", "spindle_seal"]', 12.0, 3500.00, 21, '2024-12-20 18:00:00', NULL, '2024-12-18 10:00:00'),
(5, 'preventive', 'Turret alignment, chuck jaw replacement', '["chuck_jaw_set"]', 5.0, 650.00, 22, '2024-11-01 14:00:00', '2025-01-15 08:00:00', '2024-11-01 08:00:00'),
(6, 'preventive', 'Standard maintenance, Y-axis leadscrew inspection', '[]', 4.0, 320.00, 21, '2024-12-05 12:00:00', '2025-02-01 08:00:00', '2024-12-05 08:00:00'),
(8, 'calibration', 'Wheel dressing, precision calibration', '["dressing_diamond"]', 8.0, 1200.00, 21, '2024-12-10 17:00:00', '2025-03-10 08:00:00', '2024-12-10 08:00:00'),
(10, 'preventive', 'Laser optics cleaning, gas line inspection', '["optics_lens_set"]', 6.0, 2800.00, 22, '2024-11-25 15:00:00', '2025-01-15 08:00:00', '2024-11-25 08:00:00'),
(11, 'preventive', 'Filter replacement, powder handling system check', '["hepa_filter", "build_plate"]', 8.0, 4500.00, 21, '2024-12-01 16:00:00', '2025-02-01 08:00:00', '2024-12-01 08:00:00'),
(13, 'calibration', 'CMM calibration with certified artifacts', '[]', 10.0, 2000.00, 22, '2024-12-05 17:00:00', '2025-06-05 08:00:00', '2024-12-05 08:00:00'),

-- Emergency repair
(4, 'emergency', 'Unplanned downtime - spindle failure during operation', '[]', 2.0, 0.00, 21, NULL, NULL, '2024-12-18 08:00:00')
ON CONFLICT DO NOTHING;

-- Sample audit log entries (these would normally be created by triggers)
INSERT INTO audit_log (table_name, record_id, action, old_data, new_data, changed_fields, performed_by, performed_at) VALUES
('employees', 29, 'UPDATE', 
 '{"is_active": true, "deleted_at": null}', 
 '{"is_active": false, "deleted_at": "2024-06-15T10:00:00"}', 
 ARRAY['is_active', 'deleted_at'], 
 1, '2024-06-15 10:00:00'),
 
('employees', 30, 'UPDATE', 
 '{"is_active": true, "deleted_at": null}', 
 '{"is_active": false, "deleted_at": "2024-09-01T14:30:00"}', 
 ARRAY['is_active', 'deleted_at'], 
 1, '2024-09-01 14:30:00'),

('parts', 24, 'UPDATE', 
 '{"deleted_at": null}', 
 '{"deleted_at": "2024-07-15T11:00:00"}', 
 ARRAY['deleted_at'], 
 4, '2024-07-15 11:00:00'),

('machines', 14, 'UPDATE', 
 '{"status": "offline", "deleted_at": null}', 
 '{"status": "retired", "deleted_at": "2024-10-01T09:00:00"}', 
 ARRAY['status', 'deleted_at'], 
 21, '2024-10-01 09:00:00'),

('materials', 34, 'UPDATE', 
 '{"deleted_at": null}', 
 '{"deleted_at": "2024-08-01T09:00:00"}', 
 ARRAY['deleted_at'], 
 9, '2024-08-01 09:00:00'),

('production_orders', 1, 'UPDATE',
 '{"status": "completed"}',
 '{"status": "shipped", "shipped_date": "2024-02-25"}',
 ARRAY['status', 'shipped_date'],
 2, '2024-02-25 09:00:00')
ON CONFLICT DO NOTHING;
