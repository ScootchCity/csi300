-- =============================================================================
-- PawCare Seed Data - Part 6: Treatments, Vaccinations, Prescriptions
-- =============================================================================

-- Treatments (procedures performed during visits)
-- Schema: record_id, procedure_id, medication_id, quantity, unit_price, notes, created_at
-- Note: Either procedure_id OR medication_id must be set (not both)
INSERT INTO treatments (record_id, procedure_id, quantity, unit_price, notes, created_at) VALUES
-- Wellness exam treatments
(1, 1, 1, 75.00, 'Comprehensive physical exam', '2023-01-15 09:30:00'),
(2, 1, 1, 75.00, 'Comprehensive physical exam', '2023-01-15 10:00:00'),
(3, 1, 1, 75.00, 'Comprehensive physical exam', '2023-02-10 10:30:00'),
(4, 1, 1, 75.00, 'Sick exam', '2023-02-10 11:00:00'),
(4, 25, 1, 85.00, 'IV fluid therapy for dehydration', '2023-02-10 11:30:00'),
(5, 1, 1, 75.00, 'Comprehensive physical exam', '2023-02-10 11:30:00'),
(6, 2, 1, 65.00, 'Sick visit exam', '2023-03-05 14:45:00'),
(6, 30, 1, 150.00, 'Radiograph - thorax', '2023-03-05 15:00:00'),
(7, 1, 1, 75.00, 'Vaccine visit', '2023-03-20 09:30:00'),
(8, 3, 1, 95.00, 'Exotic pet wellness', '2023-04-12 10:30:00'),

-- More treatments
(9, 1, 1, 75.00, 'Standard exam before vaccine', '2023-04-25 11:30:00'),
(10, 2, 1, 65.00, 'Ear examination', '2023-05-08 10:00:00'),
(10, 26, 1, 45.00, 'Ear cytology', '2023-05-08 10:15:00'),
(11, 1, 1, 75.00, 'Wellness exam', '2023-05-15 10:30:00'),
(12, 10, 1, 250.00, 'Dental cleaning with extractions', '2023-06-01 09:30:00'),
(12, 11, 2, 85.00, 'Two tooth extractions', '2023-06-01 10:00:00'),
(12, 8, 1, 175.00, 'General anesthesia', '2023-06-01 09:00:00'),
(13, 1, 1, 75.00, 'Post-op check', '2023-06-15 14:30:00'),
(14, 1, 1, 75.00, 'Comprehensive exam', '2023-07-10 10:30:00'),
(14, 27, 1, 125.00, 'Auscultation revealed murmur', '2023-07-10 10:45:00'),

(15, 1, 1, 75.00, 'Brief exam before vaccine', '2023-07-22 09:30:00'),
(16, 2, 1, 65.00, 'Orthopedic examination', '2023-08-05 11:30:00'),
(16, 30, 2, 150.00, 'Stifle radiographs', '2023-08-05 11:45:00'),
(17, 3, 1, 95.00, 'Rabbit wellness exam', '2023-08-18 10:30:00'),
(18, 14, 1, 65.00, 'Full grooming service', '2023-09-02 10:00:00'),
(18, 15, 1, 25.00, 'Nail trim', '2023-09-02 09:45:00'),
(19, 4, 1, 95.00, 'New patient comprehensive exam', '2023-09-15 14:30:00'),
(20, 1, 1, 75.00, 'Wellness exam', '2023-10-01 10:30:00'),

-- 2024 treatments
(21, 1, 1, 75.00, 'Annual exam', '2024-01-10 09:30:00'),
(22, 1, 1, 75.00, 'Annual exam', '2024-01-10 10:00:00'),
(23, 1, 1, 85.00, 'Senior wellness exam', '2024-01-25 10:30:00'),
(23, 30, 2, 150.00, 'Hip radiographs', '2024-01-25 10:45:00'),
(24, 2, 1, 65.00, 'Follow-up exam', '2024-02-05 14:30:00'),
(25, 3, 1, 95.00, 'Rabbit exam', '2024-02-20 10:30:00'),
(26, 2, 1, 65.00, 'Sick exam', '2024-03-05 11:30:00'),
(27, 4, 1, 95.00, 'New patient exam - husky', '2024-03-15 09:30:00'),
(28, 1, 1, 75.00, 'Annual wellness', '2024-03-28 10:30:00'),
(29, 4, 1, 95.00, 'New patient puppy exam', '2024-04-10 14:30:00'),
(30, 1, 1, 75.00, 'Wellness exam', '2024-04-22 10:30:00'),

(31, 2, 1, 65.00, 'Dermatology exam', '2024-05-05 10:00:00'),
(31, 28, 1, 55.00, 'Skin scraping', '2024-05-05 10:15:00'),
(32, 1, 1, 75.00, 'Annual exam', '2024-05-18 11:30:00'),
(33, 1, 1, 75.00, 'Wellness with weight check', '2024-06-01 10:30:00'),
(34, 7, 1, 450.00, 'Mass removal surgery', '2024-06-15 15:00:00'),
(34, 8, 1, 175.00, 'General anesthesia', '2024-06-15 14:00:00'),
(34, 17, 1, 125.00, 'Histopathology submission', '2024-06-15 16:00:00'),
(35, 4, 1, 95.00, 'New patient exam - Savannah', '2024-06-28 09:30:00'),
(36, 10, 1, 250.00, 'Dental cleaning', '2024-07-10 10:30:00'),
(36, 11, 6, 85.00, 'Multiple extractions - senior', '2024-07-10 11:00:00'),
(36, 8, 1, 175.00, 'General anesthesia', '2024-07-10 10:00:00'),

(37, 1, 1, 75.00, 'Annual wellness', '2024-07-22 10:00:00'),
(38, 5, 1, 85.00, 'Kitten exam', '2024-08-05 11:30:00'),
(39, 1, 1, 75.00, 'Wellness exam - greyhound', '2024-08-18 10:30:00'),
(40, 1, 1, 75.00, 'Annual wellness', '2024-09-01 14:30:00'),
(41, 1, 1, 85.00, 'Large breed orthopedic screening', '2024-09-15 11:00:00'),
(41, 30, 4, 150.00, 'Hip and elbow radiographs', '2024-09-15 11:30:00'),
(42, 1, 1, 75.00, 'Vaccine visit', '2024-10-05 09:30:00'),
(43, 2, 1, 65.00, 'Weight loss workup', '2024-10-18 10:30:00'),
(43, 24, 1, 125.00, 'Thyroid panel', '2024-10-18 10:45:00'),
(44, 2, 1, 65.00, 'Recheck exam', '2024-11-02 14:30:00'),
(45, 3, 1, 95.00, 'Exotic pet exam', '2024-11-15 10:30:00'),

-- Emergency treatments
(46, 2, 1, 125.00, 'Emergency triage exam', '2024-06-20 22:30:00'),
(46, 30, 6, 150.00, 'Full body radiographs', '2024-06-20 22:45:00'),
(46, 25, 1, 85.00, 'IV catheter and fluid therapy', '2024-06-20 23:00:00'),
(46, 22, 1, 95.00, 'Pain management protocol', '2024-06-20 23:00:00'),
(47, 2, 1, 125.00, 'Emergency exam - bloat', '2024-08-10 03:30:00'),
(47, 30, 2, 150.00, 'Abdominal radiographs', '2024-08-10 03:45:00'),
(47, 35, 1, 200.00, 'Gastric decompression', '2024-08-10 04:00:00'),
(48, 2, 1, 125.00, 'Toxicity exam', '2024-09-25 19:30:00'),
(48, 36, 1, 75.00, 'Induced emesis', '2024-09-25 19:45:00'),
(48, 25, 1, 85.00, 'IV fluid support', '2024-09-25 20:00:00')
ON CONFLICT DO NOTHING;

-- Vaccinations
-- Schema: pet_id, vaccine_id, administered_by, record_id, administered_at, next_due_date, batch_number, notes
INSERT INTO vaccinations (pet_id, vaccine_id, administered_by, administered_at, next_due_date, batch_number, notes) VALUES
-- 2023 vaccinations
(1, 1, 7, '2023-01-15 09:20:00', '2024-01-15', 'DHPP-2023-001', 'Annual booster'),
(2, 1, 7, '2023-01-15 09:50:00', '2024-01-15', 'DHPP-2023-001', 'Annual booster'),
(1, 2, 7, '2023-01-15 09:22:00', '2026-01-15', 'RAB-2023-015', '3 year rabies'),
(2, 2, 7, '2023-01-15 09:52:00', '2026-01-15', 'RAB-2023-015', '3 year rabies'),
(3, 3, 9, '2023-02-10 10:20:00', '2024-02-10', 'FVRCP-2023-008', 'Annual booster'),
(5, 3, 9, '2023-02-10 11:20:00', '2024-02-10', 'FVRCP-2023-008', 'Annual booster'),
(7, 3, 7, '2023-03-20 09:15:00', '2024-03-20', 'FVRCP-2023-012', 'Booster administered'),
(7, 2, 7, '2023-03-20 09:17:00', '2024-03-20', 'RAB-2023-022', '1 year rabies'),
(8, 12, 11, '2023-04-12 10:20:00', '2024-04-12', 'RHDV-2023-003', 'Rabbit vaccine'),
(9, 2, 11, '2023-04-25 11:20:00', '2026-04-25', 'RAB-2023-028', '3 year rabies'),

(10, 3, 7, '2023-05-08 10:20:00', '2024-05-08', 'FVRCP-2023-018', 'Annual booster'),
(11, 1, 7, '2023-05-15 10:45:00', '2024-05-15', 'DHPP-2023-022', 'Annual booster'),
(15, 3, 7, '2023-07-22 09:20:00', '2024-07-22', 'FVRCP-2023-028', 'FVRCP booster'),
(17, 12, 14, '2023-08-18 10:45:00', '2024-08-18', 'RHDV-2023-006', 'Rabbit vaccine'),
(20, 1, 11, '2023-10-01 10:45:00', '2024-10-01', 'DHPP-2023-040', 'Annual booster'),
(20, 6, 11, '2023-10-01 10:47:00', '2024-10-01', 'LYME-2023-012', 'Lyme vaccination'),

-- 2024 vaccinations
(1, 1, 7, '2024-01-10 09:20:00', '2025-01-10', 'DHPP-2024-002', 'Annual booster'),
(2, 1, 7, '2024-01-10 09:50:00', '2025-01-10', 'DHPP-2024-002', 'Annual booster'),
(3, 3, 9, '2024-01-25 10:20:00', '2025-01-25', 'FVRCP-2024-005', 'Annual booster'),
(8, 12, 11, '2024-02-20 10:45:00', '2025-02-20', 'RHDV-2024-001', 'Annual rabbit vaccine'),
(21, 1, 7, '2024-03-15 09:40:00', '2025-03-15', 'DHPP-2024-010', 'New patient vaccines'),
(21, 2, 7, '2024-03-15 09:42:00', '2027-03-15', 'RAB-2024-008', '3 year rabies'),
(22, 3, 9, '2024-03-28 10:45:00', '2025-03-28', 'FVRCP-2024-012', 'Annual booster'),
(23, 1, 11, '2024-04-10 14:45:00', '2024-05-10', 'DHPP-2024-015', 'Puppy series #2'),
(23, 2, 11, '2024-04-10 14:47:00', '2025-04-10', 'RAB-2024-012', '1 year puppy rabies'),
(24, 3, 14, '2024-04-22 10:45:00', '2025-04-22', 'FVRCP-2024-018', 'Annual booster'),

(26, 3, 9, '2024-05-18 11:45:00', '2025-05-18', 'FVRCP-2024-022', 'Annual booster'),
(29, 3, 9, '2024-06-28 09:45:00', '2025-06-28', 'FVRCP-2024-028', 'New patient vaccines'),
(31, 1, 7, '2024-07-22 10:15:00', '2025-07-22', 'DHPP-2024-032', 'Annual booster'),
(32, 3, 9, '2024-08-05 11:45:00', '2025-02-05', 'FVRCP-2024-035', 'Kitten series'),
(32, 5, 9, '2024-08-05 11:47:00', '2025-08-05', 'FELV-2024-008', 'FeLV for kitten'),
(33, 1, 11, '2024-08-18 10:45:00', '2025-08-18', 'DHPP-2024-038', 'Annual booster'),
(1, 1, 7, '2024-10-05 09:20:00', '2025-10-05', 'DHPP-2024-042', 'DHPP booster'),
(8, 12, 11, '2024-11-15 10:45:00', '2025-11-15', 'RHDV-2024-010', 'RHDV2 vaccine'),

-- Exotic pet vaccines
(40, 2, 14, '2024-05-10 10:30:00', '2025-05-10', 'RAB-2024-020', 'Ferret rabies'),
(40, 13, 14, '2024-05-10 10:32:00', '2025-05-10', 'CDV-2024-002', 'Ferret distemper')
ON CONFLICT DO NOTHING;

-- Prescriptions
-- Schema: record_id, medication_id, prescribed_by, dosage, quantity, refills_allowed, refills_used, instructions, start_date, end_date, is_filled
INSERT INTO prescriptions (record_id, medication_id, prescribed_by, dosage, quantity, refills_allowed, refills_used, instructions, start_date, end_date, is_filled) VALUES
-- Gastritis treatment
(4, 10, 9, '10mg once daily', 30, 2, 0, 'Give in morning on empty stomach', '2023-02-10', '2023-03-12', TRUE),
(4, 13, 9, '8mg twice daily', 20, 0, 0, 'Give with food', '2023-02-10', '2023-02-20', TRUE),

-- Brachycephalic management
(6, 5, 7, '25mg once daily', 60, 3, 1, 'Weight management supplement', '2023-03-05', '2023-05-05', TRUE),

-- Ear infection
(10, 23, 7, '5 drops twice daily', 1, 0, 0, 'Clean ear then apply 5 drops', '2023-05-08', '2023-05-22', TRUE),

-- Allergy treatment
(11, 1, 7, '16mg once daily', 30, 5, 2, 'For seasonal allergies', '2023-05-15', '2023-06-15', TRUE),

-- Post-dental antibiotics
(12, 19, 9, '250mg twice daily', 14, 0, 0, 'Complete full course', '2023-06-01', '2023-06-08', TRUE),
(12, 6, 9, '25mg twice daily', 14, 0, 0, 'Give with food for pain', '2023-06-01', '2023-06-08', TRUE),

-- Heart murmur monitoring
(14, 7, 11, '5mg once daily', 60, 5, 3, 'Heart medication - give in morning', '2023-07-10', '2023-09-10', TRUE),

-- Luxating patella
(16, 4, 9, '75mg once daily', 30, 2, 1, 'Give with food', '2023-08-05', '2023-09-05', TRUE),
(16, 30, 9, '500mg once daily', 60, 5, 2, 'Joint supplement', '2023-08-05', '2023-10-05', TRUE),

-- Dermatitis supplements
(19, 5, 9, '1000mg once daily', 60, 5, 3, 'Omega fatty acid supplement', '2023-09-15', '2023-11-15', TRUE),

-- 2024 prescriptions
-- Senior cat arthritis
(23, 30, 9, '250mg once daily', 60, 5, 2, 'Feline joint supplement', '2024-01-25', '2024-03-25', TRUE),
(23, 4, 9, '25mg once daily', 30, 2, 1, 'For arthritis pain - give with food', '2024-01-25', '2024-02-25', TRUE),

-- Dietary indiscretion
(26, 13, 11, '4mg every 8 hours', 10, 0, 0, 'Anti-diarrheal', '2024-03-05', '2024-03-08', TRUE),
(26, 32, 11, '1 packet with each meal', 6, 0, 0, 'Probiotic support', '2024-03-05', '2024-03-08', TRUE),

-- Atopic dermatitis
(31, 1, 7, '5.4mg once daily', 30, 5, 1, 'For skin allergies', '2024-05-05', '2024-06-05', TRUE),
(31, 27, 7, 'Apply twice weekly', 1, 2, 0, 'Medicated shampoo', '2024-05-05', '2024-06-05', TRUE),

-- Post-surgery lipoma
(34, 6, 11, '50mg twice daily', 14, 0, 0, 'Post-operative pain control', '2024-06-15', '2024-06-22', TRUE),
(34, 19, 11, '500mg twice daily', 14, 0, 0, 'Prevent infection', '2024-06-15', '2024-06-22', TRUE),

-- Senior dental
(36, 19, 14, '150mg twice daily', 14, 0, 0, 'Post-dental antibiotics', '2024-07-10', '2024-07-17', TRUE),
(36, 6, 14, '12.5mg twice daily', 14, 0, 0, 'Pain management', '2024-07-10', '2024-07-17', TRUE),

-- Hyperthyroidism
(43, 8, 9, '2.5mg twice daily', 60, 5, 0, 'Thyroid medication - recheck in 4 weeks', '2024-10-18', '2024-11-18', TRUE),

-- Emergency prescriptions
(46, 6, 12, '75mg every 8 hours', 30, 1, 0, 'Pain management post-trauma', '2024-06-20', '2024-06-30', TRUE),
(46, 15, 12, '500mg every 12 hours', 30, 0, 0, 'Broad spectrum antibiotic', '2024-06-20', '2024-07-05', TRUE),
(47, 10, 12, '20mg once daily', 14, 1, 0, 'GI protectant', '2024-08-10', '2024-08-24', TRUE),
(47, 13, 12, '8mg twice daily', 10, 0, 0, 'Anti-nausea', '2024-08-10', '2024-08-15', TRUE),
(48, 33, 13, '1 dose every 6 hours', 6, 0, 0, 'Activated charcoal for toxin', '2024-09-25', '2024-09-26', TRUE)
ON CONFLICT DO NOTHING;
