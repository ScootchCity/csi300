-- =============================================================================
-- MedCare Seed Data - Part 1: Reference Tables
-- =============================================================================

-- Departments
INSERT INTO medcare.departments (name, building, floor, phone, email) VALUES
('Cardiology', 'Main Building', 3, '802-555-0101', 'cardiology@medcare.com'),
('Neurology', 'Main Building', 4, '802-555-0102', 'neurology@medcare.com'),
('Orthopedics', 'West Wing', 2, '802-555-0103', 'orthopedics@medcare.com'),
('Pediatrics', 'East Wing', 1, '802-555-0104', 'pediatrics@medcare.com'),
('Internal Medicine', 'Main Building', 2, '802-555-0105', 'internalmedicine@medcare.com'),
('Dermatology', 'West Wing', 1, '802-555-0106', 'dermatology@medcare.com'),
('Oncology', 'Main Building', 5, '802-555-0107', 'oncology@medcare.com'),
('Psychiatry', 'East Wing', 3, '802-555-0108', 'psychiatry@medcare.com'),
('Obstetrics & Gynecology', 'East Wing', 2, '802-555-0109', 'obgyn@medcare.com'),
('Emergency Medicine', 'Main Building', 1, '802-555-0110', 'emergency@medcare.com'),
('Radiology', 'Main Building', 1, '802-555-0111', 'radiology@medcare.com'),
('Gastroenterology', 'West Wing', 3, '802-555-0112', 'gastro@medcare.com')
ON CONFLICT DO NOTHING;

-- Specializations
INSERT INTO medcare.specializations (name, category, description, requires_certification) VALUES
('Interventional Cardiology', 'Cardiology', 'Catheter-based treatment of heart diseases', true),
('Electrophysiology', 'Cardiology', 'Diagnosis and treatment of heart rhythm disorders', true),
('General Cardiology', 'Cardiology', 'Diagnosis and treatment of heart conditions', true),
('Stroke Neurology', 'Neurology', 'Specialized care for stroke patients', true),
('Epilepsy', 'Neurology', 'Treatment of seizure disorders', true),
('Movement Disorders', 'Neurology', 'Parkinson''s and other movement conditions', true),
('Sports Medicine', 'Orthopedics', 'Treatment of sports-related injuries', true),
('Joint Replacement', 'Orthopedics', 'Hip, knee, and shoulder replacement surgery', true),
('Spine Surgery', 'Orthopedics', 'Surgical treatment of spinal conditions', true),
('General Pediatrics', 'Pediatrics', 'Primary care for children', true),
('Pediatric Cardiology', 'Pediatrics', 'Heart conditions in children', true),
('Primary Care', 'Internal Medicine', 'General adult healthcare', false),
('Geriatrics', 'Internal Medicine', 'Care for elderly patients', true),
('Medical Dermatology', 'Dermatology', 'Skin disease treatment', true),
('Cosmetic Dermatology', 'Dermatology', 'Aesthetic skin procedures', false),
('Surgical Oncology', 'Oncology', 'Cancer surgery', true),
('Medical Oncology', 'Oncology', 'Cancer treatment with medications', true),
('Child Psychiatry', 'Psychiatry', 'Mental health for children', true),
('Adult Psychiatry', 'Psychiatry', 'Mental health for adults', true),
('Addiction Medicine', 'Psychiatry', 'Treatment of substance use disorders', true),
('Maternal-Fetal Medicine', 'Obstetrics & Gynecology', 'High-risk pregnancy care', true),
('Emergency Medicine', 'Emergency Medicine', 'Acute care and trauma', true),
('Diagnostic Radiology', 'Radiology', 'Medical imaging interpretation', true),
('Interventional Radiology', 'Radiology', 'Image-guided procedures', true),
('Hepatology', 'Gastroenterology', 'Liver disease treatment', true)
ON CONFLICT DO NOTHING;

-- Insurance Providers
INSERT INTO medcare.insurance_providers (name, plan_type, coverage_level, phone, email, website, is_active) VALUES
('Blue Cross Blue Shield VT', 'PPO', 'premium', '800-247-2583', 'members@bcbsvt.com', 'www.bcbsvt.com', true),
('Blue Cross Blue Shield VT', 'HMO', 'standard', '800-247-2583', 'members@bcbsvt.com', 'www.bcbsvt.com', true),
('MVP Health Care', 'HMO', 'standard', '800-687-6277', 'member@mvphealthcare.com', 'www.mvphealthcare.com', true),
('MVP Health Care', 'PPO', 'premium', '800-687-6277', 'member@mvphealthcare.com', 'www.mvphealthcare.com', true),
('Cigna', 'PPO', 'premium', '800-997-1654', 'service@cigna.com', 'www.cigna.com', true),
('Cigna', 'EPO', 'standard', '800-997-1654', 'service@cigna.com', 'www.cigna.com', true),
('Aetna', 'HMO', 'basic', '800-872-3862', 'members@aetna.com', 'www.aetna.com', true),
('Aetna', 'PPO', 'standard', '800-872-3862', 'members@aetna.com', 'www.aetna.com', true),
('UnitedHealthcare', 'PPO', 'premium', '800-328-5979', 'service@uhc.com', 'www.uhc.com', true),
('UnitedHealthcare', 'HMO', 'standard', '800-328-5979', 'service@uhc.com', 'www.uhc.com', true),
('Medicare', 'POS', 'standard', '800-633-4227', NULL, 'www.medicare.gov', true),
('Medicaid VT', 'HMO', 'basic', '800-250-8427', NULL, 'www.greenmountaincare.org', true),
('Humana', 'PPO', 'standard', '800-457-4708', 'members@humana.com', 'www.humana.com', true),
('Kaiser Permanente', 'HMO', 'premium', '800-464-4000', 'member@kp.org', 'www.kp.org', false),
('Self Pay', 'POS', 'basic', NULL, NULL, NULL, true)
ON CONFLICT DO NOTHING;

-- Medications
INSERT INTO medcare.medications (name, generic_name, category, dosage_form, strength, manufacturer, requires_prescription, controlled_substance) VALUES
-- Cardiovascular
('Lipitor', 'Atorvastatin', 'Cardiovascular', 'tablet', '10mg', 'Pfizer', true, false),
('Lipitor', 'Atorvastatin', 'Cardiovascular', 'tablet', '20mg', 'Pfizer', true, false),
('Lisinopril', 'Lisinopril', 'Cardiovascular', 'tablet', '10mg', 'Various', true, false),
('Metoprolol', 'Metoprolol', 'Cardiovascular', 'tablet', '25mg', 'Various', true, false),
('Metoprolol', 'Metoprolol', 'Cardiovascular', 'tablet', '50mg', 'Various', true, false),
('Plavix', 'Clopidogrel', 'Cardiovascular', 'tablet', '75mg', 'Bristol-Myers Squibb', true, false),
('Eliquis', 'Apixaban', 'Cardiovascular', 'tablet', '5mg', 'Bristol-Myers Squibb', true, false),
-- Pain Management
('Tylenol', 'Acetaminophen', 'Pain Relief', 'tablet', '500mg', 'Johnson & Johnson', false, false),
('Advil', 'Ibuprofen', 'Pain Relief', 'tablet', '200mg', 'Pfizer', false, false),
('Celebrex', 'Celecoxib', 'Pain Relief', 'capsule', '200mg', 'Pfizer', true, false),
('Tramadol', 'Tramadol', 'Pain Relief', 'tablet', '50mg', 'Various', true, true),
('Oxycodone', 'Oxycodone', 'Pain Relief', 'tablet', '5mg', 'Various', true, true),
-- Antibiotics
('Amoxicillin', 'Amoxicillin', 'Antibiotic', 'capsule', '500mg', 'Various', true, false),
('Augmentin', 'Amoxicillin-Clavulanate', 'Antibiotic', 'tablet', '875mg', 'GlaxoSmithKline', true, false),
('Azithromycin', 'Azithromycin', 'Antibiotic', 'tablet', '250mg', 'Pfizer', true, false),
('Ciprofloxacin', 'Ciprofloxacin', 'Antibiotic', 'tablet', '500mg', 'Bayer', true, false),
('Doxycycline', 'Doxycycline', 'Antibiotic', 'capsule', '100mg', 'Various', true, false),
-- Mental Health
('Zoloft', 'Sertraline', 'Antidepressant', 'tablet', '50mg', 'Pfizer', true, false),
('Lexapro', 'Escitalopram', 'Antidepressant', 'tablet', '10mg', 'Forest', true, false),
('Xanax', 'Alprazolam', 'Anxiolytic', 'tablet', '0.5mg', 'Pfizer', true, true),
('Ativan', 'Lorazepam', 'Anxiolytic', 'tablet', '1mg', 'Wyeth', true, true),
('Ambien', 'Zolpidem', 'Sleep Aid', 'tablet', '10mg', 'Sanofi', true, true),
-- Diabetes
('Metformin', 'Metformin', 'Diabetes', 'tablet', '500mg', 'Various', true, false),
('Metformin', 'Metformin', 'Diabetes', 'tablet', '1000mg', 'Various', true, false),
('Jardiance', 'Empagliflozin', 'Diabetes', 'tablet', '10mg', 'Boehringer Ingelheim', true, false),
('Ozempic', 'Semaglutide', 'Diabetes', 'injection', '0.5mg', 'Novo Nordisk', true, false),
-- Respiratory
('Albuterol', 'Albuterol', 'Respiratory', 'inhaler', '90mcg', 'Various', true, false),
('Advair', 'Fluticasone-Salmeterol', 'Respiratory', 'inhaler', '250/50mcg', 'GlaxoSmithKline', true, false),
('Singulair', 'Montelukast', 'Respiratory', 'tablet', '10mg', 'Merck', true, false),
('Prednisone', 'Prednisone', 'Corticosteroid', 'tablet', '10mg', 'Various', true, false),
-- Gastrointestinal
('Omeprazole', 'Omeprazole', 'Gastrointestinal', 'capsule', '20mg', 'Various', true, false),
('Nexium', 'Esomeprazole', 'Gastrointestinal', 'capsule', '40mg', 'AstraZeneca', true, false),
('Zofran', 'Ondansetron', 'Antiemetic', 'tablet', '4mg', 'GlaxoSmithKline', true, false),
-- Dermatology
('Hydrocortisone', 'Hydrocortisone', 'Dermatology', 'cream', '1%', 'Various', false, false),
('Tretinoin', 'Tretinoin', 'Dermatology', 'cream', '0.025%', 'Various', true, false),
-- Neurology
('Gabapentin', 'Gabapentin', 'Neurology', 'capsule', '300mg', 'Pfizer', true, false),
('Topamax', 'Topiramate', 'Neurology', 'tablet', '50mg', 'Janssen', true, false),
('Sumatriptan', 'Sumatriptan', 'Neurology', 'tablet', '50mg', 'GlaxoSmithKline', true, false)
ON CONFLICT DO NOTHING;

-- Lab Tests
INSERT INTO medcare.lab_tests (name, code, category, description, normal_range, unit, turnaround_hours, base_cost, requires_fasting) VALUES
-- Blood Tests
('Complete Blood Count', 'CBC', 'Hematology', 'Measures different components of blood', 'Varies by component', 'cells/μL', 4, 35.00, false),
('Basic Metabolic Panel', 'BMP', 'Chemistry', 'Measures glucose, calcium, and electrolytes', 'Varies by component', 'Various', 4, 45.00, true),
('Comprehensive Metabolic Panel', 'CMP', 'Chemistry', 'Includes BMP plus liver and kidney markers', 'Varies by component', 'Various', 6, 65.00, true),
('Lipid Panel', 'LIPID', 'Chemistry', 'Measures cholesterol and triglycerides', 'Total <200, LDL <100, HDL >40', 'mg/dL', 6, 55.00, true),
('Hemoglobin A1C', 'HBA1C', 'Chemistry', 'Average blood sugar over 3 months', '<5.7% normal, 5.7-6.4% prediabetes', '%', 24, 40.00, false),
('Thyroid Panel', 'TSH', 'Endocrine', 'Measures thyroid function', 'TSH: 0.4-4.0', 'mIU/L', 24, 75.00, false),
('Liver Function Panel', 'LFP', 'Chemistry', 'Measures liver enzymes and function', 'Varies by enzyme', 'U/L', 6, 60.00, false),
('Prothrombin Time', 'PT', 'Coagulation', 'Measures blood clotting time', '11-13.5 seconds', 'seconds', 2, 30.00, false),
('INR', 'INR', 'Coagulation', 'International Normalized Ratio for warfarin', '2.0-3.0 for most conditions', 'ratio', 2, 30.00, false),
('Troponin', 'TROP', 'Cardiac', 'Detects heart muscle damage', '<0.04 ng/mL', 'ng/mL', 1, 85.00, false),
('BNP', 'BNP', 'Cardiac', 'Brain natriuretic peptide for heart failure', '<100 pg/mL', 'pg/mL', 4, 95.00, false),
-- Urinalysis
('Urinalysis', 'UA', 'Urinalysis', 'Examines urine for various conditions', 'Clear, normal pH', 'Various', 2, 25.00, false),
('Urine Culture', 'UCULT', 'Microbiology', 'Identifies bacteria in urine', 'No growth', 'CFU/mL', 48, 45.00, false),
-- Imaging
('Chest X-Ray', 'CXR', 'Radiology', 'Images of chest cavity', 'Clear lungs', 'N/A', 2, 150.00, false),
('CT Scan - Head', 'CTHEAD', 'Radiology', 'Detailed brain imaging', 'No abnormalities', 'N/A', 4, 450.00, false),
('CT Scan - Abdomen', 'CTABD', 'Radiology', 'Detailed abdominal imaging', 'No abnormalities', 'N/A', 4, 550.00, false),
('MRI - Brain', 'MRIBR', 'Radiology', 'Detailed brain soft tissue imaging', 'No abnormalities', 'N/A', 24, 1200.00, false),
('MRI - Spine', 'MRISP', 'Radiology', 'Detailed spine imaging', 'No abnormalities', 'N/A', 24, 1400.00, false),
('Echocardiogram', 'ECHO', 'Cardiac', 'Ultrasound of the heart', 'EF 55-70%', '%', 24, 350.00, false),
('EKG/ECG', 'EKG', 'Cardiac', 'Electrical activity of heart', 'Normal sinus rhythm', 'N/A', 1, 75.00, false),
-- Specialty
('PSA', 'PSA', 'Oncology', 'Prostate-specific antigen', '<4.0 ng/mL', 'ng/mL', 24, 55.00, false),
('Mammogram', 'MAMMO', 'Radiology', 'Breast imaging', 'No abnormalities', 'N/A', 24, 250.00, false),
('Colonoscopy', 'COLON', 'Gastroenterology', 'Visual examination of colon', 'No polyps', 'N/A', 1, 1500.00, true),
('Vitamin D', 'VITD', 'Chemistry', 'Measures vitamin D levels', '30-100 ng/mL', 'ng/mL', 24, 65.00, false),
('Vitamin B12', 'B12', 'Chemistry', 'Measures B12 levels', '200-900 pg/mL', 'pg/mL', 24, 55.00, false)
ON CONFLICT DO NOTHING;
