USE hospital_db;
-- question 1.1
-- from the providers table to retrieve information about all providers.
-- Retrieve the first and last name of the provider and their specialty
SELECT 
    first_name,               -- Provider's first name
    last_name,                -- Provider's last name
    provider_speciality       -- Provider's specialty
FROM 
    providers;

-- question 1.2   
-- This query finds all patients who have visited a provider.
-- It joins the patients, visits, and providers tables using INNER JOIN.
-- Only records with matching patient_id and provider_id will be included in the result.
SELECT 
    p.patient_id,              -- Select patient ID from the patients table
    p.first_name,              -- Select the first name of the patient
    p.last_name,               -- Select the last name of the patient
    pr.provider_speciality     -- Select the provider's specialty from the providers table
FROM 
    patients p                 -- 'p' is an alias for the patients table
INNER JOIN 
    visits v                   -- Join the visits table where patient_id matches
    ON p.patient_id = v.patient_id
INNER JOIN 
    providers pr               -- Join the providers table where provider_id matches
    ON v.provider_id = pr.provider_id;

    
-- question 1.3
-- This query retrieves all patients and their visit details (if any), 
-- including patients who have not had any visits. 
-- It uses a LEFT JOIN to include patients without visits.
SELECT 
    p.patient_id,           -- Select patient ID from the patients table
    p.first_name,           -- Select the first name of the patient
    p.last_name,            -- Select the last name of the patient
    v.date_of_visit         -- Select the date of the visit, if it exists
FROM 
    patients p              -- 'p' is an alias for the patients table
LEFT JOIN 
    visits v                -- Perform a LEFT JOIN with the visits table
    ON p.patient_id = v.patient_id;
    -- Question 1.4
    -- Even if there is no corresponding visit, the patient will still be displayed

   -- This query counts the number of visits each provider has had.
-- It uses a LEFT JOIN to ensure that providers with zero visits are also included in the result.
-- The COUNT() function is used to aggregate the number of visits for each provider.
SELECT 
    CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,  -- Concatenate the provider's first and last name
    COUNT(v.visit_id) AS visit_count  -- Count the number of visits for each provider
FROM 
    providers pr            -- 'pr' is an alias for the providers table
LEFT JOIN 
    visits v                -- Perform a LEFT JOIN with the visits table
    ON pr.provider_id = v.provider_id
GROUP BY 
    pr.first_name,          -- Group by provider's first name
    pr.last_name;           -- Group by provider's last name
-- question 1.5
-- This query retrieves all patients who had visits that required admission.
-- It joins the patients, visits, and admissions tables.
SELECT 
    p.patient_id,           -- Select patient ID from the patients table
    p.first_name,           -- Select the first name of the patient
    p.last_name,            -- Select the last name of the patient
    a.admission_date,       -- Select the admission date from the admissions table
    a.discharge_date        -- Select the discharge date from the admissions table
FROM 
    patients p              -- 'p' is an alias for the patients table
INNER JOIN 
    visits v                -- Join the visits table where patient_id matches
    ON p.patient_id = v.patient_id
INNER JOIN 
    admissions a            -- Join the admissions table where patient_id matches
    ON p.patient_id = a.patient_id;  -- Use patient_id to join with admissions
