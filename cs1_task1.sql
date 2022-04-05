/* Task 1*/

DROP TABLE Clinic CASCADE CONSTRAINTS;
DROP TABLE Service CASCADE CONSTRAINTS;
DROP TABLE Doctor CASCADE CONSTRAINTS;
DROP TABLE Assignment CASCADE CONSTRAINTS;
DROP TABLE Patient CASCADE CONSTRAINTS;

/* Creating the tables */
CREATE TABLE Clinic
(hospital_id VARCHAR(5) NOT NULL,
hospital_name VARCHAR2(20) NOT NULL,
hospital_address VARCHAR2(50),
suburb VARCHAR2(50),
postcode NUMBER(4)
);

CREATE TABLE Service
(service_id VARCHAR(5) NOT NULL,
staff_id VARCHAR2(20) NOT NULL,
hospital_id VARCHAR(5) NOT NULL,
service_name VARCHAR2(50),
service_cost NUMBER(5)
);

CREATE TABLE Doctor
(staff_id VARCHAR2(20) NOT NULL,
staff_name VARCHAR(20),
staff_ph NUMBER(10)
);

CREATE TABLE Assignment
(assignment_id VARCHAR(5) NOT NULL,
patient_id VARCHAR(10) NOT NULL,
patient_service_start_date DATE NOT NULL,
patient_service_end_date DATE NOT NULL, 
service_id VARCHAR(5) NOT NULL
);

CREATE TABLE Patient
(patient_id VARCHAR(10) NOT NULL,
patient_name VARCHAR2(20) NOT NULL,
patient_age NUMERIC(3,1),
patient_ph_no NUMBER(10),
patient_address VARCHAR2(50),
patient_nationality VARCHAR2(20),
patient_emergency_contact NUMBER(10) NOT NULL
);

/* Adding Primary Keys */
ALTER TABLE Clinic
ADD CONSTRAINT PK_Clinic PRIMARY KEY (hospital_id);

ALTER TABLE Service
ADD CONSTRAINT PK_Service PRIMARY KEY (service_id);

ALTER TABLE Assignment
ADD CONSTRAINT PK_Assignment PRIMARY KEY (assignment_id,service_id,patient_id);

ALTER TABLE Doctor
ADD CONSTRAINT PK_Doctor PRIMARY KEY (staff_id);

ALTER TABLE Patient
ADD CONSTRAINT PK_Patient PRIMARY KEY (patient_id);

/* Adding Foreign Key constraints */
ALTER TABLE Service
ADD FOREIGN KEY (hospital_id) REFERENCES Clinic(hospital_id);

ALTER TABLE Service
ADD FOREIGN KEY (staff_id) REFERENCES Doctor(staff_id);

ALTER TABLE Assignment 
ADD FOREIGN KEY (service_id) REFERENCES Service(service_id);

ALTER TABLE Assignment 
ADD FOREIGN KEY (patient_id) REFERENCES Patient(patient_id);

/* Inserting values into Clinic*/
INSERT INTO Clinic
VALUES ('H1','Clayton Clinic','21 Clayton Road','Clayton',3168);
INSERT INTO Clinic
VALUES ('H2','Caulfield Clinic','22 Caulfield Road','Caulfield',3162);
INSERT INTO Clinic
VALUES ('H3','Carnegie Clinic','23 Carnegie Road','Carnegie',3163);
INSERT INTO Clinic
VALUES ('H4','Oakleigh Clinic','24 Oakleigh Road','Oakleigh',3166);
INSERT INTO Clinic
VALUES ('H5','Westall Clinic','25 Westall Road','Westall',3169);

/* Inserting values into Patient*/
INSERT INTO Patient
VALUES ('P0','Albus Severus Potter',0.5,420452371,'31 Clayton Road, Clayton 3168','Australian',420450001);

INSERT INTO Patient
VALUES ('P1','Harry Potter',11,420452371,'31 Clayton Road, Clayton 3168','Australian',420450001);
INSERT INTO Patient
VALUES ('P2','Hermione Granger',22,420452372,'32 Caulfield Road, Clayton 3162','British',420450002);
INSERT INTO Patient
VALUES ('P3','Ronald Weasley',33,420452373,'33 Carnegie Road, Carnegie 3163','American',420450003);
INSERT INTO Patient
VALUES ('P4','Severus Snape',14,420452374,'34 Oakleigh Road, Oakleigh 3168','Canadian',420450004);
INSERT INTO Patient
VALUES ('P5','Draco Malfoy',25,420452375,'35 Westall Road, Westall 3169','French',420450005);
INSERT INTO Patient
VALUES ('P6','Daniel Radcliffe',31,420452371,'36 Clayton Road, Clayton 3168','Australian',420450001);
INSERT INTO Patient
VALUES ('P7','Emma Watson',12,420452372,'37 Caulfield Road, Clayton 3162','British',420450002);
INSERT INTO Patient
VALUES ('P8','Rupert Grint',23,420452373,'38 Carnegie Road, Carnegie 3163','American',420450003);
INSERT INTO Patient
VALUES ('P9','Alan Rickman',34,420452374,'39 Oakleigh Road, Oakleigh 3168','Canadian',420450004);
INSERT INTO Patient
VALUES ('P10','Tom Felton',15,420452375,'40 Westall Road, Westall 3169','French',420450005);

INSERT INTO Patient
VALUES ('P11','Arthur Weasley',70,420452376,'41 Oakleigh Road, Oakleigh 3168','Canadian',420450006);
INSERT INTO Patient
VALUES ('P12','Molly Weasley',65,420452377,'42 Westall Road, Westall 3169','French',420450007);


/* Inserting values into Doctor*/
INSERT INTO Doctor VALUES ('D1','James Potter',420451000);
INSERT INTO Doctor VALUES ('D2','Lily Evans',420451002);
INSERT INTO Doctor VALUES ('D3','Serius Black',420451003);
INSERT INTO Doctor VALUES ('D4','Remus Lupin',420451004);
INSERT INTO Doctor VALUES ('D5','Albus Dumbledore',420451005);
INSERT INTO Doctor VALUES ('D6','Minerva McGonagall',420451006);
INSERT INTO Doctor VALUES ('D7','Godric Gryffindor',420451007);
INSERT INTO Doctor VALUES ('D8','Salazar Slytherin',420451008);
INSERT INTO Doctor VALUES ('D9','Helga Hufflepuff',420451009);
INSERT INTO Doctor VALUES ('D10','Rowena Ravenclaw',420451010);

/* Inserting values into Service*/
INSERT INTO Service VALUES ('S1','D1','H1','General Medicine',10);
INSERT INTO Service VALUES ('S2','D2','H1','Mental Health',20);
INSERT INTO Service VALUES ('S3','D3','H2','Skin Diseases',30);
INSERT INTO Service VALUES ('S4','D4','H3','Paediatric Health',40);
INSERT INTO Service VALUES ('S5','D5','H3','Sexual Health',50);
INSERT INTO Service VALUES ('S6','D6','H3','Paediatric Health',40);
INSERT INTO Service VALUES ('S7','D7','H4','General Medicine',10);
INSERT INTO Service VALUES ('S8','D8','H4','Mental Health',20);
INSERT INTO Service VALUES ('S9','D9','H5','Skin Diseases',30);
INSERT INTO Service VALUES ('S10','D10','H5','Paediatric Health',40);

/* Inserting values into Assignment */
INSERT INTO Assignment 
VALUES ('A0','P0',TO_DATE('01/04/2020','DD/MM/YYYY'),TO_DATE('01/05/2020','DD/MM/YYYY'),'S1');

INSERT INTO Assignment 
VALUES ('A1','P1',TO_DATE('01/01/2020','DD/MM/YYYY'),TO_DATE('01/02/2020','DD/MM/YYYY'),'S1');
INSERT INTO Assignment 
VALUES ('A2','P2',TO_DATE('02/01/2020','DD/MM/YYYY'),TO_DATE('02/02/2020','DD/MM/YYYY'),'S2');
INSERT INTO Assignment 
VALUES ('A3','P3',TO_DATE('03/02/2020','DD/MM/YYYY'),TO_DATE('03/03/2020','DD/MM/YYYY'),'S3');
INSERT INTO Assignment 
VALUES ('A4','P4',TO_DATE('04/02/2020','DD/MM/YYYY'),TO_DATE('04/03/2020','DD/MM/YYYY'),'S4');
INSERT INTO Assignment 
VALUES ('A5','P5',TO_DATE('05/03/2020','DD/MM/YYYY'),TO_DATE('05/04/2020','DD/MM/YYYY'),'S5');
INSERT INTO Assignment 
VALUES ('A6','P6',TO_DATE('06/03/2020','DD/MM/YYYY'),TO_DATE('06/04/2020','DD/MM/YYYY'),'S6');
INSERT INTO Assignment 
VALUES ('A7','P7',TO_DATE('07/04/2020','DD/MM/YYYY'),TO_DATE('01/05/2020','DD/MM/YYYY'),'S7');
INSERT INTO Assignment 
VALUES ('A8','P8',TO_DATE('08/04/2020','DD/MM/YYYY'),TO_DATE('01/05/2020','DD/MM/YYYY'),'S8');
INSERT INTO Assignment 
VALUES ('A9','P9',TO_DATE('09/04/2020','DD/MM/YYYY'),TO_DATE('01/05/2020','DD/MM/YYYY'),'S9');
INSERT INTO Assignment 
VALUES ('A10','P10',TO_DATE('10/04/2020','DD/MM/YYYY'),TO_DATE('01/05/2020','DD/MM/YYYY'),'S10');

INSERT INTO Assignment 
VALUES ('A11','P11',TO_DATE('11/04/2020','DD/MM/YYYY'),TO_DATE('02/05/2020','DD/MM/YYYY'),'S9');
INSERT INTO Assignment 
VALUES ('A12','P12',TO_DATE('12/04/2020','DD/MM/YYYY'),TO_DATE('02/05/2020','DD/MM/YYYY'),'S10');

commit;


