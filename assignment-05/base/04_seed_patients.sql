-- =============================================================================
-- MedCare Seed Data - Part 3: Patients
-- =============================================================================

-- Patients (some with insurance, some without for LEFT JOIN practice)
INSERT INTO patients (first_name, last_name, date_of_birth, gender, email, phone, address, city, state, zip_code, insurance_id, policy_number, emergency_contact_name, emergency_contact_phone, blood_type, allergies, is_active) VALUES
-- Patients with insurance
('John', 'Smith', '1975-03-15', 'Male', 'john.smith@email.com', '802-555-2001', '123 Main St', 'Burlington', 'VT', '05401', 1, 'BCBS-VT-001234', 'Mary Smith', '802-555-2002', 'A+', 'Penicillin', true),
('Sarah', 'Johnson', '1982-07-22', 'Female', 'sarah.j@email.com', '802-555-2003', '456 Oak Ave', 'Burlington', 'VT', '05401', 1, 'BCBS-VT-001235', 'Tom Johnson', '802-555-2004', 'B+', NULL, true),
('Michael', 'Williams', '1968-11-08', 'Male', 'mwilliams@email.com', '802-555-2005', '789 Pine St', 'South Burlington', 'VT', '05403', 3, 'MVP-HMO-5001', 'Lisa Williams', '802-555-2006', 'O+', 'Sulfa drugs', true),
('Emily', 'Brown', '1990-04-30', 'Female', 'emily.brown@email.com', '802-555-2007', '321 Elm Rd', 'Williston', 'VT', '05495', 5, 'CIGNA-PPO-7890', 'Robert Brown', '802-555-2008', 'A-', NULL, true),
('David', 'Jones', '1955-09-12', 'Male', 'djones@email.com', '802-555-2009', '654 Maple Dr', 'Essex Junction', 'VT', '05452', 11, 'MEDICARE-123456', 'Carol Jones', '802-555-2010', 'AB+', 'Aspirin, Latex', true),
('Jennifer', 'Davis', '1988-01-25', 'Female', 'jdavis@email.com', '802-555-2011', '987 Cedar Ln', 'Colchester', 'VT', '05446', 9, 'UHC-PPO-456789', 'Mark Davis', '802-555-2012', 'B-', NULL, true),
('Christopher', 'Miller', '1972-06-18', 'Male', 'cmiller@email.com', '802-555-2013', '147 Birch Way', 'Burlington', 'VT', '05401', 7, 'AETNA-HMO-2345', 'Susan Miller', '802-555-2014', 'O-', 'Codeine', true),
('Amanda', 'Wilson', '1995-12-03', 'Female', 'awilson@email.com', '802-555-2015', '258 Spruce Ave', 'Winooski', 'VT', '05404', 4, 'MVP-PPO-6789', 'James Wilson', '802-555-2016', 'A+', NULL, true),
('Matthew', 'Moore', '1980-08-14', 'Male', 'mmoore@email.com', '802-555-2017', '369 Walnut St', 'Burlington', 'VT', '05401', 1, 'BCBS-VT-001236', 'Linda Moore', '802-555-2018', 'B+', 'Ibuprofen', true),
('Jessica', 'Taylor', '1993-02-28', 'Female', 'jtaylor@email.com', '802-555-2019', '741 Ash Blvd', 'Essex', 'VT', '05451', 6, 'CIGNA-EPO-3456', 'Kevin Taylor', '802-555-2020', 'AB-', NULL, true),

('Robert', 'Anderson', '1965-05-20', 'Male', 'randerson@email.com', '802-555-2021', '852 Hickory Ln', 'Milton', 'VT', '05468', 11, 'MEDICARE-234567', 'Patricia Anderson', '802-555-2022', 'O+', NULL, true),
('Ashley', 'Thomas', '1987-10-07', 'Female', 'athomas@email.com', '802-555-2023', '963 Poplar Dr', 'Burlington', 'VT', '05401', 2, 'BCBS-HMO-7890', 'Richard Thomas', '802-555-2024', 'A+', 'Shellfish', true),
('Daniel', 'Jackson', '1978-03-31', 'Male', 'djackson@email.com', '802-555-2025', '159 Cherry St', 'South Burlington', 'VT', '05403', 8, 'AETNA-PPO-4567', 'Karen Jackson', '802-555-2026', 'B-', NULL, true),
('Megan', 'White', '1992-07-16', 'Female', 'mwhite@email.com', '802-555-2027', '267 Willow Ave', 'Williston', 'VT', '05495', 3, 'MVP-HMO-5002', 'Steven White', '802-555-2028', 'O+', 'Eggs', true),
('Andrew', 'Harris', '1960-12-25', 'Male', 'aharris@email.com', '802-555-2029', '378 Dogwood Rd', 'Colchester', 'VT', '05446', 12, 'MEDICAID-VT-001', 'Nancy Harris', '802-555-2030', 'A-', 'Peanuts', true),
('Nicole', 'Martin', '1985-04-09', 'Female', 'nmartin@email.com', '802-555-2031', '489 Magnolia Blvd', 'Burlington', 'VT', '05401', 10, 'UHC-HMO-567890', 'Brian Martin', '802-555-2032', 'AB+', NULL, true),
('Joshua', 'Garcia', '1998-09-21', 'Male', 'jgarcia@email.com', '802-555-2033', '591 Redwood Way', 'Essex Junction', 'VT', '05452', 5, 'CIGNA-PPO-7891', 'Maria Garcia', '802-555-2034', 'B+', NULL, true),
('Stephanie', 'Martinez', '1970-01-14', 'Female', 'smartinez@email.com', '802-555-2035', '602 Cypress St', 'Burlington', 'VT', '05401', 1, 'BCBS-VT-001237', 'Carlos Martinez', '802-555-2036', 'O-', 'Morphine', true),
('Kevin', 'Robinson', '1983-06-06', 'Male', 'krobinson@email.com', '802-555-2037', '713 Juniper Ln', 'Winooski', 'VT', '05404', 9, 'UHC-PPO-456790', 'Michelle Robinson', '802-555-2038', 'A+', NULL, true),
('Rachel', 'Clark', '1996-11-30', 'Female', 'rclark@email.com', '802-555-2039', '824 Sycamore Dr', 'South Burlington', 'VT', '05403', 4, 'MVP-PPO-6790', 'Timothy Clark', '802-555-2040', 'B+', 'Dairy', true),

('William', 'Rodriguez', '1958-02-17', 'Male', 'wrodriguez@email.com', '802-555-2041', '935 Beech Ave', 'Milton', 'VT', '05468', 11, 'MEDICARE-345678', 'Carmen Rodriguez', '802-555-2042', 'AB-', NULL, true),
('Lauren', 'Lewis', '1989-08-23', 'Female', 'llewis@email.com', '802-555-2043', '146 Locust Blvd', 'Burlington', 'VT', '05401', 13, 'HUMANA-PPO-123', 'Ryan Lewis', '802-555-2044', 'O+', NULL, true),
('Brandon', 'Lee', '1976-04-05', 'Male', 'blee@email.com', '802-555-2045', '257 Chestnut Way', 'Essex', 'VT', '05451', 7, 'AETNA-HMO-2346', 'Jennifer Lee', '802-555-2046', 'A-', 'Latex', true),
('Kayla', 'Walker', '2005-10-12', 'Female', NULL, '802-555-2047', '368 Hawthorn Rd', 'Burlington', 'VT', '05401', 2, 'BCBS-HMO-7891', 'Eric Walker', '802-555-2048', 'B+', NULL, true),
('Tyler', 'Hall', '2010-03-28', 'Male', NULL, '802-555-2049', '479 Palm St', 'Colchester', 'VT', '05446', 1, 'BCBS-VT-001238', 'Heather Hall', '802-555-2050', 'O+', 'Tree nuts', true),
('Brittany', 'Allen', '1991-07-19', 'Female', 'ballen@email.com', '802-555-2051', '580 Olive Ln', 'Williston', 'VT', '05495', 5, 'CIGNA-PPO-7892', 'Scott Allen', '802-555-2052', 'A+', NULL, true),
('Justin', 'Young', '1973-12-08', 'Male', 'jyoung@email.com', '802-555-2053', '691 Ivy Dr', 'Burlington', 'VT', '05401', 8, 'AETNA-PPO-4568', 'Angela Young', '802-555-2054', 'B-', NULL, true),
('Samantha', 'King', '1986-05-03', 'Female', 'sking@email.com', '802-555-2055', '702 Fern Way', 'South Burlington', 'VT', '05403', 10, 'UHC-HMO-567891', 'Derek King', '802-555-2056', 'AB+', 'Gluten', true),
('Ryan', 'Wright', '2015-09-14', 'Male', NULL, '802-555-2057', '813 Moss Blvd', 'Essex Junction', 'VT', '05452', 3, 'MVP-HMO-5003', 'Chelsea Wright', '802-555-2058', 'O-', NULL, true),
('Amber', 'Scott', '1994-01-27', 'Female', 'ascott@email.com', '802-555-2059', '924 Reed Ave', 'Winooski', 'VT', '05404', 6, 'CIGNA-EPO-3457', 'Derek Scott', '802-555-2060', 'A+', NULL, true),

-- Patients WITHOUT insurance (for LEFT JOIN practice - NULL insurance_id)
('Thomas', 'Green', '1981-11-11', 'Male', 'tgreen@email.com', '802-555-2061', '135 Oak Hill Rd', 'Burlington', 'VT', '05401', NULL, NULL, 'Patricia Green', '802-555-2062', 'B+', NULL, true),
('Melissa', 'Baker', '1967-06-24', 'Female', 'mbaker@email.com', '802-555-2063', '246 Valley View', 'Milton', 'VT', '05468', NULL, NULL, 'Harold Baker', '802-555-2064', 'O+', 'Sulfa', true),
('Eric', 'Adams', '1999-03-16', 'Male', 'eadams@email.com', '802-555-2065', '357 Mountain Rd', 'Stowe', 'VT', '05672', NULL, NULL, 'Linda Adams', '802-555-2066', 'A-', NULL, true),
('Christina', 'Nelson', '1984-08-09', 'Female', 'cnelson@email.com', '802-555-2067', '468 Lake St', 'Shelburne', 'VT', '05482', NULL, NULL, 'Mark Nelson', '802-555-2068', 'AB+', NULL, true),
('Gregory', 'Carter', '1962-02-14', 'Male', 'gcarter@email.com', '802-555-2069', '579 River Rd', 'Montpelier', 'VT', '05602', 15, NULL, 'Susan Carter', '802-555-2070', 'B-', 'Penicillin', true), -- Self-pay

-- More patients with various insurance for variety
('Rebecca', 'Mitchell', '1979-04-22', 'Female', 'rmitchell@email.com', '802-555-2071', '680 Forest Ave', 'Burlington', 'VT', '05401', 1, 'BCBS-VT-001239', 'Paul Mitchell', '802-555-2072', 'O+', NULL, true),
('Nathan', 'Perez', '1988-10-05', 'Male', 'nperez@email.com', '802-555-2073', '791 Summit Dr', 'South Burlington', 'VT', '05403', 9, 'UHC-PPO-456791', 'Maria Perez', '802-555-2074', 'A+', NULL, true),
('Hannah', 'Roberts', '2008-07-31', 'Female', NULL, '802-555-2075', '802 Meadow Ln', 'Williston', 'VT', '05495', 4, 'MVP-PPO-6791', 'Jason Roberts', '802-555-2076', 'B+', 'Bee stings', true),
('Adam', 'Turner', '1953-01-18', 'Male', 'aturner@email.com', '802-555-2077', '913 Sunset Blvd', 'Colchester', 'VT', '05446', 11, 'MEDICARE-456789', 'Dorothy Turner', '802-555-2078', 'O-', 'Contrast dye', true),
('Victoria', 'Phillips', '1997-06-13', 'Female', 'vphillips@email.com', '802-555-2079', '124 Sunrise Way', 'Essex', 'VT', '05451', 2, 'BCBS-HMO-7892', 'Daniel Phillips', '802-555-2080', 'A+', NULL, true),

-- Inactive patient for testing
('Charles', 'Cooper', '1945-12-01', 'Male', 'ccooper@email.com', '802-555-2081', '235 Winter St', 'Burlington', 'VT', '05401', 11, 'MEDICARE-567890', 'Ellen Cooper', '802-555-2082', 'AB-', 'Multiple', false),

-- Additional patients for more data
('Elizabeth', 'Bailey', '1974-09-08', 'Female', 'ebailey@email.com', '802-555-2083', '346 Spring Rd', 'Winooski', 'VT', '05404', 5, 'CIGNA-PPO-7893', 'Thomas Bailey', '802-555-2084', 'B+', NULL, true),
('Jason', 'Rivera', '1986-02-20', 'Male', 'jrivera@email.com', '802-555-2085', '457 Summer Ave', 'Burlington', 'VT', '05401', 7, 'AETNA-HMO-2347', 'Rosa Rivera', '802-555-2086', 'O+', NULL, true),
('Michelle', 'Campbell', '1990-11-15', 'Female', 'mcampbell@email.com', '802-555-2087', '568 Autumn Blvd', 'South Burlington', 'VT', '05403', 3, 'MVP-HMO-5004', 'David Campbell', '802-555-2088', 'A-', 'Nickel', true),
('Patrick', 'Parker', '1969-07-04', 'Male', 'pparker@email.com', '802-555-2089', '679 Harvest Ln', 'Milton', 'VT', '05468', 10, 'UHC-HMO-567892', 'Linda Parker', '802-555-2090', 'B-', NULL, true),
('Christina', 'Evans', '2012-04-17', 'Female', NULL, '802-555-2091', '780 Garden Way', 'Essex Junction', 'VT', '05452', 1, 'BCBS-VT-001240', 'Michael Evans', '802-555-2092', 'AB+', 'Strawberries', true),
('Derek', 'Edwards', '1977-08-26', 'Male', 'dedwards@email.com', '802-555-2093', '891 Orchard Dr', 'Colchester', 'VT', '05446', 8, 'AETNA-PPO-4569', 'Sarah Edwards', '802-555-2094', 'O+', NULL, true),
('Allison', 'Collins', '1993-03-09', 'Female', 'acollins@email.com', '802-555-2095', '902 Vineyard St', 'Burlington', 'VT', '05401', 6, 'CIGNA-EPO-3458', 'Brian Collins', '802-555-2096', 'A+', NULL, true),
('Marcus', 'Stewart', '1961-10-30', 'Male', 'mstewart@email.com', '802-555-2097', '113 Prairie Rd', 'Williston', 'VT', '05495', 12, 'MEDICAID-VT-002', 'Diana Stewart', '802-555-2098', 'B+', 'NSAIDs', true)
ON CONFLICT DO NOTHING;
