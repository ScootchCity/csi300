-- =============================================================================
-- PawCare Seed Data - Part 3: Owners
-- =============================================================================

INSERT INTO owners (first_name, last_name, email, phone, address, city, state, zip_code, preferred_clinic_id, registered_at, is_active) VALUES
-- Active owners with multiple pets
('John', 'Smith', 'john.smith@email.com', '802-555-0001', '123 Maple Street', 'Burlington', 'Vermont', '05401', 1, '2020-01-15 10:00:00', TRUE),
('Sarah', 'Johnson', 'sarah.j@email.com', '802-555-0002', '456 Oak Avenue', 'Burlington', 'Vermont', '05401', 1, '2020-02-20 14:30:00', TRUE),
('Michael', 'Williams', 'mwilliams@email.com', '802-555-0003', '789 Pine Road', 'South Burlington', 'Vermont', '05403', 2, '2020-03-10 09:15:00', TRUE),
('Emily', 'Brown', 'emily.brown@email.com', '802-555-0004', '321 Elm Street', 'Burlington', 'Vermont', '05401', 1, '2020-04-05 11:45:00', TRUE),
('David', 'Jones', 'djones@email.com', '802-555-0005', '654 Cedar Lane', 'Williston', 'Vermont', '05495', 3, '2020-05-12 16:00:00', TRUE),
('Jessica', 'Garcia', 'jgarcia@email.com', '802-555-0006', '987 Birch Way', 'Essex Junction', 'Vermont', '05452', 5, '2020-06-18 10:30:00', TRUE),
('Christopher', 'Miller', 'cmiller@email.com', '802-555-0007', '147 Spruce Court', 'Burlington', 'Vermont', '05401', 2, '2020-07-22 13:00:00', TRUE),
('Amanda', 'Davis', 'amanda.d@email.com', '802-555-0008', '258 Willow Drive', 'Colchester', 'Vermont', '05446', 3, '2020-08-30 15:15:00', TRUE),
('Matthew', 'Rodriguez', 'mrodriguez@email.com', '802-555-0009', '369 Ash Boulevard', 'South Burlington', 'Vermont', '05403', 2, '2020-09-14 09:45:00', TRUE),
('Ashley', 'Martinez', 'amartinez@email.com', '802-555-0010', '741 Hickory Street', 'Burlington', 'Vermont', '05401', 1, '2020-10-25 12:30:00', TRUE),

-- More owners
('Daniel', 'Anderson', 'danderson@email.com', '802-555-0011', '852 Magnolia Ave', 'Williston', 'Vermont', '05495', 3, '2020-11-08 10:00:00', TRUE),
('Jennifer', 'Taylor', 'jtaylor@email.com', '802-555-0012', '963 Poplar Lane', 'Essex Junction', 'Vermont', '05452', 5, '2020-12-15 14:00:00', TRUE),
('Ryan', 'Thomas', 'rthomas@email.com', '802-555-0013', '159 Cherry Road', 'Burlington', 'Vermont', '05401', 1, '2021-01-20 11:30:00', TRUE),
('Stephanie', 'Hernandez', 'shernandez@email.com', '802-555-0014', '267 Dogwood Way', 'Colchester', 'Vermont', '05446', 2, '2021-02-28 09:00:00', TRUE),
('Joshua', 'Moore', 'jmoore@email.com', '802-555-0015', '378 Redwood Court', 'South Burlington', 'Vermont', '05403', 2, '2021-03-12 16:45:00', TRUE),
('Nicole', 'Jackson', 'njackson@email.com', '802-555-0016', '489 Cypress Drive', 'Burlington', 'Vermont', '05401', 1, '2021-04-18 10:15:00', TRUE),
('Andrew', 'White', 'awhite@email.com', '802-555-0017', '591 Sycamore Street', 'Williston', 'Vermont', '05495', 3, '2021-05-25 13:30:00', TRUE),
('Megan', 'Harris', 'mharris@email.com', '802-555-0018', '602 Chestnut Lane', 'Essex Junction', 'Vermont', '05452', 5, '2021-06-30 15:00:00', TRUE),
('Brandon', 'Clark', 'bclark@email.com', '802-555-0019', '713 Walnut Avenue', 'Burlington', 'Vermont', '05401', 1, '2021-07-14 09:30:00', TRUE),
('Lauren', 'Lewis', 'llewis@email.com', '802-555-0020', '824 Beech Road', 'Colchester', 'Vermont', '05446', 3, '2021-08-22 11:00:00', TRUE),

-- 2022 registrations
('Kevin', 'Robinson', 'krobinson@email.com', '802-555-0021', '935 Alder Way', 'South Burlington', 'Vermont', '05403', 2, '2022-01-10 10:00:00', TRUE),
('Rachel', 'Walker', 'rwalker@email.com', '802-555-0022', '146 Fir Court', 'Burlington', 'Vermont', '05401', 1, '2022-02-15 14:30:00', TRUE),
('Tyler', 'Hall', 'thall@email.com', '802-555-0023', '257 Juniper Drive', 'Williston', 'Vermont', '05495', 3, '2022-03-20 09:15:00', TRUE),
('Samantha', 'Allen', 'sallen@email.com', '802-555-0024', '368 Hemlock Street', 'Essex Junction', 'Vermont', '05452', 5, '2022-04-25 11:45:00', TRUE),
('Justin', 'Young', 'jyoung@email.com', '802-555-0025', '479 Locust Lane', 'Burlington', 'Vermont', '05401', 1, '2022-05-30 16:00:00', TRUE),
('Brittany', 'King', 'bking@email.com', '802-555-0026', '581 Mulberry Ave', 'Colchester', 'Vermont', '05446', 2, '2022-06-08 10:30:00', TRUE),
('Jason', 'Wright', 'jwright@email.com', '802-555-0027', '692 Palm Road', 'South Burlington', 'Vermont', '05403', 2, '2022-07-15 13:00:00', TRUE),
('Amber', 'Scott', 'ascott@email.com', '802-555-0028', '703 Olive Way', 'Burlington', 'Vermont', '05401', 1, '2022-08-22 15:15:00', TRUE),
('Eric', 'Green', 'egreen@email.com', '802-555-0029', '814 Peach Court', 'Williston', 'Vermont', '05495', 3, '2022-09-28 09:45:00', TRUE),
('Heather', 'Adams', 'hadams@email.com', '802-555-0030', '925 Plum Drive', 'Essex Junction', 'Vermont', '05452', 5, '2022-10-05 12:30:00', TRUE),

-- 2023-2024 registrations
('Patrick', 'Nelson', 'pnelson@email.com', '802-555-0031', '136 Apple Street', 'Burlington', 'Vermont', '05401', 1, '2023-01-12 10:00:00', TRUE),
('Christina', 'Carter', 'ccarter@email.com', '802-555-0032', '247 Pear Lane', 'Colchester', 'Vermont', '05446', 2, '2023-02-18 14:00:00', TRUE),
('Sean', 'Mitchell', 'smitchell@email.com', '802-555-0033', '358 Fig Avenue', 'South Burlington', 'Vermont', '05403', 2, '2023-03-25 11:30:00', TRUE),
('Monica', 'Perez', 'mperez@email.com', '802-555-0034', '469 Grape Road', 'Burlington', 'Vermont', '05401', 1, '2023-04-30 09:00:00', TRUE),
('Derek', 'Roberts', 'droberts@email.com', '802-555-0035', '571 Lemon Way', 'Williston', 'Vermont', '05495', 3, '2023-05-15 16:45:00', TRUE),
('Vanessa', 'Turner', 'vturner@email.com', '802-555-0036', '682 Lime Court', 'Essex Junction', 'Vermont', '05452', 5, '2023-06-22 10:15:00', TRUE),
('Scott', 'Phillips', 'sphillips@email.com', '802-555-0037', '793 Orange Drive', 'Burlington', 'Vermont', '05401', 1, '2023-07-28 13:30:00', TRUE),
('Kimberly', 'Campbell', 'kcampbell@email.com', '802-555-0038', '804 Mango Street', 'Colchester', 'Vermont', '05446', 3, '2023-08-10 15:00:00', TRUE),
('Gregory', 'Parker', 'gparker@email.com', '802-555-0039', '915 Coconut Lane', 'South Burlington', 'Vermont', '05403', 2, '2023-09-18 09:30:00', TRUE),
('Tiffany', 'Evans', 'tevans@email.com', '802-555-0040', '126 Banana Avenue', 'Burlington', 'Vermont', '05401', 1, '2023-10-25 11:00:00', TRUE),

-- 2024 registrations
('Marcus', 'Edwards', 'medwards@email.com', '802-555-0041', '237 Papaya Road', 'Williston', 'Vermont', '05495', 3, '2024-01-08 10:00:00', TRUE),
('Alicia', 'Collins', 'acollins@email.com', '802-555-0042', '348 Guava Way', 'Essex Junction', 'Vermont', '05452', 5, '2024-02-14 14:30:00', TRUE),
('Travis', 'Stewart', 'tstewart@email.com', '802-555-0043', '459 Melon Court', 'Burlington', 'Vermont', '05401', 1, '2024-03-20 09:15:00', TRUE),
('Michelle', 'Sanchez', 'msanchez@email.com', '802-555-0044', '561 Kiwi Drive', 'Colchester', 'Vermont', '05446', 2, '2024-04-25 11:45:00', TRUE),
('Richard', 'Morris', 'rmorris@email.com', '802-555-0045', '672 Berry Street', 'South Burlington', 'Vermont', '05403', 2, '2024-05-30 16:00:00', TRUE),

-- Owners with exotic pets
('Linda', 'Foster', 'lfoster@email.com', '802-555-0046', '783 Exotic Lane', 'Burlington', 'Vermont', '05401', 1, '2021-03-15 10:30:00', TRUE),
('Robert', 'Powell', 'rpowell@email.com', '802-555-0047', '894 Rare Road', 'Williston', 'Vermont', '05495', 3, '2022-05-20 13:00:00', TRUE),
('Elizabeth', 'Reed', 'ereed@email.com', '802-555-0048', '905 Unusual Way', 'Essex Junction', 'Vermont', '05452', 5, '2023-07-10 15:15:00', TRUE),

-- Inactive owners (for filtering)
('William', 'Cooper', 'wcooper@email.com', '802-555-0049', '116 Past Street', 'Burlington', 'Vermont', '05401', 1, '2019-06-15 09:45:00', FALSE),
('Nancy', 'Richardson', 'nrichardson@email.com', '802-555-0050', '227 Former Lane', 'Colchester', 'Vermont', '05446', 2, '2018-08-22 12:30:00', FALSE)
ON CONFLICT DO NOTHING;
