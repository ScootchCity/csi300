-- =============================================================================
-- PawCare Seed Data - Part 5: Appointments and Medical Records
-- =============================================================================

-- Appointments (2023-2025)
INSERT INTO appointments (pet_id, vet_id, clinic_id, scheduled_at, duration_mins, status, visit_type, reason, created_at) VALUES
-- 2023 Appointments
(1, 7, 1, '2023-01-15 09:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-01-10 10:00:00'),
(2, 7, 1, '2023-01-15 09:30:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-01-10 10:30:00'),
(3, 9, 2, '2023-02-10 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-02-05 09:00:00'),
(4, 9, 2, '2023-02-10 10:30:00', 30, 'completed', 'sick', 'Vomiting', '2023-02-09 14:00:00'),
(5, 9, 2, '2023-02-10 11:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-02-05 09:30:00'),
(6, 7, 1, '2023-03-05 14:00:00', 45, 'completed', 'sick', 'Breathing issues', '2023-03-04 11:00:00'),
(7, 7, 1, '2023-03-20 09:00:00', 30, 'completed', 'wellness', 'Vaccination', '2023-03-15 10:00:00'),
(8, 11, 3, '2023-04-12 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-04-08 09:00:00'),
(9, 11, 3, '2023-04-25 11:00:00', 30, 'completed', 'vaccination', 'Rabies shot', '2023-04-20 14:00:00'),
(10, 7, 1, '2023-05-08 09:30:00', 30, 'completed', 'sick', 'Ear infection', '2023-05-07 16:00:00'),

(11, 7, 1, '2023-05-15 10:00:00', 30, 'completed', 'wellness', 'Checkup', '2023-05-10 09:00:00'),
(12, 9, 2, '2023-06-01 09:00:00', 30, 'completed', 'dental', 'Dental cleaning', '2023-05-25 10:00:00'),
(13, 9, 2, '2023-06-15 14:00:00', 30, 'completed', 'follow_up', 'Post-dental check', '2023-06-01 14:30:00'),
(14, 11, 3, '2023-07-10 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-07-05 09:00:00'),
(15, 7, 1, '2023-07-22 09:00:00', 30, 'completed', 'vaccination', 'FVRCP booster', '2023-07-18 10:00:00'),
(16, 9, 2, '2023-08-05 11:00:00', 30, 'completed', 'sick', 'Limping', '2023-08-04 15:00:00'),
(17, 14, 5, '2023-08-18 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-08-14 09:00:00'),
(18, 7, 1, '2023-09-02 09:30:00', 30, 'completed', 'grooming', 'Full groom', '2023-08-28 10:00:00'),
(19, 9, 2, '2023-09-15 14:00:00', 30, 'completed', 'wellness', 'New patient exam', '2023-09-12 11:00:00'),
(20, 11, 3, '2023-10-01 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2023-09-26 09:00:00'),

-- 2024 Appointments
(1, 7, 1, '2024-01-10 09:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-01-05 10:00:00'),
(2, 7, 1, '2024-01-10 09:30:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-01-05 10:30:00'),
(3, 9, 2, '2024-01-25 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-01-20 09:00:00'),
(6, 7, 1, '2024-02-05 14:00:00', 30, 'completed', 'follow_up', 'Breathing check', '2024-02-01 10:00:00'),
(8, 11, 3, '2024-02-20 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-02-15 09:00:00'),
(9, 11, 3, '2024-03-05 11:00:00', 30, 'completed', 'sick', 'Diarrhea', '2024-03-04 16:00:00'),
(21, 7, 1, '2024-03-15 09:00:00', 30, 'completed', 'wellness', 'New patient exam', '2024-03-10 10:00:00'),
(22, 9, 2, '2024-03-28 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-03-23 09:00:00'),
(23, 11, 3, '2024-04-10 14:00:00', 30, 'completed', 'vaccination', 'Puppy shots', '2024-04-05 10:00:00'),
(24, 14, 5, '2024-04-22 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-04-18 09:00:00'),

(25, 7, 1, '2024-05-05 09:30:00', 30, 'completed', 'sick', 'Skin issues', '2024-05-04 11:00:00'),
(26, 9, 2, '2024-05-18 11:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-05-14 09:00:00'),
(27, 7, 1, '2024-06-01 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-05-27 10:00:00'),
(28, 11, 3, '2024-06-15 14:00:00', 45, 'completed', 'surgery', 'Mass removal', '2024-06-08 09:00:00'),
(29, 9, 2, '2024-06-28 09:00:00', 30, 'completed', 'wellness', 'New patient exam', '2024-06-24 10:00:00'),
(30, 14, 5, '2024-07-10 10:00:00', 30, 'completed', 'dental', 'Dental cleaning', '2024-07-05 09:00:00'),
(31, 7, 1, '2024-07-22 09:30:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-07-18 10:00:00'),
(32, 9, 2, '2024-08-05 11:00:00', 30, 'completed', 'wellness', 'Kitten checkup', '2024-08-01 09:00:00'),
(33, 11, 3, '2024-08-18 10:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-08-14 10:00:00'),
(34, 7, 1, '2024-09-01 14:00:00', 30, 'completed', 'wellness', 'Annual checkup', '2024-08-28 09:00:00'),

(35, 11, 3, '2024-09-15 10:00:00', 45, 'completed', 'wellness', 'Large breed checkup', '2024-09-10 09:00:00'),
(1, 7, 1, '2024-10-05 09:00:00', 30, 'completed', 'vaccination', 'DHPP booster', '2024-10-01 10:00:00'),
(3, 9, 2, '2024-10-18 10:00:00', 30, 'completed', 'sick', 'Weight loss', '2024-10-17 11:00:00'),
(6, 7, 1, '2024-11-02 14:00:00', 30, 'completed', 'wellness', 'Checkup', '2024-10-28 09:00:00'),
(8, 11, 3, '2024-11-15 10:00:00', 30, 'completed', 'vaccination', 'RHDV2', '2024-11-11 09:00:00'),

-- Emergency appointments
(1, 12, 4, '2024-06-20 22:00:00', 60, 'completed', 'emergency', 'Hit by car', '2024-06-20 21:30:00'),
(9, 12, 4, '2024-08-10 03:00:00', 45, 'completed', 'emergency', 'Bloat symptoms', '2024-08-10 02:30:00'),
(28, 13, 4, '2024-09-25 19:00:00', 60, 'completed', 'emergency', 'Toxin ingestion', '2024-09-25 18:30:00'),

-- Upcoming/scheduled appointments (2025)
(2, 7, 1, '2025-01-15 09:00:00', 30, 'scheduled', 'wellness', 'Annual checkup', '2025-01-02 10:00:00'),
(4, 9, 2, '2025-01-18 10:00:00', 30, 'confirmed', 'wellness', 'Senior checkup', '2025-01-10 09:00:00'),
(10, 7, 1, '2025-01-22 11:00:00', 30, 'scheduled', 'vaccination', 'FVRCP booster', '2025-01-15 10:00:00'),
(21, 7, 1, '2025-02-01 09:30:00', 30, 'scheduled', 'wellness', 'Annual checkup', '2025-01-20 09:00:00'),
(23, 11, 3, '2025-02-10 14:00:00', 30, 'scheduled', 'vaccination', 'Rabies', '2025-02-01 10:00:00'),

-- Cancelled/no-show
(15, 7, 1, '2024-04-05 09:00:00', 30, 'cancelled', 'wellness', 'Annual checkup', '2024-03-28 10:00:00'),
(19, 9, 2, '2024-07-15 10:00:00', 30, 'no_show', 'follow_up', 'Recheck', '2024-07-10 09:00:00'),

-- Multi-clinic pets (Task 3.3: pets that visit both Burlington Downtown and Williston)
(1, 7, 3, '2024-03-15 14:00:00', 30, 'completed', 'wellness', 'Visit to Williston branch', '2024-03-10 10:00:00'),
(6, 11, 3, '2024-04-20 10:00:00', 30, 'completed', 'wellness', 'Consultation at Williston', '2024-04-15 09:00:00')
ON CONFLICT DO NOTHING;

-- Medical Records
INSERT INTO medical_records (pet_id, vet_id, appointment_id, visit_date, chief_complaint, diagnosis, notes, weight_kg, temperature_f, heart_rate, respiratory_rate, follow_up_date, created_at) VALUES
-- 2023 Records
(1, 7, 1, '2023-01-15', 'Annual wellness exam', 'Healthy', 'All vitals normal. Continue current diet.', 32.0, 101.5, 80, 18, '2024-01-15', '2023-01-15 09:30:00'),
(2, 7, 2, '2023-01-15', 'Annual wellness exam', 'Healthy', 'Slight tartar buildup, recommend dental cleaning.', 27.5, 101.3, 85, 20, '2024-01-15', '2023-01-15 10:00:00'),
(3, 9, 3, '2023-02-10', 'Annual wellness exam', 'Healthy - Early dental disease', 'Grade 1 dental disease. Schedule cleaning.', 6.8, 101.0, 140, 24, '2023-08-10', '2023-02-10 10:30:00'),
(4, 9, 4, '2023-02-10', 'Vomiting x2 days', 'Gastritis', 'Likely dietary indiscretion. Bland diet x 3 days.', 4.5, 102.1, 160, 28, '2023-02-17', '2023-02-10 11:00:00'),
(5, 9, 5, '2023-02-10', 'Annual wellness exam', 'Healthy', 'No concerns. Long coat well maintained.', 4.0, 101.2, 145, 25, '2024-02-10', '2023-02-10 11:30:00'),
(6, 7, 6, '2023-03-05', 'Difficulty breathing', 'Brachycephalic airway syndrome - mild', 'Stenotic nares noted. Weight management important.', 12.5, 102.5, 110, 35, '2023-04-05', '2023-03-05 14:45:00'),
(7, 7, 7, '2023-03-20', 'Vaccination visit', 'Healthy', 'Vaccines administered. No adverse reactions.', 5.5, 101.1, 150, 22, '2024-03-20', '2023-03-20 09:30:00'),
(8, 11, 8, '2023-04-12', 'Annual wellness exam', 'Healthy', 'Rabbit in good condition. Teeth normal.', 2.0, 102.5, 220, 40, '2024-04-12', '2023-04-12 10:30:00'),
(9, 11, 9, '2023-04-25', 'Rabies vaccination', 'Healthy', 'Vaccine administered without incident.', 30.0, 101.8, 90, 20, '2024-04-25', '2023-04-25 11:30:00'),
(10, 7, 10, '2023-05-08', 'Ear scratching', 'Otitis externa - bacterial', 'Ear cytology positive for cocci. Start ear drops.', 5.8, 101.5, 155, 24, '2023-05-22', '2023-05-08 10:00:00'),

-- More 2023 records
(11, 7, 11, '2023-05-15', 'Wellness checkup', 'Healthy - mild allergies', 'Seasonal allergies. Apoquel as needed.', 24.0, 101.6, 95, 22, '2023-11-15', '2023-05-15 10:30:00'),
(12, 9, 12, '2023-06-01', 'Dental cleaning', 'Periodontal disease Grade 2', 'Dental completed. 2 extractions required.', 4.0, 101.0, 145, 22, '2023-06-15', '2023-06-01 09:30:00'),
(13, 9, 13, '2023-06-15', 'Post-dental recheck', 'Healing well', 'Extraction sites healing normally.', 4.0, 101.2, 140, 24, NULL, '2023-06-15 14:30:00'),
(14, 11, 14, '2023-07-10', 'Annual wellness', 'Healthy - heart murmur Grade 2', 'New murmur detected. Echocardiogram recommended.', 7.5, 101.5, 120, 25, '2023-08-10', '2023-07-10 10:30:00'),
(15, 7, 15, '2023-07-22', 'FVRCP booster', 'Healthy', 'Vaccine administered.', 5.0, 101.1, 150, 22, '2024-07-22', '2023-07-22 09:30:00'),
(16, 9, 16, '2023-08-05', 'Right rear limping', 'Luxating patella Grade 2', 'Conservative management first. NSAIDs prescribed.', 9.5, 101.4, 100, 20, '2023-09-05', '2023-08-05 11:30:00'),
(17, 14, 17, '2023-08-18', 'Annual wellness - rabbit', 'Healthy', 'Good body condition. Teeth normal.', 1.8, 102.0, 210, 38, '2024-08-18', '2023-08-18 10:30:00'),
(18, 7, 18, '2023-09-02', 'Grooming visit', 'Healthy', 'Full groom completed. Nails trimmed.', 13.0, 101.3, 95, 18, NULL, '2023-09-02 10:00:00'),
(19, 9, 19, '2023-09-15', 'New patient exam', 'Healthy - dermatitis noted', 'Mild skin dryness. Omega supplements recommended.', 4.5, 101.4, 145, 24, '2024-03-15', '2023-09-15 14:30:00'),
(20, 11, 20, '2023-10-01', 'Annual wellness', 'Healthy', 'Very athletic dog. No concerns.', 25.0, 101.2, 75, 16, '2024-10-01', '2023-10-01 10:30:00'),

-- 2024 Records
(1, 7, 21, '2024-01-10', 'Annual wellness exam', 'Healthy', 'Weight stable. Continue current management.', 32.5, 101.4, 78, 18, '2025-01-10', '2024-01-10 09:30:00'),
(2, 7, 22, '2024-01-10', 'Annual wellness exam', 'Healthy', 'Dental much improved. Good home care.', 28.0, 101.2, 82, 19, '2025-01-10', '2024-01-10 10:00:00'),
(3, 9, 23, '2024-01-25', 'Annual wellness - senior', 'Healthy - arthritis', 'Mild hip arthritis noted. Joint supplement started.', 6.5, 101.1, 142, 24, '2024-07-25', '2024-01-25 10:30:00'),
(6, 7, 24, '2024-02-05', 'Breathing recheck', 'Stable', 'No progression. Weight management successful.', 11.8, 101.8, 105, 28, '2024-08-05', '2024-02-05 14:30:00'),
(8, 11, 25, '2024-02-20', 'Annual wellness - rabbit', 'Healthy', 'All normal. Diet appropriate.', 2.1, 102.2, 215, 42, '2025-02-20', '2024-02-20 10:30:00'),
(9, 11, 26, '2024-03-05', 'Diarrhea x 1 day', 'Dietary indiscretion', 'Got into garbage. Supportive care.', 29.5, 102.0, 92, 22, '2024-03-12', '2024-03-05 11:30:00'),
(21, 7, 27, '2024-03-15', 'New patient exam', 'Healthy', 'Beautiful coat. Very vocal breed.', 27.0, 101.6, 88, 22, '2024-09-15', '2024-03-15 09:30:00'),
(22, 9, 28, '2024-03-28', 'Annual wellness', 'Healthy', 'Long coat in excellent condition.', 8.0, 101.0, 138, 22, '2025-03-28', '2024-03-28 10:30:00'),
(23, 11, 29, '2024-04-10', 'Puppy vaccination', 'Healthy puppy', 'Second round vaccines. Growing well.', 16.0, 101.8, 95, 24, '2024-05-10', '2024-04-10 14:30:00'),
(24, 14, 30, '2024-04-22', 'Annual wellness', 'Healthy', 'Gentle temperament. No concerns.', 4.5, 101.2, 148, 22, '2025-04-22', '2024-04-22 10:30:00'),

-- More 2024 records
(25, 7, 31, '2024-05-05', 'Itchy skin', 'Atopic dermatitis', 'Positive for environmental allergies. Apoquel started.', 7.0, 101.5, 110, 22, '2024-06-05', '2024-05-05 10:00:00'),
(26, 9, 32, '2024-05-18', 'Annual wellness', 'Healthy', 'Luxating patella stable. Weight good.', 3.5, 101.3, 155, 24, '2025-05-18', '2024-05-18 11:30:00'),
(27, 7, 33, '2024-06-01', 'Annual wellness', 'Healthy - overweight', 'BCS 7/9. Diet plan discussed.', 6.0, 101.4, 140, 22, '2024-09-01', '2024-06-01 10:30:00'),
(28, 11, 34, '2024-06-15', 'Mass on left shoulder', 'Lipoma', 'Benign fatty mass removed. Histopath confirmed.', 44.5, 101.6, 85, 18, '2024-06-29', '2024-06-15 15:00:00'),
(29, 9, 35, '2024-06-28', 'New patient exam', 'Healthy', 'F4 Savannah. Very active and healthy.', 8.5, 101.2, 135, 22, '2024-12-28', '2024-06-28 09:30:00'),
(30, 14, 36, '2024-07-10', 'Dental cleaning', 'Severe periodontal disease', '6 extractions required. Senior dog doing well.', 2.5, 101.8, 120, 25, '2024-07-24', '2024-07-10 10:30:00'),
(31, 7, 37, '2024-07-22', 'Annual wellness', 'Healthy', 'Rescue doing great. Well-adjusted.', 28.0, 101.4, 88, 20, '2025-07-22', '2024-07-22 10:00:00'),
(32, 9, 38, '2024-08-05', 'Kitten checkup', 'Healthy kitten', 'Growing well. Vaccines current.', 3.8, 101.5, 165, 28, '2024-11-05', '2024-08-05 11:30:00'),
(33, 11, 39, '2024-08-18', 'Annual wellness', 'Healthy', 'Retired racer in excellent condition.', 32.0, 101.0, 70, 14, '2025-08-18', '2024-08-18 10:30:00'),
(34, 7, 40, '2024-09-01', 'Annual wellness', 'Healthy', 'Unique coat, skin healthy.', 3.5, 101.3, 160, 26, '2025-09-01', '2024-09-01 14:30:00'),

(35, 11, 41, '2024-09-15', 'Large breed checkup', 'Healthy - orthopedic screening', 'No hip dysplasia signs. Growing appropriately.', 62.0, 101.5, 75, 16, '2025-03-15', '2024-09-15 11:00:00'),
(1, 7, 42, '2024-10-05', 'DHPP booster', 'Healthy', 'Vaccine administered. No reactions.', 32.5, 101.3, 80, 18, '2025-10-05', '2024-10-05 09:30:00'),
(3, 9, 43, '2024-10-18', 'Weight loss concern', 'Hyperthyroidism', 'T4 elevated. Methimazole started.', 5.8, 101.5, 180, 32, '2024-11-18', '2024-10-18 10:30:00'),
(6, 7, 44, '2024-11-02', 'Wellness checkup', 'Stable', 'Breathing unchanged. Continue management.', 11.5, 101.7, 108, 30, '2025-05-02', '2024-11-02 14:30:00'),
(8, 11, 45, '2024-11-15', 'RHDV2 vaccination', 'Healthy', 'Vaccine administered.', 2.0, 102.0, 218, 40, '2025-11-15', '2024-11-15 10:30:00'),

-- Emergency records
(1, 12, 46, '2024-06-20', 'Hit by car - emergency', 'Pelvic fracture, soft tissue trauma', 'Stabilized. Surgery recommended. Referral to ortho.', 32.0, 102.5, 140, 35, '2024-06-27', '2024-06-20 23:00:00'),
(9, 12, 47, '2024-08-10', 'Bloat symptoms', 'Gastric dilatation - no volvulus', 'Decompressed via tube. No surgery needed.', 30.5, 103.0, 150, 40, '2024-08-12', '2024-08-10 04:00:00'),
(28, 13, 48, '2024-09-25', 'Chocolate ingestion', 'Theobromine toxicity - mild', 'Induced vomiting. Activated charcoal. Monitoring.', 45.0, 102.2, 120, 28, '2024-09-26', '2024-09-25 20:00:00')
ON CONFLICT DO NOTHING;

-- Medical records for multi-clinic appointments (Task 3.3)
INSERT INTO medical_records (pet_id, vet_id, appointment_id, visit_date, chief_complaint, diagnosis, notes, weight_kg, temperature_f, heart_rate, respiratory_rate, follow_up_date, created_at)
SELECT 1, 7, a.appointment_id, '2024-03-15', 'Wellness at Williston branch', 'Healthy', 'Routine check at Williston location.', 32.0, 101.4, 80, 18, NULL, '2024-03-15 14:30:00'
FROM appointments a WHERE a.pet_id = 1 AND a.clinic_id = 3 AND a.scheduled_at = '2024-03-15 14:00:00';
INSERT INTO medical_records (pet_id, vet_id, appointment_id, visit_date, chief_complaint, diagnosis, notes, weight_kg, temperature_f, heart_rate, respiratory_rate, follow_up_date, created_at)
SELECT 6, 11, a.appointment_id, '2024-04-20', 'Consultation at Williston', 'Stable', 'Breathing recheck at Williston branch.', 11.5, 101.6, 108, 28, NULL, '2024-04-20 10:30:00'
FROM appointments a WHERE a.pet_id = 6 AND a.clinic_id = 3 AND a.scheduled_at = '2024-04-20 10:00:00';
