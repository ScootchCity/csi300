-- =============================================================================
-- PrecisionParts Manufacturing - Schema Definition
-- =============================================================================

-- =============================================================================
-- Core Tables
-- =============================================================================

-- Employees table with soft-delete and role-based access
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    employee_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    role VARCHAR(30) NOT NULL CHECK (role IN (
        'operator', 'supervisor', 'engineer', 'quality_inspector', 
        'maintenance', 'manager', 'admin'
    )),
    department VARCHAR(50) NOT NULL CHECK (department IN (
        'Production', 'Quality Control', 'Engineering', 'Maintenance', 
        'Warehouse', 'Administration', 'Shipping'
    )),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    hourly_rate DECIMAL(8, 2),
    is_active BOOLEAN DEFAULT true,
    deleted_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Materials/Raw inventory with soft-delete
CREATE TABLE materials (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(30) NOT NULL CHECK (type IN (
        'metal', 'plastic', 'composite', 'electronic', 'fastener', 
        'lubricant', 'adhesive', 'raw_material', 'consumable'
    )),
    unit VARCHAR(20) NOT NULL CHECK (unit IN (
        'kg', 'lb', 'meter', 'foot', 'piece', 'liter', 'gallon', 'sheet', 'roll'
    )),
    unit_cost DECIMAL(12, 4) NOT NULL CHECK (unit_cost >= 0),
    stock_quantity DECIMAL(12, 4) NOT NULL DEFAULT 0,
    reorder_level DECIMAL(12, 4) NOT NULL DEFAULT 0,
    lead_time_days INT DEFAULT 7,
    supplier VARCHAR(100),
    deleted_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Parts catalog with soft-delete
CREATE TABLE parts (
    id SERIAL PRIMARY KEY,
    part_number VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(30) NOT NULL CHECK (category IN (
        'aerospace', 'automotive', 'medical', 'industrial', 'electronics', 'prototype'
    )),
    current_version INT NOT NULL DEFAULT 1,
    base_price DECIMAL(12, 2) NOT NULL CHECK (base_price >= 0),
    production_time_mins INT NOT NULL DEFAULT 60,
    requires_certification BOOLEAN DEFAULT false,
    deleted_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Part versions for tracking design changes
CREATE TABLE part_versions (
    id SERIAL PRIMARY KEY,
    part_id INT NOT NULL REFERENCES parts(id),
    version INT NOT NULL,
    specifications JSONB NOT NULL DEFAULT '{}',
    drawing_url VARCHAR(255),
    change_notes TEXT,
    approved_by INT REFERENCES employees(id),
    approved_at TIMESTAMP,
    created_by INT NOT NULL REFERENCES employees(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(part_id, version)
);

-- Bill of materials - what materials are needed for each part
CREATE TABLE part_materials (
    id SERIAL PRIMARY KEY,
    part_id INT NOT NULL REFERENCES parts(id),
    material_id INT NOT NULL REFERENCES materials(id),
    quantity_needed DECIMAL(12, 4) NOT NULL CHECK (quantity_needed > 0),
    notes VARCHAR(255),
    UNIQUE(part_id, material_id)
);

-- Machines/Equipment with soft-delete
CREATE TABLE machines (
    id SERIAL PRIMARY KEY,
    machine_code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(30) NOT NULL CHECK (type IN (
        'cnc_mill', 'cnc_lathe', 'press', 'grinder', 'welder', 
        'laser_cutter', 'assembly_station', '3d_printer', 'inspection'
    )),
    manufacturer VARCHAR(100),
    model VARCHAR(50),
    serial_number VARCHAR(50),
    status VARCHAR(20) NOT NULL DEFAULT 'operational' CHECK (status IN (
        'operational', 'maintenance', 'repair', 'offline', 'retired'
    )),
    location VARCHAR(50),
    hourly_cost DECIMAL(10, 2) DEFAULT 0,
    maintenance_interval_hours INT DEFAULT 500,
    total_run_hours DECIMAL(12, 2) DEFAULT 0,
    last_maintenance_at TIMESTAMP,
    next_maintenance_due TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Production orders (customer orders)
CREATE TABLE production_orders (
    id SERIAL PRIMARY KEY,
    order_number VARCHAR(20) NOT NULL UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    customer_po VARCHAR(50),
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN (
        'pending', 'confirmed', 'in_production', 'quality_check', 
        'completed', 'shipped', 'cancelled'
    )),
    priority VARCHAR(10) NOT NULL DEFAULT 'normal' CHECK (priority IN (
        'low', 'normal', 'high', 'urgent'
    )),
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    shipped_date DATE,
    total_amount DECIMAL(14, 2) DEFAULT 0,
    notes TEXT,
    created_by INT REFERENCES employees(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order line items
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES production_orders(id),
    part_id INT NOT NULL REFERENCES parts(id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(12, 2) NOT NULL CHECK (unit_price >= 0),
    quantity_completed INT DEFAULT 0,
    quantity_rejected INT DEFAULT 0,
    UNIQUE(order_id, part_id)
);

-- Production runs (actual manufacturing batches)
CREATE TABLE production_runs (
    id SERIAL PRIMARY KEY,
    run_number VARCHAR(20) NOT NULL UNIQUE,
    order_id INT NOT NULL REFERENCES production_orders(id),
    order_item_id INT NOT NULL REFERENCES order_items(id),
    machine_id INT NOT NULL REFERENCES machines(id),
    operator_id INT NOT NULL REFERENCES employees(id),
    supervisor_id INT REFERENCES employees(id),
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled' CHECK (status IN (
        'scheduled', 'setup', 'running', 'paused', 'completed', 'aborted'
    )),
    planned_quantity INT NOT NULL CHECK (planned_quantity > 0),
    quantity_produced INT DEFAULT 0,
    quantity_scrapped INT DEFAULT 0,
    scheduled_start TIMESTAMP,
    actual_start TIMESTAMP,
    actual_end TIMESTAMP,
    machine_hours DECIMAL(8, 2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quality control inspections
CREATE TABLE quality_checks (
    id SERIAL PRIMARY KEY,
    run_id INT NOT NULL REFERENCES production_runs(id),
    inspector_id INT NOT NULL REFERENCES employees(id),
    check_type VARCHAR(20) NOT NULL CHECK (check_type IN (
        'in_process', 'final', 'first_article', 'random_sample', 'customer_return'
    )),
    sample_size INT NOT NULL DEFAULT 1,
    result VARCHAR(20) NOT NULL CHECK (result IN (
        'pass', 'fail', 'conditional', 'pending'
    )),
    defects_found INT DEFAULT 0,
    defect_types JSONB DEFAULT '[]',
    measurements JSONB DEFAULT '{}',
    notes TEXT,
    checked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Audit and Logging Tables
-- =============================================================================

-- General audit log for tracking all changes
CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    action VARCHAR(10) NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE', 'RESTORE')),
    old_data JSONB,
    new_data JSONB,
    changed_fields TEXT[],
    performed_by INT REFERENCES employees(id),
    performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address INET,
    session_info JSONB
);

-- Inventory movement log
CREATE TABLE inventory_log (
    id SERIAL PRIMARY KEY,
    material_id INT NOT NULL REFERENCES materials(id),
    change_type VARCHAR(20) NOT NULL CHECK (change_type IN (
        'received', 'consumed', 'adjusted', 'scrapped', 'returned', 'transferred'
    )),
    quantity_change DECIMAL(12, 4) NOT NULL,
    quantity_before DECIMAL(12, 4) NOT NULL,
    quantity_after DECIMAL(12, 4) NOT NULL,
    unit_cost DECIMAL(12, 4),
    reference_type VARCHAR(30),
    reference_id INT,
    reason TEXT,
    performed_by INT REFERENCES employees(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order status history
CREATE TABLE order_status_history (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES production_orders(id),
    old_status VARCHAR(20),
    new_status VARCHAR(20) NOT NULL,
    changed_by INT REFERENCES employees(id),
    change_reason TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Machine maintenance log
CREATE TABLE maintenance_log (
    id SERIAL PRIMARY KEY,
    machine_id INT NOT NULL REFERENCES machines(id),
    maintenance_type VARCHAR(20) NOT NULL CHECK (maintenance_type IN (
        'preventive', 'corrective', 'emergency', 'calibration', 'inspection'
    )),
    description TEXT NOT NULL,
    parts_replaced JSONB DEFAULT '[]',
    labor_hours DECIMAL(6, 2),
    cost DECIMAL(10, 2),
    performed_by INT REFERENCES employees(id),
    completed_at TIMESTAMP,
    next_due_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Indexes for Performance
-- =============================================================================

CREATE INDEX idx_employees_active ON employees(is_active) WHERE deleted_at IS NULL;
CREATE INDEX idx_employees_department ON employees(department);
CREATE INDEX idx_employees_role ON employees(role);

CREATE INDEX idx_materials_type ON materials(type) WHERE deleted_at IS NULL;
CREATE INDEX idx_materials_reorder ON materials(stock_quantity, reorder_level) WHERE deleted_at IS NULL;

CREATE INDEX idx_parts_category ON parts(category) WHERE deleted_at IS NULL;
CREATE INDEX idx_parts_number ON parts(part_number) WHERE deleted_at IS NULL;

CREATE INDEX idx_machines_status ON machines(status) WHERE deleted_at IS NULL;
CREATE INDEX idx_machines_maintenance ON machines(next_maintenance_due);

CREATE INDEX idx_orders_status ON production_orders(status);
CREATE INDEX idx_orders_due_date ON production_orders(due_date);
CREATE INDEX idx_orders_customer ON production_orders(customer_name);

CREATE INDEX idx_runs_status ON production_runs(status);
CREATE INDEX idx_runs_machine ON production_runs(machine_id);
CREATE INDEX idx_runs_operator ON production_runs(operator_id);

CREATE INDEX idx_quality_run ON quality_checks(run_id);
CREATE INDEX idx_quality_result ON quality_checks(result);

CREATE INDEX idx_audit_table ON audit_log(table_name, record_id);
CREATE INDEX idx_audit_time ON audit_log(performed_at);

CREATE INDEX idx_inventory_material ON inventory_log(material_id);
CREATE INDEX idx_inventory_time ON inventory_log(created_at);

-- =============================================================================
-- Views for Common Queries
-- =============================================================================

-- Active employees only (soft-delete aware)
CREATE VIEW active_employees AS
SELECT id, employee_number, first_name, last_name, email, role, department, 
       hire_date, hourly_rate, is_active, created_at
FROM employees
WHERE deleted_at IS NULL AND is_active = true;

-- Active materials only
CREATE VIEW active_materials AS
SELECT id, sku, name, type, unit, unit_cost, stock_quantity, reorder_level,
       lead_time_days, supplier, created_at
FROM materials
WHERE deleted_at IS NULL;

-- Active parts only
CREATE VIEW active_parts AS
SELECT id, part_number, name, description, category, current_version,
       base_price, production_time_mins, requires_certification, created_at
FROM parts
WHERE deleted_at IS NULL;

-- Active machines only
CREATE VIEW active_machines AS
SELECT id, machine_code, name, type, manufacturer, model, status, location,
       hourly_cost, total_run_hours, next_maintenance_due, created_at
FROM machines
WHERE deleted_at IS NULL;

-- Materials that need reordering
CREATE VIEW materials_to_reorder AS
SELECT m.id, m.sku, m.name, m.type, m.unit, m.unit_cost, m.stock_quantity,
       m.reorder_level, m.lead_time_days, m.supplier, m.created_at,
       (m.reorder_level - m.stock_quantity) AS quantity_to_order,
       CURRENT_DATE + m.lead_time_days AS expected_arrival
FROM materials m
WHERE m.deleted_at IS NULL
  AND m.stock_quantity <= m.reorder_level;

-- Open orders summary
CREATE VIEW open_orders_summary AS
SELECT 
    po.id,
    po.order_number,
    po.customer_name,
    po.status,
    po.priority,
    po.due_date,
    po.due_date - CURRENT_DATE AS days_until_due,
    COUNT(oi.id) AS line_items,
    SUM(oi.quantity) AS total_parts_ordered,
    SUM(oi.quantity_completed) AS total_parts_completed,
    ROUND(SUM(oi.quantity_completed)::DECIMAL / NULLIF(SUM(oi.quantity), 0) * 100, 1) AS completion_pct
FROM production_orders po
LEFT JOIN order_items oi ON po.id = oi.order_id
WHERE po.status NOT IN ('completed', 'shipped', 'cancelled')
GROUP BY po.id, po.order_number, po.customer_name, po.status, po.priority, po.due_date;
