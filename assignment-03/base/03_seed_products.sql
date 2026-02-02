-- =============================================================================
-- ShopFlow Seed Data - Part 2: Products
-- =============================================================================

-- Electronics - Smartphones (category 9)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('ELEC-SPH-001', 'ProPhone X1 128GB', 'Flagship smartphone with 6.5" OLED display', 9, 999.99, 450.00, 0.185, TRUE, '2024-01-15', NULL),
('ELEC-SPH-002', 'ProPhone X1 256GB', 'Flagship smartphone with 6.5" OLED display, 256GB', 9, 1099.99, 480.00, 0.185, TRUE, '2024-01-15', NULL),
('ELEC-SPH-003', 'BudgetPhone A5', 'Affordable smartphone with great battery', 9, 299.99, 120.00, 0.175, TRUE, '2024-02-01', NULL),
('ELEC-SPH-004', 'MidRange Pro 7', 'Mid-tier phone with premium features', 9, 549.99, 220.00, 0.180, TRUE, '2024-03-10', NULL),
('ELEC-SPH-005', 'ProPhone X0', 'Previous generation flagship', 9, 699.99, 350.00, 0.182, TRUE, '2023-01-20', '2024-12-01'),
('ELEC-SPH-006', 'GamerPhone Elite', 'Gaming-focused smartphone', 9, 899.99, 400.00, 0.210, TRUE, '2024-06-15', NULL),
('ELEC-SPH-007', 'CompactPhone Mini', 'Small form factor smartphone', 9, 649.99, 280.00, 0.140, TRUE, '2024-04-01', NULL),
('ELEC-SPH-008', 'SeniorPhone Easy', 'Simple smartphone for seniors', 9, 199.99, 80.00, 0.165, TRUE, '2024-01-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Electronics - Laptops (category 10)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('ELEC-LAP-001', 'ProBook 15 i7', 'Professional laptop with 15" display', 10, 1299.99, 650.00, 1.800, TRUE, '2024-02-01', NULL),
('ELEC-LAP-002', 'ProBook 13 M1', 'Ultralight laptop with M1 chip', 10, 1499.99, 750.00, 1.200, TRUE, '2024-02-15', NULL),
('ELEC-LAP-003', 'GamerBook RTX', 'Gaming laptop with RTX 4070', 10, 1899.99, 950.00, 2.500, TRUE, '2024-04-01', NULL),
('ELEC-LAP-004', 'StudentBook Basic', 'Affordable laptop for students', 10, 499.99, 220.00, 1.600, TRUE, '2024-01-10', NULL),
('ELEC-LAP-005', 'WorkStation Pro 17', 'High-performance workstation', 10, 2499.99, 1200.00, 3.200, TRUE, '2024-05-01', NULL),
('ELEC-LAP-006', 'ChromeBook Lite', 'Lightweight Chromebook', 10, 349.99, 150.00, 1.100, TRUE, '2024-03-01', NULL),
('ELEC-LAP-007', 'ProBook 15 i5', 'Mid-range professional laptop', 10, 999.99, 500.00, 1.850, TRUE, '2024-02-01', NULL),
('ELEC-LAP-008', 'GamerBook RTX 4060', 'Entry gaming laptop', 10, 1399.99, 700.00, 2.300, TRUE, '2024-04-15', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Electronics - Audio (category 11)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('ELEC-AUD-001', 'ProPods Wireless', 'Premium wireless earbuds', 11, 249.99, 80.00, 0.050, TRUE, '2024-01-01', NULL),
('ELEC-AUD-002', 'StudioHeadphones Pro', 'Professional studio headphones', 11, 349.99, 120.00, 0.280, TRUE, '2024-02-01', NULL),
('ELEC-AUD-003', 'BassBoost Speaker', 'Portable Bluetooth speaker', 11, 129.99, 45.00, 0.650, TRUE, '2024-01-15', NULL),
('ELEC-AUD-004', 'SoundBar 5.1', 'Home theater soundbar', 11, 399.99, 180.00, 3.500, TRUE, '2024-03-01', NULL),
('ELEC-AUD-005', 'BudgetBuds Basic', 'Affordable wireless earbuds', 11, 49.99, 15.00, 0.040, TRUE, '2024-01-01', NULL),
('ELEC-AUD-006', 'NoiseCancelling Elite', 'ANC over-ear headphones', 11, 299.99, 100.00, 0.260, TRUE, '2024-04-01', NULL),
('ELEC-AUD-007', 'PartyBox 500', 'Large party speaker', 11, 599.99, 250.00, 8.500, TRUE, '2024-05-01', NULL),
('ELEC-AUD-008', 'Vintage Turntable', 'Record player with Bluetooth', 11, 199.99, 70.00, 4.200, FALSE, '2023-06-01', '2024-08-01')
ON CONFLICT (sku) DO NOTHING;

-- Electronics - Cameras (category 12)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('ELEC-CAM-001', 'ProCam DSLR 4K', 'Professional DSLR camera', 12, 1899.99, 900.00, 0.850, TRUE, '2024-01-01', NULL),
('ELEC-CAM-002', 'ActionCam Pro', 'Waterproof action camera', 12, 349.99, 120.00, 0.120, TRUE, '2024-02-01', NULL),
('ELEC-CAM-003', 'VlogCam Compact', 'Compact vlogging camera', 12, 799.99, 350.00, 0.290, TRUE, '2024-03-01', NULL),
('ELEC-CAM-004', 'SecurityCam WiFi', 'Indoor security camera', 12, 79.99, 25.00, 0.180, TRUE, '2024-01-15', NULL),
('ELEC-CAM-005', 'DroneX Pro', 'Camera drone with 4K', 12, 999.99, 450.00, 0.750, TRUE, '2024-04-01', NULL),
('ELEC-CAM-006', 'InstantPrint Camera', 'Instant photo printer camera', 12, 149.99, 55.00, 0.300, TRUE, '2024-02-15', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Electronics - Wearables (category 13)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('ELEC-WRB-001', 'SmartWatch Ultra', 'Premium smartwatch with GPS', 13, 449.99, 180.00, 0.052, TRUE, '2024-01-01', NULL),
('ELEC-WRB-002', 'FitBand Pro', 'Fitness tracker with HR monitor', 13, 129.99, 40.00, 0.028, TRUE, '2024-01-15', NULL),
('ELEC-WRB-003', 'SmartWatch SE', 'Affordable smartwatch', 13, 249.99, 100.00, 0.045, TRUE, '2024-02-01', NULL),
('ELEC-WRB-004', 'KidsWatch GPS', 'GPS smartwatch for children', 13, 99.99, 35.00, 0.038, TRUE, '2024-03-01', NULL),
('ELEC-WRB-005', 'FitBand Basic', 'Entry-level fitness tracker', 13, 49.99, 15.00, 0.022, TRUE, '2024-01-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Clothing - Men's (category 14)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('CLTH-MEN-001', 'Classic Oxford Shirt', 'Cotton oxford button-down', 14, 59.99, 18.00, 0.250, TRUE, '2024-01-01', NULL),
('CLTH-MEN-002', 'Slim Fit Jeans', 'Modern slim fit denim', 14, 79.99, 25.00, 0.450, TRUE, '2024-01-01', NULL),
('CLTH-MEN-003', 'Wool Blazer', 'Classic wool sport coat', 14, 199.99, 70.00, 0.800, TRUE, '2024-02-01', NULL),
('CLTH-MEN-004', 'Casual Polo', 'Pique cotton polo shirt', 14, 44.99, 12.00, 0.200, TRUE, '2024-01-15', NULL),
('CLTH-MEN-005', 'Winter Jacket', 'Insulated winter jacket', 14, 149.99, 55.00, 1.200, TRUE, '2024-09-01', NULL),
('CLTH-MEN-006', 'Chino Pants', 'Classic chino trousers', 14, 69.99, 22.00, 0.400, TRUE, '2024-01-01', NULL),
('CLTH-MEN-007', 'Graphic T-Shirt', 'Cotton graphic tee', 14, 29.99, 8.00, 0.180, TRUE, '2024-03-01', NULL),
('CLTH-MEN-008', 'Merino Sweater', 'Fine merino wool sweater', 14, 89.99, 30.00, 0.350, TRUE, '2024-08-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Clothing - Women's (category 15)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('CLTH-WMN-001', 'Silk Blouse', 'Elegant silk blouse', 15, 89.99, 28.00, 0.150, TRUE, '2024-01-01', NULL),
('CLTH-WMN-002', 'High-Waist Jeans', 'Trendy high-waist denim', 15, 84.99, 26.00, 0.420, TRUE, '2024-01-01', NULL),
('CLTH-WMN-003', 'Maxi Dress', 'Flowing maxi dress', 15, 129.99, 40.00, 0.350, TRUE, '2024-03-01', NULL),
('CLTH-WMN-004', 'Cashmere Cardigan', 'Soft cashmere cardigan', 15, 179.99, 65.00, 0.300, TRUE, '2024-08-01', NULL),
('CLTH-WMN-005', 'Yoga Leggings', 'High-performance yoga pants', 15, 64.99, 18.00, 0.200, TRUE, '2024-01-15', NULL),
('CLTH-WMN-006', 'Cocktail Dress', 'Little black dress', 15, 149.99, 50.00, 0.280, TRUE, '2024-02-01', NULL),
('CLTH-WMN-007', 'Denim Jacket', 'Classic denim jacket', 15, 99.99, 32.00, 0.650, TRUE, '2024-04-01', NULL),
('CLTH-WMN-008', 'Linen Pants', 'Breathable linen trousers', 15, 74.99, 24.00, 0.280, TRUE, '2024-05-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Home & Garden - Furniture (category 19)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('HOME-FRN-001', 'Ergonomic Office Chair', 'Adjustable office chair with lumbar support', 19, 349.99, 140.00, 15.000, TRUE, '2024-01-01', NULL),
('HOME-FRN-002', 'Standing Desk', 'Electric height-adjustable desk', 19, 599.99, 250.00, 35.000, TRUE, '2024-02-01', NULL),
('HOME-FRN-003', 'Leather Sofa 3-Seat', 'Premium leather sofa', 19, 1299.99, 550.00, 65.000, TRUE, '2024-01-15', NULL),
('HOME-FRN-004', 'Bookshelf Oak', '5-tier oak bookshelf', 19, 199.99, 80.00, 25.000, TRUE, '2024-03-01', NULL),
('HOME-FRN-005', 'Coffee Table Glass', 'Modern glass coffee table', 19, 249.99, 90.00, 18.000, TRUE, '2024-02-15', NULL),
('HOME-FRN-006', 'Dining Table Set', '6-person dining set', 19, 899.99, 380.00, 55.000, TRUE, '2024-04-01', NULL),
('HOME-FRN-007', 'Nightstand Pair', 'Set of 2 nightstands', 19, 179.99, 65.00, 12.000, TRUE, '2024-01-01', NULL),
('HOME-FRN-008', 'TV Stand Modern', 'Media console with storage', 19, 279.99, 110.00, 28.000, TRUE, '2024-03-15', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Home & Garden - Kitchen (category 20)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('HOME-KIT-001', 'Smart Blender Pro', 'High-speed smart blender', 20, 199.99, 75.00, 4.500, TRUE, '2024-01-01', NULL),
('HOME-KIT-002', 'Coffee Maker Deluxe', 'Programmable coffee machine', 20, 149.99, 55.00, 3.800, TRUE, '2024-01-15', NULL),
('HOME-KIT-003', 'Air Fryer XL', 'Large capacity air fryer', 20, 129.99, 45.00, 5.200, TRUE, '2024-02-01', NULL),
('HOME-KIT-004', 'Knife Set Premium', '12-piece knife block set', 20, 249.99, 90.00, 3.500, TRUE, '2024-01-01', NULL),
('HOME-KIT-005', 'Stand Mixer', 'Professional stand mixer', 20, 349.99, 140.00, 8.500, TRUE, '2024-03-01', NULL),
('HOME-KIT-006', 'Instant Pot 8Qt', 'Multi-function pressure cooker', 20, 119.99, 42.00, 5.800, TRUE, '2024-01-01', NULL),
('HOME-KIT-007', 'Cast Iron Skillet', '12-inch cast iron pan', 20, 49.99, 18.00, 3.600, TRUE, '2024-02-15', NULL),
('HOME-KIT-008', 'Food Processor', 'Multi-purpose food processor', 20, 179.99, 65.00, 4.200, TRUE, '2024-04-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Sports & Outdoors (category 4)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('SPRT-OUT-001', 'Yoga Mat Premium', 'Extra thick yoga mat', 4, 49.99, 15.00, 1.200, TRUE, '2024-01-01', NULL),
('SPRT-OUT-002', 'Dumbbell Set 20kg', 'Adjustable dumbbell pair', 4, 199.99, 80.00, 20.000, TRUE, '2024-01-15', NULL),
('SPRT-OUT-003', 'Running Shoes Pro', 'Professional running shoes', 4, 149.99, 55.00, 0.580, TRUE, '2024-02-01', NULL),
('SPRT-OUT-004', 'Camping Tent 4P', '4-person waterproof tent', 4, 249.99, 95.00, 4.500, TRUE, '2024-03-01', NULL),
('SPRT-OUT-005', 'Mountain Bike', '21-speed mountain bike', 4, 599.99, 280.00, 14.000, TRUE, '2024-04-01', NULL),
('SPRT-OUT-006', 'Resistance Bands Set', '5-band resistance set', 4, 29.99, 8.00, 0.350, TRUE, '2024-01-01', NULL),
('SPRT-OUT-007', 'Hiking Backpack 50L', 'Large hiking backpack', 4, 129.99, 45.00, 1.800, TRUE, '2024-02-15', NULL),
('SPRT-OUT-008', 'Swim Goggles Pro', 'Anti-fog swimming goggles', 4, 34.99, 10.00, 0.080, TRUE, '2024-01-01', NULL),
('SPRT-OUT-009', 'Fitness Tracker Band', 'Water-resistant fitness band', 4, 79.99, 25.00, 0.025, FALSE, '2023-01-01', '2024-06-01'),
('SPRT-OUT-010', 'Golf Club Set', 'Complete 14-club set', 4, 799.99, 350.00, 12.000, TRUE, '2024-05-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Health & Beauty (category 6)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('HLTH-BTY-001', 'Vitamin D3 Supplements', '365-day supply vitamin D', 6, 24.99, 8.00, 0.150, TRUE, '2024-01-01', NULL),
('HLTH-BTY-002', 'Anti-Aging Serum', 'Premium face serum', 6, 89.99, 28.00, 0.050, TRUE, '2024-02-01', NULL),
('HLTH-BTY-003', 'Electric Toothbrush', 'Sonic electric toothbrush', 6, 79.99, 28.00, 0.180, TRUE, '2024-01-15', NULL),
('HLTH-BTY-004', 'Hair Dryer Pro', 'Professional hair dryer', 6, 149.99, 55.00, 0.650, TRUE, '2024-03-01', NULL),
('HLTH-BTY-005', 'Massage Gun', 'Percussion massage device', 6, 199.99, 75.00, 1.100, TRUE, '2024-02-01', NULL),
('HLTH-BTY-006', 'Organic Shampoo Set', 'Natural shampoo & conditioner', 6, 34.99, 12.00, 0.800, TRUE, '2024-01-01', NULL),
('HLTH-BTY-007', 'Facial Cleanser', 'Gentle daily cleanser', 6, 19.99, 6.00, 0.200, TRUE, '2024-01-01', NULL),
('HLTH-BTY-008', 'Protein Powder 2kg', 'Whey protein supplement', 6, 54.99, 22.00, 2.200, TRUE, '2024-01-15', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Books & Media (category 5)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('BOOK-MED-001', 'SQL Fundamentals', 'Complete guide to SQL', 5, 49.99, 15.00, 0.800, TRUE, '2024-01-01', NULL),
('BOOK-MED-002', 'JavaScript Mastery', 'Advanced JavaScript techniques', 5, 54.99, 18.00, 0.900, TRUE, '2024-02-01', NULL),
('BOOK-MED-003', 'Bestseller Novel 2024', 'Award-winning fiction', 5, 24.99, 8.00, 0.450, TRUE, '2024-03-01', NULL),
('BOOK-MED-004', 'Vinyl Record Collection', 'Classic rock vinyl set', 5, 79.99, 30.00, 1.500, TRUE, '2024-01-15', NULL),
('BOOK-MED-005', 'Board Game Deluxe', 'Strategy board game', 5, 44.99, 16.00, 1.200, TRUE, '2024-02-15', NULL),
('BOOK-MED-006', 'Cookbook Italian', 'Authentic Italian recipes', 5, 34.99, 12.00, 1.100, TRUE, '2024-01-01', NULL),
('BOOK-MED-007', 'E-Reader Device', 'Backlit e-reader 8GB', 5, 129.99, 55.00, 0.180, TRUE, '2024-04-01', NULL),
('BOOK-MED-008', 'Photography Guide', 'Professional photography book', 5, 39.99, 14.00, 0.950, TRUE, '2024-03-15', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Toys & Games (category 7)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('TOYS-GAM-001', 'Building Blocks 1000pc', 'Creative building set', 7, 49.99, 18.00, 1.500, TRUE, '2024-01-01', NULL),
('TOYS-GAM-002', 'RC Car Racing', 'Remote control race car', 7, 79.99, 28.00, 0.850, TRUE, '2024-02-01', NULL),
('TOYS-GAM-003', 'Doll House Deluxe', 'Wooden dollhouse set', 7, 129.99, 48.00, 5.500, TRUE, '2024-01-15', NULL),
('TOYS-GAM-004', 'Puzzle 1000 Pieces', 'Landscape jigsaw puzzle', 7, 19.99, 6.00, 0.600, TRUE, '2024-01-01', NULL),
('TOYS-GAM-005', 'Science Kit Chemistry', 'Educational chemistry set', 7, 39.99, 14.00, 1.200, TRUE, '2024-03-01', NULL),
('TOYS-GAM-006', 'Video Game Console', 'Latest gaming console', 7, 499.99, 380.00, 4.500, TRUE, '2024-01-01', NULL),
('TOYS-GAM-007', 'Stuffed Animal Bear', 'Giant plush teddy bear', 7, 34.99, 12.00, 0.800, TRUE, '2024-02-15', NULL),
('TOYS-GAM-008', 'Card Game Party', 'Party card game set', 7, 24.99, 8.00, 0.300, TRUE, '2024-01-01', NULL)
ON CONFLICT (sku) DO NOTHING;

-- Food & Beverages (category 8)
INSERT INTO products (sku, name, description, category_id, price, cost, weight_kg, is_active, created_at, discontinued_at) VALUES
('FOOD-BEV-001', 'Organic Coffee Beans 1kg', 'Premium arabica beans', 8, 29.99, 12.00, 1.100, TRUE, '2024-01-01', NULL),
('FOOD-BEV-002', 'Green Tea Collection', 'Assorted green tea box', 8, 24.99, 9.00, 0.250, TRUE, '2024-01-15', NULL),
('FOOD-BEV-003', 'Dark Chocolate Box', 'Premium dark chocolates', 8, 34.99, 14.00, 0.500, TRUE, '2024-02-01', NULL),
('FOOD-BEV-004', 'Olive Oil Extra Virgin', 'Italian olive oil 1L', 8, 19.99, 7.00, 1.050, TRUE, '2024-01-01', NULL),
('FOOD-BEV-005', 'Honey Raw Organic', 'Pure organic honey 500g', 8, 14.99, 5.00, 0.550, TRUE, '2024-03-01', NULL),
('FOOD-BEV-006', 'Protein Bars 12pk', 'Healthy protein snack bars', 8, 29.99, 11.00, 0.720, TRUE, '2024-01-01', NULL),
('FOOD-BEV-007', 'Wine Red Reserve', 'Aged red wine 750ml', 8, 44.99, 18.00, 1.300, TRUE, '2024-02-15', NULL),
('FOOD-BEV-008', 'Gourmet Pasta Set', 'Italian pasta variety pack', 8, 22.99, 8.00, 1.500, TRUE, '2024-01-01', NULL)
ON CONFLICT (sku) DO NOTHING;
