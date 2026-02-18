-- =============================================================================
-- MedCare Health Clinic Database Schema
-- Assignment 5: SQL Joins
-- =============================================================================

-- Create schema
CREATE SCHEMA IF NOT EXISTS medcare;

-- Set search path
SET search_path TO medcare, public;

-- =============================================================================
-- Reference Tables
-- =============================================================================

-- Departments
CREATE TABLE medcare.departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    building VARCHAR(50) NOT NULL,
    floor INTEGER NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    head_doctor_id INTEGER, -- Will be updated after doctors table
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medical Specializations
CREATE TABLE medcare.specializations (
    specialization_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(100) NOT NULL,
    description TEXT,
    requires_certification BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insurance Providers
CREATE TABLE medcare.insurance_providers (
    provider_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    plan_type VARCHAR(50) NOT NULL, -- HMO, PPO, EPO, POS
    coverage_level VARCHAR(20) DEFAULT 'standard', -- basic, standard, premium
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(200),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medications Catalog
CREATE TABLE medcare.medications (
    medication_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    generic_name VARCHAR(200),
    category VARCHAR(100) NOT NULL,
    dosage_form VARCHAR(50) NOT NULL, -- tablet, capsule, liquid, injection
    strength VARCHAR(50),
    manufacturer VARCHAR(100),
    requires_prescription BOOLEAN DEFAULT true,
    controlled_substance BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lab Tests Catalog
CREATE TABLE medcare.lab_tests (
    test_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    code VARCHAR(20) UNIQUE,
    category VARCHAR(100) NOT NULL, -- blood, urine, imaging, etc.
    description TEXT,
    normal_range VARCHAR(100),
    unit VARCHAR(50),
    turnaround_hours INTEGER DEFAULT 24,
    base_cost DECIMAL(10,2) NOT NULL,
    requires_fasting BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Core Tables
-- =============================================================================

-- Doctors
CREATE TABLE medcare.doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    department_id INTEGER REFERENCES medcare.departments(department_id),
    hire_date DATE NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    supervisor_id INTEGER REFERENCES medcare.doctors(doctor_id),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key for department head
ALTER TABLE medcare.departments 
ADD CONSTRAINT fk_department_head 
FOREIGN KEY (head_doctor_id) REFERENCES medcare.doctors(doctor_id);

-- Doctor Specializations (many-to-many)
CREATE TABLE medcare.doctor_specializations (
    doctor_id INTEGER NOT NULL REFERENCES medcare.doctors(doctor_id),
    specialization_id INTEGER NOT NULL REFERENCES medcare.specializations(specialization_id),
    is_primary BOOLEAN DEFAULT false,
    certified_at DATE,
    expires_at DATE,
    PRIMARY KEY (doctor_id, specialization_id)
);

-- Patients
CREATE TABLE medcare.patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20),
    email VARCHAR(100),
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(2) DEFAULT 'VT',
    zip_code VARCHAR(10),
    insurance_id INTEGER REFERENCES medcare.insurance_providers(provider_id),
    policy_number VARCHAR(50),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    blood_type VARCHAR(5),
    allergies TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments
CREATE TABLE medcare.appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES medcare.patients(patient_id),
    doctor_id INTEGER NOT NULL REFERENCES medcare.doctors(doctor_id),
    scheduled_at TIMESTAMP NOT NULL,
    duration_mins INTEGER DEFAULT 30,
    status VARCHAR(20) DEFAULT 'scheduled' 
        CHECK (status IN ('scheduled', 'confirmed', 'in_progress', 'completed', 'cancelled', 'no_show')),
    visit_type VARCHAR(50) NOT NULL 
        CHECK (visit_type IN ('new_patient', 'follow_up', 'annual_physical', 'urgent', 'telehealth', 'procedure')),
    reason TEXT,
    notes TEXT,
    room_number VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Diagnoses
CREATE TABLE medcare.diagnoses (
    diagnosis_id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL REFERENCES medcare.appointments(appointment_id),
    icd_code VARCHAR(20) NOT NULL, -- ICD-10 code
    description VARCHAR(500) NOT NULL,
    severity VARCHAR(20) DEFAULT 'moderate'
        CHECK (severity IN ('mild', 'moderate', 'severe', 'critical')),
    is_primary BOOLEAN DEFAULT false,
    onset_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prescriptions
CREATE TABLE medcare.prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    diagnosis_id INTEGER REFERENCES medcare.diagnoses(diagnosis_id),
    patient_id INTEGER NOT NULL REFERENCES medcare.patients(patient_id),
    doctor_id INTEGER NOT NULL REFERENCES medcare.doctors(doctor_id),
    medication_id INTEGER NOT NULL REFERENCES medcare.medications(medication_id),
    dosage VARCHAR(100) NOT NULL,
    frequency VARCHAR(100) NOT NULL,
    duration_days INTEGER,
    quantity INTEGER NOT NULL,
    refills_allowed INTEGER DEFAULT 0,
    refills_remaining INTEGER DEFAULT 0,
    instructions TEXT,
    prescribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    filled_at TIMESTAMP,
    pharmacy VARCHAR(200),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lab Results
CREATE TABLE medcare.lab_results (
    result_id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES medcare.patients(patient_id),
    test_id INTEGER NOT NULL REFERENCES medcare.lab_tests(test_id),
    doctor_id INTEGER NOT NULL REFERENCES medcare.doctors(doctor_id),
    appointment_id INTEGER REFERENCES medcare.appointments(appointment_id),
    ordered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    collected_at TIMESTAMP,
    resulted_at TIMESTAMP,
    result_value VARCHAR(200),
    is_abnormal BOOLEAN DEFAULT false,
    status VARCHAR(20) DEFAULT 'ordered'
        CHECK (status IN ('ordered', 'collected', 'processing', 'completed', 'cancelled')),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insurance Claims
CREATE TABLE medcare.claims (
    claim_id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES medcare.patients(patient_id),
    appointment_id INTEGER REFERENCES medcare.appointments(appointment_id),
    provider_id INTEGER NOT NULL REFERENCES medcare.insurance_providers(provider_id),
    claim_number VARCHAR(50) UNIQUE,
    amount_billed DECIMAL(10,2) NOT NULL,
    amount_covered DECIMAL(10,2) DEFAULT 0,
    amount_owed DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'submitted'
        CHECK (status IN ('submitted', 'processing', 'approved', 'partial', 'denied', 'paid')),
    filed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP,
    denial_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Indexes
-- =============================================================================

CREATE INDEX idx_doctors_department ON medcare.doctors(department_id);
CREATE INDEX idx_doctors_supervisor ON medcare.doctors(supervisor_id);
CREATE INDEX idx_patients_insurance ON medcare.patients(insurance_id);
CREATE INDEX idx_appointments_patient ON medcare.appointments(patient_id);
CREATE INDEX idx_appointments_doctor ON medcare.appointments(doctor_id);
CREATE INDEX idx_appointments_scheduled ON medcare.appointments(scheduled_at);
CREATE INDEX idx_appointments_status ON medcare.appointments(status);
CREATE INDEX idx_diagnoses_appointment ON medcare.diagnoses(appointment_id);
CREATE INDEX idx_diagnoses_icd ON medcare.diagnoses(icd_code);
CREATE INDEX idx_prescriptions_patient ON medcare.prescriptions(patient_id);
CREATE INDEX idx_prescriptions_doctor ON medcare.prescriptions(doctor_id);
CREATE INDEX idx_lab_results_patient ON medcare.lab_results(patient_id);
CREATE INDEX idx_lab_results_test ON medcare.lab_results(test_id);
CREATE INDEX idx_claims_patient ON medcare.claims(patient_id);
CREATE INDEX idx_claims_status ON medcare.claims(status);
