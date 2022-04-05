/* Task 4 */

DROP TABLE age_group_dim CASCADE CONSTRAINTS PURGE;
DROP TABLE service_dim CASCADE CONSTRAINTS PURGE;
DROP TABLE time_period_dim CASCADE CONSTRAINTS PURGE;
DROP TABLE hospital_location_dim CASCADE CONSTRAINTS PURGE;
DROP TABLE temporary_fact CASCADE CONSTRAINTS PURGE;
DROP TABLE government_hospital_fact CASCADE CONSTRAINTS PURGE;

/* Creating dimension tables */
/* 1) age group dimension */
CREATE TABLE age_group_dim as
SELECT patient_age 
FROM patient;

/* Adding an age group to age_group_dim */
ALTER TABLE age_group_dim
ADD age_group VARCHAR2(50);

UPDATE age_group_dim
SET age_group = 'Infant'
WHERE patient_age < 1;

UPDATE age_group_dim
SET age_group = 'Children'
WHERE patient_age >=1 AND patient_age < 18;

UPDATE age_group_dim
SET age_group = 'Adult'
WHERE patient_age >= 18 AND patient_age < 65;

UPDATE age_group_dim
SET age_group = 'Senior'
WHERE patient_age >= 65;

/* 2) service dimension */
CREATE TABLE service_dim as
SELECT DISTINCT service_id, service_name, service_cost
FROM Service;

/* Adding a service range */

ALTER TABLE service_dim
ADD service_charge_range VARCHAR2(50);

UPDATE service_dim
SET service_charge_range = 'Low Price'
WHERE service_cost < 20;

UPDATE service_dim
SET service_charge_range = 'Medium Price'
WHERE service_cost <=50 AND service_cost >= 20;

UPDATE service_dim
SET service_charge_range = 'High Price'
WHERE service_cost > 50;

/* 3) time period dim */
CREATE TABLE time_period_dim as
SELECT DISTINCT
    TO_CHAR(patient_service_start_date,'MM/YYYY') as time_id,
    TO_CHAR(patient_service_start_date,'MM') as month,
    TO_CHAR(patient_service_start_date,'YYYY') as year
FROM Assignment;

/* Adding month names */
ALTER TABLE time_period_dim
ADD month_name VARCHAR2(50);

UPDATE time_period_dim
SET month_name = 'January'
WHERE to_char(month) = '01';

UPDATE time_period_dim
SET month_name = 'February'
WHERE to_char(month) = '02';

UPDATE time_period_dim
SET month_name = 'March'
WHERE to_char(month) = '03';

UPDATE time_period_dim
SET month_name = 'April'
WHERE to_char(month) = '04';

/* Adding seasons */
ALTER TABLE time_period_dim
ADD season VARCHAR2(50);

UPDATE time_period_dim
SET season = 'Summer'
WHERE time_id LIKE '01%';

UPDATE time_period_dim
SET season = 'Autumn'
WHERE time_id LIKE '02%' OR time_id LIKE '03%';

UPDATE time_period_dim
SET season = 'Winter'
WHERE time_id LIKE '04%' OR time_id = '05%' OR time_id LIKE '06%' OR time_id = '07%';

UPDATE time_period_dim
SET season = 'Spring'
WHERE time_id LIKE '08%' OR time_id = '09%' OR time_id LIKE '10%';

/* 4) hospital_location dimension */
CREATE TABLE hospital_location_dim as
SELECT suburb, postcode
FROM Clinic;

/* Creating a temporary fact tables */
CREATE TABLE temporary_fact as
SELECT DISTINCT
    TO_CHAR(A.patient_service_start_date,'MM/YYYY') as time_id,
    S.service_id, 
    S.service_cost,
    H.hospital_id,
    H.suburb,
    P.patient_id,
    P.patient_age
FROM Service S, Clinic H, Patient P, Assignment A
WHERE 
    H.hospital_id = S.hospital_id AND
    S.service_id = A.service_id AND
    A.patient_id = P.patient_id 
GROUP BY 
    TO_CHAR(A.patient_service_start_date,'MM/YYYY'),
    S.service_id, 
    s.service_cost,
    H.hospital_id, 
    H.suburb,
    P.patient_id,
    P.patient_age;

/* Creating the actual fact table */

CREATE TABLE government_hospital_fact AS
SELECT
    t.time_id,
    t.patient_age,
    t.service_id,
    t.suburb,
    COUNT(t.patient_id) AS "NUMBER_OF_PATIENTS",
    SUM(t.service_cost) AS "TOTAL_SERVICE_CHARGED"
FROM temporary_fact t
GROUP BY
    t.time_id,
    t.patient_age,
    t.service_id,
    t.suburb;

commit;

