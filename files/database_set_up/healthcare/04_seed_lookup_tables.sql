-- =====================================================================
-- 04_seed_lookup_tables.sql
-- =====================================================================
-- Populates the three reference / lookup tables created in
-- 02_create_lookup_tables.sql.  Run this AFTER that script and BEFORE
-- the patient-ingestion notebook, because the patients table FK
-- constraints require these rows to exist first.
--
-- Values are sourced directly from profiling the 2000-row CSV:
--   states           -> 10 distinct two-letter state codes
--   insurance_types  -> 4 distinct values
--   conditions       -> 9 named conditions  (CSV value "None" is stored
--                       as NULL on the patients row, NOT as a row here)
-- =====================================================================

USE patient_data;

-- ---------------------------------------------------------------------
-- states
-- We let AUTO_INCREMENT assign the IDs so the order here determines
-- which state_id each code gets.  That's fine -- the notebook looks up
-- IDs by state_code, not by a hard-coded number.
-- ---------------------------------------------------------------------
INSERT INTO states (state_code) VALUES
    ('CA'),
    ('FL'),
    ('GA'),
    ('IL'),
    ('MI'),
    ('NC'),
    ('NY'),
    ('OH'),
    ('PA'),
    ('TX');

-- ---------------------------------------------------------------------
-- insurance_types
-- ---------------------------------------------------------------------
INSERT INTO insurance_types (type_name) VALUES
    ('Medicaid'),
    ('Medicare'),
    ('Private'),
    ('Self-Pay');

-- ---------------------------------------------------------------------
-- conditions
-- Nine named conditions from the CSV.  Patients whose CSV value is
-- "None" will have condition_id = NULL in the patients table -- we do
-- NOT insert a "None" row here because NULL already expresses
-- "no condition on record" and avoids a fake category in aggregations.
-- ---------------------------------------------------------------------
INSERT INTO conditions (condition_name) VALUES
    ('Anxiety'),
    ('Arthritis'),
    ('Asthma'),
    ('COPD'),
    ('Depression'),
    ('Diabetes'),
    ('Heart Disease'),
    ('Hypertension'),
    ('Obesity');
