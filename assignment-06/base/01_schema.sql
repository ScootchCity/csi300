-- =============================================================================
-- PawCare Veterinary Clinic - Database Schema
-- Assignment 6: Subqueries, CTEs & Views
-- =============================================================================

-- =============================================================================
-- Core Reference Tables
-- =============================================================================

-- Species lookup table
CREATE TABLE IF NOT EXISTS species (
    species_id SERIAL PRIMARY KEY,
    species_name VARCHAR(50) NOT NULL UNIQUE,
    category VARCHAR(30) NOT NULL CHECK (category IN ('mammal', 'bird', 'reptile', 'fish', 'amphibian')),
    avg_lifespan_years INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Clinic locations
CREATE TABLE IF NOT EXISTS clinics (
    clinic_id SERIAL PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20),
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    opens_at TIME NOT NULL DEFAULT '08:00',
    closes_at TIME NOT NULL DEFAULT '18:00',
    is_emergency_center BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- People Tables
-- =============================================================================

-- Pet owners/clients
CREATE TABLE IF NOT EXISTS owners (
    owner_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    preferred_clinic_id INTEGER REFERENCES clinics(clinic_id),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Staff members (vets, technicians, receptionists)
CREATE TABLE IF NOT EXISTS staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    role VARCHAR(30) NOT NULL CHECK (role IN ('veterinarian', 'vet_technician', 'receptionist', 'manager', 'specialist')),
    specialization VARCHAR(100), -- e.g., 'surgery', 'dermatology', 'cardiology'
    license_number VARCHAR(50),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2),
    reports_to INTEGER REFERENCES staff(staff_id),
    clinic_id INTEGER REFERENCES clinics(clinic_id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Pet Tables
-- =============================================================================

-- Pets
CREATE TABLE IF NOT EXISTS pets (
    pet_id SERIAL PRIMARY KEY,
    owner_id INTEGER NOT NULL REFERENCES owners(owner_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    breed VARCHAR(100),
    pet_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'unknown')),
    weight_kg DECIMAL(6, 2),
    color VARCHAR(50),
    is_neutered BOOLEAN DEFAULT FALSE,
    microchip_id VARCHAR(50) UNIQUE,
    allergies TEXT,
    notes TEXT,
    is_deceased BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Medical Tables
-- =============================================================================

-- Vaccines catalog
CREATE TABLE IF NOT EXISTS vaccines (
    vaccine_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100),
    species_id INTEGER REFERENCES species(species_id),
    validity_months INTEGER NOT NULL DEFAULT 12,
    is_core_vaccine BOOLEAN DEFAULT FALSE, -- Required vs optional
    unit_price DECIMAL(8, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Procedures catalog
CREATE TABLE IF NOT EXISTS procedures (
    procedure_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL CHECK (category IN ('examination', 'surgery', 'dental', 'diagnostic', 'grooming', 'preventive', 'emergency')),
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    duration_mins INTEGER DEFAULT 30,
    requires_anesthesia BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medications catalog
CREATE TABLE IF NOT EXISTS medications (
    medication_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    generic_name VARCHAR(100),
    category VARCHAR(50) NOT NULL CHECK (category IN ('antibiotic', 'anti-inflammatory', 'pain_relief', 'antiparasitic', 'cardiac', 'dermatological', 'supplement', 'sedative', 'other')),
    form VARCHAR(30) CHECK (form IN ('tablet', 'capsule', 'liquid', 'injection', 'topical', 'chewable', 'powder', 'gel')),
    unit VARCHAR(20) NOT NULL, -- mg, ml, etc.
    unit_price DECIMAL(8, 2) NOT NULL,
    requires_prescription BOOLEAN DEFAULT TRUE,
    stock_quantity INTEGER DEFAULT 0,
    reorder_level INTEGER DEFAULT 50,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments
CREATE TABLE IF NOT EXISTS appointments (
    appointment_id SERIAL PRIMARY KEY,
    pet_id INTEGER NOT NULL REFERENCES pets(pet_id),
    vet_id INTEGER NOT NULL REFERENCES staff(staff_id),
    clinic_id INTEGER NOT NULL REFERENCES clinics(clinic_id),
    scheduled_at TIMESTAMP NOT NULL,
    duration_mins INTEGER DEFAULT 30,
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'confirmed', 'in_progress', 'completed', 'cancelled', 'no_show')),
    visit_type VARCHAR(30) NOT NULL CHECK (visit_type IN ('wellness', 'sick', 'follow_up', 'surgery', 'emergency', 'vaccination', 'dental', 'grooming')),
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medical records (one per visit)
CREATE TABLE IF NOT EXISTS medical_records (
    record_id SERIAL PRIMARY KEY,
    pet_id INTEGER NOT NULL REFERENCES pets(pet_id),
    vet_id INTEGER NOT NULL REFERENCES staff(staff_id),
    appointment_id INTEGER REFERENCES appointments(appointment_id),
    visit_date DATE NOT NULL,
    chief_complaint TEXT,
    diagnosis TEXT,
    notes TEXT,
    weight_kg DECIMAL(6, 2),
    temperature_f DECIMAL(4, 1),
    heart_rate INTEGER, -- beats per minute
    respiratory_rate INTEGER, -- breaths per minute
    follow_up_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Treatments (procedures and medications given during a visit)
CREATE TABLE IF NOT EXISTS treatments (
    treatment_id SERIAL PRIMARY KEY,
    record_id INTEGER NOT NULL REFERENCES medical_records(record_id),
    procedure_id INTEGER REFERENCES procedures(procedure_id),
    medication_id INTEGER REFERENCES medications(medication_id),
    quantity DECIMAL(8, 2) DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_treatment_type CHECK (
        (procedure_id IS NOT NULL AND medication_id IS NULL) OR
        (procedure_id IS NULL AND medication_id IS NOT NULL)
    )
);

-- Vaccinations administered
CREATE TABLE IF NOT EXISTS vaccinations (
    vaccination_id SERIAL PRIMARY KEY,
    pet_id INTEGER NOT NULL REFERENCES pets(pet_id),
    vaccine_id INTEGER NOT NULL REFERENCES vaccines(vaccine_id),
    administered_by INTEGER NOT NULL REFERENCES staff(staff_id),
    record_id INTEGER REFERENCES medical_records(record_id),
    administered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    next_due_date DATE,
    batch_number VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prescriptions
CREATE TABLE IF NOT EXISTS prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    record_id INTEGER NOT NULL REFERENCES medical_records(record_id),
    medication_id INTEGER NOT NULL REFERENCES medications(medication_id),
    prescribed_by INTEGER NOT NULL REFERENCES staff(staff_id),
    dosage VARCHAR(100) NOT NULL, -- e.g., "10mg twice daily"
    quantity INTEGER NOT NULL,
    refills_allowed INTEGER DEFAULT 0,
    refills_used INTEGER DEFAULT 0,
    instructions TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    is_filled BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Billing Tables
-- =============================================================================

-- Invoices
CREATE TABLE IF NOT EXISTS invoices (
    invoice_id SERIAL PRIMARY KEY,
    owner_id INTEGER NOT NULL REFERENCES owners(owner_id),
    record_id INTEGER REFERENCES medical_records(record_id),
    invoice_number VARCHAR(20) NOT NULL UNIQUE,
    invoice_date DATE NOT NULL DEFAULT CURRENT_DATE,
    subtotal DECIMAL(10, 2) NOT NULL DEFAULT 0,
    tax_rate DECIMAL(4, 2) DEFAULT 0.08,
    tax_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    total DECIMAL(10, 2) NOT NULL DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'partial', 'overdue', 'cancelled', 'refunded')),
    payment_method VARCHAR(30),
    paid_at TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Indexes for Performance
-- =============================================================================

CREATE INDEX IF NOT EXISTS idx_pets_owner ON pets(owner_id);
CREATE INDEX IF NOT EXISTS idx_pets_species ON pets(species_id);
CREATE INDEX IF NOT EXISTS idx_appointments_pet ON appointments(pet_id);
CREATE INDEX IF NOT EXISTS idx_appointments_vet ON appointments(vet_id);
CREATE INDEX IF NOT EXISTS idx_appointments_scheduled ON appointments(scheduled_at);
CREATE INDEX IF NOT EXISTS idx_appointments_status ON appointments(status);
CREATE INDEX IF NOT EXISTS idx_medical_records_pet ON medical_records(pet_id);
CREATE INDEX IF NOT EXISTS idx_medical_records_vet ON medical_records(vet_id);
CREATE INDEX IF NOT EXISTS idx_medical_records_date ON medical_records(visit_date);
CREATE INDEX IF NOT EXISTS idx_treatments_record ON treatments(record_id);
CREATE INDEX IF NOT EXISTS idx_vaccinations_pet ON vaccinations(pet_id);
CREATE INDEX IF NOT EXISTS idx_prescriptions_record ON prescriptions(record_id);
CREATE INDEX IF NOT EXISTS idx_invoices_owner ON invoices(owner_id);
CREATE INDEX IF NOT EXISTS idx_invoices_status ON invoices(status);
CREATE INDEX IF NOT EXISTS idx_staff_reports_to ON staff(reports_to);
CREATE INDEX IF NOT EXISTS idx_staff_clinic ON staff(clinic_id);
