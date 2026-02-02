-- =============================================================================
-- PawCare Seed Data - Part 7: Invoices
-- =============================================================================

-- Invoices (billing records)
-- Schema: owner_id, record_id, invoice_number, invoice_date, subtotal, tax_rate, tax_amount, discount_amount, total, status, payment_method, paid_at, notes
INSERT INTO invoices (owner_id, record_id, invoice_number, invoice_date, subtotal, tax_amount, discount_amount, total, status, payment_method, paid_at, notes) VALUES
-- 2023 Invoices
(1, 1, 'INV-2023-0001', '2023-01-15', 85.00, 4.76, 0.00, 89.76, 'paid', 'credit_card', '2023-01-15 09:45:00', 'Annual wellness exam'),
(1, 2, 'INV-2023-0002', '2023-01-15', 85.00, 4.76, 0.00, 89.76, 'paid', 'credit_card', '2023-01-15 10:15:00', 'Annual wellness exam'),
(2, 3, 'INV-2023-0003', '2023-02-10', 95.00, 5.32, 0.00, 100.32, 'paid', 'debit_card', '2023-02-10 10:45:00', 'Senior cat exam'),
(3, 4, 'INV-2023-0004', '2023-02-10', 165.00, 9.24, 0.00, 174.24, 'paid', 'credit_card', '2023-02-10 11:30:00', 'Sick visit with treatment'),
(3, 5, 'INV-2023-0005', '2023-02-10', 85.00, 4.76, 0.00, 89.76, 'paid', 'cash', '2023-02-10 11:45:00', 'Wellness exam'),
(4, 6, 'INV-2023-0006', '2023-03-05', 285.00, 15.96, 0.00, 300.96, 'paid', 'credit_card', '2023-03-05 15:30:00', 'Sick visit with x-rays'),
(5, 7, 'INV-2023-0007', '2023-03-20', 145.00, 8.12, 0.00, 153.12, 'paid', 'credit_card', '2023-03-20 09:45:00', 'Vaccines'),
(6, 8, 'INV-2023-0008', '2023-04-12', 115.00, 6.44, 0.00, 121.44, 'paid', 'debit_card', '2023-04-12 10:45:00', 'Exotic wellness'),
(7, 9, 'INV-2023-0009', '2023-04-25', 125.00, 7.00, 0.00, 132.00, 'paid', 'credit_card', '2023-04-25 11:45:00', 'Rabies vaccine'),
(8, 10, 'INV-2023-0010', '2023-05-08', 145.00, 8.12, 0.00, 153.12, 'paid', 'cash', '2023-05-08 10:30:00', 'Ear infection treatment'),

(9, 11, 'INV-2023-0011', '2023-05-15', 135.00, 7.56, 0.00, 142.56, 'paid', 'credit_card', '2023-05-15 10:45:00', 'Wellness with allergy meds'),
(10, 12, 'INV-2023-0012', '2023-06-01', 485.00, 27.16, 0.00, 512.16, 'paid', 'credit_card', '2023-06-01 12:00:00', 'Dental with extractions'),
(10, 13, 'INV-2023-0013', '2023-06-15', 45.00, 2.52, 0.00, 47.52, 'paid', 'credit_card', '2023-06-15 14:45:00', 'Post-dental recheck'),
(11, 14, 'INV-2023-0014', '2023-07-10', 165.00, 9.24, 0.00, 174.24, 'paid', 'debit_card', '2023-07-10 11:00:00', 'Exam with heart consult'),
(12, 15, 'INV-2023-0015', '2023-07-22', 95.00, 5.32, 0.00, 100.32, 'paid', 'credit_card', '2023-07-22 09:45:00', 'FVRCP booster'),
(13, 16, 'INV-2023-0016', '2023-08-05', 265.00, 14.84, 0.00, 279.84, 'paid', 'credit_card', '2023-08-05 12:00:00', 'Orthopedic exam with x-rays'),
(14, 17, 'INV-2023-0017', '2023-08-18', 125.00, 7.00, 0.00, 132.00, 'paid', 'cash', '2023-08-18 10:45:00', 'Rabbit wellness'),
(15, 18, 'INV-2023-0018', '2023-09-02', 95.00, 5.32, 0.00, 100.32, 'paid', 'credit_card', '2023-09-02 10:15:00', 'Grooming service'),
(16, 19, 'INV-2023-0019', '2023-09-15', 125.00, 7.00, 0.00, 132.00, 'paid', 'debit_card', '2023-09-15 15:00:00', 'New patient exam'),
(17, 20, 'INV-2023-0020', '2023-10-01', 145.00, 8.12, 0.00, 153.12, 'paid', 'credit_card', '2023-10-01 10:45:00', 'Annual with Lyme vaccine'),

-- 2024 Invoices
(1, 21, 'INV-2024-0001', '2024-01-10', 125.00, 7.00, 0.00, 132.00, 'paid', 'credit_card', '2024-01-10 09:45:00', 'Annual wellness'),
(1, 22, 'INV-2024-0002', '2024-01-10', 125.00, 7.00, 0.00, 132.00, 'paid', 'credit_card', '2024-01-10 10:15:00', 'Annual wellness'),
(2, 23, 'INV-2024-0003', '2024-01-25', 245.00, 13.72, 0.00, 258.72, 'paid', 'debit_card', '2024-01-25 11:00:00', 'Senior exam with x-rays'),
(4, 24, 'INV-2024-0004', '2024-02-05', 75.00, 4.20, 0.00, 79.20, 'paid', 'credit_card', '2024-02-05 14:45:00', 'Follow-up'),
(6, 25, 'INV-2024-0005', '2024-02-20', 115.00, 6.44, 0.00, 121.44, 'paid', 'cash', '2024-02-20 10:45:00', 'Rabbit wellness'),
(7, 26, 'INV-2024-0006', '2024-03-05', 165.00, 9.24, 0.00, 174.24, 'paid', 'credit_card', '2024-03-05 12:00:00', 'Sick visit'),
(18, 27, 'INV-2024-0007', '2024-03-15', 185.00, 10.36, 0.00, 195.36, 'paid', 'credit_card', '2024-03-15 10:00:00', 'New patient with vaccines'),
(19, 28, 'INV-2024-0008', '2024-03-28', 125.00, 7.00, 0.00, 132.00, 'paid', 'debit_card', '2024-03-28 10:45:00', 'Annual wellness'),
(20, 29, 'INV-2024-0009', '2024-04-10', 185.00, 10.36, 0.00, 195.36, 'paid', 'credit_card', '2024-04-10 15:00:00', 'Puppy vaccines'),
(21, 30, 'INV-2024-0010', '2024-04-22', 95.00, 5.32, 0.00, 100.32, 'paid', 'credit_card', '2024-04-22 10:45:00', 'Annual wellness'),

(22, 31, 'INV-2024-0011', '2024-05-05', 185.00, 10.36, 0.00, 195.36, 'paid', 'credit_card', '2024-05-05 10:45:00', 'Dermatology consult'),
(23, 32, 'INV-2024-0012', '2024-05-18', 125.00, 7.00, 0.00, 132.00, 'paid', 'debit_card', '2024-05-18 12:00:00', 'Annual wellness'),
(24, 33, 'INV-2024-0013', '2024-06-01', 95.00, 5.32, 0.00, 100.32, 'paid', 'credit_card', '2024-06-01 10:45:00', 'Weight check'),
(25, 34, 'INV-2024-0014', '2024-06-15', 685.00, 38.36, 0.00, 723.36, 'paid', 'credit_card', '2024-06-15 17:00:00', 'Mass removal surgery'),
(26, 35, 'INV-2024-0015', '2024-06-28', 145.00, 8.12, 0.00, 153.12, 'paid', 'cash', '2024-06-28 10:00:00', 'New patient exam'),
(27, 36, 'INV-2024-0016', '2024-07-10', 545.00, 30.52, 0.00, 575.52, 'paid', 'credit_card', '2024-07-10 12:00:00', 'Senior dental'),
(28, 37, 'INV-2024-0017', '2024-07-22', 125.00, 7.00, 0.00, 132.00, 'paid', 'credit_card', '2024-07-22 10:15:00', 'Annual wellness'),
(29, 38, 'INV-2024-0018', '2024-08-05', 155.00, 8.68, 0.00, 163.68, 'paid', 'debit_card', '2024-08-05 12:00:00', 'Kitten package'),
(30, 39, 'INV-2024-0019', '2024-08-18', 95.00, 5.32, 0.00, 100.32, 'paid', 'credit_card', '2024-08-18 10:45:00', 'Wellness exam'),
(31, 40, 'INV-2024-0020', '2024-09-01', 95.00, 5.32, 0.00, 100.32, 'paid', 'cash', '2024-09-01 14:45:00', 'Annual wellness'),

(32, 41, 'INV-2024-0021', '2024-09-15', 285.00, 15.96, 0.00, 300.96, 'paid', 'credit_card', '2024-09-15 11:30:00', 'Large breed orthopedic screening'),
(1, 42, 'INV-2024-0022', '2024-10-05', 125.00, 7.00, 0.00, 132.00, 'paid', 'credit_card', '2024-10-05 09:45:00', 'DHPP booster'),
(2, 43, 'INV-2024-0023', '2024-10-18', 225.00, 12.60, 0.00, 237.60, 'paid', 'debit_card', '2024-10-18 11:00:00', 'Thyroid workup'),
(4, 44, 'INV-2024-0024', '2024-11-02', 75.00, 4.20, 0.00, 79.20, 'paid', 'credit_card', '2024-11-02 14:45:00', 'Recheck exam'),
(6, 45, 'INV-2024-0025', '2024-11-15', 145.00, 8.12, 0.00, 153.12, 'paid', 'cash', '2024-11-15 10:45:00', 'Rabbit vaccine'),

-- Emergency invoices (higher costs)
(1, 46, 'INV-2024-0026', '2024-06-21', 1450.00, 81.20, 0.00, 1531.20, 'paid', 'credit_card', '2024-06-21 10:00:00', 'Emergency - hit by car'),
(7, 47, 'INV-2024-0027', '2024-08-10', 685.00, 38.36, 0.00, 723.36, 'paid', 'credit_card', '2024-08-10 08:00:00', 'Emergency - bloat'),
(25, 48, 'INV-2024-0028', '2024-09-26', 425.00, 23.80, 0.00, 448.80, 'paid', 'debit_card', '2024-09-26 10:00:00', 'Emergency - toxin ingestion'),

-- Some unpaid/pending invoices for variety
(1, NULL, 'INV-2025-0001', '2025-01-02', 125.00, 7.00, 0.00, 132.00, 'pending', NULL, NULL, 'Scheduled annual exam'),
(3, NULL, 'INV-2025-0002', '2025-01-10', 135.00, 7.56, 0.00, 142.56, 'pending', NULL, NULL, 'Scheduled senior exam'),

-- Invoices with discounts (loyalty program)
(9, 11, 'INV-2023-0011B', '2023-05-15', 145.00, 7.56, 10.00, 142.56, 'paid', 'credit_card', '2023-05-15 11:00:00', 'Loyalty discount applied'),
(1, 21, 'INV-2024-0001B', '2024-01-10', 135.00, 7.00, 10.00, 132.00, 'paid', 'credit_card', '2024-01-10 10:00:00', 'Multi-pet discount')
ON CONFLICT DO NOTHING;
