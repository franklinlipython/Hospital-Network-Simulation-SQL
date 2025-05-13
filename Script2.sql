/*
=====================================================================================
1.4.1 Testing SQL Schema Constraints with INSERT, UPDATE, and DELETE statements
=====================================================================================
*/

/* Information_System Table: PRIMARY KEY, NOT NULL, and CHECK constraint

CREATE TABLE Information_System (
    System_ID VARCHAR(10) PRIMARY KEY,
    Security_Level VARCHAR(20) NOT NULL,
    Permission VARCHAR(20) NOT NULL CHECK (Permission IN ('Restricted', 'Full', 'Partial', 'Limited')),
    Description TEXT NOT NULL
);
*/

-- Below are 3 INSERT, 3 UPDATE, and 3 DELETE commands that test these constraints

INSERT INTO Information_System (System_ID, Security_Level, Permission, Description)
VALUES ('S1', 'High', 'Full', 'System for full-access staff');
/* Failure: Insertion of a tuple containing a primary key value into a table 
in which that primary key value already exists is not possible 
because the values of the primary key of any relation are inherently unique.
*/

INSERT INTO Information_System (System_ID, Security_Level, Permission, Description)
VALUES ('S5', 'Medium', 'Partial', 'System for department heads');
/* Success: Insertion of a primary key value into a relation where that primary key value 
does not already exist ('S5') would result in a success because a primary key is inherently unique  
*/

INSERT INTO Information_System (System_ID, Security_Level, Permission, Description)
VALUES ('S3', NULL, 'Limited', 'Missing security level');
/* Failure: Insertion of an attribute value into a tuple that was designated as NOT NULL 
is not possible due to the violation of the NOT NULL constraint.
*/ 

UPDATE Information_System
SET Permission = 'Open'
WHERE System_ID = 'S2';
/* Failure: Updating an existing attribute value to a value not specified by the Check constraint
violates this Check constraint- Permission can only be 'Restricted', 'Full', 'Partial', or 'Limited' and 
not anything else
*/

UPDATE Information_System
SET Description = NULL
WHERE System_ID = 'V3';
/*
Failure: The value of the attribute Description that corresponds to the tuple where System_ID = 'V2' 
cannot be updated to NULL, since Description was designated as NOT NULL. 
*/

UPDATE Information_System
SET System_ID = 'V2'
WHERE System_ID = 'V1';
/* Failure: The value of primary key cannot be updated to the value of another primary key that already
exists in the relation, since primary key values are inherently unique.
*/  

DELETE FROM Information_System
WHERE System_ID = 'V2';
 /* Failure: Deletion of the tuple (an entire row) where System_ID = 'V2' is not possible
 because the the primary key value 'V2' is already referenced by a foreign key value 
 'V2' in the Volunteer table
*/

DELETE FROM Information_System
WHERE System_ID = 'P3';
 /* Failure: Deletion of the tuple where System_ID = 'P3' from the Information_System table 
 is not possible because the primary key value 'P3' is already referenced by the 
 foreign key value 'P3' in the Patient table (referential integrity constraint).
*/

DELETE FROM Information_System
WHERE System_ID = 'P20';
/* Success: Deletion of the tuple where System_ID = 'P20' would not affect any rows because 'P20' 
does not exist as a value of the attribute System_ID in the Information_System table.
However, the command would still result in a success, because there are technically 
no constraints violated in this case, the syntax of the statement is correct, and 'P20' is not already
referenced by any foreign key value in the Patient table.
*/

/* Medical Record Table: PRIMARY KEY, NOT NULL, UNIQUE, and FOREIGN KEY (referential integrity) constraints

CREATE TABLE Medical_Record (
    Record_ID INT PRIMARY KEY,
    Date_Recorded DATE NOT NULL,
    Patient_ID INT UNIQUE,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
*/

-- Below are commands that test these constraints

INSERT INTO Medical_Record (Record_ID, Date_Recorded, Patient_ID)
VALUES (39, '2025-01-05', 7); 
/* 
Failure: This insertion is not possible because it would violate the uniqueness constraint
enforced for values of the Patient_ID attribute of the Medical_Record relation. Patient ID 7 
already exists in the Medical_Record table so inserting a tuple where patient_ID = 7 would fail.   
*/

INSERT INTO Medical_Record (Record_ID, Date_Recorded, Patient_ID)
VALUES (41, '2025-01-05', 39);
/*
Failure: This insertion is not possible because it would violate the
foreign key (referential integrity) constraint of the medical_Record relation; 
Patient ID 39 does not yet exist in the referenced parent relation (Patient table)
*/

UPDATE Medical_Record
SET Record_ID = NULL
WHERE Patient_ID = '3';
/* Failure: Since Record_ID is the primary key of the Medical_Record table and primary keys cannot have
NULL values, updating record_ID to NULL where Patient_ID = '3' would violate the primary key 
(entity integrity) constraint of the Medical_Record relation.
*/

UPDATE Medical_Record
SET Patient_ID = NULL
WHERE Record_ID = '9';
/*
Success: Patient ID of the Medical_Record relation can be updated to NULL because technically, the 
UNIQUENESS constraint of the Patient_ID attribute does not prevent NULL values from existing
in the Patient_ID column. 
*/

DELETE FROM Medical_Record
WHERE Patient_ID = '4';
/* Failure: Record_ID is the primary key of the Medical_Record relation.
It is not possible to delete a tuple where the value of the primary key (Record_ID = 4 when Patient_ID = 4) is referenced
by the value of the foreign key (Record_ID = 4) of other tuples in the Diagnoses, Treatments, and 
Presrciptions (referencing) relations, since doing so would violate the referential integrity constraint
of the Medical_Record (referenced) relation.

*/

DELETE FROM Medical_Record
WHERE Patient_ID = '52';
/* Success: This command will run successfully but affect 0 rows because it attempts to delete
a tuple that doesn't exist in the first place. There exist no tuples where Patient_ID = '52' and 
where the value of Record_ID (primary key) of the Medical_Record relation is referenced by the 
value of Record_ID (foreign key) of the Diagnoses, Treatments, and Prescriptions relations;
consequently, the referential integrity constraint of the Medical_Record relation would not be violated
upon executing this command.
/*

=====================================================================================
1.4.2 Checking COMPLEX CONSTRAINTS
=====================================================================================
*/

/*
Complaint Table: Non-Deterministic Constraint that may be addressed at the application level 

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

*The below statement is used to insert a tuple where the date_filed is logically impossible -
the date filed cannot be later than the current date. This is so we can develop a SELECT query
that can retrieve complaints where the complex constraint is violated.
*/

INSERT INTO Complaint (Complaint_ID, Patient_ID, Details, Status, Type, Date_Filed)
VALUES (4, 2, 'Complaints about Medication', 'Open', 'Medication Side Effect', '2027-09-14');

/* Success but Logically Impossible:
*Date Filed cannot be later than current date, so application-level check could be enforced to prevent this.
*/

-- The Select Query directly below is used to identify any complaints that violate this complex constraint
 
SELECT Complaint_ID, Patient_ID, Date_Filed, Status, Type, Details 
FROM Complaint 
WHERE Date_Filed > CURDATE();

/*
Sponsors_Projects table: 

CREATE TABLE Sponsors_Project (
	Foundation_ID INT NOT NULL, 
    Project_ID INT NOT NULL, 
    PRIMARY KEY (Foundation_ID, Project_ID),
    FOREIGN KEY (Foundation_ID) REFERENCES Funding_Foundation(Foundation_ID),
    FOREIGN KEY (Project_ID) REFERENCES Research_Project(Project_ID)
);

Minimum participation constraint:
This is a complex constraint that involves verifying whether each Project_ID is associated
with at least one Foundation_ID.

Maximum participation constraint: 
Maximum participation (3 funding foundations) is already enforced by the fact that
Foundation_ID and Project_ID form a primary key and the same project cannot appear in the 
same composite primary key more than 3 times according to the 3 Foundation_ID values that 
are the only existing Foundation_ID values in the Funding_ Foundation table 

So in this case, the only complex constraint that exists pertains to minimum participation.
*/

/* 
The command below tests whether deleting a project_ID from the Sponsors_Project table
will lead to an error. 
*/

DELETE FROM Sponsors_Project
WHERE Project_ID = 10; #currently, project_ID 10 only has one associated Foundation_ID 
/* Success:
This deletion statement is successful but logically impossible because all existing projects
must be associated with at least one funding foundation and currently, there exists only one
funding foundation for project 10. 
*/

-- The below SELECT query searches for projects that do not have any associated funding foundation.

SELECT RP.Project_ID, COUNT(SP.Project_ID) AS Funding_Foundation_Count 
FROM Research_Project AS RP 
LEFT JOIN Sponsors_Project AS SP ON RP.Project_ID = SP.Project_ID 
GROUP BY RP.Project_ID 
HAVING Funding_Foundation_Count < 1;


