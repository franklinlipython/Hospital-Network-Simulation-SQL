/* Note: The user of this script should first create a schema called
University_Health_Network
*/
USE University_Health_Network;

CREATE TABLE Information_System (
    System_ID VARCHAR(10) PRIMARY KEY,
    Security_Level VARCHAR(20) NOT NULL,
    Permission VARCHAR(20) NOT NULL CHECK (Permission IN ('Restricted', 'Full', 'Partial', 'Limited')),
    Description TEXT NOT NULL
);

INSERT INTO Information_System (System_ID, Security_Level, Permission, Description) VALUES
-- Staff Members (Non-research)
('S1', 'High', 'Full', 'Medical staff member with access to full patient data and hospital systems'),
('S2', 'Medium', 'Partial', 'Administrative staff with access to scheduling and internal systems'),

-- Staff Members (Researchers)
('S3', 'High', 'Full', 'Researcher with access to clinical study data and lab systems'),
('S4', 'High', 'Partial', 'Researcher with access to anonymized patient datasets'),

-- Volunteers
('V1', 'Low', 'Limited', 'Volunteer assisting patients with non-clinical support'),
('V2', 'Low', 'Limited', 'Volunteer helping at the front desk and waiting areas'),
('V3', 'Low', 'Limited', 'Volunteer supporting staff during mealtimes'),

-- Patients
('P1', 'Low', 'Restricted', 'Inpatient with access to limited personal health information'),
('P2', 'Low', 'Restricted', 'Outpatient accessing basic appointment and lab result information'),
('P3', 'Low', 'Restricted', 'Emergency room patient with limited access to their visit summary');

CREATE TABLE Staff_Member (
    Staff_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE, -- staff email should be unique
    Position VARCHAR(100) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL UNIQUE,
    Department VARCHAR(100) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    System_ID VARCHAR(10) NOT NULL,
    Date_Recorded DATE NOT NULL,
    FOREIGN KEY (System_ID) REFERENCES Information_System(System_ID)
);

INSERT INTO Staff_Member (
    Staff_ID, First_Name, Last_Name, Email, Position, Phone_Number, Department,
    Date_of_Birth, Gender, System_ID, Date_Recorded
) VALUES
-- Non-Research Staff (System_IDs: S1, S2)
(1, 'Grace', 'Kim', 'grace.kim@hospital.org', 'Physician', '416-555-1001', 'Cardiology', '1981-04-15', 'Female', 'S1', '2025-03-30'),
(2, 'Daniel', 'Smith', 'daniel.smith@hospital.org', 'Admin Coordinator', '416-555-1002', 'Operations', '1985-12-02', 'Male', 'S2', '2025-03-30'),
(3, 'Helen', 'Lopez', 'helen.lopez@hospital.org', 'Nurse', '437-555-1003', 'ICU', '1990-06-21', 'Female', 'S1', '2025-03-30'),
(4, 'Brian', 'Nguyen', 'brian.nguyen@hospital.org', 'Physician', '647-555-1004', 'Neurology', '1978-09-10', 'Male', 'S1', '2025-03-30'),
(5, 'Sarah', 'Adams', 'sarah.adams@hospital.org', 'Medical Assistant', '416-555-1005', 'General Medicine', '1992-01-30', 'Female', 'S2', '2025-03-30'),
(6, 'Leo', 'Martinez', 'leo.martinez@hospital.org', 'Nurse', '647-555-1006', 'Emergency', '1987-11-14', 'Male', 'S2', '2025-03-30'),
(7, 'Monica', 'Peterson', 'monica.peterson@hospital.org', 'Records Officer', '437-555-1007', 'Records', '1984-03-08', 'Female', 'S2', '2025-03-30'),
(8, 'Chris', 'Wright', 'chris.wright@hospital.org', 'Admin Assistant', '416-555-1008', 'HR', '1989-07-01', 'Male', 'S2', '2025-03-30'),
(9, 'Nina', 'Singh', 'nina.singh@hospital.org', 'Physician', '647-555-1009', 'Dermatology', '1982-12-18', 'Female', 'S1', '2025-03-30'),
(10, 'Ethan', 'Brown', 'ethan.brown@hospital.org', 'Nurse', '416-555-1010', 'Surgery', '1991-05-06', 'Male', 'S1', '2025-03-30'),

-- Research Staff (System_IDs: S3, S4)
(11, 'Emily', 'Zhao', 'emily.zhao@hospital.org', 'Researcher', '437-555-1011', 'Clinical Trials', '1990-07-22', 'Female', 'S3', '2025-03-30'),
(12, 'Lucas', 'Moreno', 'lucas.moreno@hospital.org', 'Researcher', '416-555-1012', 'Oncology Research', '1988-03-09', 'Male', 'S3', '2025-03-30'),
(13, 'Olivia', 'Clark', 'olivia.clark@hospital.org', 'Researcher', '647-555-1013', 'Neuroscience Lab', '1993-10-11', 'Female', 'S4', '2025-03-30'),
(14, 'Jack', 'Turner', 'jack.turner@hospital.org', 'Researcher', '437-555-1014', 'Genetics Lab', '1985-02-17', 'Male', 'S4', '2025-03-30'),
(15, 'Ava', 'Brooks', 'ava.brooks@hospital.org', 'Researcher', '416-555-1015', 'Public Health', '1991-08-25', 'Female', 'S3', '2025-03-30'),
(16, 'Noah', 'Diaz', 'noah.diaz@hospital.org', 'Researcher', '647-555-1016', 'Infectious Disease', '1986-11-05', 'Male', 'S4', '2025-03-30'),
(17, 'Sophia', 'Reyes', 'sophia.reyes@hospital.org', 'Researcher', '416-555-1017', 'Pediatric Research', '1994-06-19', 'Female', 'S3', '2025-03-30'),
(18, 'Benjamin', 'Ahmed', 'benjamin.ahmed@hospital.org', 'Researcher', '647-555-1018', 'Bioinformatics', '1983-09-03', 'Male', 'S3', '2025-03-30'),
(19, 'Isabella', 'Green', 'isabella.green@hospital.org', 'Researcher', '416-555-1019', 'Molecular Medicine', '1990-12-07', 'Female', 'S4', '2025-03-30'),
(20, 'William', 'Scott', 'william.scott@hospital.org', 'Researcher', '437-555-1020', 'Data Science', '1987-04-28', 'Male', 'S4', '2025-03-30');

-- Age of the Staff_Member entity is a derived attribute 
-- use of TIMESTAMPDIFF function to compute the difference in years between two dates
SELECT Staff_ID, First_Name, Last_Name, Date_of_Birth, 
TIMESTAMPDIFF(YEAR, Date_of_Birth, CURDATE()) AS Age
FROM Staff_Member;

CREATE TABLE Training_Program (
    Training_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT NOT NULL,
    Period VARCHAR(50) NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Requirement VARCHAR(255) NOT NULL
);

INSERT INTO Training_Program (Training_ID, Name, Description, Period, Type, Requirement)
VALUES
(1, 'Patient Data Privacy', 'Training on handling patient information securely, including HIPAA compliance.', 'Quarterly', 'Compliance', 'Mandatory for all hospital staff'),
(2, 'Basic Life Support (BLS)', 'Covers CPR and emergency response protocols for medical emergencies.', 'Every 2 years', 'Medical', 'Required for all clinical staff'),
(3, 'Workplace Harassment Prevention', 'Education on maintaining a respectful and inclusive workplace.', 'Annually', 'HR', 'Required for all staff'),
(4, 'Infection Control', 'Guidelines for preventing and controlling infections in hospital settings.', 'Semi-Annually', 'Medical', 'Mandatory for all healthcare personnel'),
(5, 'EHR System Training', 'Instruction on using the hospital’s Electronic Health Records system effectively.', 'One-time', 'Technical', 'Required for new staff and system users'),
(6, 'Clinical Trials Ethics', 'Covers ethical considerations in medical research involving human subjects.', 'Annually', 'Research', 'Required for research staff'),
(7, 'Fire Safety and Evacuation', 'Training on fire response, alarm protocols, and building evacuation.', 'Annually', 'Safety', 'All employees must complete'),
(8, 'Medical Device Operation', 'Instruction on safe and effective usage of hospital-grade medical equipment.', 'Annually', 'Technical', 'Required for medical practitioners'),
(9, 'Data Analysis for Researchers', 'Covers basic to intermediate statistical analysis techniques using health data.', 'Bi-Annually', 'Research', 'Required for research analysts and scientists'),
(10, 'Effective Communication', 'Focuses on patient-centered communication and inter-staff collaboration.', 'Annually', 'Soft Skills', 'Recommended for all departments');

CREATE TABLE Attends (
	Training_ID INT NOT NULL,
    Staff_ID INT NOT NULL,
    PRIMARY KEY (Training_ID, Staff_ID),
    FOREIGN KEY (Training_ID) REFERENCES Training_Program(Training_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff_Member(Staff_ID)
);

INSERT INTO Attends (Training_ID, Staff_ID)
VALUES
-- Non-Research Staff attending non-research training
(1, 1),  -- Grace Kim → Patient Data Privacy
(2, 2),  -- Daniel Smith → Basic Life Support
(3, 3),  -- Helen Lopez → Workplace Harassment Prevention
(4, 4),  -- Brian Nguyen → Infection Control
(5, 5),  -- Sarah Adams → EHR System Training

-- Research Staff attending research-based training
(6, 11), -- Emily Zhao → Clinical Trials Ethics
(9, 12), -- Lucas Moreno → Data Analysis for Researchers
(6, 13), -- Olivia Clark → Clinical Trials Ethics
(9, 14), -- Jack Turner → Data Analysis for Researchers
(6, 15); -- Ava Brooks → Clinical Trials Ethics

CREATE TABLE Hospital (
    Hospital_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO Hospital (Hospital_ID, Name, Location)
VALUES
(1, 'Princess Margaret Cancer Centre', '610 University Ave, Toronto, ON M5G 2C4'),
(2, 'Toronto General Hospital', '200 Elizabeth St, Toronto, ON M5G 2C4'),
(3, 'Toronto Rehab', '550 University Ave, Toronto, ON M5G 2A2'),
(4, 'Toronto Western Hospital', '399 Bathurst St, Toronto, ON M5T 2S8');

CREATE TABLE Belongs_To (
	Staff_ID INT NOT NULL,
    Hospital_ID INT NOT NULL,
    PRIMARY KEY (Staff_ID, hospital_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff_Member(Staff_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID)
);

INSERT INTO Belongs_To (Staff_ID, Hospital_ID)
VALUES
-- Princess Margaret Cancer Centre: Oncology, Hematology, Molecular research
(1, 1),   -- Grace Kim (Physician, Cardiology → could support cancer patients with comorbidities)
(11, 1),  -- Emily Zhao (Clinical Trials)
(12, 1),  -- Lucas Moreno (Oncology Research)
(19, 1),  -- Isabella Green (Molecular Medicine)

-- Toronto General Hospital: Internal medicine, Cardiology, Neurology, Research
(2, 2),   -- Daniel Smith (Admin Coordinator)
(4, 2),   -- Brian Nguyen (Neurology)
(5, 2),   -- Sarah Adams (Medical Assistant, General Medicine)
(15, 2),  -- Ava Brooks (Public Health Research)

-- Toronto Rehab: Physical Therapy, Pediatrics, Long-term care
(3, 3),   -- Helen Lopez (ICU Nurse)
(10, 3),  -- Ethan Brown (Surgery Nurse)
(17, 3),  -- Sophia Reyes (Pediatric Research)
(8, 3),   -- Chris Wright (Admin Assistant, HR)

-- Toronto Western Hospital: Emergency, Infectious Disease, Surgery, Neurology
(6, 4),   -- Leo Martinez (Emergency Nurse)
(7, 4),   -- Monica Peterson (Records Officer)
(14, 4),  -- Jack Turner (Genetics Lab)
(16, 4);  -- Noah Diaz (Infectious Disease)

CREATE TABLE Volunteer (
    Volunteer_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    System_ID VARCHAR(10) NOT NULL,
    FOREIGN KEY (System_ID) REFERENCES Information_System(System_ID)
);

INSERT INTO Volunteer (Volunteer_ID, First_Name, Last_Name, Phone_Number, Email, System_ID)
VALUES
(1, 'Liam', 'Taylor', '416-777-2011', 'liam.taylor@volunteer.org', 'V1'),
(2, 'Ava', 'Mitchell', '437-888-2012', 'ava.mitchell@volunteer.org', 'V2'),
(3, 'Noah', 'Campbell', '647-999-2013', 'noah.campbell@volunteer.org', 'V3'),
(4, 'Sophia', 'Edwards', '416-777-2014', 'sophia.edwards@volunteer.org', 'V1'),
(5, 'Mason', 'Bennett', '437-888-2015', 'mason.bennett@volunteer.org', 'V2'),
(6, 'Mia', 'Hughes', '647-999-2016', 'mia.hughes@volunteer.org', 'V3'),
(7, 'Elijah', 'Reed', '416-777-2017', 'elijah.reed@volunteer.org', 'V1'),
(8, 'Isabella', 'Price', '437-888-2018', 'isabella.price@volunteer.org', 'V2'),
(9, 'James', 'Ward', '647-999-2019', 'james.ward@volunteer.org', 'V3'),
(10, 'Charlotte', 'Gray', '416-777-2020', 'charlotte.gray@volunteer.org', 'V1');

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone_Number VARCHAR(20) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    Hospital_ID INT NOT NULL,
    Patient_DOB DATE NOT NULL,
    System_ID VARCHAR(10) NOT NULL,
    FOREIGN KEY (System_ID) REFERENCES Information_System(System_ID)
);

INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Email, Phone_Number, Address, Gender, Hospital_ID, Patient_DOB, System_ID)
VALUES
(1, 'Oliver', 'Johnson', 'oliver.johnson@patientmail.com', '416-789-3011', '15 Esplanade, Toronto, ON', 'Male', 201, '1985-07-14', 'P1'),
(2, 'Amelia', 'Scott', 'amelia.scott@patientmail.com', '647-222-3012', '21 Iceboat Terrace, Toronto, ON', 'Female', 201, '1990-02-28', 'P2'),
(3, 'Ethan', 'Lee', 'ethan.lee@patientmail.com', '437-333-3013', '170 Bayview Ave, Toronto, ON', 'Male', 202, '1978-10-03', 'P3'),
(4, 'Ava', 'Walker', 'ava.walker@patientmail.com', '416-444-3014', '102 Shuter St, Toronto, ON', 'Female', 203, '2000-05-12', 'P1'),
(5, 'Mason', 'King', 'mason.king@patientmail.com', '647-555-3015', '77 Charles St W, Toronto, ON', 'Male', 202, '1995-11-25', 'P2'),
(6, 'Sophia', 'Reed', 'sophia.reed@patientmail.com', '437-666-3016', '35 Lower Jarvis St, Toronto, ON', 'Female', 201, '1988-08-09', 'P3'),
(7, 'Logan', 'Green', 'logan.green@patientmail.com', '416-777-3017', '10 Capreol Crt, Toronto, ON', 'Male', 204, '1976-03-15', 'P1'),
(8, 'Emily', 'Barnes', 'emily.barnes@patientmail.com', '647-888-3018', '33 Bay St, Toronto, ON', 'Female', 202, '1992-12-01', 'P2'),
(9, 'Lucas', 'Hill', 'lucas.hill@patientmail.com', '437-999-3019', '38 Cameron St, Toronto, ON', 'Male', 203, '1983-06-19', 'P3'),
(10, 'Chloe', 'Ward', 'chloe.ward@patientmail.com', '416-321-3020', '130 River St, Toronto, ON', 'Female', 204, '2014-04-02', 'P1');

CREATE TABLE Medical_Record (
    Record_ID INT PRIMARY KEY,
    Date_Recorded DATE NOT NULL,
    Patient_ID INT UNIQUE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

INSERT INTO Medical_Record (Record_ID, Date_Recorded, Patient_ID)
VALUES
(1, '2025-01-05', 1),
(2, '2025-01-12', 2),
(3, '2025-01-20', 3),
(4, '2025-02-01', 4),
(5, '2025-02-10', 5),
(6, '2025-02-15', 6),
(7, '2025-02-22', 7),
(8, '2025-03-01', 8),
(9, '2025-03-08', 9),
(10, '2025-03-15', 10);

CREATE TABLE Diagnoses(
	Record_ID INT NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,
    PRIMARY KEY (Record_ID, Diagnosis),
    FOREIGN KEY (Record_ID) REFERENCES Medical_Record(Record_ID)
);

INSERT INTO Diagnoses (Record_ID, Diagnosis)
VALUES
(1, 'Iron Deficiency Anemia'),
(1, 'Gastroesophageal Reflux Disease'),
(2, 'Osteoarthritis'),
(2, 'Vitamin D Deficiency'),
(2, 'Tension Headache'),
(3, 'Urinary Tract Infection'),
(3, 'Allergic Rhinitis'),
(4, 'Sciatica'),
(5, 'Panic Disorder'),
(6, 'Hypothyroidism');

CREATE TABLE Treatments(
	Record_ID INT NOT NULL,
    Treatment VARCHAR(255) NOT NULL,
    PRIMARY KEY (Record_ID, Treatment),
    FOREIGN KEY (Record_ID) REFERENCES Medical_Record(Record_ID)
);

INSERT INTO Treatments (Record_ID, Treatment)
VALUES
(1, 'Iron supplement therapy'),
(1, 'Proton pump inhibitor treatment'),
(2, 'NSAID regimen'),
(2, 'Vitamin D supplementation'),
(2, 'Muscle relaxation exercises'),
(3, 'Antibiotic course'),
(3, 'Antihistamine regimen'),
(4, 'Physical therapy for lower back pain'),
(5, 'Cognitive Behavioral Therapy'),
(6, 'Levothyroxine hormone replacement');

CREATE TABLE Prescriptions(
	Record_ID INT NOT NULL,
    Prescription varchar(255) NOT NULL,
    PRIMARY KEY (Record_ID, Prescription),
    FOREIGN KEY (Record_ID) REFERENCES Medical_Record(Record_ID)
);

INSERT INTO Prescriptions (Record_ID, Prescription)
VALUES
(1, 'Ferrous sulfate 325mg daily'),
(1, 'Omeprazole 20mg daily before meals'),
(2, 'Ibuprofen 400mg as needed'),
(2, 'Vitamin D3 2000 IU daily'),
(2, 'Cyclobenzaprine 5mg at bedtime'),
(3, 'Nitrofurantoin 100mg twice daily'),
(3, 'Cetirizine 10mg daily'),
(4, 'Referral to physical therapy for sciatica relief'),
(5, 'Sertraline 25mg daily'),
(6, 'Levothyroxine 75mcg daily');

CREATE TABLE Receives_Care_At (
	Patient_ID INT NOT NULL,
    Hospital_ID INT NOT NULL,
    PRIMARY KEY (Patient_ID, Hospital_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID)
);

INSERT INTO Receives_Care_At (Patient_ID, Hospital_ID)
VALUES
(1, 1),  -- Iron Deficiency Anemia → Hematology support at Princess Margaret
(2, 2),  -- Osteoarthritis, Tension Headache → Neurology + General Medicine at Toronto General
(3, 4),  -- UTI & Allergic Rhinitis → Emergency & Immunology at Toronto Western
(4, 3),  -- Sciatica → Physical Therapy at Toronto Rehab
(5, 2),  -- Panic Disorder → Psychiatry/Public Health support at Toronto General
(6, 4),  -- Hypothyroidism → Emergency/General support at Toronto Western
(7, 3),  -- Older patient → Long-term care rehab (age-based) at Toronto Rehab
(8, 2),  -- Common treatment needs → General access at Toronto General
(9, 4),  -- Complex allergies & chronic condition support at Toronto Western
(10, 3); -- Pediatric patient → Pediatric Research staff at Toronto Rehab

CREATE TABLE Complaint (
    Complaint_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    Details TEXT NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Open', 'In Review', 'Resolved', 'Closed')),
    Type VARCHAR(100) NOT NULL,
    Date_Filed DATE NOT NULL,
    PRIMARY KEY (Complaint_ID, Patient_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

INSERT INTO Complaint (Complaint_ID, Patient_ID, Details, Status, Type, Date_Filed)
VALUES
-- Patient 1 (Diagnosis: Iron Deficiency Anemia, GERD)
(1, 1, 'Iron supplements caused stomach upset and nausea.', 'Open', 'Medication Side Effect', '2025-03-01'),
(2, 1, 'Omeprazole not relieving reflux symptoms effectively.', 'In Review', 'Medication Ineffectiveness', '2025-03-03'),

-- Patient 2 (Diagnosis: Osteoarthritis, Vitamin D Deficiency, Tension Headache)
(1, 2, 'Joint pain persists despite regular NSAID use.', 'In Review', 'Treatment Ineffectiveness', '2025-03-04'),
(2, 2, 'Vitamin D supplements caused mild allergic reaction.', 'Resolved', 'Medication Reaction', '2025-03-06'),
(3, 2, 'Headaches worsened after starting new muscle relaxant.', 'Open', 'Medication Side Effect', '2025-03-08'),

-- Patient 3 (Diagnosis: Urinary Tract Infection, Allergic Rhinitis)
(1, 3, 'Antibiotics caused nausea and dizziness.', 'Resolved', 'Medication Reaction', '2025-03-05'),
(2, 3, 'Allergy symptoms not improving with current treatment.', 'In Review', 'Ineffective Treatment', '2025-03-07'),

-- Patient 4 (Diagnosis: Sciatica)
(1, 4, 'No improvement after 3 physical therapy sessions.', 'Open', 'Treatment Ineffectiveness', '2025-03-09'),

-- Patient 5 (Diagnosis: Panic Disorder)
(1, 5, 'CBT sessions are too short to be helpful.', 'In Review', 'Therapy Concern', '2025-03-10'),

-- Patient 6 (Diagnosis: Hypothyroidism)
(1, 6, 'Levothyroxine dosage may be too low — symptoms persist.', 'Open', 'Medication Adjustment Request', '2025-03-11');

CREATE TABLE Healthcare_Provider (
    Provider_ID INT PRIMARY KEY,
    Provider_Type VARCHAR(50) NOT NULL, 
    License_Number VARCHAR(50) NOT NULL UNIQUE,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL
);

INSERT INTO Healthcare_Provider (Provider_ID, Provider_Type, License_Number, First_Name, Last_Name, Phone_Number, Email, Address)
VALUES
(1, 'Physician', 'LIC-202601', 'Lena', 'Morris', '555-5001', 'lena.morris@hospital.org', '600 University Ave, Toronto, ON'),
(2, 'Physician', 'LIC-202602', 'Omar', 'Delgado', '555-5002', 'omar.delgado@hospital.org', '200 Elizabeth St, Toronto, ON'),
(3, 'Nurse', 'LIC-202603', 'Ava', 'Thompson', '555-5003', 'ava.thompson@hospital.org', '399 Bathurst St, Toronto, ON'),
(4, 'Physician Assistant', 'LIC-202604', 'Ravi', 'Shah', '555-5004', 'ravi.shah@hospital.org', '101 College St, Toronto, ON'),
(5, 'Physician', 'LIC-202605', 'Elena', 'Park', '555-5005', 'elena.park@hospital.org', '700 Bay St, Toronto, ON'),
(6, 'Nurse', 'LIC-202606', 'Marcus', 'Lee', '555-5006', 'marcus.lee@hospital.org', '585 University Ave, Toronto, ON'),
(7, 'Physician', 'LIC-202607', 'Claire', 'Osei', '555-5007', 'claire.osei@hospital.org', '399 Yonge St, Toronto, ON'),
(8, 'Physician Assistant', 'LIC-202608', 'Jonah', 'Bennett', '555-5008', 'jonah.bennett@hospital.org', '120 Carlton St, Toronto, ON'),
(9, 'Physician', 'LIC-202609', 'Natalie', 'Young', '555-5009', 'natalie.young@hospital.org', '77 Gerrard St W, Toronto, ON'),
(10, 'Nurse', 'LIC-202610', 'Samira', 'Khan', '555-5010', 'samira.khan@hospital.org', '250 Dundas St W, Toronto, ON');

CREATE TABLE Cooperates_With (
	Hospital_ID INT NOT NULL,
    Provider_ID INT NOT NULL,
    PRIMARY KEY (Hospital_ID, Provider_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID),
    FOREIGN KEY (Provider_ID) REFERENCES Healthcare_Provider(Provider_ID)
);

INSERT INTO Cooperates_With (Hospital_ID, Provider_ID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8),
(4, 9),
(4, 10);

CREATE TABLE Provider_Specialties (
	Provider_ID INT NOT NULL,
    Provider_Specialty VARCHAR(255) NOT NULL,
    PRIMARY KEY (Provider_ID, Provider_Specialty),
    FOREIGN KEY (Provider_ID) REFERENCES Healthcare_Provider(Provider_ID)
);

INSERT INTO Provider_Specialties (Provider_ID, Provider_Specialty)
VALUES
(1, 'Hematology'),                       -- Iron Deficiency Anemia
(2, 'Gastroenterology'),                 -- GERD
(3, 'Critical Care Nursing'),            -- Urinary Tract Infection
(4, 'Surgical Assistance'),              -- Sciatica
(5, 'Neurology'),                        -- Tension Headache
(6, 'Emergency Nursing'),                -- Vitamin D Deficiency / Hypothyroidism
(7, 'Allergy and Immunology'),           -- Allergic Rhinitis
(8, 'Orthopedic Surgery Assistance'),    -- Osteoarthritis
(9, 'Psychiatry'),                       -- Panic Disorder
(10, 'Pediatric Nursing');               -- Hypothyroidism (in pediatric case)

-- Researcher is a subclass of Staff_Member so the former should have Staff_ID as its primary key
CREATE TABLE Researcher (
    Staff_ID INT PRIMARY KEY,
    Researcher_Type VARCHAR(50) NOT NULL,
    Educational_Background TEXT NOT NULL
);

INSERT INTO Researcher (Staff_ID, Researcher_Type, Educational_Background)
VALUES
(11, 'Clinical Researcher', 'PhD in Pharmacology'),
(12, 'Cancer Researcher', 'MD, MSc in Oncology'),
(13, 'Neuroscientist', 'PhD in Neuroscience'),
(14, 'Geneticist', 'PhD in Molecular Genetics'),
(15, 'Public Health Researcher', 'MPH'),
(16, 'Infectious Disease Specialist', 'MD, PhD in Microbiology'),
(17, 'Pediatric Researcher', 'PhD in Pediatric Medicine'),
(18, 'Bioinformatician', 'PhD in Computational Biology'),
(19, 'Molecular Biologist', 'PhD in Molecular Medicine'),
(20, 'Data Scientist', 'PhD in Health Data Science');

CREATE TABLE Fields_of_Research(
	Staff_ID INT NOT NULL,
    Field_of_Research VARCHAR(255) NOT NULL,
    PRIMARY KEY (Staff_ID, Field_of_Research),
    FOREIGN KEY (Staff_ID) REFERENCES Researcher(Staff_ID)
);

INSERT INTO Fields_of_Research (Staff_ID, Field_of_Research)
VALUES
(11, 'Pharmacological Interventions in Clinical Trials'),
(12, 'Cancer Therapeutics and Drug Resistance'),
(13, 'Neuroplasticity and Brain Disorders'),
(14, 'Gene Editing and Inherited Disorders'),
(15, 'Epidemiology and Public Health Policy'),
(16, 'Antimicrobial Resistance and Emerging Pathogens'),
(17, 'Childhood Development and Pediatric Diseases'),
(18, 'Genomic Data Analysis and Computational Biology'),
(19, 'Cellular Mechanisms in Molecular Medicine'),
(20, 'Machine Learning in Healthcare Analytics');

CREATE TABLE Research_Project (
    Project_ID INT PRIMARY KEY,
    Description TEXT NOT NULL,
    Status VARCHAR(20) NOT NULL
);

INSERT INTO Research_Project (Project_ID, Description, Status)
VALUES
(1, 'Evaluating the efficacy of novel pharmacological interventions in chronic disease management.', 'Ongoing'),
(2, 'Developing next-generation cancer therapies targeting drug-resistant tumors.', 'Ongoing'),
(3, 'Investigating brain plasticity in neurodegenerative disorders.', 'Completed'),
(4, 'CRISPR-based gene editing for rare inherited genetic conditions.', 'Ongoing'),
(5, 'Assessing the impact of public health policies on urban populations.', 'Ongoing'),
(6, 'Tracking antimicrobial resistance in hospital-acquired infections.', 'Ongoing'),
(7, 'Longitudinal study on pediatric developmental milestones and health outcomes.', 'Completed'),
(8, 'Applying AI to analyze high-throughput genomic data in rare diseases.', 'Ongoing'),
(9, 'Studying molecular pathways in cardiovascular and metabolic diseases.', 'Ongoing'),
(10, 'Predictive modeling for hospital readmission rates using machine learning.', 'Ongoing');

CREATE TABLE Conducts (
	Staff_ID INT NOT NULL,
    Project_ID INT NOT NULL,
    PRIMARY KEY (Staff_ID, Project_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Researcher(Staff_ID),
    FOREIGN KEY(Project_ID) REFERENCES Research_Project(Project_ID)
);

INSERT INTO Conducts (Staff_ID, Project_ID)
VALUES
(11, 1),  -- Clinical Researcher on pharmacological interventions
(12, 2),  -- Cancer Researcher on drug-resistant tumors
(13, 3),  -- Neuroscientist on neuroplasticity
(14, 4),  -- Geneticist on CRISPR gene editing
(15, 5),  -- Public Health Researcher on policy impact
(16, 6),  -- Infectious Disease Specialist on AMR
(17, 7),  -- Pediatric Researcher on child development
(18, 8),  -- Bioinformatician on genomic data
(19, 9),  -- Molecular Biologist on molecular pathways
(20, 10); -- Data Scientist on predictive modeling

CREATE TABLE Publication (
    Publication_ID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL UNIQUE,
    Journal_Name VARCHAR(255) NOT NULL,
    Date_Published DATE NOT NULL
);

INSERT INTO Publication (Publication_ID, Title, Journal_Name, Date_Published)
VALUES
(1, 'A Randomized Trial of Dual Pharmacologic Agents for Hypertension in Elderly Patients', 'Journal of Clinical Pharmacology', '2024-11-15'),
(2, 'Targeting EGFR Pathways to Overcome Chemotherapy Resistance in Triple-Negative Breast Cancer', 'Cancer Research', '2024-12-05'),
(3, 'Functional MRI Analysis of Neuroplastic Changes in Early-Stage Alzheimer\'s Disease', 'Journal of Neuroscience', '2024-10-20'),
(4, 'CRISPR-Mediated Correction of CFTR Mutations in Cystic Fibrosis Cell Models', 'Molecular Genetics and Genomics', '2025-01-12'),
(5, 'Evaluating the Impact of Mask Mandates on Urban Respiratory Health Outcomes', 'Public Health Reports', '2025-02-01'),
(6, 'Multi-Drug Resistance Trends in Gram-Negative Bacteria in ICU Patients: A 5-Year Study', 'Infectious Disease Journal', '2024-09-30'),
(7, 'Cognitive and Physical Developmental Delays in Preterm Infants: A Longitudinal Study', 'Pediatrics Today', '2024-08-25'),
(8, 'AI-Driven Genomic Feature Selection for Rare Disease Variant Discovery', 'Bioinformatics & Systems Biology', '2025-03-05'),
(9, 'Molecular Regulation of Insulin Sensitivity in Obese Individuals with Cardiovascular Risk', 'Journal of Molecular Medicine', '2024-11-01'),
(10, 'Predictive Modeling of 30-Day Hospital Readmissions Using EHR-Based Machine Learning', 'Healthcare Data Science Journal', '2025-03-10');

CREATE TABLE Publish (
		Project_ID INT NOT NULL,
        Publication_ID INT NOT NULL,
        PRIMARY KEY (Project_ID, Publication_ID),
        FOREIGN KEY (Project_ID) REFERENCES Research_Project(Project_ID),
        FOREIGN KEY (Publication_ID) REFERENCES Publication(Publication_ID)
);

INSERT INTO Publish (Project_ID, Publication_ID)
VALUES
(1, 1),  -- Pharmacologic trial for chronic disease
(2, 2),  -- Cancer therapy & drug resistance
(3, 3),  -- Neuroplasticity in Alzheimer’s
(4, 4),  -- CRISPR for genetic disorders
(5, 5),  -- Public health policy analysis
(6, 6),  -- Antimicrobial resistance trends
(7, 7),  -- Pediatric development study
(8, 8),  -- Genomic analysis with AI
(9, 9),  -- Molecular mechanisms in disease
(10, 10); -- Predictive modeling for readmission

CREATE TABLE Funding_Foundation (
    Foundation_ID INT PRIMARY KEY CHECK (Foundation_ID IN (1, 2, 3)),
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT NOT NULL
);

INSERT INTO Funding_Foundation (Foundation_ID, Name, Description)
VALUES
(1, 'Princess Margaret Cancer Foundation', 'Cancer research and patient care fundraising'),
(2, 'UHN Foundation', 'Hospital network fundraising and research support'),
(3, 'West Park Foundation', 'Rehabilitation and patient recovery support');

CREATE TABLE Foundation_Event (
    Event_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Date DATE NOT NULL,
    Location VARCHAR(255) NOT NULL
);

INSERT INTO Foundation_Event (Event_ID, Name, Date, Location)
VALUES
(1, 'Princess Margaret Walk to Conquer Cancer', '2025-05-11', 'Downtown Toronto, ON'),
(2, 'UHN Gala for Health Innovation', '2025-06-20', 'Fairmont Royal York, Toronto, ON'),
(3, 'West Park Rehabilitation Research Forum', '2025-04-15', 'West Park Healthcare Centre, Toronto, ON'),
(4, 'Princess Margaret Ride to Conquer Cancer', '2025-08-09', 'Exhibition Place, Toronto, ON'),
(5, 'UHN Foundation Research & Discovery Night', '2025-10-05', 'MaRS Discovery District, Toronto, ON'),
(6, 'West Park Foundation Donor Appreciation Event', '2025-09-17', 'Old Mill Toronto, Etobicoke, ON'),
(7, 'Princess Margaret Cancer Research Symposium', '2025-11-03', 'Princess Margaret Cancer Centre, Toronto, ON'),
(8, 'UHN Foundation Innovation Luncheon', '2025-03-21', 'The Globe and Mail Centre, Toronto, ON'),
(9, 'West Park Wellness Expo', '2025-07-12', 'Sheridan College, Mississauga, ON'),
(10, 'Princess Margaret Legacy Circle Reception', '2025-12-01', 'Artscape Daniels Launchpad, Toronto, ON');

CREATE TABLE Holds (
	Event_ID INT NOT NULL,
    Foundation_ID INT NOT NULL,
    PRIMARY KEY (Event_ID, Foundation_ID),
    FOREIGN KEY (Event_ID) REFERENCES Foundation_Event(Event_ID),
    FOREIGN KEY (Foundation_ID) REFERENCES Funding_Foundation(Foundation_ID)
);

INSERT INTO Holds (Event_ID, Foundation_ID)
VALUES
(1, 1),  -- Walk to Conquer Cancer – Princess Margaret
(2, 2),  -- UHN Gala – UHN Foundation
(3, 3),  -- Rehab Forum – West Park Foundation
(4, 1),  -- Ride to Conquer Cancer – Princess Margaret
(5, 2),  -- Research & Discovery Night – UHN
(6, 3),  -- Donor Appreciation – West Park
(7, 1),  -- Cancer Research Symposium – Princess Margaret
(8, 2),  -- Innovation Luncheon – UHN
(9, 3),  -- Wellness Expo – West Park
(10, 1); -- Legacy Circle Reception – Princess Margaret

CREATE TABLE Sponsors_Researcher (
	Staff_ID INT NOT NULL,
    Foundation_ID INT NOT NULL,
    PRIMARY KEY (Staff_ID, Foundation_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Researcher(Staff_ID),
    FOREIGN KEY (Foundation_ID) REFERENCES Funding_Foundation(Foundation_ID)
);

INSERT INTO Sponsors_Researcher (Staff_ID, Foundation_ID) 
VALUES
-- Sponsored by Princess Margaret Cancer Foundation (Cancer research & molecular medicine)
(12, 1),  -- Cancer Researcher (focuses on drug-resistant tumors)
(14, 1),  -- Geneticist (CRISPR research applicable to cancer treatment)
(18, 1),  -- Bioinformatician (supports cancer genomics through data analysis)
(19, 1),  -- Molecular Biologist (studies cellular mechanisms related to cancer and chronic disease)

-- Sponsored by UHN Foundation (General medical research, data science, public health)
(11, 2),  -- Clinical Researcher (broad clinical trials across chronic conditions)
(13, 2),  -- Neuroscientist (supports brain research within hospital network)
(15, 2),  -- Public Health Researcher (evaluates policy impact on population health)
(20, 2),  -- Data Scientist (develops predictive analytics for hospital outcomes)

-- Sponsored by West Park Foundation (Rehabilitation, long-term care, infectious diseases)
(16, 3),  -- Infectious Disease Specialist (examines hospital-acquired infections relevant to rehab patients)
(17, 3);  -- Pediatric Researcher (studies developmental delays requiring rehabilitation)

CREATE TABLE Sponsors_Project (
	Foundation_ID INT NOT NULL, 
    Project_ID INT NOT NULL, 
    PRIMARY KEY (Foundation_ID, Project_ID),
    FOREIGN KEY (Foundation_ID) REFERENCES Funding_Foundation(Foundation_ID),
    FOREIGN KEY (Project_ID) REFERENCES Research_Project(Project_ID)
);

INSERT INTO Sponsors_Project (Foundation_ID, Project_ID)
VALUES
-- Princess Margaret Cancer Foundation (cancer & advanced research)
(1, 2),  -- Drug resistance in cancer
(1, 4),  -- CRISPR for genetic disorders
(1, 8),  -- AI in genomics (relevant to cancer genomics)
(1, 9),  -- Molecular medicine in metabolic/cancer overlap

-- UHN Foundation (broad hospital network support)
(2, 1),  -- Pharmacologic interventions
(2, 3),  -- Alzheimer’s neuroplasticity
(2, 5),  -- Public health policy impact
(2, 10), -- Predictive modeling for hospital readmission

-- West Park Foundation (rehabilitation and patient recovery)
(3, 6),  -- Antimicrobial resistance (relevant to rehab care)
(3, 7);  -- Pediatric development and long-term outcomes
