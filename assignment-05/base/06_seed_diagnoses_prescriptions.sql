-- =============================================================================
-- MedCare Seed Data - Part 5: Diagnoses and Prescriptions
-- =============================================================================

-- Diagnoses (linked to appointments)
INSERT INTO diagnoses (appointment_id, icd_code, description, severity, is_primary, notes) VALUES
-- 2023 Diagnoses
(1, 'I25.10', 'Atherosclerotic heart disease', 'moderate', true, 'Stable angina, well-controlled'),
(2, 'E11.9', 'Type 2 diabetes mellitus without complications', 'mild', true, 'New diagnosis, lifestyle counseling'),
(3, 'I10', 'Essential hypertension', 'moderate', true, 'Improved with medication adjustment'),
(4, 'G43.909', 'Migraine, unspecified', 'moderate', true, 'Triggered by stress and lack of sleep'),
(5, 'E11.65', 'Type 2 diabetes with hyperglycemia', 'mild', true, 'A1C improving'),
(6, 'Z00.129', 'Well child check', 'mild', true, 'Normal development'),
(7, 'R07.9', 'Chest pain, unspecified', 'severe', true, 'Ruled out cardiac etiology'),
(7, 'F41.9', 'Anxiety disorder, unspecified', 'mild', false, 'Likely cause of symptoms'),
(8, 'S83.511A', 'Sprain of ACL of right knee', 'moderate', true, 'PT ongoing'),
(9, 'L30.9', 'Dermatitis, unspecified', 'mild', true, 'Eczema confirmed'),

(10, 'F32.1', 'Major depressive disorder, moderate', 'moderate', true, 'Medication adjustment made'),
(11, 'I25.10', 'Atherosclerotic heart disease', 'moderate', true, 'Post-stent, stable'),
(12, 'C50.919', 'Malignant neoplasm of breast', 'severe', true, 'Continuing chemotherapy'),
(13, 'G43.909', 'Migraine, unspecified', 'moderate', true, 'New preventive medication started'),
(14, 'Z34.00', 'Supervision of normal first pregnancy', 'mild', true, '8 weeks gestation'),
(15, 'Z00.00', 'Annual physical examination', 'mild', true, 'No abnormalities'),
(16, 'Z23', 'Immunization status', 'mild', true, 'Vaccines administered'),
(17, 'M54.5', 'Low back pain', 'moderate', true, 'MRI shows disc herniation'),
(17, 'M51.16', 'Intervertebral disc degeneration, lumbar', 'mild', false, 'Mild changes'),
(18, 'R00.2', 'Palpitations', 'mild', true, 'Holter monitor ordered'),

(19, 'E78.5', 'Hyperlipidemia, unspecified', 'mild', true, 'Lipids improved with statin'),
(20, 'T78.40XA', 'Allergy, unspecified', 'severe', true, 'Anaphylaxis to bee sting'),
(21, 'I50.9', 'Heart failure, unspecified', 'moderate', true, 'EF stable at 45%'),
(22, 'F03.90', 'Unspecified dementia without behavioral disturbance', 'mild', true, 'Early cognitive changes'),
(23, 'Z00.00', 'Annual physical examination', 'mild', true, 'Routine wellness'),
(24, 'J45.20', 'Mild intermittent asthma', 'mild', true, 'Rescue inhaler only'),
(25, 'M75.101', 'Rotator cuff tear, right shoulder', 'moderate', true, 'Cortisone injection given'),
(26, 'F41.1', 'Generalized anxiety disorder', 'moderate', true, 'CBT referral given'),
(27, 'L40.0', 'Psoriasis vulgaris', 'moderate', true, 'Starting biologic therapy'),
(28, 'Z34.02', 'Supervision of normal pregnancy, second trimester', 'mild', true, '24 weeks, normal progress'),

(29, 'C50.919', 'Malignant neoplasm of breast', 'severe', true, 'Cycle 5 completed'),
(30, 'R53.83', 'Other fatigue', 'mild', true, 'Thyroid panel pending'),

-- 2024 Diagnoses
(31, 'I25.10', 'Atherosclerotic heart disease', 'moderate', true, 'Annual assessment stable'),
(32, 'E11.9', 'Type 2 diabetes mellitus', 'mild', true, 'A1C at 6.8%'),
(33, 'I10', 'Essential hypertension', 'mild', true, 'Well controlled'),
(34, 'G40.909', 'Epilepsy, unspecified', 'mild', true, 'Seizure-free on medication'),
(35, 'R41.81', 'Age-related cognitive decline', 'mild', true, 'Geriatric assessment normal'),
(36, 'Z00.129', 'Well child check', 'mild', true, '4-year wellness visit'),
(37, 'I25.10', 'Atherosclerotic heart disease', 'moderate', true, 'Post-hospitalization stable'),
(38, 'M17.11', 'Primary osteoarthritis, right knee', 'moderate', true, 'Post-arthroscopy improving'),
(39, 'L30.9', 'Dermatitis', 'mild', true, 'Controlled with treatment'),
(40, 'F33.1', 'Major depressive disorder, recurrent, moderate', 'moderate', true, 'Mood improving'),

(41, 'I48.0', 'Paroxysmal atrial fibrillation', 'moderate', true, 'Rate controlled'),
(42, 'C50.919', 'Malignant neoplasm of breast, in remission', 'moderate', true, 'NED on imaging'),
(43, 'G20', 'Parkinson''s disease', 'moderate', true, 'Stable on current regimen'),
(44, 'Z39.2', 'Postpartum care', 'mild', true, 'Normal postpartum recovery'),
(45, 'R41.81', 'Age-related cognitive decline', 'mild', true, 'Memory stable'),
(46, 'Z00.129', 'Well child check', 'mild', true, 'Normal growth'),
(47, 'M54.5', 'Low back pain', 'moderate', true, 'Conservative management'),
(48, 'I50.9', 'Heart failure', 'mild', true, 'EF improved to 50%'),
(49, 'Z00.00', 'Annual physical examination', 'mild', true, 'All normal'),
(50, 'J45.31', 'Mild persistent asthma with acute exacerbation', 'moderate', true, 'Treated in urgent care'),

(51, 'I25.10', 'Atherosclerotic heart disease', 'moderate', true, 'Cardiac rehab progressing'),
(52, 'I63.9', 'Cerebral infarction, unspecified', 'moderate', true, 'Previous stroke, on prevention'),
(53, 'Z00.00', 'Annual physical examination', 'mild', true, 'Wellness visit'),
(53, 'E66.9', 'Obesity, unspecified', 'mild', false, 'Weight management discussed'),
(54, 'H66.90', 'Otitis media, unspecified', 'mild', true, 'Acute ear infection'),
(55, 'S83.511A', 'ACL sprain, right knee', 'mild', true, 'Cleared for return to sports'),
(56, 'F43.10', 'Post-traumatic stress disorder', 'moderate', true, 'PTSD therapy progressing'),
(57, 'L70.0', 'Acne vulgaris', 'mild', true, 'Responding to treatment'),
(58, 'N97.9', 'Female infertility, unspecified', 'mild', true, 'Workup initiated'),
(59, 'Z08', 'Cancer survivorship', 'mild', true, 'No evidence of disease'),

(60, 'I10', 'Essential hypertension', 'mild', true, 'At goal'),
(61, 'E11.9', 'Type 2 diabetes mellitus', 'mild', true, 'Self-pay patient'),
(62, 'G89.29', 'Other chronic pain', 'moderate', true, 'Pain management plan'),
(63, 'S61.401A', 'Laceration without FB, right hand', 'mild', true, 'Sutured'),
(64, 'R10.9', 'Abdominal pain, unspecified', 'moderate', true, 'Appendicitis ruled out'),
(65, 'Z00.00', 'Annual physical examination', 'mild', true, 'Routine wellness'),
(66, 'M81.0', 'Osteoporosis without fracture', 'mild', true, 'DEXA stable'),
(67, 'E66.9', 'Obesity', 'mild', true, 'Weight loss success'),
(68, 'Z02.5', 'Sports physical examination', 'mild', true, 'Cleared for all sports'),
(69, 'I25.10', 'Atherosclerotic heart disease', 'moderate', true, 'Stent patent'),
(70, 'G35', 'Multiple sclerosis', 'moderate', true, 'Stable on DMT')
ON CONFLICT DO NOTHING;

-- Prescriptions (linked to diagnoses, with patient and doctor from appointment)
-- Schema: diagnosis_id, patient_id, doctor_id, medication_id, dosage, frequency, duration_days, quantity, refills_allowed, refills_remaining, instructions, prescribed_at, is_active
INSERT INTO prescriptions (diagnosis_id, patient_id, doctor_id, medication_id, dosage, frequency, duration_days, quantity, refills_allowed, refills_remaining, instructions, prescribed_at, is_active) VALUES
-- Cardiac medications (Patient 1, Dr 1)
(1, 1, 1, 1, '325mg', 'once daily', 365, 90, 3, 3, 'Take with food', '2023-01-15 09:30:00', true),
(1, 1, 1, 2, '20mg', 'once daily', 365, 90, 3, 3, 'Take in evening', '2023-01-15 09:30:00', true),
(1, 1, 1, 3, '25mg', 'once daily', 365, 90, 3, 3, 'Do not stop abruptly', '2023-01-15 09:30:00', true),

-- Diabetes medications (Patient 2, Dr 2)
(2, 2, 2, 6, '500mg', 'twice daily', 365, 60, 5, 5, 'Take with meals', '2023-01-20 10:30:00', true),

-- Hypertension (Patient 3, Dr 3)
(3, 3, 3, 4, '5mg', 'once daily', 365, 90, 3, 3, 'Monitor blood pressure', '2023-02-05 14:30:00', true),

-- Migraine (Patient 4, Dr 4)
(4, 4, 4, 10, '50mg', 'as needed', 30, 9, 2, 2, 'Take at onset of migraine', '2023-02-10 11:30:00', true),

-- Eczema (Patient 9, Dr 9)
(9, 9, 9, 23, 'thin layer', 'twice daily', 14, 1, 1, 0, 'Apply to affected areas', '2023-03-20 11:30:00', false),

-- Depression (Patient 10, Dr 10)
(10, 10, 10, 12, '50mg', 'once daily', 365, 90, 3, 3, 'Take in morning', '2023-04-01 10:30:00', true),

-- Anxiety (Patient 8, Dr 8)
(8, 8, 8, 13, '0.5mg', 'as needed', 30, 15, 0, 0, 'Use sparingly for acute anxiety', '2023-03-10 08:30:00', false),

-- Heart failure (Patient 21, Dr 1)
(21, 21, 1, 5, '40mg', 'once daily', 365, 90, 3, 3, 'Monitor potassium', '2023-07-01 09:30:00', true),

-- Allergic reaction (Patient 20, Dr 20)
(20, 20, 20, 20, '50mg', 'as needed', 7, 7, 0, 0, 'For allergic symptoms', '2023-06-15 15:30:00', false),

-- Pain management (Patient 17, Dr 17)
(17, 17, 17, 17, '500mg', 'every 6 hours', 10, 40, 0, 0, 'Take with food', '2023-05-20 14:30:00', false),

-- Asthma (Patient 24, Dr 24)
(24, 24, 24, 19, '90mcg', 'as needed', 365, 1, 2, 2, '2 puffs as needed for wheezing', '2023-08-01 09:45:00', true),

-- Psoriasis (Patient 27, Dr 27)
(27, 27, 27, 22, '10mg', 'weekly', 365, 4, 11, 11, 'Refrigerate, inject weekly', '2023-09-01 10:30:00', true),

-- 2024 prescriptions
(31, 1, 1, 1, '81mg', 'once daily', 365, 90, 3, 3, 'Low-dose aspirin', '2024-01-10 09:30:00', true),
(32, 2, 2, 6, '1000mg', 'twice daily', 365, 60, 5, 5, 'Dose increased', '2024-01-15 10:30:00', true),
(34, 34, 4, 30, '500mg', 'twice daily', 365, 60, 5, 5, 'Anti-seizure medication', '2024-02-01 10:30:00', true),
(40, 10, 10, 12, '100mg', 'once daily', 365, 90, 3, 3, 'Dose increased', '2024-03-15 11:30:00', true),
(41, 41, 1, 26, '5mg', 'once daily', 365, 90, 3, 3, 'Anticoagulant for afib', '2024-03-20 09:30:00', true),
(43, 43, 4, 31, '100/25mg', 'three times daily', 365, 270, 3, 3, 'Parkinson treatment', '2024-04-10 10:30:00', true),
(47, 17, 17, 18, '500mg', 'twice daily', 10, 20, 0, 0, 'Muscle relaxant', '2024-05-10 14:30:00', false),
(48, 21, 1, 5, '20mg', 'once daily', 365, 90, 3, 3, 'Heart failure management', '2024-05-15 10:00:00', true)
ON CONFLICT DO NOTHING;
