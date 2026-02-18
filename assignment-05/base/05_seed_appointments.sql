-- =============================================================================
-- MedCare Seed Data - Part 4: Appointments
-- =============================================================================

-- Appointments (2023-2025)
INSERT INTO medcare.appointments (patient_id, doctor_id, scheduled_at, duration_mins, status, visit_type, reason, notes, room_number, created_at) VALUES
-- 2023 Appointments
(1, 2, '2023-01-15 09:00:00', 30, 'completed', 'annual_physical', 'Annual heart checkup', 'Patient reports no chest pain', '301', '2023-01-10 10:00:00'),
(2, 6, '2023-01-20 10:00:00', 30, 'completed', 'new_patient', 'New patient intake', 'Transferred from out of state', '205', '2023-01-15 09:00:00'),
(3, 2, '2023-02-05 14:00:00', 45, 'completed', 'follow_up', 'Blood pressure follow-up', 'BP improved with medication', '301', '2023-01-30 11:00:00'),
(4, 3, '2023-02-10 11:00:00', 30, 'completed', 'new_patient', 'Headaches evaluation', 'Migraines suspected', '401', '2023-02-05 09:00:00'),
(5, 6, '2023-02-15 09:30:00', 30, 'completed', 'follow_up', 'Diabetes management', 'A1C improved', '205', '2023-02-10 10:00:00'),
(6, 5, '2023-03-01 10:00:00', 45, 'completed', 'new_patient', 'Pediatric checkup', 'Well child visit', '104', '2023-02-25 09:00:00'),
(7, 11, '2023-03-10 08:00:00', 30, 'completed', 'urgent', 'Chest pain', 'Ruled out MI', '101', '2023-03-10 07:30:00'),
(8, 4, '2023-03-15 14:30:00', 30, 'completed', 'follow_up', 'Knee injury rehab', 'Physical therapy progressing', '203', '2023-03-10 10:00:00'),
(9, 7, '2023-03-20 11:00:00', 30, 'completed', 'new_patient', 'Skin rash evaluation', 'Eczema diagnosis', '106', '2023-03-15 09:00:00'),
(10, 9, '2023-04-01 10:00:00', 30, 'completed', 'annual_physical', 'Annual psychiatric eval', 'Medication review', '308', '2023-03-25 10:00:00'),

(11, 2, '2023-04-10 09:00:00', 30, 'completed', 'follow_up', 'Post-procedure checkup', 'Stent placement recovery', '301', '2023-04-05 09:00:00'),
(12, 8, '2023-04-15 14:00:00', 60, 'completed', 'procedure', 'Chemotherapy session', 'Cycle 3 of 6', '507', '2023-04-10 10:00:00'),
(13, 3, '2023-04-20 10:30:00', 30, 'completed', 'follow_up', 'Migraine management', 'New medication started', '401', '2023-04-15 09:00:00'),
(14, 10, '2023-05-01 09:00:00', 45, 'completed', 'new_patient', 'Prenatal visit', 'First trimester', '209', '2023-04-25 10:00:00'),
(15, 6, '2023-05-10 11:00:00', 30, 'completed', 'annual_physical', 'Annual physical', 'Routine wellness', '205', '2023-05-05 09:00:00'),
(16, 5, '2023-05-15 10:00:00', 30, 'completed', 'follow_up', 'Vaccination follow-up', 'All vaccines current', '104', '2023-05-10 10:00:00'),
(17, 4, '2023-05-20 14:00:00', 30, 'completed', 'new_patient', 'Back pain evaluation', 'MRI ordered', '203', '2023-05-15 09:00:00'),
(18, 13, '2023-06-01 09:00:00', 30, 'completed', 'new_patient', 'Palpitations', 'Holter monitor ordered', '302', '2023-05-25 10:00:00'),
(19, 6, '2023-06-10 10:30:00', 30, 'completed', 'follow_up', 'Cholesterol recheck', 'Lipid panel improved', '205', '2023-06-05 09:00:00'),
(20, 11, '2023-06-15 15:00:00', 30, 'completed', 'urgent', 'Allergic reaction', 'Epinephrine administered', '101', '2023-06-15 14:30:00'),

-- More 2023 appointments
(21, 2, '2023-07-01 09:00:00', 30, 'completed', 'follow_up', 'Heart failure management', 'Stable on current meds', '301', '2023-06-25 10:00:00'),
(22, 3, '2023-07-10 11:00:00', 30, 'completed', 'new_patient', 'Memory concerns', 'Cognitive testing ordered', '402', '2023-07-05 09:00:00'),
(23, 6, '2023-07-15 10:00:00', 30, 'completed', 'annual_physical', 'Annual wellness', 'All labs normal', '205', '2023-07-10 10:00:00'),
(24, 5, '2023-08-01 09:30:00', 30, 'completed', 'follow_up', 'Asthma check', 'Well controlled', '104', '2023-07-25 09:00:00'),
(25, 4, '2023-08-10 14:00:00', 45, 'completed', 'procedure', 'Cortisone injection', 'Right shoulder', '203', '2023-08-05 10:00:00'),
(26, 9, '2023-08-20 11:00:00', 30, 'completed', 'follow_up', 'Anxiety management', 'CBT referral given', '308', '2023-08-15 09:00:00'),
(27, 7, '2023-09-01 10:00:00', 30, 'completed', 'follow_up', 'Psoriasis treatment', 'Biologic initiated', '106', '2023-08-25 10:00:00'),
(28, 10, '2023-09-10 09:00:00', 30, 'completed', 'follow_up', 'Second trimester visit', 'Normal progress', '209', '2023-09-05 09:00:00'),
(29, 8, '2023-09-15 14:00:00', 60, 'completed', 'procedure', 'Chemotherapy session', 'Cycle 5 of 6', '507', '2023-09-10 10:00:00'),
(30, 6, '2023-10-01 10:00:00', 30, 'completed', 'new_patient', 'Fatigue evaluation', 'Thyroid workup ordered', '205', '2023-09-25 09:00:00'),

-- 2024 Appointments
(1, 2, '2024-01-10 09:00:00', 30, 'completed', 'annual_physical', 'Annual heart checkup', 'Stable cardiac function', '301', '2024-01-05 10:00:00'),
(2, 6, '2024-01-15 10:00:00', 30, 'completed', 'follow_up', 'Diabetes recheck', 'A1C at goal', '205', '2024-01-10 09:00:00'),
(3, 14, '2024-01-20 11:00:00', 30, 'completed', 'follow_up', 'Hypertension check', 'BP well controlled', '302', '2024-01-15 10:00:00'),
(4, 15, '2024-02-01 10:00:00', 30, 'completed', 'follow_up', 'Epilepsy management', 'Seizure-free 6 months', '403', '2024-01-25 09:00:00'),
(5, 21, '2024-02-10 09:00:00', 30, 'completed', 'annual_physical', 'Geriatric assessment', 'Stable overall health', '206', '2024-02-05 10:00:00'),
(6, 19, '2024-02-15 10:30:00', 30, 'completed', 'annual_physical', 'Well child visit', '4-year checkup', '105', '2024-02-10 09:00:00'),
(7, 6, '2024-02-20 11:00:00', 30, 'completed', 'follow_up', 'Post-discharge checkup', 'Recovery good', '205', '2024-02-15 10:00:00'),
(8, 17, '2024-03-01 14:00:00', 45, 'completed', 'procedure', 'Knee arthroscopy follow-up', 'PT prescribed', '204', '2024-02-25 09:00:00'),
(9, 38, '2024-03-10 10:00:00', 30, 'completed', 'follow_up', 'Skin check', 'No new lesions', '107', '2024-03-05 10:00:00'),
(10, 40, '2024-03-15 11:00:00', 45, 'completed', 'follow_up', 'Depression management', 'Improved mood', '309', '2024-03-10 09:00:00'),

(11, 13, '2024-03-20 09:00:00', 30, 'completed', 'follow_up', 'Arrhythmia monitoring', 'Afib controlled', '303', '2024-03-15 10:00:00'),
(12, 39, '2024-04-01 14:00:00', 60, 'completed', 'follow_up', 'Cancer remission check', 'NED confirmed', '508', '2024-03-25 09:00:00'),
(13, 16, '2024-04-10 10:00:00', 30, 'completed', 'follow_up', 'Parkinson''s management', 'Stable symptoms', '404', '2024-04-05 10:00:00'),
(14, 10, '2024-04-15 09:00:00', 30, 'completed', 'follow_up', 'Postpartum visit', '6 weeks post-delivery', '210', '2024-04-10 09:00:00'),
(15, 22, '2024-04-20 11:00:00', 30, 'completed', 'annual_physical', 'Annual geriatric exam', 'Memory stable', '207', '2024-04-15 10:00:00'),
(16, 19, '2024-05-01 10:00:00', 30, 'completed', 'follow_up', 'Growth check', 'Normal development', '105', '2024-04-25 09:00:00'),
(17, 18, '2024-05-10 14:00:00', 45, 'completed', 'follow_up', 'Spine surgery consult', 'Conservative management', '205', '2024-05-05 10:00:00'),
(18, 24, '2024-05-15 09:30:00', 30, 'completed', 'follow_up', 'Heart failure check', 'LVEF improved', '303', '2024-05-10 09:00:00'),
(19, 33, '2024-05-20 10:00:00', 30, 'completed', 'follow_up', 'Annual wellness', 'All vitals normal', '208', '2024-05-15 10:00:00'),
(20, 35, '2024-06-01 08:30:00', 30, 'completed', 'urgent', 'Asthma exacerbation', 'Nebulizer treatment', '102', '2024-06-01 08:00:00'),

-- More 2024 appointments
(21, 2, '2024-06-10 09:00:00', 30, 'completed', 'follow_up', 'Cardiac rehab progress', 'Good exercise tolerance', '301', '2024-06-05 10:00:00'),
(22, 27, '2024-06-15 11:00:00', 30, 'completed', 'follow_up', 'Stroke prevention', 'On anticoagulation', '405', '2024-06-10 09:00:00'),
(23, 6, '2024-06-20 10:00:00', 30, 'completed', 'annual_physical', 'Wellness visit', 'Weight counseling', '205', '2024-06-15 10:00:00'),
(24, 31, '2024-07-01 09:30:00', 30, 'completed', 'new_patient', 'Ear infection', 'Antibiotics prescribed', '106', '2024-06-25 09:00:00'),
(25, 29, '2024-07-10 14:00:00', 30, 'completed', 'follow_up', 'ACL rehab check', 'Cleared for activity', '204', '2024-07-05 10:00:00'),
(26, 40, '2024-07-15 11:00:00', 30, 'completed', 'follow_up', 'PTSD therapy', 'Good progress', '310', '2024-07-10 09:00:00'),
(27, 38, '2024-08-01 10:00:00', 30, 'completed', 'follow_up', 'Acne treatment', 'Clearing nicely', '107', '2024-07-25 10:00:00'),
(28, 41, '2024-08-10 09:00:00', 45, 'completed', 'new_patient', 'Fertility consultation', 'Testing ordered', '211', '2024-08-05 09:00:00'),
(29, 8, '2024-08-15 10:00:00', 30, 'completed', 'follow_up', 'Survivorship visit', 'No recurrence', '509', '2024-08-10 10:00:00'),
(30, 34, '2024-08-20 11:00:00', 30, 'completed', 'follow_up', 'Hypertension check', 'BP at goal', '209', '2024-08-15 09:00:00'),

(31, 6, '2024-09-01 09:00:00', 30, 'completed', 'new_patient', 'Uninsured patient', 'Self-pay wellness', '205', '2024-08-25 10:00:00'),
(32, 6, '2024-09-10 10:00:00', 30, 'completed', 'follow_up', 'Chronic pain management', 'Multimodal approach', '205', '2024-09-05 09:00:00'),
(33, 35, '2024-09-15 14:00:00', 30, 'completed', 'urgent', 'Laceration repair', '4 sutures placed', '103', '2024-09-15 13:30:00'),
(34, 36, '2024-09-20 11:00:00', 30, 'completed', 'urgent', 'Abdominal pain', 'Appendicitis ruled out', '104', '2024-09-20 10:30:00'),
(35, 6, '2024-10-01 10:00:00', 30, 'completed', 'annual_physical', 'Annual wellness', 'All labs normal', '205', '2024-09-25 09:00:00'),
(36, 21, '2024-10-10 09:00:00', 30, 'completed', 'follow_up', 'Osteoporosis management', 'DEXA stable', '206', '2024-10-05 10:00:00'),
(37, 6, '2024-10-15 11:00:00', 30, 'completed', 'follow_up', 'Weight management', 'Lost 10 lbs', '205', '2024-10-10 09:00:00'),
(38, 19, '2024-10-20 10:00:00', 30, 'completed', 'annual_physical', 'School physical', 'Sports clearance', '105', '2024-10-15 10:00:00'),
(39, 2, '2024-11-01 09:00:00', 30, 'completed', 'follow_up', 'Post-angioplasty check', 'Stent patent', '301', '2024-10-25 09:00:00'),
(40, 3, '2024-11-10 11:00:00', 30, 'completed', 'follow_up', 'Multiple sclerosis check', 'Stable on DMT', '406', '2024-11-05 10:00:00'),

-- Cancelled and no-show appointments
(41, 6, '2024-06-25 10:00:00', 30, 'cancelled', 'follow_up', 'Routine checkup', 'Patient called to cancel', '205', '2024-06-20 09:00:00'),
(42, 2, '2024-07-05 09:00:00', 30, 'no_show', 'follow_up', 'Cardiac follow-up', 'Did not appear', '301', '2024-06-30 10:00:00'),
(43, 5, '2024-08-01 10:30:00', 30, 'cancelled', 'follow_up', 'Pediatric checkup', 'Rescheduled', '104', '2024-07-25 09:00:00'),

-- Scheduled/upcoming appointments (2025)
(1, 2, '2025-01-15 09:00:00', 30, 'scheduled', 'annual_physical', 'Annual cardiac assessment', NULL, '301', '2025-01-02 10:00:00'),
(5, 21, '2025-01-20 10:00:00', 30, 'confirmed', 'follow_up', 'Geriatric follow-up', NULL, '206', '2025-01-10 09:00:00'),
(10, 9, '2025-02-01 11:00:00', 30, 'scheduled', 'follow_up', 'Medication review', NULL, '308', '2025-01-15 10:00:00'),
(15, 6, '2025-02-10 09:30:00', 30, 'scheduled', 'annual_physical', 'Annual wellness', NULL, '205', '2025-01-25 09:00:00'),

-- Telehealth appointments
(20, 9, '2024-05-15 14:00:00', 30, 'completed', 'telehealth', 'Anxiety follow-up', 'Virtual visit successful', NULL, '2024-05-10 10:00:00'),
(26, 40, '2024-06-20 11:00:00', 30, 'completed', 'telehealth', 'Therapy session', 'Zoom appointment', NULL, '2024-06-15 09:00:00'),
(30, 6, '2024-07-25 10:00:00', 30, 'completed', 'telehealth', 'Medication refill', 'Quick virtual check', NULL, '2024-07-20 10:00:00')
ON CONFLICT DO NOTHING;
