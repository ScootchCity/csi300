-- =============================================================================
-- PrecisionParts Manufacturing - Seed Data: Employees
-- =============================================================================


-- Employees (various roles and departments)
INSERT INTO employees (employee_number, first_name, last_name, email, role, department, hire_date, hourly_rate, is_active) VALUES
-- Management
('EMP001', 'Robert', 'Chen', 'r.chen@precisionparts.com', 'manager', 'Administration', '2018-03-15', 85.00, true),
('EMP002', 'Sarah', 'Williams', 's.williams@precisionparts.com', 'manager', 'Production', '2019-01-10', 75.00, true),
('EMP003', 'Michael', 'Torres', 'm.torres@precisionparts.com', 'manager', 'Quality Control', '2019-06-01', 72.00, true),

-- Engineers
('EMP004', 'Jennifer', 'Park', 'j.park@precisionparts.com', 'engineer', 'Engineering', '2020-02-15', 65.00, true),
('EMP005', 'David', 'Schmidt', 'd.schmidt@precisionparts.com', 'engineer', 'Engineering', '2020-08-01', 62.00, true),
('EMP006', 'Lisa', 'Nakamura', 'l.nakamura@precisionparts.com', 'engineer', 'Engineering', '2021-03-20', 58.00, true),

-- Supervisors
('EMP007', 'James', 'Morrison', 'j.morrison@precisionparts.com', 'supervisor', 'Production', '2019-11-01', 55.00, true),
('EMP008', 'Maria', 'Rodriguez', 'm.rodriguez@precisionparts.com', 'supervisor', 'Production', '2020-05-15', 52.00, true),
('EMP009', 'Thomas', 'Anderson', 't.anderson@precisionparts.com', 'supervisor', 'Warehouse', '2020-09-01', 48.00, true),

-- Quality Inspectors
('EMP010', 'Emily', 'Johnson', 'e.johnson@precisionparts.com', 'quality_inspector', 'Quality Control', '2021-01-15', 45.00, true),
('EMP011', 'Kevin', 'Lee', 'k.lee@precisionparts.com', 'quality_inspector', 'Quality Control', '2021-06-01', 43.00, true),
('EMP012', 'Anna', 'Kowalski', 'a.kowalski@precisionparts.com', 'quality_inspector', 'Quality Control', '2022-02-01', 42.00, true),

-- Machine Operators
('EMP013', 'Carlos', 'Mendez', 'c.mendez@precisionparts.com', 'operator', 'Production', '2020-03-01', 38.00, true),
('EMP014', 'Jessica', 'Taylor', 'j.taylor@precisionparts.com', 'operator', 'Production', '2020-07-15', 36.00, true),
('EMP015', 'Ryan', 'OBrien', 'r.obrien@precisionparts.com', 'operator', 'Production', '2021-02-01', 35.00, true),
('EMP016', 'Michelle', 'Davis', 'm.davis@precisionparts.com', 'operator', 'Production', '2021-08-15', 35.00, true),
('EMP017', 'Daniel', 'Kim', 'd.kim@precisionparts.com', 'operator', 'Production', '2022-01-10', 34.00, true),
('EMP018', 'Amanda', 'Wilson', 'a.wilson@precisionparts.com', 'operator', 'Production', '2022-04-01', 34.00, true),
('EMP019', 'Brian', 'Martinez', 'b.martinez@precisionparts.com', 'operator', 'Production', '2022-09-01', 33.00, true),
('EMP020', 'Stephanie', 'Brown', 's.brown@precisionparts.com', 'operator', 'Production', '2023-01-15', 32.00, true),

-- Maintenance
('EMP021', 'William', 'Garcia', 'w.garcia@precisionparts.com', 'maintenance', 'Maintenance', '2019-08-01', 48.00, true),
('EMP022', 'Patricia', 'Miller', 'p.miller@precisionparts.com', 'maintenance', 'Maintenance', '2021-04-01', 45.00, true),
('EMP023', 'Christopher', 'Moore', 'c.moore@precisionparts.com', 'maintenance', 'Maintenance', '2022-06-01', 42.00, true),

-- Warehouse
('EMP024', 'Nicole', 'Thompson', 'n.thompson@precisionparts.com', 'operator', 'Warehouse', '2021-05-01', 32.00, true),
('EMP025', 'Matthew', 'White', 'm.white@precisionparts.com', 'operator', 'Warehouse', '2022-03-01', 31.00, true),

-- Admin
('EMP026', 'Rachel', 'Harris', 'r.harris@precisionparts.com', 'admin', 'Administration', '2020-01-15', 45.00, true),

-- Shipping
('EMP027', 'Steven', 'Clark', 's.clark@precisionparts.com', 'operator', 'Shipping', '2021-07-01', 33.00, true),
('EMP028', 'Lauren', 'Lewis', 'l.lewis@precisionparts.com', 'operator', 'Shipping', '2022-08-01', 32.00, true),

-- Inactive/Deleted employees for testing soft-delete queries
('EMP029', 'George', 'Walker', 'g.walker@precisionparts.com', 'operator', 'Production', '2019-05-01', 35.00, false),
('EMP030', 'Diana', 'Hall', 'd.hall@precisionparts.com', 'operator', 'Production', '2020-02-01', 34.00, true)
ON CONFLICT (employee_number) DO NOTHING;

-- Soft-delete some employees for testing
UPDATE employees 
SET deleted_at = '2024-06-15 10:00:00', is_active = false 
WHERE employee_number = 'EMP029';

UPDATE employees 
SET deleted_at = '2024-09-01 14:30:00', is_active = false 
WHERE employee_number = 'EMP030';
