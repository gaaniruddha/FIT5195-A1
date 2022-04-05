/* task 5 */

/* 5a */
/* Total number of patients in Winter */
/* Clarification - Here, while calculating the total number of patients who have made appointments - I am considering only the patient_service_start_date. */
/* This is because a patient may make an appointment in Autumn and can still be there in the hospital during Winter. */
/* Thus, patients making appointments during Autumn i.e patients with patient_service_start_date in Autumn will be considered as Autumn patients and not Winter patients */
SELECT 
    t.season,
    COUNT(NUMBER_OF_PATIENTS)
FROM
    government_hospital_fact g JOIN time_period_dim t
    ON 
    g.time_id = t.time_id
WHERE
    t.season = 'Winter'
GROUP BY 
    t.season;
    
    
/* 5b */
/* Total service charged for each service cost type. */
SELECT 
    s.service_charge_range AS "SERVICE COST TYPE",
    SUM(total_service_charged) AS "TOTAL SERVICE CHARGED"
FROM 
    government_hospital_fact g JOIN service_dim s
    ON 
    g.service_id = s.service_id
GROUP BY
    s.service_charge_range;
    
/* 5c */
/* total number of patients by each age group in April 2020. */
SELECT 
    COUNT(number_of_patients) AS "TOTAL NUMBER OF PATIENTS",
    a.age_group AS "AGE GROUP"
FROM
    government_hospital_fact g JOIN age_group_dim a
    ON
    g.patient_age = a.patient_age
    JOIN
    time_period_dim t
    ON
    g.time_id = t.time_id
WHERE
    t.month_name = 'April'
    AND
    TO_CHAR(t.year) = '2020'
GROUP BY 
    a.age_group;
    
/* 5d */
/* e total service charged for general medical consultations in each suburb. */
SELECT 
    SUM(total_service_charged) AS "Total Service Charged",
    l.suburb,
    l.postcode
FROM
    government_hospital_fact g JOIN
    service_dim s ON
    g.service_id = s.service_id
    JOIN
    hospital_location_dim l
    ON 
    g.suburb = l.suburb
WHERE
    s.service_name = 'General Medicine'
GROUP BY
    l.suburb,
    l.postcode;
