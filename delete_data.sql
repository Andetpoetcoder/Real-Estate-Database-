/********************************************************************************/
/*	    This file stores delete command for our tables (if necessary)			*/
/********************************************************************************/

USE RealEstate;

-- Delete a contract with ID 1
DELETE FROM contract WHERE property_id = 1;

-- Delete a property with ID 1
DELIMITER //

CREATE PROCEDURE DeleteProperty(IN propertyId INT)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM contract WHERE property_id = propertyId;
    DELETE FROM client_property_interest WHERE property_id = propertyId;
    DELETE FROM property_employee WHERE property_id = propertyId;
    DELETE FROM property_feature WHERE property_id = propertyId;
    DELETE FROM listing WHERE property_id = propertyId;
    DELETE FROM property_employee WHERE property_id = propertyId;
    DELETE FROM client_inspection WHERE inspection_id IN (SELECT id FROM inspection WHERE property_id = propertyId);
    DELETE FROM inspection WHERE property_id = propertyId;
    DELETE FROM offer WHERE property_id = propertyId;
    DELETE FROM property WHERE id = propertyId;
    SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteProperty(1);

-- Delete a property type with ID 1
DELIMITER //

CREATE PROCEDURE DeleteTypeOfProperty(IN propertyTypeId INT)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM contract WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM client_property_interest WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM property_employee WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM property_feature WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM listing WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM property_employee WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM client_inspection WHERE inspection_id IN (SELECT id FROM inspection WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId));
    DELETE FROM inspection WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM offer WHERE property_id IN (SELECT id FROM property WHERE property_type_id = propertyTypeId);
    DELETE FROM property WHERE property_type_id = propertyTypeId;
    DELETE FROM type_of_property WHERE id = propertyTypeId;
    SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteTypeOfProperty(1);

-- Delete a property feature for property with ID 1 and feature with ID 2
DELETE FROM property_feature WHERE property_id = 1 AND feature_id = 2;

-- Delete a feature with ID 1
DELIMITER //

CREATE PROCEDURE DeleteFeature(IN featureId INT)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM property_feature WHERE feature_id = featureId;
    DELETE FROM feature WHERE id = featureId;
    SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteFeature(1);

-- Delete a listing type with ID 1
DELIMITER //

CREATE PROCEDURE DeleteListingType(IN listingTypeId INT)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM contract WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM client_property_interest WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM property_employee WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM property_feature WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM listing WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM property_employee WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM client_inspection WHERE inspection_id IN (SELECT id FROM inspection WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId));
    DELETE FROM inspection WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM offer WHERE property_id IN (SELECT id FROM property WHERE listing_type_id = listingTypeId);
    DELETE FROM property WHERE listing_type_id = listingTypeId;
    DELETE FROM listing WHERE listing_type_id = listingTypeId;
    DELETE FROM contract WHERE listing_type_id = listingTypeId;
    DELETE FROM listing_type WHERE id = listingTypeId;
    SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteListingType(1);

-- Delete a status type with ID 1
DELIMITER //

CREATE PROCEDURE DeleteStatusType(IN statusTypeId INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM contract WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
	DELETE FROM client_property_interest WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
    DELETE FROM property_employee WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
    DELETE FROM property_feature WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
	DELETE FROM listing WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
	DELETE FROM property_employee WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
	DELETE FROM client_inspection WHERE inspection_id IN (SELECT id FROM inspection WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId));
    DELETE FROM inspection WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
	DELETE FROM offer WHERE property_id IN (SELECT id FROM property WHERE property_status_id = statusTypeId);
    DELETE FROM property WHERE property_status_id = statusTypeId;
    DELETE FROM status_type WHERE id = statusTypeId;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteStatusType(1);

-- Delete a listing with ID 1
DELETE FROM listing WHERE id = 1;

-- Delete an employee with ID 1
DELIMITER //

CREATE PROCEDURE DeleteEmployee(IN employeeId INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM client_inspection WHERE inspection_id IN (SELECT id FROM inspection WHERE responsible_employee_id = employeeId);
    DELETE FROM inspection WHERE responsible_employee_id = employeeId;
    DELETE FROM property_employee WHERE employee_id = employeeId;
    DELETE FROM contract WHERE responsible_employee_id = employeeId;
    DELETE FROM employee WHERE id = employeeId;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteEmployee(1);

-- Delete a property employee for property with ID 1 and employee with ID 1
DELETE FROM property_employee WHERE property_id = 1 AND employee_id = 1;

-- Delete a role type with ID 1
DELIMITER //

CREATE PROCEDURE DeleteRoleType(IN roleTypeID INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM property_employee WHERE role_type_id = roleTypeID;
    DELETE FROM role_type WHERE id = roleTypeID;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteRoleType(1);

-- Delete an inspection with ID 1
DELIMITER //

CREATE PROCEDURE DeleteInspection(IN inspectionID INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM client_inspection WHERE inspection_id = inspectionID;
    DELETE FROM inspection WHERE id = inspectionID;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteInspection(1);

-- Delete a client with ID 1
DELIMITER //

CREATE PROCEDURE DeleteClient(IN clientID INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM client_property_interest WHERE client_id = clientID;
    DELETE FROM client_inspection WHERE client_id = clientID;
    DELETE FROM offer WHERE client_id = clientID;
    DELETE FROM contract WHERE client_id = clientID;
    DELETE FROM client WHERE id = clientID;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteClient(1);

-- Delete a client's property interest with client ID 1 and property ID 2
DELETE FROM client_property_interest WHERE client_id = 1 AND property_id = 2;

-- Delete a client's inspection with client ID 1 and inspection ID 2
DELETE FROM client_inspection WHERE client_id = 1 AND inspection_id = 2;

-- Delete an offer with ID 1
DELETE FROM offer WHERE id = 1;

-- Delete an offer status with ID 1
DELIMITER //

CREATE PROCEDURE DeleteOfferStatus(IN oferStatusID INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM offer WHERE offer_status_id = oferStatusID;
    DELETE FROM offer_status WHERE id = oferStatusID;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteOfferStatus(1);

-- Delete a contract with ID 1
DELETE FROM contract WHERE id = 1;

-- Delete a contract status with ID 1
DELIMITER //

CREATE PROCEDURE DeleteContractStatus(IN contractStatusID INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM contract WHERE contract_status_id = contractStatusID;
    DELETE FROM contract_status WHERE id = contractStatusID;
	SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;

CALL DeleteContractStatus(1);