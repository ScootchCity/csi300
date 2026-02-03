-- =============================================================================
-- ShopFlow Seed Data - Part 3: Customers
-- =============================================================================

INSERT INTO customers (email, first_name, last_name, phone, country, city, tier, created_at, last_order_at) VALUES
-- USA Customers
('john.smith@gmail.com', 'John', 'Smith', '+1-555-0101', 'USA', 'New York', 'gold', '2023-01-15', '2025-12-15'),
('emily.johnson@yahoo.com', 'Emily', 'Johnson', '+1-555-0102', 'USA', 'Los Angeles', 'platinum', '2022-06-20', '2025-12-28'),
('michael.williams@outlook.com', 'Michael', 'Williams', '+1-555-0103', 'USA', 'Chicago', 'silver', '2023-05-10', '2025-11-20'),
('sarah.brown@gmail.com', 'Sarah', 'Brown', NULL, 'USA', 'Houston', 'bronze', '2024-01-05', '2025-10-15'),
('david.jones@hotmail.com', 'David', 'Jones', '+1-555-0105', 'USA', 'Phoenix', 'gold', '2023-03-22', '2025-12-10'),
('jessica.garcia@gmail.com', 'Jessica', 'Garcia', '+1-555-0106', 'USA', 'Philadelphia', 'silver', '2023-08-14', '2025-09-25'),
('christopher.miller@yahoo.com', 'Christopher', 'Miller', NULL, 'USA', 'San Antonio', 'bronze', '2024-03-01', '2025-08-30'),
('ashley.davis@gmail.com', 'Ashley', 'Davis', '+1-555-0108', 'USA', 'San Diego', 'platinum', '2022-02-28', '2025-12-30'),
('matthew.rodriguez@outlook.com', 'Matthew', 'Rodriguez', '+1-555-0109', 'USA', 'Dallas', 'gold', '2023-04-17', '2025-11-05'),
('amanda.martinez@gmail.com', 'Amanda', 'Martinez', '+1-555-0110', 'USA', 'San Jose', 'silver', '2023-09-03', '2025-12-01'),
('joshua.hernandez@yahoo.com', 'Joshua', 'Hernandez', NULL, 'USA', 'Austin', 'bronze', '2024-06-15', NULL),
('stephanie.lopez@gmail.com', 'Stephanie', 'Lopez', '+1-555-0112', 'USA', 'Jacksonville', 'bronze', '2024-08-20', '2025-10-10'),
('andrew.gonzalez@outlook.com', 'Andrew', 'Gonzalez', '+1-555-0113', 'USA', 'Fort Worth', 'silver', '2023-11-08', '2025-11-28'),
('nicole.wilson@gmail.com', 'Nicole', 'Wilson', '+1-555-0114', 'USA', 'Columbus', 'gold', '2023-02-14', '2025-12-22'),
('daniel.anderson@yahoo.com', 'Daniel', 'Anderson', NULL, 'USA', 'Charlotte', 'bronze', '2024-04-30', '2025-07-15'),

-- Canada Customers
('sophie.tremblay@gmail.com', 'Sophie', 'Tremblay', '+1-416-555-0201', 'Canada', 'Toronto', 'gold', '2023-01-20', '2025-12-18'),
('lucas.gagnon@yahoo.com', 'Lucas', 'Gagnon', '+1-514-555-0202', 'Canada', 'Montreal', 'silver', '2023-06-12', '2025-11-22'),
('emma.roy@outlook.com', 'Emma', 'Roy', NULL, 'Canada', 'Vancouver', 'platinum', '2022-09-05', '2025-12-25'),
('william.cote@gmail.com', 'William', 'Côté', '+1-613-555-0204', 'Canada', 'Ottawa', 'bronze', '2024-02-18', '2025-09-30'),
('olivia.bouchard@yahoo.com', 'Olivia', 'Bouchard', '+1-403-555-0205', 'Canada', 'Calgary', 'silver', '2023-10-25', '2025-10-28'),

-- UK Customers
('james.taylor@gmail.com', 'James', 'Taylor', '+44-20-5550-0301', 'UK', 'London', 'platinum', '2022-04-10', '2025-12-29'),
('charlotte.davies@yahoo.co.uk', 'Charlotte', 'Davies', '+44-121-555-0302', 'UK', 'Birmingham', 'gold', '2023-03-08', '2025-11-15'),
('oliver.evans@outlook.com', 'Oliver', 'Evans', NULL, 'UK', 'Manchester', 'silver', '2023-07-22', '2025-12-05'),
('amelia.thomas@gmail.com', 'Amelia', 'Thomas', '+44-113-555-0304', 'UK', 'Leeds', 'bronze', '2024-05-14', '2025-08-20'),
('harry.roberts@yahoo.co.uk', 'Harry', 'Roberts', '+44-141-555-0305', 'UK', 'Glasgow', 'silver', '2023-12-01', '2025-11-10'),

-- Germany Customers
('max.mueller@gmail.com', 'Max', 'Müller', '+49-30-5550-0401', 'Germany', 'Berlin', 'gold', '2023-02-25', '2025-12-12'),
('anna.schmidt@yahoo.de', 'Anna', 'Schmidt', '+49-89-5550-0402', 'Germany', 'Munich', 'platinum', '2022-08-15', '2025-12-27'),
('leon.schneider@outlook.de', 'Leon', 'Schneider', NULL, 'Germany', 'Hamburg', 'silver', '2023-09-18', '2025-10-25'),
('lena.fischer@gmail.com', 'Lena', 'Fischer', '+49-221-555-0404', 'Germany', 'Cologne', 'bronze', '2024-01-30', '2025-09-15'),
('paul.weber@yahoo.de', 'Paul', 'Weber', '+49-69-5550-0405', 'Germany', 'Frankfurt', 'gold', '2023-05-20', '2025-11-30'),

-- France Customers
('louis.martin@gmail.com', 'Louis', 'Martin', '+33-1-5550-0501', 'France', 'Paris', 'platinum', '2022-07-12', '2025-12-20'),
('chloe.bernard@yahoo.fr', 'Chloé', 'Bernard', '+33-4-5550-0502', 'France', 'Lyon', 'gold', '2023-04-28', '2025-11-18'),
('hugo.dubois@outlook.fr', 'Hugo', 'Dubois', NULL, 'France', 'Marseille', 'silver', '2023-08-05', '2025-10-08'),
('lea.moreau@gmail.com', 'Léa', 'Moreau', '+33-5-5550-0504', 'France', 'Toulouse', 'bronze', '2024-03-12', '2025-08-25'),
('lucas.laurent@yahoo.fr', 'Lucas', 'Laurent', '+33-3-5550-0505', 'France', 'Nice', 'silver', '2023-11-20', '2025-12-02'),

-- Australia Customers
('jack.thompson@gmail.com', 'Jack', 'Thompson', '+61-2-5550-0601', 'Australia', 'Sydney', 'gold', '2023-01-08', '2025-12-16'),
('mia.white@yahoo.com.au', 'Mia', 'White', '+61-3-5550-0602', 'Australia', 'Melbourne', 'platinum', '2022-05-25', '2025-12-28'),
('noah.harris@outlook.com.au', 'Noah', 'Harris', NULL, 'Australia', 'Brisbane', 'silver', '2023-06-30', '2025-11-12'),
('ava.martin@gmail.com', 'Ava', 'Martin', '+61-8-5550-0604', 'Australia', 'Perth', 'bronze', '2024-02-08', '2025-09-20'),
('ethan.clark@yahoo.com.au', 'Ethan', 'Clark', '+61-7-5550-0605', 'Australia', 'Adelaide', 'gold', '2023-10-15', '2025-10-30'),

-- Japan Customers
('yuki.tanaka@gmail.com', 'Yuki', 'Tanaka', '+81-3-5550-0701', 'Japan', 'Tokyo', 'platinum', '2022-03-18', '2025-12-30'),
('hana.suzuki@yahoo.co.jp', 'Hana', 'Suzuki', '+81-6-5550-0702', 'Japan', 'Osaka', 'gold', '2023-02-05', '2025-11-25'),
('kenji.yamamoto@outlook.jp', 'Kenji', 'Yamamoto', NULL, 'Japan', 'Yokohama', 'silver', '2023-07-10', '2025-10-18'),
('sakura.watanabe@gmail.com', 'Sakura', 'Watanabe', '+81-52-555-0704', 'Japan', 'Nagoya', 'bronze', '2024-04-22', '2025-08-12'),
('takeshi.ito@yahoo.co.jp', 'Takeshi', 'Ito', '+81-78-555-0705', 'Japan', 'Kobe', 'silver', '2023-12-08', '2025-12-08'),

-- Brazil Customers
('pedro.silva@gmail.com', 'Pedro', 'Silva', '+55-11-5550-0801', 'Brazil', 'São Paulo', 'gold', '2023-03-15', '2025-12-14'),
('ana.santos@yahoo.com.br', 'Ana', 'Santos', '+55-21-5550-0802', 'Brazil', 'Rio de Janeiro', 'platinum', '2022-10-28', '2025-12-26'),
('lucas.oliveira@outlook.com', 'Lucas', 'Oliveira', NULL, 'Brazil', 'Brasília', 'silver', '2023-08-20', '2025-11-08'),
('julia.rodrigues@gmail.com', 'Julia', 'Rodrigues', '+55-31-5550-0804', 'Brazil', 'Belo Horizonte', 'bronze', '2024-01-15', '2025-09-28'),
('gabriel.ferreira@yahoo.com.br', 'Gabriel', 'Ferreira', '+55-41-5550-0805', 'Brazil', 'Curitiba', 'gold', '2023-06-05', '2025-10-22'),

-- More diverse customers for better query practice
('inactive.user@oldmail.com', 'Inactive', 'User', NULL, 'USA', 'Detroit', 'bronze', '2022-01-01', NULL),
('test.customer@local', 'Test', 'Customer', '+1-555-9999', 'USA', 'Test City', 'bronze', '2025-01-01', NULL),
('vip.shopper@luxury.com', 'Victoria', 'Premium', '+1-555-8888', 'USA', 'Beverly Hills', 'platinum', '2021-06-15', '2025-12-31'),
('bulk.buyer@wholesale.com', 'Bob', 'Wholesale', '+1-555-7777', 'USA', 'Miami', 'gold', '2022-03-20', '2025-12-20'),
('new.signup@recent.com', 'Nancy', 'Newcomer', NULL, 'USA', 'Seattle', 'bronze', '2025-12-01', NULL),
('european.shopper@eu.com', 'Erik', 'Euroson', '+46-8-5550-0901', 'Sweden', 'Stockholm', 'silver', '2023-04-10', '2025-11-15'),
('asian.buyer@asia.com', 'Ling', 'Chen', '+86-21-5550-1001', 'China', 'Shanghai', 'gold', '2023-02-28', '2025-12-10'),
('middle.east@me.com', 'Ahmed', 'Al-Hassan', '+971-4-555-1101', 'UAE', 'Dubai', 'platinum', '2022-11-11', '2025-12-24')
ON CONFLICT (email) DO NOTHING;
