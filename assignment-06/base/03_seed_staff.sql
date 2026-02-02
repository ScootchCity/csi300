-- =============================================================================
-- PawCare Seed Data - Part 2: Staff (with hierarchy for recursive CTE practice)
-- =============================================================================

-- Staff members with reporting hierarchy
-- Level 0: CEO/Owner (reports_to = NULL)
-- Level 1: Clinic Managers (report to CEO)
-- Level 2: Senior Vets (report to managers)
-- Level 3: Vets, Technicians (report to senior vets or managers)
-- Level 4: Junior staff (report to vets)

INSERT INTO staff (first_name, last_name, email, phone, role, specialization, license_number, hire_date, salary, reports_to, clinic_id, is_active) VALUES
-- CEO/Owner (Level 0)
('Victoria', 'Sterling', 'v.sterling@vet', '802-555-1000', 'manager', 'Executive Leadership', NULL, '2015-01-15', 150000.00, NULL, 1, TRUE),

-- Clinic Managers (Level 1) - report to CEO (id: 1)
('Marcus', 'Chen', 'm.chen@vet', '802-555-1001', 'manager', 'Hospital Administration', NULL, '2016-03-01', 85000.00, 1, 1, TRUE),
('Diana', 'Okonkwo', 'd.okonkwo@vet', '802-555-1002', 'manager', 'Hospital Administration', NULL, '2016-06-15', 85000.00, 1, 2, TRUE),
('Robert', 'Martinez', 'r.martinez@vet', '802-555-1003', 'manager', 'Hospital Administration', NULL, '2017-01-10', 82000.00, 1, 3, TRUE),
('Sarah', 'Thompson', 's.thompson@vet', '802-555-1004', 'manager', 'Emergency Services', NULL, '2017-04-01', 90000.00, 1, 4, TRUE),
('James', 'Wilson', 'j.wilson@vet', '802-555-1005', 'manager', 'Hospital Administration', NULL, '2018-02-20', 80000.00, 1, 5, TRUE),

-- Senior Veterinarians (Level 2) - report to managers
-- Downtown (clinic 1, manager id: 2)
('Dr. Emily', 'Watson', 'e.watson@vet', '802-555-2001', 'veterinarian', 'Internal Medicine', 'VT-2010-1234', '2017-05-01', 120000.00, 2, 1, TRUE),
('Dr. Michael', 'Park', 'm.park@vet', '802-555-2002', 'veterinarian', 'Surgery', 'VT-2012-2345', '2018-03-15', 125000.00, 2, 1, TRUE),

-- South End (clinic 2, manager id: 3)
('Dr. Lisa', 'Johnson', 'l.johnson@vet', '802-555-2003', 'veterinarian', 'Dermatology', 'VT-2011-3456', '2017-08-01', 118000.00, 3, 2, TRUE),
('Dr. David', 'Kim', 'd.kim@vet', '802-555-2004', 'veterinarian', 'Oncology', 'VT-2013-4567', '2018-11-01', 130000.00, 3, 2, TRUE),

-- Williston (clinic 3, manager id: 4)
('Dr. Amanda', 'Brown', 'a.brown@vet', '802-555-2005', 'veterinarian', 'Cardiology', 'VT-2014-5678', '2019-02-01', 122000.00, 4, 3, TRUE),

-- Emergency (clinic 4, manager id: 5)
('Dr. Christopher', 'Lee', 'c.lee@vet', '802-555-2006', 'specialist', 'Emergency & Critical Care', 'VT-2009-6789', '2016-09-01', 145000.00, 5, 4, TRUE),
('Dr. Jennifer', 'Garcia', 'j.garcia@vet', '802-555-2007', 'specialist', 'Emergency & Critical Care', 'VT-2010-7890', '2017-11-15', 140000.00, 5, 4, TRUE),

-- Essex (clinic 5, manager id: 6)
('Dr. Kevin', 'Patel', 'k.patel@vet', '802-555-2008', 'veterinarian', 'Dentistry', 'VT-2015-8901', '2019-06-01', 115000.00, 6, 5, TRUE),

-- Veterinarians (Level 3) - report to senior vets
-- Report to Dr. Watson (id: 7)
('Dr. Rachel', 'Green', 'r.green@vet', '802-555-3001', 'veterinarian', 'General Practice', 'VT-2018-1001', '2020-01-15', 95000.00, 7, 1, TRUE),
('Dr. Nathan', 'Scott', 'n.scott@vet', '802-555-3002', 'veterinarian', 'General Practice', 'VT-2019-1002', '2021-03-01', 90000.00, 7, 1, TRUE),

-- Report to Dr. Park (id: 8)
('Dr. Sophia', 'Turner', 's.turner@vet', '802-555-3003', 'veterinarian', 'Surgery', 'VT-2020-1003', '2022-05-01', 92000.00, 8, 1, TRUE),

-- Report to Dr. Johnson (id: 9)
('Dr. Brandon', 'Wright', 'b.wright@vet', '802-555-3004', 'veterinarian', 'General Practice', 'VT-2019-1004', '2021-08-15', 88000.00, 9, 2, TRUE),

-- Report to Dr. Kim (id: 10)
('Dr. Maria', 'Santos', 'm.santos@vet', '802-555-3005', 'veterinarian', 'General Practice', 'VT-2021-1005', '2023-01-10', 85000.00, 10, 2, TRUE),

-- Report to Dr. Brown (id: 11)
('Dr. Andrew', 'Phillips', 'a.phillips@vet', '802-555-3006', 'veterinarian', 'General Practice', 'VT-2020-1006', '2022-09-01', 87000.00, 11, 3, TRUE),

-- Report to Dr. Lee (id: 12)
('Dr. Jessica', 'Adams', 'j.adams@vet', '802-555-3007', 'veterinarian', 'Emergency', 'VT-2021-1007', '2023-04-01', 105000.00, 12, 4, TRUE),

-- Report to Dr. Patel (id: 14)
('Dr. Tyler', 'Mitchell', 't.mitchell@vet', '802-555-3008', 'veterinarian', 'General Practice', 'VT-2022-1008', '2024-01-15', 82000.00, 14, 5, TRUE),

-- Vet Technicians (Level 3/4) - report to vets or managers
-- Downtown techs (report to Dr. Watson id: 7)
('Ashley', 'Morgan', 'a.morgan@vet', '802-555-4001', 'vet_technician', NULL, 'VTT-2019-001', '2019-06-01', 42000.00, 7, 1, TRUE),
('Brian', 'Cooper', 'b.cooper@vet', '802-555-4002', 'vet_technician', NULL, 'VTT-2020-002', '2020-03-15', 40000.00, 7, 1, TRUE),
('Carla', 'Ruiz', 'c.ruiz@vet', '802-555-4003', 'vet_technician', NULL, 'VTT-2021-003', '2021-07-01', 38000.00, 8, 1, TRUE),

-- South End techs (report to Dr. Johnson id: 9)
('Derek', 'Hall', 'd.hall@vet', '802-555-4004', 'vet_technician', NULL, 'VTT-2018-004', '2018-09-01', 44000.00, 9, 2, TRUE),
('Elena', 'Torres', 'e.torres@vet', '802-555-4005', 'vet_technician', NULL, 'VTT-2020-005', '2020-11-01', 41000.00, 10, 2, TRUE),

-- Williston techs (report to Dr. Brown id: 11)
('Frank', 'Nelson', 'f.nelson@vet', '802-555-4006', 'vet_technician', NULL, 'VTT-2019-006', '2019-04-01', 43000.00, 11, 3, TRUE),
('Grace', 'Young', 'g.young@vet', '802-555-4007', 'vet_technician', NULL, 'VTT-2022-007', '2022-02-01', 37000.00, 11, 3, TRUE),

-- Emergency techs (report to Dr. Lee id: 12)
('Henry', 'Baker', 'h.baker@vet', '802-555-4008', 'vet_technician', NULL, 'VTT-2017-008', '2017-08-01', 48000.00, 12, 4, TRUE),
('Irene', 'Cox', 'i.cox@vet', '802-555-4009', 'vet_technician', NULL, 'VTT-2019-009', '2019-12-01', 46000.00, 13, 4, TRUE),
('Jack', 'Reed', 'j.reed@vet', '802-555-4010', 'vet_technician', NULL, 'VTT-2021-010', '2021-05-01', 42000.00, 12, 4, TRUE),

-- Essex techs (report to Dr. Patel id: 14)
('Karen', 'Wood', 'k.wood@vet', '802-555-4011', 'vet_technician', NULL, 'VTT-2020-011', '2020-08-01', 40000.00, 14, 5, TRUE),

-- Receptionists (Level 4) - report to managers
('Laura', 'Price', 'l.price@vet', '802-555-5001', 'receptionist', NULL, NULL, '2020-02-01', 35000.00, 2, 1, TRUE),
('Mike', 'Howard', 'm.howard@vet', '802-555-5002', 'receptionist', NULL, NULL, '2021-06-01', 34000.00, 3, 2, TRUE),
('Nancy', 'Ward', 'n.ward@vet', '802-555-5003', 'receptionist', NULL, NULL, '2019-10-01', 36000.00, 4, 3, TRUE),
('Oscar', 'Gray', 'o.gray@vet', '802-555-5004', 'receptionist', NULL, NULL, '2022-01-15', 33000.00, 5, 4, TRUE),
('Paula', 'Ross', 'p.ross@vet', '802-555-5005', 'receptionist', NULL, NULL, '2023-03-01', 32000.00, 6, 5, TRUE),

-- Inactive staff member (for filtering exercises)
('Dr. Thomas', 'Blake', 't.blake@vet', '802-555-9001', 'veterinarian', 'General Practice', 'VT-2016-9999', '2016-05-01', 95000.00, 7, 1, FALSE)
ON CONFLICT DO NOTHING;
