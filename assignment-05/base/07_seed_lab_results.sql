-- =============================================================================
-- MedCare Seed Data - Part 6: Lab Results
-- =============================================================================

-- Lab Results (linked to patients, tests, and ordering doctors)
-- Schema: patient_id, test_id, doctor_id, appointment_id, ordered_at, collected_at, resulted_at, result_value, is_abnormal, status, notes
INSERT INTO medcare.lab_results (patient_id, test_id, doctor_id, appointment_id, ordered_at, collected_at, resulted_at, result_value, is_abnormal, status, notes) VALUES
-- Complete Blood Count results
(1, 1, 2, 1, '2023-01-15 09:30:00', '2023-01-15 10:00:00', '2023-01-15 14:00:00', '14.2 g/dL', false, 'completed', 'Normal hemoglobin'),
(2, 1, 6, 2, '2023-01-20 10:30:00', '2023-01-20 11:00:00', '2023-01-20 15:00:00', '11.8 g/dL', true, 'completed', 'Mild anemia'),
(3, 1, 2, 3, '2023-02-05 14:30:00', '2023-02-05 15:00:00', '2023-02-05 18:00:00', '15.1 g/dL', false, 'completed', NULL),
(5, 1, 6, 5, '2023-02-15 10:00:00', '2023-02-15 10:30:00', '2023-02-15 14:00:00', '13.5 g/dL', false, 'completed', NULL),

-- Basic Metabolic Panel results
(1, 2, 2, 1, '2023-01-15 09:30:00', '2023-01-15 10:00:00', '2023-01-15 14:00:00', 'See panel', false, 'completed', 'All values within normal limits'),
(2, 2, 6, 2, '2023-01-20 10:30:00', '2023-01-20 11:00:00', '2023-01-20 15:00:00', 'See panel', true, 'completed', 'Glucose elevated at 165 mg/dL'),
(5, 2, 6, 5, '2023-02-15 10:00:00', '2023-02-15 10:30:00', '2023-02-15 14:00:00', 'See panel', false, 'completed', 'Glucose improved'),

-- Lipid Panel results
(1, 3, 2, 1, '2023-01-15 09:30:00', '2023-01-15 10:00:00', '2023-01-15 14:00:00', 'Total: 195 mg/dL', false, 'completed', 'LDL 110, HDL 55, TG 150'),
(3, 3, 2, 3, '2023-02-05 14:30:00', '2023-02-05 15:00:00', '2023-02-05 18:00:00', 'Total: 185 mg/dL', false, 'completed', 'Improved with statin'),
(19, 3, 6, 19, '2023-06-10 11:00:00', '2023-06-10 11:30:00', '2023-06-10 15:00:00', 'Total: 175 mg/dL', false, 'completed', 'Good cholesterol control'),

-- HbA1c results
(2, 4, 6, 2, '2023-01-20 10:30:00', '2023-01-20 11:00:00', '2023-01-20 15:00:00', '8.2%', true, 'completed', 'Uncontrolled at diagnosis'),
(5, 4, 6, 5, '2023-02-15 10:00:00', '2023-02-15 10:30:00', '2023-02-15 14:00:00', '7.5%', true, 'completed', 'Improving'),
(5, 4, 21, 35, '2024-02-10 09:30:00', '2024-02-10 10:00:00', '2024-02-10 14:00:00', '6.8%', false, 'completed', 'At goal'),

-- Thyroid Panel
(30, 5, 6, 30, '2023-10-01 10:30:00', '2023-10-01 11:00:00', '2023-10-01 15:00:00', 'TSH: 2.5 mIU/L', false, 'completed', 'Normal thyroid function'),
(15, 5, 6, 45, '2024-04-20 11:30:00', '2024-04-20 12:00:00', '2024-04-20 16:00:00', 'TSH: 1.8 mIU/L', false, 'completed', 'Normal'),

-- Liver Function Tests
(12, 6, 8, 12, '2023-04-15 14:30:00', '2023-04-15 15:00:00', '2023-04-15 18:00:00', 'ALT: 45 U/L', false, 'completed', 'Pre-chemo baseline'),
(29, 6, 8, 29, '2023-09-15 14:30:00', '2023-09-15 15:00:00', '2023-09-15 18:00:00', 'ALT: 52 U/L', false, 'completed', 'Slight elevation, monitoring'),

-- Urinalysis
(3, 7, 2, 3, '2023-02-05 14:30:00', '2023-02-05 15:00:00', '2023-02-05 16:00:00', 'Normal', false, 'completed', 'No protein or glucose'),
(14, 7, 10, 14, '2023-05-01 09:30:00', '2023-05-01 10:00:00', '2023-05-01 11:00:00', 'Normal', false, 'completed', 'Prenatal screening normal'),
(28, 7, 10, 28, '2023-09-10 09:30:00', '2023-09-10 10:00:00', '2023-09-10 11:00:00', 'Trace protein', true, 'completed', 'Repeat in 2 weeks'),

-- PSA
(21, 10, 2, 21, '2023-07-01 09:30:00', '2023-07-01 10:00:00', '2023-07-01 14:00:00', '2.1 ng/mL', false, 'completed', 'Normal PSA'),

-- Vitamin D
(22, 11, 3, 22, '2023-07-10 11:30:00', '2023-07-10 12:00:00', '2023-07-10 16:00:00', '22 ng/mL', true, 'completed', 'Vitamin D insufficiency'),
(36, 11, 21, 66, '2024-10-10 09:30:00', '2024-10-10 10:00:00', '2024-10-10 14:00:00', '35 ng/mL', false, 'completed', 'Normal after supplementation'),

-- B12
(22, 12, 3, 22, '2023-07-10 11:30:00', '2023-07-10 12:00:00', '2023-07-10 16:00:00', '450 pg/mL', false, 'completed', 'Normal'),

-- Iron Panel
(2, 13, 6, 2, '2023-01-20 10:30:00', '2023-01-20 11:00:00', '2023-01-20 15:00:00', 'Fe: 45 mcg/dL', true, 'completed', 'Iron deficiency'),
(32, 13, 6, 61, '2024-09-01 09:30:00', '2024-09-01 10:00:00', '2024-09-01 14:00:00', 'Fe: 85 mcg/dL', false, 'completed', 'Normal'),

-- Coagulation Panel
(11, 14, 2, 11, '2023-04-10 09:30:00', '2023-04-10 10:00:00', '2023-04-10 14:00:00', 'INR: 2.5', false, 'completed', 'Therapeutic range'),
(41, 14, 13, 41, '2024-03-20 09:30:00', '2024-03-20 10:00:00', '2024-03-20 14:00:00', 'INR: 2.8', false, 'completed', 'Well anticoagulated'),

-- Cardiac Enzymes
(7, 15, 11, 7, '2023-03-10 08:15:00', '2023-03-10 08:30:00', '2023-03-10 09:00:00', 'Troponin: <0.01 ng/mL', false, 'completed', 'Negative for MI'),
(18, 15, 13, 18, '2023-06-01 09:15:00', '2023-06-01 09:30:00', '2023-06-01 10:00:00', 'Troponin: <0.01 ng/mL', false, 'completed', 'Negative'),

-- BNP
(21, 16, 2, 21, '2023-07-01 09:30:00', '2023-07-01 10:00:00', '2023-07-01 14:00:00', '450 pg/mL', true, 'completed', 'Elevated in heart failure'),
(48, 16, 24, 48, '2024-05-15 10:00:00', '2024-05-15 10:30:00', '2024-05-15 14:00:00', '180 pg/mL', true, 'completed', 'Improved from baseline'),

-- Electrolytes
(21, 17, 2, 21, '2023-07-01 09:30:00', '2023-07-01 10:00:00', '2023-07-01 14:00:00', 'K: 4.2 mEq/L', false, 'completed', 'Normal potassium'),

-- Creatinine
(1, 18, 2, 1, '2023-01-15 09:30:00', '2023-01-15 10:00:00', '2023-01-15 14:00:00', '1.1 mg/dL', false, 'completed', 'Normal kidney function'),
(21, 18, 2, 21, '2023-07-01 09:30:00', '2023-07-01 10:00:00', '2023-07-01 14:00:00', '1.4 mg/dL', true, 'completed', 'Mild CKD'),

-- Glucose Fasting
(2, 19, 6, 2, '2023-01-20 10:30:00', '2023-01-20 11:00:00', '2023-01-20 15:00:00', '165 mg/dL', true, 'completed', 'Elevated fasting glucose'),
(5, 19, 6, 5, '2023-02-15 10:00:00', '2023-02-15 10:30:00', '2023-02-15 14:00:00', '125 mg/dL', true, 'completed', 'Still elevated but improving'),

-- Pregnancy Test
(14, 20, 10, 14, '2023-05-01 09:15:00', '2023-05-01 09:30:00', '2023-05-01 09:45:00', 'Positive', false, 'completed', 'Pregnancy confirmed'),
(28, 20, 10, 28, '2023-09-10 09:00:00', '2023-09-10 09:15:00', '2023-09-10 09:30:00', 'Positive', false, 'completed', 'Ongoing pregnancy'),

-- Strep Test
(6, 21, 5, 6, '2023-03-01 10:30:00', '2023-03-01 10:45:00', '2023-03-01 11:00:00', 'Negative', false, 'completed', 'No strep throat'),

-- COVID PCR
(7, 22, 11, 7, '2023-03-10 08:00:00', '2023-03-10 08:15:00', '2023-03-10 12:00:00', 'Negative', false, 'completed', 'COVID ruled out'),

-- Drug Screen
(10, 23, 9, 10, '2023-04-01 10:15:00', '2023-04-01 10:30:00', '2023-04-01 11:00:00', 'Negative', false, 'completed', 'Routine pre-medication screen'),

-- Allergy Panel
(20, 24, 11, 20, '2023-06-15 15:30:00', '2023-06-15 16:00:00', '2023-06-16 10:00:00', 'Multiple positives', true, 'completed', 'Bee venom, dust mites positive'),

-- MRI results
(17, 25, 4, 17, '2023-05-20 14:30:00', '2023-05-22 09:00:00', '2023-05-23 10:00:00', 'See report', false, 'completed', 'L4-L5 disc herniation'),
(22, 25, 3, 22, '2023-07-10 11:30:00', '2023-07-12 10:00:00', '2023-07-13 10:00:00', 'See report', false, 'completed', 'Brain MRI - mild atrophy'),

-- Pending and ordered labs (2025)
(1, 1, 2, NULL, '2025-01-10 09:00:00', NULL, NULL, NULL, false, 'ordered', 'Pre-visit labs'),
(1, 3, 2, NULL, '2025-01-10 09:00:00', NULL, NULL, NULL, false, 'ordered', 'Annual lipid panel'),
(5, 4, 21, NULL, '2025-01-15 10:00:00', NULL, NULL, NULL, false, 'ordered', 'Diabetes monitoring'),

-- Collected but pending results
(10, 1, 9, NULL, '2025-01-08 11:00:00', '2025-01-08 11:30:00', NULL, NULL, false, 'collected', 'Awaiting analysis'),
(15, 2, 6, NULL, '2025-01-09 09:00:00', '2025-01-09 09:30:00', NULL, NULL, false, 'collected', 'Processing')
ON CONFLICT DO NOTHING;
