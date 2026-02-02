-- =============================================================================
-- PawCare Seed Data - Part 1: Reference Tables
-- =============================================================================

-- Species
INSERT INTO species (species_name, category, avg_lifespan_years) VALUES
('Dog', 'mammal', 12),
('Cat', 'mammal', 15),
('Rabbit', 'mammal', 10),
('Hamster', 'mammal', 3),
('Guinea Pig', 'mammal', 6),
('Bird (Parrot)', 'bird', 40),
('Bird (Canary)', 'bird', 10),
('Turtle', 'reptile', 30),
('Snake', 'reptile', 20),
('Lizard', 'reptile', 15),
('Fish (Freshwater)', 'fish', 5),
('Ferret', 'mammal', 8),
('Chinchilla', 'mammal', 15),
('Hedgehog', 'mammal', 5),
('Frog', 'amphibian', 10)
ON CONFLICT DO NOTHING;

-- Clinics
INSERT INTO clinics (clinic_name, address, city, state, zip_code, phone, email, opens_at, closes_at, is_emergency_center) VALUES
('PawCare Downtown', '100 Main Street', 'Burlington', 'Vermont', '05401', '802-555-0100', 'downtown@vet', '08:00', '18:00', FALSE),
('PawCare South End', '250 Pine Street', 'Burlington', 'Vermont', '05401', '802-555-0200', 'southend@vet', '08:00', '20:00', FALSE),
('PawCare Williston', '75 Taft Corners', 'Williston', 'Vermont', '05495', '802-555-0300', 'williston@vet', '07:00', '19:00', FALSE),
('PawCare Emergency', '500 Hospital Drive', 'Burlington', 'Vermont', '05401', '802-555-0911', 'emergency@vet', '00:00', '23:59', TRUE),
('PawCare Essex', '120 Susie Wilson Road', 'Essex Junction', 'Vermont', '05452', '802-555-0400', 'essex@vet', '08:00', '17:00', FALSE)
ON CONFLICT DO NOTHING;

-- Vaccines
INSERT INTO vaccines (name, manufacturer, species_id, validity_months, is_core_vaccine, unit_price) VALUES
-- Dog vaccines
('Rabies (Canine)', 'Zoetis', 1, 36, TRUE, 25.00),
('DHPP (Distemper Combo)', 'Merck', 1, 12, TRUE, 35.00),
('Bordetella', 'Elanco', 1, 12, FALSE, 30.00),
('Lyme Disease', 'Zoetis', 1, 12, FALSE, 40.00),
('Canine Influenza', 'Merck', 1, 12, FALSE, 45.00),
('Leptospirosis', 'Zoetis', 1, 12, FALSE, 28.00),
-- Cat vaccines
('Rabies (Feline)', 'Zoetis', 2, 36, TRUE, 25.00),
('FVRCP (Feline Distemper)', 'Merck', 2, 12, TRUE, 32.00),
('Feline Leukemia (FeLV)', 'Boehringer', 2, 12, FALSE, 38.00),
-- Rabbit vaccines
('RHDV2 (Rabbit)', 'Medgene', 3, 12, TRUE, 45.00),
('Myxomatosis', 'Filavac', 3, 12, FALSE, 50.00),
-- Ferret vaccines
('Rabies (Ferret)', 'Zoetis', 12, 12, TRUE, 25.00),
('Distemper (Ferret)', 'Merck', 12, 12, TRUE, 35.00)
ON CONFLICT DO NOTHING;

-- Procedures
INSERT INTO procedures (name, category, description, base_price, duration_mins, requires_anesthesia) VALUES
-- Examinations
('Wellness Exam', 'examination', 'Comprehensive physical examination', 55.00, 30, FALSE),
('Sick Visit', 'examination', 'Examination for illness or injury', 65.00, 30, FALSE),
('Senior Wellness Exam', 'examination', 'Extended exam for pets 7+ years', 85.00, 45, FALSE),
('Puppy/Kitten Exam', 'examination', 'New pet examination and consultation', 45.00, 45, FALSE),
('Emergency Exam', 'emergency', 'Emergency assessment', 125.00, 30, FALSE),
-- Surgeries
('Spay (Female Dog)', 'surgery', 'Ovariohysterectomy for female dogs', 350.00, 90, TRUE),
('Neuter (Male Dog)', 'surgery', 'Orchiectomy for male dogs', 250.00, 60, TRUE),
('Spay (Female Cat)', 'surgery', 'Ovariohysterectomy for female cats', 250.00, 60, TRUE),
('Neuter (Male Cat)', 'surgery', 'Orchiectomy for male cats', 150.00, 45, TRUE),
('Mass Removal', 'surgery', 'Surgical removal of mass/tumor', 400.00, 90, TRUE),
('Laceration Repair', 'surgery', 'Wound closure and repair', 200.00, 45, TRUE),
('Foreign Body Removal', 'surgery', 'Surgical removal of foreign object', 800.00, 120, TRUE),
('Orthopedic Surgery', 'surgery', 'Bone/joint surgical repair', 2500.00, 180, TRUE),
-- Dental
('Dental Cleaning', 'dental', 'Professional dental scaling and polishing', 300.00, 60, TRUE),
('Tooth Extraction (Simple)', 'dental', 'Single tooth extraction', 75.00, 30, TRUE),
('Tooth Extraction (Surgical)', 'dental', 'Complex tooth extraction', 150.00, 45, TRUE),
('Dental X-rays', 'dental', 'Full mouth radiographs', 125.00, 30, TRUE),
-- Diagnostics
('Blood Panel (Basic)', 'diagnostic', 'CBC and basic chemistry', 95.00, 15, FALSE),
('Blood Panel (Comprehensive)', 'diagnostic', 'Full chemistry and CBC', 175.00, 15, FALSE),
('Urinalysis', 'diagnostic', 'Complete urine analysis', 45.00, 10, FALSE),
('Fecal Exam', 'diagnostic', 'Parasite screening', 35.00, 10, FALSE),
('X-ray (Single View)', 'diagnostic', 'Single radiograph', 85.00, 20, FALSE),
('X-ray (Multiple Views)', 'diagnostic', 'Multiple radiographs', 150.00, 30, FALSE),
('Ultrasound', 'diagnostic', 'Abdominal or cardiac ultrasound', 250.00, 45, FALSE),
('ECG/EKG', 'diagnostic', 'Electrocardiogram', 125.00, 20, FALSE),
-- Preventive
('Microchip Implant', 'preventive', 'Microchip insertion and registration', 45.00, 10, FALSE),
('Nail Trim', 'preventive', 'Nail trimming', 20.00, 15, FALSE),
('Anal Gland Expression', 'preventive', 'Manual gland expression', 30.00, 10, FALSE),
('Ear Cleaning', 'preventive', 'Professional ear cleaning', 25.00, 15, FALSE),
('Heartworm Test', 'preventive', '4Dx SNAP test', 55.00, 10, FALSE),
('FeLV/FIV Test', 'preventive', 'Feline leukemia/immunodeficiency test', 65.00, 10, FALSE),
-- Grooming
('Bath (Small)', 'grooming', 'Bath for small pets under 25lbs', 35.00, 30, FALSE),
('Bath (Medium)', 'grooming', 'Bath for medium pets 25-50lbs', 45.00, 45, FALSE),
('Bath (Large)', 'grooming', 'Bath for large pets over 50lbs', 60.00, 60, FALSE),
('Full Groom', 'grooming', 'Bath, haircut, nails, ears', 85.00, 90, FALSE),
-- Emergency
('IV Catheter Placement', 'emergency', 'Intravenous catheter insertion', 75.00, 15, FALSE),
('Fluid Therapy (Per Hour)', 'emergency', 'IV fluid administration', 50.00, 60, FALSE),
('Oxygen Therapy', 'emergency', 'Supplemental oxygen support', 100.00, 60, FALSE),
('CPR', 'emergency', 'Cardiopulmonary resuscitation', 250.00, 30, FALSE)
ON CONFLICT DO NOTHING;

-- Medications
INSERT INTO medications (name, generic_name, category, form, unit, unit_price, requires_prescription, stock_quantity, reorder_level) VALUES
-- Antibiotics
('Clavamox', 'Amoxicillin/Clavulanate', 'antibiotic', 'tablet', 'mg', 1.50, TRUE, 500, 100),
('Baytril', 'Enrofloxacin', 'antibiotic', 'tablet', 'mg', 2.00, TRUE, 300, 75),
('Metronidazole', 'Metronidazole', 'antibiotic', 'tablet', 'mg', 0.75, TRUE, 400, 100),
('Cephalexin', 'Cephalexin', 'antibiotic', 'capsule', 'mg', 1.25, TRUE, 350, 80),
('Doxycycline', 'Doxycycline', 'antibiotic', 'capsule', 'mg', 1.00, TRUE, 300, 75),
-- Anti-inflammatory
('Rimadyl', 'Carprofen', 'anti-inflammatory', 'chewable', 'mg', 2.50, TRUE, 400, 100),
('Metacam', 'Meloxicam', 'anti-inflammatory', 'liquid', 'ml', 3.00, TRUE, 200, 50),
('Previcox', 'Firocoxib', 'anti-inflammatory', 'chewable', 'mg', 3.50, TRUE, 250, 60),
('Prednisone', 'Prednisone', 'anti-inflammatory', 'tablet', 'mg', 0.50, TRUE, 600, 150),
-- Pain Relief
('Tramadol', 'Tramadol', 'pain_relief', 'tablet', 'mg', 0.75, TRUE, 400, 100),
('Gabapentin', 'Gabapentin', 'pain_relief', 'capsule', 'mg', 0.60, TRUE, 500, 120),
('Buprenorphine', 'Buprenorphine', 'pain_relief', 'injection', 'ml', 15.00, TRUE, 50, 15),
-- Antiparasitic
('Heartgard Plus', 'Ivermectin/Pyrantel', 'antiparasitic', 'chewable', 'dose', 12.00, TRUE, 200, 50),
('NexGard', 'Afoxolaner', 'antiparasitic', 'chewable', 'dose', 22.00, TRUE, 150, 40),
('Simparica Trio', 'Sarolaner/Moxidectin/Pyrantel', 'antiparasitic', 'chewable', 'dose', 28.00, TRUE, 120, 30),
('Revolution Plus', 'Selamectin/Sarolaner', 'antiparasitic', 'topical', 'dose', 24.00, TRUE, 100, 25),
('Panacur', 'Fenbendazole', 'antiparasitic', 'liquid', 'ml', 0.80, TRUE, 300, 75),
('Drontal Plus', 'Praziquantel/Pyrantel/Febantel', 'antiparasitic', 'tablet', 'dose', 8.00, TRUE, 200, 50),
-- Cardiac
('Vetmedin', 'Pimobendan', 'cardiac', 'chewable', 'mg', 4.00, TRUE, 150, 40),
('Enalapril', 'Enalapril', 'cardiac', 'tablet', 'mg', 0.80, TRUE, 250, 60),
('Furosemide', 'Furosemide', 'cardiac', 'tablet', 'mg', 0.40, TRUE, 400, 100),
('Atenolol', 'Atenolol', 'cardiac', 'tablet', 'mg', 0.50, TRUE, 200, 50),
-- Dermatological
('Apoquel', 'Oclacitinib', 'dermatological', 'tablet', 'mg', 3.00, TRUE, 300, 75),
('Cytopoint', 'Lokivetmab', 'dermatological', 'injection', 'ml', 85.00, TRUE, 30, 10),
('Ketoconazole', 'Ketoconazole', 'dermatological', 'tablet', 'mg', 1.50, TRUE, 200, 50),
-- Supplements
('Cosequin', 'Glucosamine/Chondroitin', 'supplement', 'chewable', 'dose', 1.00, FALSE, 400, 100),
('Omega-3 Fish Oil', 'Fish Oil', 'supplement', 'liquid', 'ml', 0.30, FALSE, 500, 100),
('Purina FortiFlora', 'Probiotics', 'supplement', 'powder', 'packet', 1.50, FALSE, 300, 75),
('Denamarin', 'SAMe/Silybin', 'supplement', 'tablet', 'dose', 2.50, FALSE, 200, 50),
-- Sedatives
('Acepromazine', 'Acepromazine', 'sedative', 'tablet', 'mg', 1.00, TRUE, 150, 40),
('Trazodone', 'Trazodone', 'sedative', 'tablet', 'mg', 0.80, TRUE, 200, 50),
('Sileo', 'Dexmedetomidine', 'sedative', 'gel', 'ml', 25.00, TRUE, 40, 10),
-- Other
('Cerenia', 'Maropitant', 'other', 'tablet', 'mg', 8.00, TRUE, 100, 25),
('Famotidine', 'Famotidine', 'other', 'tablet', 'mg', 0.30, FALSE, 400, 100),
('Omeprazole', 'Omeprazole', 'other', 'capsule', 'mg', 0.50, TRUE, 300, 75)
ON CONFLICT DO NOTHING;
