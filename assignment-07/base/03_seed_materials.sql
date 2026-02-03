-- =============================================================================
-- PrecisionParts Manufacturing - Seed Data: Materials
-- =============================================================================


-- Materials/Raw inventory
INSERT INTO materials (sku, name, type, unit, unit_cost, stock_quantity, reorder_level, lead_time_days, supplier) VALUES
-- Metals
('MTL-AL6061-SH', 'Aluminum 6061-T6 Sheet 0.125"', 'metal', 'sheet', 45.00, 150, 50, 5, 'MetalSource Inc.'),
('MTL-AL6061-RD', 'Aluminum 6061-T6 Rod 1"', 'metal', 'foot', 8.50, 500, 100, 5, 'MetalSource Inc.'),
('MTL-AL7075-SH', 'Aluminum 7075-T6 Sheet 0.25"', 'metal', 'sheet', 85.00, 75, 25, 7, 'MetalSource Inc.'),
('MTL-SS304-SH', 'Stainless Steel 304 Sheet 0.063"', 'metal', 'sheet', 65.00, 100, 30, 7, 'SteelWorks Ltd.'),
('MTL-SS316-RD', 'Stainless Steel 316 Rod 0.5"', 'metal', 'foot', 12.00, 300, 75, 7, 'SteelWorks Ltd.'),
('MTL-TI64-SH', 'Titanium Ti-6Al-4V Sheet 0.125"', 'metal', 'sheet', 250.00, 25, 10, 14, 'Aerospace Metals'),
('MTL-TI64-RD', 'Titanium Ti-6Al-4V Rod 1"', 'metal', 'foot', 95.00, 50, 20, 14, 'Aerospace Metals'),
('MTL-BRASS-RD', 'Brass C360 Rod 0.75"', 'metal', 'foot', 6.50, 200, 50, 5, 'MetalSource Inc.'),
('MTL-STEEL-4140', 'Steel 4140 Bar 2"', 'metal', 'foot', 15.00, 150, 40, 5, 'SteelWorks Ltd.'),
('MTL-COPPER-SH', 'Copper C110 Sheet 0.032"', 'metal', 'sheet', 55.00, 40, 15, 7, 'MetalSource Inc.'),

-- Plastics
('PLS-PEEK-RD', 'PEEK Rod 1"', 'plastic', 'foot', 75.00, 80, 25, 10, 'PolymerPro'),
('PLS-DELRIN-RD', 'Delrin/Acetal Rod 1.5"', 'plastic', 'foot', 12.00, 200, 50, 7, 'PolymerPro'),
('PLS-UHMW-SH', 'UHMW Polyethylene Sheet 0.5"', 'plastic', 'sheet', 35.00, 50, 15, 7, 'PolymerPro'),
('PLS-NYLON-RD', 'Nylon 6/6 Rod 2"', 'plastic', 'foot', 8.00, 150, 40, 5, 'PolymerPro'),
('PLS-PTFE-RD', 'PTFE/Teflon Rod 1"', 'plastic', 'foot', 25.00, 60, 20, 10, 'PolymerPro'),

-- Composites
('CMP-CF-SH', 'Carbon Fiber Sheet 3K 0.125"', 'composite', 'sheet', 180.00, 30, 10, 14, 'CompositeWorld'),
('CMP-GF-SH', 'Fiberglass Sheet G10 0.25"', 'composite', 'sheet', 45.00, 40, 15, 10, 'CompositeWorld'),

-- Fasteners
('FST-SS-M6', 'SS Socket Head Cap Screw M6x20', 'fastener', 'piece', 0.25, 5000, 1000, 3, 'FastenerKing'),
('FST-SS-M8', 'SS Socket Head Cap Screw M8x25', 'fastener', 'piece', 0.35, 4000, 800, 3, 'FastenerKing'),
('FST-SS-M10', 'SS Socket Head Cap Screw M10x30', 'fastener', 'piece', 0.50, 3000, 600, 3, 'FastenerKing'),
('FST-NUT-M6', 'SS Hex Nut M6', 'fastener', 'piece', 0.10, 6000, 1500, 3, 'FastenerKing'),
('FST-NUT-M8', 'SS Hex Nut M8', 'fastener', 'piece', 0.15, 5000, 1000, 3, 'FastenerKing'),
('FST-WASHER-M6', 'SS Flat Washer M6', 'fastener', 'piece', 0.05, 8000, 2000, 3, 'FastenerKing'),

-- Electronics
('ELC-SENSOR-TEMP', 'Temperature Sensor PT100', 'electronic', 'piece', 25.00, 50, 15, 10, 'ElectroParts'),
('ELC-SENSOR-PROX', 'Proximity Sensor 5mm', 'electronic', 'piece', 45.00, 30, 10, 10, 'ElectroParts'),
('ELC-CONNECTOR-4P', 'Circular Connector 4-Pin', 'electronic', 'piece', 8.50, 100, 25, 7, 'ElectroParts'),

-- Consumables & Lubricants
('CON-COOLANT-SYN', 'Synthetic Coolant', 'lubricant', 'gallon', 35.00, 50, 15, 3, 'LubeSupply Co.'),
('CON-OIL-CUT', 'Cutting Oil ISO 68', 'lubricant', 'gallon', 28.00, 40, 12, 3, 'LubeSupply Co.'),
('CON-GREASE-LI', 'Lithium Grease NLGI 2', 'lubricant', 'kg', 15.00, 25, 8, 5, 'LubeSupply Co.'),

-- Adhesives
('ADH-EPOXY-2P', '2-Part Epoxy Structural', 'adhesive', 'piece', 35.00, 30, 10, 7, 'BondMaster'),
('ADH-LOCTITE-242', 'Loctite 242 Threadlocker', 'adhesive', 'piece', 18.00, 20, 8, 5, 'BondMaster'),
('ADH-CYANOACR', 'Cyanoacrylate Instant Adhesive', 'adhesive', 'piece', 12.00, 40, 15, 5, 'BondMaster'),

-- Raw materials
('RAW-SAND-CAST', 'Casting Sand Fine', 'raw_material', 'kg', 2.50, 500, 100, 5, 'FoundrySupplies'),
('RAW-FLUX-WELD', 'Welding Flux', 'raw_material', 'kg', 8.00, 50, 15, 5, 'WeldPro')
ON CONFLICT (sku) DO NOTHING;

-- Soft-delete some materials for testing
UPDATE materials 
SET deleted_at = '2024-08-01 09:00:00' 
WHERE sku = 'RAW-SAND-CAST';

-- Set some materials below reorder level for testing
UPDATE materials SET stock_quantity = 8 WHERE sku = 'MTL-TI64-SH';
UPDATE materials SET stock_quantity = 18 WHERE sku = 'MTL-TI64-RD';
UPDATE materials SET stock_quantity = 12 WHERE sku = 'CMP-CF-SH';
