-- =============================================================================
-- ShopFlow Seed Data - Part 1: Categories & Warehouses
-- =============================================================================

-- =============================================================================
-- Categories (8 main categories)
-- =============================================================================
INSERT INTO categories (name, description, parent_id, is_active) VALUES
('Electronics', 'Electronic devices and accessories', NULL, TRUE),
('Clothing', 'Apparel and fashion items', NULL, TRUE),
('Home & Garden', 'Home decor, furniture, and garden supplies', NULL, TRUE),
('Sports & Outdoors', 'Sporting goods and outdoor equipment', NULL, TRUE),
('Books & Media', 'Books, music, movies, and games', NULL, TRUE),
('Health & Beauty', 'Personal care and wellness products', NULL, TRUE),
('Toys & Games', 'Toys, games, and hobbies', NULL, TRUE),
('Food & Beverages', 'Grocery and gourmet food items', NULL, TRUE)
ON CONFLICT (name) DO NOTHING;

-- Subcategories for Electronics
INSERT INTO categories (name, description, parent_id, is_active) VALUES
('Smartphones', 'Mobile phones and accessories', 1, TRUE),
('Laptops', 'Notebook computers', 1, TRUE),
('Audio', 'Headphones, speakers, and audio equipment', 1, TRUE),
('Cameras', 'Digital cameras and photography', 1, TRUE),
('Wearables', 'Smartwatches and fitness trackers', 1, TRUE)
ON CONFLICT (name) DO NOTHING;

-- Subcategories for Clothing
INSERT INTO categories (name, description, parent_id, is_active) VALUES
('Men''s Clothing', 'Clothing for men', 2, TRUE),
('Women''s Clothing', 'Clothing for women', 2, TRUE),
('Kids'' Clothing', 'Clothing for children', 2, TRUE),
('Shoes', 'Footwear for all', 2, TRUE),
('Accessories', 'Bags, belts, and accessories', 2, TRUE)
ON CONFLICT (name) DO NOTHING;

-- Subcategories for Home & Garden
INSERT INTO categories (name, description, parent_id, is_active) VALUES
('Furniture', 'Home and office furniture', 3, TRUE),
('Kitchen', 'Kitchen appliances and utensils', 3, TRUE),
('Bedding', 'Bedding and linens', 3, TRUE),
('Garden Tools', 'Gardening equipment and supplies', 3, TRUE)
ON CONFLICT (name) DO NOTHING;

-- =============================================================================
-- Warehouses (5 locations)
-- =============================================================================
INSERT INTO warehouses (name, country, city, capacity, is_active) VALUES
('East Coast Hub', 'USA', 'New Jersey', 50000, TRUE),
('West Coast Hub', 'USA', 'California', 45000, TRUE),
('Central Distribution', 'USA', 'Texas', 35000, TRUE),
('European Center', 'Germany', 'Frankfurt', 40000, TRUE),
('Asia Pacific', 'Singapore', 'Singapore', 30000, TRUE)
ON CONFLICT DO NOTHING;
