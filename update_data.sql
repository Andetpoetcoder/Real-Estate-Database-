/********************************************************************************/
/*	    This file stores update command for our tables (if necessary)			*/
/********************************************************************************/

USE RealEstate;

-- Update multiple columns in the property table for a property with ID 1
UPDATE property
SET 
    price = 160000,
    city = 'New City',
    num_bed = 3,
    num_bath = 2
WHERE
    id = 1;

-- Update description for a property type with ID 1
UPDATE type_of_property SET description = 'Townhouse' WHERE id = 1;

-- Update property feature for a property with ID 1
UPDATE property_feature SET feature_id = 3 WHERE property_id = 1;

-- Update description for a feature with ID 1
UPDATE feature SET feature_description = 'Swimming Pool' WHERE id = 1;

-- Update description for a listing type with ID 1
UPDATE listing_type SET description = 'For Rent' WHERE id = 1;

-- Update description for a status type with ID 1
UPDATE status_type SET description = 'Under Offer' WHERE id = 1;

-- Update multiple columns for a listing with ID 1
UPDATE listing
SET 
    price = 1400000,
    create_date = '2024-01-20'
WHERE
    id = 1;

-- Update job title for an employee with ID 1
UPDATE employee SET job_title = 'Sales Agent' WHERE id = 1;

-- Update role type for an employee working on property with ID 1
UPDATE property_employee SET role_type_id = 3 WHERE property_id = 1 AND employee_id = 1;

-- Update description for a role type with ID 1
UPDATE role_type SET description = 'Sales Specialist' WHERE id = 1;

-- Update responsible employee for an inspection with ID 1
UPDATE inspection SET responsible_employee_id = 3 WHERE id = 1;

-- Update email address for a client with ID 1
UPDATE client SET email_address = 'updatedemail@example.com' WHERE id = 1;

-- Update property interest for a client with ID 1
UPDATE client_property_interest SET property_id = 3 WHERE client_id = 1;

-- Update inspection for a client with ID 1
UPDATE client_inspection SET inspection_id = 3 WHERE client_id = 1;

-- Update offer amount for an offer with ID 1
UPDATE offer SET offer_amount = 150000 WHERE id = 1;

-- Update description for an offer status with ID 1
UPDATE offer_status SET description = 'In Consideration' WHERE id = 1;

-- Update contract document for a contract with ID 1
UPDATE contract SET contract_document = 'Lease Agreement No. 2992' WHERE id = 1;

-- Update description for a contract status with ID 1
UPDATE contract_status SET description = 'Signed' WHERE id = 1;