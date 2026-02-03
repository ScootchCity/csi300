-- =============================================================================
-- ShopFlow Seed Data - Part 6: Product Reviews
-- =============================================================================
-- Reviews with ratings 1-5, some with NULL comments

INSERT INTO product_reviews (product_id, customer_id, rating, title, comment, is_verified_purchase, created_at) VALUES
-- Laptop reviews (product 1)
(1, 1, 5, 'Excellent laptop!', 'Fast, reliable, and great battery life. Perfect for work and gaming.', TRUE, '2024-01-15 14:30:00'),
(1, 2, 5, 'Best purchase ever', 'This laptop exceeded all my expectations. Highly recommend!', TRUE, '2024-01-20 10:15:00'),
(1, 16, 4, 'Very good but pricey', 'Great performance but a bit expensive for the specs.', TRUE, '2024-03-12 16:45:00'),
(1, 36, 5, 'Perfect for developers', NULL, TRUE, '2024-04-10 09:30:00'),
(1, 42, 4, 'Solid machine', 'Good build quality and fast processor. Fan can be loud sometimes.', TRUE, '2024-06-15 11:00:00'),
(1, 8, 5, 'Outstanding quality', 'Second one I''ve bought. Company laptop is now the same as personal.', TRUE, '2024-08-22 15:20:00'),

-- Smartphone reviews (product 2)
(2, 2, 5, 'Amazing phone', 'Camera quality is incredible. Battery lasts all day.', TRUE, '2024-01-18 12:00:00'),
(2, 18, 4, 'Good but not perfect', 'Great phone overall, but the screen could be brighter.', TRUE, '2024-04-25 14:30:00'),
(2, 28, 5, 'Love this phone!', NULL, TRUE, '2024-07-20 10:45:00'),
(2, 43, 4, 'Solid upgrade', 'Upgraded from previous model. Noticeable improvements everywhere.', TRUE, '2024-08-12 09:15:00'),
(2, 3, 5, 'Best smartphone I''ve owned', 'Fast, beautiful display, and excellent camera.', TRUE, '2024-06-20 16:30:00'),

-- Gaming Console reviews (product 3)
(3, 8, 5, 'Gaming heaven', 'Load times are instant. Graphics are stunning. Worth every penny.', TRUE, '2024-02-18 19:00:00'),
(3, 22, 5, 'Perfect for family', NULL, TRUE, '2024-05-15 20:30:00'),
(3, 40, 4, 'Great but noisy', 'Amazing performance but the fan can get loud during intense gaming.', TRUE, '2024-08-28 21:15:00'),
(3, 24, 5, 'Kids love it', 'Bought for the family room. Everyone enjoys it.', TRUE, '2024-09-18 18:00:00'),
(3, 46, 5, 'Best console ever', 'The exclusive games alone make it worth buying.', TRUE, '2024-10-05 15:45:00'),

-- Tablet reviews (product 4)
(4, 3, 5, 'Perfect for travel', 'Light, fast, and great battery. Use it every day.', TRUE, '2024-01-25 11:30:00'),
(4, 21, 4, 'Good tablet', 'Nice screen, but wish it had more storage.', TRUE, '2024-03-18 14:00:00'),
(4, 36, 5, 'Great for reading', NULL, TRUE, '2024-08-08 10:20:00'),
(4, 38, 5, 'Excellent purchase', 'Use it for work and entertainment. Couldn''t be happier.', TRUE, '2024-08-10 16:45:00'),

-- Headphones reviews (product 5)
(5, 5, 5, 'Best noise cancelling', 'These are incredible. Can''t hear anything with ANC on.', TRUE, '2024-01-28 13:15:00'),
(5, 24, 4, 'Good but uncomfortable', 'Sound quality is great but they hurt my ears after 2 hours.', FALSE, '2024-05-22 15:30:00'),
(5, 35, 5, 'Audio perfection', NULL, TRUE, '2024-07-28 12:00:00'),
(5, 46, 4, 'Worth the investment', 'Pricey but the sound quality justifies it.', TRUE, '2024-10-20 09:45:00'),
(5, 1, 5, 'Second pair bought', 'Lost my first pair, immediately bought another. That good.', TRUE, '2024-05-25 14:20:00'),

-- Smartwatch reviews (product 6)
(6, 6, 5, 'Life changing', 'Track everything now. Sleep, exercise, heart rate. Love it.', TRUE, '2024-02-08 08:30:00'),
(6, 32, 4, 'Good watch', 'Battery could be better but otherwise excellent.', TRUE, '2024-07-22 17:00:00'),
(6, 18, 5, 'Perfect fitness companion', NULL, TRUE, '2024-07-12 10:15:00'),
(6, 45, 3, 'Decent but overpriced', 'Works fine but I expected more for the price.', FALSE, '2024-09-15 11:30:00'),

-- Wireless Earbuds reviews (product 7)
(7, 9, 4, 'Great for workouts', 'Stay in place during running. Sound is good.', TRUE, '2024-02-20 07:00:00'),
(7, 29, 5, 'Perfect fit', 'Comfortable for all-day wear. Clear sound.', TRUE, '2024-06-25 14:45:00'),
(7, 53, 5, 'Best earbuds', NULL, TRUE, '2024-11-28 09:30:00'),

-- Bluetooth Speaker reviews (product 8)
(8, 20, 5, 'Amazing bass', 'The sound quality blew me away. Great for parties.', TRUE, '2024-04-28 20:00:00'),
(8, 12, 4, 'Loud and clear', 'Good speaker but a bit heavy to carry around.', TRUE, '2024-07-08 16:30:00'),
(8, 1, 5, 'Beach party essential', NULL, TRUE, '2024-11-30 12:15:00'),

-- Keyboard reviews (product 9)
(9, 42, 5, 'Perfect for typing', 'Mechanical keys feel amazing. Great for programming.', TRUE, '2024-06-12 11:00:00'),
(9, 27, 4, 'Good keyboard', 'Nice feel but the RGB is too bright even on lowest setting.', FALSE, '2024-07-20 14:30:00'),

-- Phone Case reviews (product 10)
(10, 2, 5, 'Great protection', 'Dropped phone twice, no damage. Worth it.', TRUE, '2024-01-15 09:00:00'),
(10, 18, 4, 'Good case', NULL, TRUE, '2024-04-28 13:45:00'),
(10, 29, 5, 'Slim and protective', 'Doesn''t add bulk but protects well.', TRUE, '2024-06-18 10:30:00'),
(10, 37, 5, 'Perfect fit', 'Fits perfectly, looks great.', TRUE, '2024-08-15 15:00:00'),

-- Monitor reviews (product 11)
(11, 27, 5, 'Crystal clear display', 'Colors are accurate. Great for photo editing.', TRUE, '2024-06-22 14:00:00'),
(11, 1, 5, 'Best monitor I''ve used', NULL, TRUE, '2024-11-30 11:30:00'),

-- Gaming Controller reviews (product 12)
(12, 22, 5, 'Responsive controls', 'No lag, comfortable grip. Perfect for gaming.', TRUE, '2024-05-18 19:30:00'),
(12, 40, 4, 'Good controller', 'Works great but the buttons are a bit stiff initially.', TRUE, '2024-08-30 21:00:00'),
(12, 46, 5, 'Pro quality', NULL, TRUE, '2024-10-12 16:15:00'),

-- Men''s jacket reviews (product 21)
(21, 19, 4, 'Stylish and warm', 'Great jacket for fall. Fits as expected.', TRUE, '2024-04-22 10:00:00'),
(21, 49, 5, 'Perfect fit', NULL, TRUE, '2024-11-28 14:30:00'),

-- Women''s dress reviews (product 22)
(22, 19, 5, 'Beautiful dress', 'Perfect for special occasions. High quality fabric.', TRUE, '2024-04-23 11:15:00'),
(22, 49, 5, 'Stunning!', 'Received so many compliments. Worth every penny.', TRUE, '2024-11-29 09:00:00'),

-- Running shoes reviews (product 45)
(45, 7, 5, 'Great for marathons', 'Comfortable even after 20 miles. Excellent support.', TRUE, '2024-02-15 18:30:00'),
(45, 17, 4, 'Good shoes', 'Comfortable but run a bit small. Order half size up.', TRUE, '2024-05-12 15:00:00'),
(45, 48, 5, 'Best running shoes', NULL, TRUE, '2024-08-22 08:45:00'),
(45, 39, 4, 'Solid choice', 'Good for daily running. Break-in period was short.', TRUE, '2024-10-25 07:30:00'),

-- Fitness equipment reviews
(51, 17, 5, 'Quality yoga mat', 'Thick and cushioned. Great for home workouts.', TRUE, '2024-04-15 06:30:00'),
(51, 46, 4, 'Good mat', NULL, TRUE, '2024-06-12 09:00:00'),
(52, 17, 5, 'Love my dumbbells', 'Perfect weight range for home gym.', TRUE, '2024-04-16 07:00:00'),
(53, 41, 4, 'Accurate tracking', 'Counts steps accurately. Battery lasts a week.', TRUE, '2024-04-12 08:15:00'),
(53, 46, 5, 'Great fitness tracker', 'Simple to use and reliable.', TRUE, '2024-10-18 10:30:00'),

-- Vitamin reviews
(54, 37, 4, 'Good quality', 'Easy to swallow. Noticed more energy after a month.', TRUE, '2024-06-08 09:00:00'),
(55, 37, 5, 'Excellent protein', 'Mixes well, tastes good, no bloating.', TRUE, '2024-06-09 09:30:00'),

-- Book reviews
(61, 4, 5, 'Must read!', 'Fascinating insights into tech history. Couldn''t put it down.', TRUE, '2024-01-22 20:00:00'),
(61, 23, 4, 'Good read', NULL, TRUE, '2024-07-15 21:30:00'),
(62, 4, 4, 'Informative', 'Great introduction to machine learning concepts.', TRUE, '2024-01-23 21:15:00'),
(63, 26, 5, 'Changed my perspective', 'Incredible business lessons. Highly recommend.', TRUE, '2024-03-20 19:00:00'),
(64, 26, 5, 'Practical advice', NULL, TRUE, '2024-03-21 20:30:00'),
(66, 23, 5, 'Page turner', 'Great mystery novel. Didn''t see the ending coming.', TRUE, '2024-07-16 22:00:00'),

-- Toy reviews
(71, 19, 5, 'Kids love it!', 'Great educational toy. My kids play with it every day.', TRUE, '2024-09-10 15:30:00'),
(71, 35, 4, 'Fun toy', NULL, TRUE, '2024-07-20 14:00:00'),
(72, 28, 5, 'Hours of fun', 'My 7 year old loves building things. Great quality.', TRUE, '2024-06-15 16:45:00'),
(73, 19, 4, 'Good quality', 'Durable and engaging for young children.', TRUE, '2024-09-12 10:00:00'),

-- Kitchen reviews
(31, 11, 5, 'Great knives', 'Sharp and well-balanced. Professional quality at home.', TRUE, '2024-03-08 18:00:00'),
(31, 25, 4, 'Good set', NULL, TRUE, '2024-05-25 17:30:00'),
(32, 11, 5, 'Excellent blender', 'Makes smoothies in seconds. Easy to clean.', TRUE, '2024-03-09 08:00:00'),
(33, 48, 4, 'Good cookware', 'Even heat distribution. Handles stay cool.', TRUE, '2024-10-18 19:00:00'),
(34, 32, 5, 'Love my coffee maker', 'Best coffee I''ve ever made at home.', TRUE, '2024-05-28 07:00:00'),

-- 1-star and 2-star reviews (for filtering exercises)
(45, 58, 1, 'Terrible quality', 'Fell apart after 2 weeks. Waste of money.', FALSE, '2024-09-01 10:00:00'),
(6, 57, 2, 'Disappointing', 'Battery dies in half a day. Expected better.', FALSE, '2024-08-05 11:30:00'),
(1, 56, 2, 'Not worth the hype', 'Overpriced for what you get. Screen has issues.', FALSE, '2024-07-15 14:00:00'),
(3, 55, 1, 'Arrived broken', 'Console was damaged. Had to return.', TRUE, '2024-06-20 09:00:00'),
(2, 50, 2, 'Camera issues', 'Camera stopped working after a month.', TRUE, '2024-03-10 16:00:00'),

-- Reviews without comments (NULL comments for filtering exercises)
(1, 7, 4, 'Good laptop', NULL, TRUE, '2024-02-20 12:00:00'),
(2, 14, 5, 'Excellent', NULL, TRUE, '2024-04-05 10:30:00'),
(3, 33, 4, 'Fun console', NULL, TRUE, '2024-07-25 18:00:00'),
(4, 47, 5, 'Great tablet', NULL, TRUE, '2024-08-18 11:15:00'),
(5, 16, 4, 'Nice headphones', NULL, TRUE, '2024-03-15 15:45:00'),
(6, 44, 5, 'Love it', NULL, TRUE, '2024-10-10 09:00:00'),
(7, 31, 4, 'Good earbuds', NULL, TRUE, '2024-03-25 08:30:00'),
(8, 51, 5, 'Awesome speaker', NULL, TRUE, '2024-09-05 20:00:00')
ON CONFLICT DO NOTHING;
