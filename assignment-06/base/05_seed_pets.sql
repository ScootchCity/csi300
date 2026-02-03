-- =============================================================================
-- PawCare Seed Data - Part 4: Pets
-- =============================================================================

INSERT INTO pets (owner_id, species_id, breed, pet_name, date_of_birth, gender, weight_kg, color, is_neutered, microchip_id, allergies, notes, is_deceased, created_at) VALUES
-- Owner 1 (John Smith) - 2 dogs
(1, 1, 'Golden Retriever', 'Max', '2019-03-15', 'male', 32.5, 'Golden', TRUE, 'MC-2020-00001', NULL, 'Friendly, loves swimming', FALSE, '2020-01-15 10:00:00'),
(1, 1, 'Labrador Retriever', 'Bella', '2020-06-20', 'female', 28.0, 'Black', TRUE, 'MC-2020-00002', 'Chicken', 'High energy, needs daily exercise', FALSE, '2020-07-01 11:00:00'),

-- Owner 2 (Sarah Johnson) - 1 cat
(2, 2, 'Maine Coon', 'Luna', '2018-09-10', 'female', 6.8, 'Gray Tabby', TRUE, 'MC-2020-00003', NULL, 'Indoor only, very vocal', FALSE, '2020-02-20 14:30:00'),

-- Owner 3 (Michael Williams) - 2 cats
(3, 2, 'Siamese', 'Milo', '2017-04-22', 'male', 4.5, 'Seal Point', TRUE, 'MC-2020-00004', NULL, 'Older cat, arthritis', FALSE, '2020-03-10 09:15:00'),
(3, 2, 'Persian', 'Cleo', '2019-11-08', 'female', 4.0, 'White', FALSE, 'MC-2020-00005', 'Fish', 'Long hair, needs regular grooming', FALSE, '2020-03-10 09:15:00'),

-- Owner 4 (Emily Brown) - 1 dog, 1 cat
(4, 1, 'French Bulldog', 'Charlie', '2020-01-25', 'male', 12.0, 'Fawn', TRUE, 'MC-2020-00006', 'Grains', 'Brachycephalic, monitor breathing', FALSE, '2020-04-05 11:45:00'),
(4, 2, 'British Shorthair', 'Whiskers', '2019-07-14', 'male', 5.5, 'Blue', TRUE, 'MC-2020-00007', NULL, NULL, FALSE, '2020-04-05 11:45:00'),

-- Owner 5 (David Jones) - 1 dog
(5, 1, 'German Shepherd', 'Rex', '2018-02-28', 'male', 38.0, 'Black and Tan', TRUE, 'MC-2020-00008', NULL, 'Working dog background, very smart', FALSE, '2020-05-12 16:00:00'),

-- Owner 6 (Jessica Garcia) - 2 dogs
(6, 1, 'Beagle', 'Daisy', '2019-05-17', 'female', 11.5, 'Tricolor', TRUE, 'MC-2020-00009', NULL, 'Prone to weight gain', FALSE, '2020-06-18 10:30:00'),
(6, 1, 'Poodle', 'Cooper', '2021-02-14', 'male', 8.0, 'Apricot', TRUE, 'MC-2021-00010', NULL, 'Standard poodle, hypoallergenic', FALSE, '2021-03-01 09:00:00'),

-- Owner 7 (Christopher Miller) - 1 cat
(7, 2, 'Ragdoll', 'Oliver', '2020-08-30', 'male', 7.2, 'Blue Bicolor', TRUE, 'MC-2020-00011', NULL, 'Very docile and affectionate', FALSE, '2020-07-22 13:00:00'),

-- Owner 8 (Amanda Davis) - 1 rabbit
(8, 3, 'Holland Lop', 'Thumper', '2020-04-10', 'male', 2.0, 'Brown', TRUE, 'MC-2020-00012', NULL, 'House rabbit, litter trained', FALSE, '2020-08-30 15:15:00'),

-- Owner 9 (Matthew Rodriguez) - 1 dog
(9, 1, 'Boxer', 'Rocky', '2019-09-05', 'male', 30.0, 'Brindle', TRUE, 'MC-2020-00013', NULL, 'High energy, loves to play', FALSE, '2020-09-14 09:45:00'),

-- Owner 10 (Ashley Martinez) - 2 cats
(10, 2, 'Bengal', 'Simba', '2020-03-22', 'male', 5.8, 'Spotted', TRUE, 'MC-2020-00014', NULL, 'Very active, needs enrichment', FALSE, '2020-10-25 12:30:00'),
(10, 2, 'Abyssinian', 'Nala', '2020-03-22', 'female', 4.2, 'Ruddy', TRUE, 'MC-2020-00015', NULL, 'Simba''s sister from same litter', FALSE, '2020-10-25 12:30:00'),

-- Owner 11-20 with various pets
(11, 1, 'Bulldog', 'Winston', '2019-12-01', 'male', 24.0, 'White', TRUE, 'MC-2020-00016', 'Environmental', 'Skin allergies, on special diet', FALSE, '2020-11-08 10:00:00'),
(12, 2, 'Scottish Fold', 'Mittens', '2020-05-15', 'female', 4.0, 'Gray', TRUE, 'MC-2020-00017', NULL, 'Indoor cat', FALSE, '2020-12-15 14:00:00'),
(13, 1, 'Cavalier King Charles', 'Lady', '2020-09-20', 'female', 7.5, 'Blenheim', TRUE, 'MC-2021-00018', NULL, 'Heart murmur detected', FALSE, '2021-01-20 11:30:00'),
(14, 1, 'Shih Tzu', 'Gizmo', '2018-06-08', 'male', 6.0, 'Gold and White', TRUE, 'MC-2021-00019', NULL, 'Senior, needs dental care', FALSE, '2021-02-28 09:00:00'),
(15, 2, 'Russian Blue', 'Shadow', '2019-10-30', 'male', 5.0, 'Blue Gray', TRUE, 'MC-2021-00020', NULL, 'Shy with strangers', FALSE, '2021-03-12 16:45:00'),
(16, 1, 'Dachshund', 'Oscar', '2020-07-25', 'male', 9.5, 'Red', TRUE, 'MC-2021-00021', NULL, 'Back issues, no jumping', FALSE, '2021-04-18 10:15:00'),
(17, 3, 'Mini Rex', 'Snowball', '2021-01-12', 'female', 1.8, 'White', FALSE, 'MC-2021-00022', NULL, 'Very friendly', FALSE, '2021-05-25 13:30:00'),
(18, 1, 'Corgi', 'Biscuit', '2020-11-05', 'male', 13.0, 'Red and White', TRUE, 'MC-2021-00023', NULL, 'Food motivated', FALSE, '2021-06-30 15:00:00'),
(19, 2, 'Sphynx', 'Dobby', '2021-03-18', 'male', 4.5, 'Pink', TRUE, 'MC-2021-00024', NULL, 'Hairless, needs skin care', FALSE, '2021-07-14 09:30:00'),
(20, 1, 'Australian Shepherd', 'Blue', '2020-02-14', 'male', 25.0, 'Blue Merle', TRUE, 'MC-2021-00025', NULL, 'Very intelligent, agility trained', FALSE, '2021-08-22 11:00:00'),

-- More dogs and cats (owners 21-35)
(21, 1, 'Husky', 'Ghost', '2021-04-20', 'male', 27.0, 'White', TRUE, 'MC-2022-00026', NULL, 'Vocal, needs lots of exercise', FALSE, '2022-01-10 10:00:00'),
(22, 2, 'Norwegian Forest', 'Thor', '2020-12-25', 'male', 8.0, 'Brown Tabby', TRUE, 'MC-2022-00027', NULL, 'Long-haired, outdoor access', FALSE, '2022-02-15 14:30:00'),
(23, 1, 'Border Collie', 'Scout', '2021-08-10', 'female', 18.0, 'Black and White', TRUE, 'MC-2022-00028', NULL, 'Herding instincts, very smart', FALSE, '2022-03-20 09:15:00'),
(24, 2, 'Birman', 'Princess', '2021-06-05', 'female', 4.5, 'Seal Point', TRUE, 'MC-2022-00029', NULL, 'Gentle and quiet', FALSE, '2022-04-25 11:45:00'),
(25, 1, 'Jack Russell', 'Ziggy', '2020-10-15', 'male', 7.0, 'White and Brown', TRUE, 'MC-2022-00030', NULL, 'High energy, loves to dig', FALSE, '2022-05-30 16:00:00'),
(26, 1, 'Maltese', 'Pearl', '2019-08-22', 'female', 3.5, 'White', TRUE, 'MC-2022-00031', NULL, 'Luxating patella', FALSE, '2022-06-08 10:30:00'),
(27, 2, 'Exotic Shorthair', 'Garfield', '2021-11-11', 'male', 5.5, 'Orange', TRUE, 'MC-2022-00032', NULL, 'Lazy, loves to eat', FALSE, '2022-07-15 13:00:00'),
(28, 1, 'Rottweiler', 'Bruno', '2021-01-30', 'male', 45.0, 'Black and Rust', TRUE, 'MC-2022-00033', NULL, 'Well-trained, gentle giant', FALSE, '2022-08-22 15:15:00'),
(29, 2, 'Savannah', 'Koda', '2022-02-14', 'male', 8.5, 'Spotted', TRUE, 'MC-2022-00034', NULL, 'F4 generation, very active', FALSE, '2022-09-28 09:45:00'),
(30, 1, 'Chihuahua', 'Peanut', '2018-03-05', 'female', 2.5, 'Tan', TRUE, 'MC-2022-00035', NULL, 'Senior, dental disease', FALSE, '2022-10-05 12:30:00'),

-- Additional pets for variety
(31, 1, 'Pit Bull Mix', 'Tank', '2022-05-20', 'male', 28.0, 'Gray', TRUE, 'MC-2023-00036', NULL, 'Rescue dog, very sweet', FALSE, '2023-01-12 10:00:00'),
(32, 2, 'Tonkinese', 'Mocha', '2022-07-15', 'female', 4.0, 'Champagne', TRUE, 'MC-2023-00037', NULL, 'Very social', FALSE, '2023-02-18 14:00:00'),
(33, 1, 'Greyhound', 'Flash', '2019-04-12', 'male', 32.0, 'Fawn', TRUE, 'MC-2023-00038', NULL, 'Retired racer', FALSE, '2023-03-25 11:30:00'),
(34, 2, 'Cornish Rex', 'Curly', '2022-09-08', 'female', 3.5, 'White', TRUE, 'MC-2023-00039', NULL, 'Curly coat', FALSE, '2023-04-30 09:00:00'),
(35, 1, 'Great Dane', 'Goliath', '2022-03-25', 'male', 65.0, 'Harlequin', TRUE, 'MC-2023-00040', NULL, 'Largest patient, very gentle', FALSE, '2023-05-15 16:45:00'),

-- Exotic pets
(46, 6, 'African Grey', 'Einstein', '2010-06-15', 'male', 0.5, 'Gray', FALSE, NULL, NULL, 'Very intelligent, large vocabulary', FALSE, '2021-03-15 10:30:00'),
(46, 8, 'Red-Eared Slider', 'Shelly', '2015-04-20', 'female', 1.2, 'Green and Red', FALSE, NULL, NULL, 'Aquatic turtle', FALSE, '2021-03-15 10:30:00'),
(47, 9, 'Ball Python', 'Monty', '2018-08-10', 'male', 1.8, 'Normal', FALSE, NULL, NULL, 'Feeds weekly, docile', FALSE, '2022-05-20 13:00:00'),
(47, 12, 'Standard', 'Noodle', '2020-02-14', 'female', 0.9, 'Sable', TRUE, 'MC-2022-00041', NULL, 'Very playful ferret', FALSE, '2022-05-20 13:00:00'),
(48, 4, 'Syrian', 'Hammy', '2023-01-05', 'male', 0.15, 'Golden', FALSE, NULL, NULL, 'Nocturnal, wheel lover', FALSE, '2023-07-10 15:15:00'),
(48, 5, 'American', 'Patches', '2022-06-20', 'female', 1.1, 'Tricolor', FALSE, NULL, NULL, 'Very vocal guinea pig', FALSE, '2023-07-10 15:15:00'),
(48, 5, 'Abyssinian', 'Ginger', '2022-06-20', 'female', 1.0, 'Red', FALSE, NULL, NULL, 'Patches'' companion', FALSE, '2023-07-10 15:15:00'),

-- Recent registrations (2024)
(41, 1, 'Goldendoodle', 'Teddy', '2023-06-12', 'male', 20.0, 'Cream', FALSE, 'MC-2024-00042', NULL, 'Puppy, first vaccinations', FALSE, '2024-01-08 10:00:00'),
(42, 2, 'Devon Rex', 'Pixie', '2023-08-25', 'female', 3.0, 'Blue', FALSE, 'MC-2024-00043', NULL, 'Kitten, playful', FALSE, '2024-02-14 14:30:00'),
(43, 1, 'Bernese Mountain Dog', 'Bear', '2023-04-18', 'male', 40.0, 'Tricolor', FALSE, 'MC-2024-00044', NULL, 'Large breed puppy', FALSE, '2024-03-20 09:15:00'),
(44, 3, 'Flemish Giant', 'Biggie', '2023-10-05', 'male', 6.5, 'Sandy', FALSE, NULL, NULL, 'Giant rabbit breed', FALSE, '2024-04-25 11:45:00'),
(45, 1, 'Miniature Schnauzer', 'Fritz', '2023-07-30', 'male', 7.0, 'Salt and Pepper', FALSE, 'MC-2024-00045', NULL, 'Needs regular grooming', FALSE, '2024-05-30 16:00:00'),

-- Deceased pet (for filtering)
(1, 1, 'Cocker Spaniel', 'Buddy', '2008-05-10', 'male', 14.0, 'Golden', TRUE, 'MC-2010-00000', NULL, 'Passed away 2023', TRUE, '2020-01-15 10:00:00'),

-- Owner with no visits yet (for subquery exercises)
(36, 2, 'Domestic Shorthair', 'Mystery', '2023-09-15', 'female', 4.0, 'Calico', FALSE, 'MC-2023-00046', NULL, 'New patient, no visits yet', FALSE, '2023-06-22 10:15:00')
ON CONFLICT DO NOTHING;
