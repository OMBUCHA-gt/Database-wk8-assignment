# Clinic Booking System SQL File

-- Drop tables if they already exist to avoid conflicts
DROP TABLE IF EXISTS Appointment_Treatment;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Treatment;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Specialization;

-- Specialization table
CREATE TABLE Specialization (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctor table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
);

-- Patient table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Appointment table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Treatment table
CREATE TABLE Treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    treatment_name VARCHAR(100) NOT NULL UNIQUE,
    cost DECIMAL(10,2) NOT NULL
);

-- Many-to-Many relationship between Appointment and Treatment
CREATE TABLE Appointment_Treatment (
    appointment_id INT,
    treatment_id INT,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatment(treatment_id)
);



# Sample Data Insert SQL 
-- Insert Specializations
INSERT INTO Specialization (name) VALUES
('General Practitioner'),
('Pediatrics'),
('Dermatology'),
('Cardiology');

-- Insert Doctors
INSERT INTO Doctor (full_name, phone_number, email, specialization_id) VALUES
('Dr. John Smith', '0711222333', 'john.smith@example.com', 1),
('Dr. Jane Mwangi', '0722444555', 'jane.mwangi@example.com', 2),
('Dr. Ali Kamau', '0733555666', 'ali.kamau@example.com', 3),
('Dr. Grace Otieno', '0744666777', 'grace.otieno@example.com', 4);

-- Insert Patients
INSERT INTO Patient (full_name, date_of_birth, gender, phone_number, email) VALUES
('Peter Kariuki', '1990-05-12', 'Male', '0799001122', 'peter.kariuki@example.com'),
('Mary Njeri', '1985-09-20', 'Female', '0788112233', 'mary.njeri@example.com'),
('Brian Ouma', '2000-12-01', 'Male', '0777888999', 'brian.ouma@example.com');

-- Insert Appointments
INSERT INTO Appointment (appointment_date, appointment_time, patient_id, doctor_id, notes) VALUES
('2025-05-10', '09:00:00', 1, 1, 'Regular check-up'),
('2025-05-11', '10:30:00', 2, 2, 'Child vaccination'),
('2025-05-12', '14:00:00', 3, 3, 'Skin rash consultation');

-- Insert Treatments
INSERT INTO Treatment (treatment_name, cost) VALUES
('General Checkup', 1000.00),
('Vaccination', 1500.00),
('Skin Cream Prescription', 800.00),
('ECG Test', 2500.00);

-- Link Appointments with Treatments
INSERT INTO Appointment_Treatment (appointment_id, treatment_id) VALUES
(1, 1),  -- Peter had a General Checkup
(2, 2),  -- Mary had a Vaccination
(3, 3),  -- Brian got Skin Cream Prescription
(3, 1);  -- Brian also had a General Checkup
