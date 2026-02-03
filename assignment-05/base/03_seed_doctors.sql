-- =============================================================================
-- MedCare Seed Data - Part 2: Doctors with Hierarchy
-- =============================================================================

-- Doctors (with supervisor hierarchy for self-join practice)
INSERT INTO doctors (first_name, last_name, email, phone, department_id, hire_date, license_number, supervisor_id, is_active) VALUES
-- Chief Medical Officer (no supervisor)
('Margaret', 'Chen', 'margaret.chen@com', '802-555-1000', 5, '2010-03-15', 'VT-MD-10001', NULL, true),

-- Department Heads (report to CMO)
('Robert', 'Williams', 'robert.williams@com', '802-555-1001', 1, '2012-06-01', 'VT-MD-10002', 1, true), -- Cardiology Head
('Sarah', 'Johnson', 'sarah.johnson@com', '802-555-1002', 2, '2013-09-15', 'VT-MD-10003', 1, true), -- Neurology Head
('Michael', 'Brown', 'michael.brown@com', '802-555-1003', 3, '2014-01-10', 'VT-MD-10004', 1, true), -- Orthopedics Head
('Emily', 'Davis', 'emily.davis@com', '802-555-1004', 4, '2011-07-20', 'VT-MD-10005', 1, true), -- Pediatrics Head
('James', 'Wilson', 'james.wilson@com', '802-555-1005', 5, '2015-03-01', 'VT-MD-10006', 1, true), -- Internal Medicine Head
('Lisa', 'Anderson', 'lisa.anderson@com', '802-555-1006', 6, '2016-05-15', 'VT-MD-10007', 1, true), -- Dermatology Head
('David', 'Taylor', 'david.taylor@com', '802-555-1007', 7, '2012-11-01', 'VT-MD-10008', 1, true), -- Oncology Head
('Jennifer', 'Martinez', 'jennifer.martinez@com', '802-555-1008', 8, '2017-02-01', 'VT-MD-10009', 1, true), -- Psychiatry Head
('Christopher', 'Garcia', 'christopher.garcia@com', '802-555-1009', 9, '2014-08-15', 'VT-MD-10010', 1, true), -- OB/GYN Head
('Amanda', 'Rodriguez', 'amanda.rodriguez@com', '802-555-1010', 10, '2013-04-01', 'VT-MD-10011', 1, true), -- Emergency Head
('Steven', 'Lee', 'steven.lee@com', '802-555-1011', 11, '2015-09-01', 'VT-MD-10012', 1, true), -- Radiology Head
('Patricia', 'White', 'patricia.white@com', '802-555-1012', 12, '2016-01-15', 'VT-MD-10013', 1, true), -- Gastroenterology Head

-- Senior Doctors (report to department heads)
-- Cardiology Seniors
('Thomas', 'Harris', 'thomas.harris@com', '802-555-1101', 1, '2018-03-01', 'VT-MD-10101', 2, true),
('Nancy', 'Clark', 'nancy.clark@com', '802-555-1102', 1, '2019-06-15', 'VT-MD-10102', 2, true),
-- Neurology Seniors
('Daniel', 'Lewis', 'daniel.lewis@com', '802-555-1103', 2, '2018-09-01', 'VT-MD-10103', 3, true),
('Michelle', 'Walker', 'michelle.walker@com', '802-555-1104', 2, '2017-11-01', 'VT-MD-10104', 3, true),
-- Orthopedics Seniors
('Kevin', 'Hall', 'kevin.hall@com', '802-555-1105', 3, '2019-02-15', 'VT-MD-10105', 4, true),
('Laura', 'Allen', 'laura.allen@com', '802-555-1106', 3, '2018-07-01', 'VT-MD-10106', 4, true),
-- Pediatrics Seniors
('Brian', 'Young', 'brian.young@com', '802-555-1107', 4, '2016-04-01', 'VT-MD-10107', 5, true),
('Stephanie', 'King', 'stephanie.king@com', '802-555-1108', 4, '2019-01-15', 'VT-MD-10108', 5, true),
-- Internal Medicine Seniors
('Richard', 'Wright', 'richard.wright@com', '802-555-1109', 5, '2017-08-01', 'VT-MD-10109', 6, true),
('Karen', 'Scott', 'karen.scott@com', '802-555-1110', 5, '2018-11-15', 'VT-MD-10110', 6, true),

-- Staff Doctors (report to senior doctors)
-- Cardiology Staff
('Jason', 'Green', 'jason.green@com', '802-555-1201', 1, '2020-03-01', 'VT-MD-10201', 13, true),
('Angela', 'Baker', 'angela.baker@com', '802-555-1202', 1, '2021-06-15', 'VT-MD-10202', 13, true),
('Eric', 'Adams', 'eric.adams@com', '802-555-1203', 1, '2022-01-10', 'VT-MD-10203', 14, true),
-- Neurology Staff
('Rachel', 'Nelson', 'rachel.nelson@com', '802-555-1204', 2, '2020-09-01', 'VT-MD-10204', 15, true),
('William', 'Carter', 'william.carter@com', '802-555-1205', 2, '2021-02-15', 'VT-MD-10205', 16, true),
-- Orthopedics Staff
('Megan', 'Mitchell', 'megan.mitchell@com', '802-555-1206', 3, '2020-05-01', 'VT-MD-10206', 17, true),
('Jeffrey', 'Roberts', 'jeffrey.roberts@com', '802-555-1207', 3, '2022-03-15', 'VT-MD-10207', 18, true),
-- Pediatrics Staff
('Ashley', 'Turner', 'ashley.turner@com', '802-555-1208', 4, '2021-08-01', 'VT-MD-10208', 19, true),
('Justin', 'Phillips', 'justin.phillips@com', '802-555-1209', 4, '2020-11-15', 'VT-MD-10209', 20, true),
-- Internal Medicine Staff
('Nicole', 'Campbell', 'nicole.campbell@com', '802-555-1210', 5, '2021-04-01', 'VT-MD-10210', 21, true),
('Andrew', 'Parker', 'andrew.parker@com', '802-555-1211', 5, '2022-07-15', 'VT-MD-10211', 22, true),
-- Emergency Staff
('Heather', 'Evans', 'heather.evans@com', '802-555-1212', 10, '2019-10-01', 'VT-MD-10212', 11, true),
('Brandon', 'Edwards', 'brandon.edwards@com', '802-555-1213', 10, '2020-02-15', 'VT-MD-10213', 11, true),
('Christina', 'Collins', 'christina.collins@com', '802-555-1214', 10, '2021-05-01', 'VT-MD-10214', 11, true),
-- Other departments
('Timothy', 'Stewart', 'timothy.stewart@com', '802-555-1215', 6, '2020-08-15', 'VT-MD-10215', 7, true), -- Dermatology
('Melissa', 'Sanchez', 'melissa.sanchez@com', '802-555-1216', 7, '2019-12-01', 'VT-MD-10216', 8, true), -- Oncology
('Gregory', 'Morris', 'gregory.morris@com', '802-555-1217', 8, '2021-03-15', 'VT-MD-10217', 9, true), -- Psychiatry
('Kimberly', 'Rogers', 'kimberly.rogers@com', '802-555-1218', 9, '2020-06-01', 'VT-MD-10218', 10, true), -- OB/GYN
('Ryan', 'Reed', 'ryan.reed@com', '802-555-1219', 11, '2022-09-15', 'VT-MD-10219', 12, true), -- Radiology
('Lauren', 'Cook', 'lauren.cook@com', '802-555-1220', 12, '2021-11-01', 'VT-MD-10220', 13, true), -- Gastroenterology

-- Inactive doctor (for testing)
('Mark', 'Thompson', 'mark.thompson@com', '802-555-1299', 5, '2015-01-01', 'VT-MD-10299', 6, false)
ON CONFLICT DO NOTHING;

-- Update department heads
UPDATE departments SET head_doctor_id = 2 WHERE department_id = 1;
UPDATE departments SET head_doctor_id = 3 WHERE department_id = 2;
UPDATE departments SET head_doctor_id = 4 WHERE department_id = 3;
UPDATE departments SET head_doctor_id = 5 WHERE department_id = 4;
UPDATE departments SET head_doctor_id = 6 WHERE department_id = 5;
UPDATE departments SET head_doctor_id = 7 WHERE department_id = 6;
UPDATE departments SET head_doctor_id = 8 WHERE department_id = 7;
UPDATE departments SET head_doctor_id = 9 WHERE department_id = 8;
UPDATE departments SET head_doctor_id = 10 WHERE department_id = 9;
UPDATE departments SET head_doctor_id = 11 WHERE department_id = 10;
UPDATE departments SET head_doctor_id = 12 WHERE department_id = 11;
UPDATE departments SET head_doctor_id = 13 WHERE department_id = 12;

-- Doctor Specializations (many-to-many)
INSERT INTO doctor_specializations (doctor_id, specialization_id, is_primary, certified_at, expires_at) VALUES
-- CMO
(1, 12, true, '2008-06-15', '2028-06-15'),
(1, 13, false, '2012-03-01', '2027-03-01'),
-- Cardiology
(2, 3, true, '2010-09-01', '2025-09-01'),
(2, 1, false, '2015-03-15', '2025-03-15'),
(13, 3, true, '2017-05-01', '2027-05-01'),
(14, 2, true, '2018-08-15', '2028-08-15'),
(14, 3, false, '2017-08-15', '2027-08-15'),
(24, 3, true, '2019-12-01', '2029-12-01'),
(25, 1, true, '2020-09-15', '2030-09-15'),
(26, 2, true, '2021-06-01', '2031-06-01'),
-- Neurology
(3, 4, true, '2012-11-01', '2027-11-01'),
(3, 5, false, '2015-06-15', '2025-06-15'),
(15, 5, true, '2017-12-01', '2027-12-01'),
(16, 6, true, '2016-09-15', '2026-09-15'),
(27, 4, true, '2019-11-01', '2029-11-01'),
(28, 5, true, '2020-05-15', '2030-05-15'),
-- Orthopedics
(4, 7, true, '2013-04-01', '2028-04-01'),
(4, 8, false, '2016-01-15', '2026-01-15'),
(17, 8, true, '2018-05-01', '2028-05-01'),
(18, 9, true, '2017-10-15', '2027-10-15'),
(29, 7, true, '2019-08-01', '2029-08-01'),
(30, 8, true, '2021-11-15', '2031-11-15'),
-- Pediatrics
(5, 10, true, '2010-10-01', '2025-10-01'),
(5, 11, false, '2014-06-15', '2024-06-15'),
(19, 10, true, '2015-07-01', '2025-07-01'),
(20, 11, true, '2018-04-15', '2028-04-15'),
(31, 10, true, '2020-11-01', '2030-11-01'),
(32, 10, true, '2020-02-15', '2030-02-15'),
-- Internal Medicine
(6, 12, true, '2014-06-01', '2029-06-01'),
(6, 13, false, '2018-03-15', '2028-03-15'),
(21, 12, true, '2016-11-01', '2026-11-01'),
(22, 13, true, '2017-02-15', '2027-02-15'),
(33, 12, true, '2020-07-01', '2030-07-01'),
(34, 12, true, '2021-10-15', '2031-10-15'),
-- Emergency
(11, 22, true, '2012-07-01', '2027-07-01'),
(35, 22, true, '2018-01-15', '2028-01-15'),
(36, 22, true, '2019-05-01', '2029-05-01'),
(37, 22, true, '2020-08-15', '2030-08-15'),
-- Other specializations
(7, 14, true, '2015-08-01', '2025-08-01'),
(7, 15, false, '2018-02-15', '2028-02-15'),
(8, 16, true, '2011-12-01', '2026-12-01'),
(8, 17, false, '2015-09-15', '2025-09-15'),
(9, 19, true, '2016-05-01', '2026-05-01'),
(9, 20, false, '2019-11-15', '2029-11-15'),
(10, 21, true, '2013-07-01', '2028-07-01'),
(12, 23, true, '2014-12-01', '2029-12-01'),
(12, 24, false, '2017-06-15', '2027-06-15'),
(13, 25, true, '2015-10-01', '2025-10-01')
ON CONFLICT DO NOTHING;
