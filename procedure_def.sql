/********************************************************************************/
/*	    This file defines all stored procedures for our database 				*/
/********************************************************************************/

USE RealEstate;

-- Get Property Count by Listing Type
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertyCountByListingType;
CREATE PROCEDURE GetPropertyCountByListingType()
BEGIN
	SELECT LT.`description` AS `Listing Type`, COUNT(*) AS `Total Property`
	FROM PROPERTY AS P 
	LEFT JOIN LISTING AS L ON P.id = L.property_id
	JOIN LISTING_TYPE AS LT ON L.listing_type_id = LT.id
	GROUP BY LT.id;
END//
DELIMITER ;

-- Get Total Rent Value
DELIMITER //
DROP PROCEDURE IF EXISTS GetTotalRent;
CREATE PROCEDURE GetTotalRent()
BEGIN
	SELECT SUM(price) AS `Total Rent`
	FROM CONTRACT
	WHERE listing_type_id IN (SELECT id FROM LISTING_TYPE WHERE DESCRIPTION = "For Rent")
	AND end_date > CURDATE();
END//
DELIMITER ;

-- Get Total Asset Value
DELIMITER //
DROP PROCEDURE IF EXISTS GetTotalAsset;
CREATE PROCEDURE GetTotalAsset()
BEGIN
	SELECT SUM(price) AS `Total Asset`
	FROM PROPERTY
	WHERE property_status_id NOT IN (SELECT id FROM STATUS_TYPE WHERE DESCRIPTION = "Sold");
END//
DELIMITER ;

-- Get Total Yearly Salary
DELIMITER //
DROP PROCEDURE IF EXISTS GetTotalYearlySalary;
CREATE PROCEDURE GetTotalYearlySalary()
BEGIN
	SELECT SUM((monthly_salary) * 12) AS `Total Yearly Salary` 
    FROM EMPLOYEE;
END//
DELIMITER ;

-- Get Property Count by City
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertyCountbyCity;
CREATE PROCEDURE GetPropertyCountbyCity()
BEGIN
	SELECT city, COUNT(*) AS `Property Count` 
    FROM PROPERTY GROUP BY city
    ORDER BY `Property Count` DESC;
END//
DELIMITER ;

-- Get Property Leased by City
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertyLeasedByCity;
CREATE PROCEDURE GetPropertyLeasedByCity()
BEGIN
	SELECT city, COUNT(*) AS `Property Count` 
    FROM PROPERTY
	WHERE property_status_id IN (SELECT id FROM STATUS_TYPE WHERE DESCRIPTION = "Leased")
    GROUP BY city
    ORDER BY `Property Count` DESC;
END//
DELIMITER ;

-- Get Property Listed by City
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertyListedByCity;
CREATE PROCEDURE GetPropertyListedByCity()
BEGIN
	SELECT city, COUNT(*) AS `Property Count` 
    FROM PROPERTY
	WHERE property_status_id IN (SELECT id FROM STATUS_TYPE WHERE DESCRIPTION = "Listed")
    GROUP BY city
    ORDER BY `Property Count` DESC;
END//
DELIMITER ;


-- Get Active Contract
DELIMITER //
DROP PROCEDURE IF EXISTS GetActiveContract;
CREATE PROCEDURE GetActiveContract()
BEGIN
	SELECT * FROM CONTRACT 
    WHERE end_date > CURDATE();
END//
DELIMITER ;

-- Get Total Sale Value of Each Employee
DELIMITER //
DROP PROCEDURE IF EXISTS GetTotalSaleValueByEmp;
CREATE PROCEDURE GetTotalSaleValueByEmp(`Year` int)
BEGIN
	IF YEAR = -1 THEN
		SELECT E.id, E.first_name, E.last_name, E.monthly_salary, E.job_title, SUM(C.price) AS `Total Sale Value`
		FROM EMPLOYEE AS E RIGHT JOIN PROPERTY_EMPLOYEE AS PE ON PE.employee_id = E.id 
		JOIN PROPERTY AS P ON PE.property_id = P.id
		JOIN CONTRACT AS C ON C.property_id = P.id
		WHERE P.property_status_id IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold")
		GROUP BY E.id
		ORDER BY `Total Sale Value` DESC;
	ELSE
		SELECT E.id, E.first_name, E.last_name, E.monthly_salary, E.job_title, SUM(C.price) AS `Total Sale Value`
		FROM EMPLOYEE AS E RIGHT JOIN PROPERTY_EMPLOYEE AS PE ON PE.employee_id = E.id 
		JOIN PROPERTY AS P ON PE.property_id = P.id
		JOIN CONTRACT AS C ON C.property_id = P.id
		WHERE P.property_status_id IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold")
        AND YEAR(C.signed_date) = `Year`
		GROUP BY E.id
		ORDER BY `Total Sale Value` DESC;
	END IF;
END//
DELIMITER ;

-- Get Total Property Count Each Employee is Responsible For
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertyCountByEmp;
CREATE PROCEDURE GetPropertyCountByEmp()
BEGIN
	SELECT E.id, E.first_name, E.last_name, E.job_title, E.monthly_salary, COUNT(property_id) AS `Number of Properties Responsible for`
	FROM EMPLOYEE AS E RIGHT JOIN PROPERTY_EMPLOYEE AS PE ON PE.employee_id = E.id 
	JOIN PROPERTY AS P ON PE.property_id = P.id 
	WHERE P.property_status_id NOT IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold")
	GROUP BY E.id ORDER BY `Number of Properties Responsible for` DESC;
END//
DELIMITER ;


-- Get Property Sold of Each Employee By State
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertySoldByState;
CREATE PROCEDURE GetPropertySoldByState(id int)
BEGIN
	SELECT P.state, COUNT(*) AS `Property Count`
	FROM EMPLOYEE AS E RIGHT JOIN PROPERTY_EMPLOYEE AS PE ON PE.employee_id = E.id 
	JOIN PROPERTY AS P ON PE.property_id = P.id 
	WHERE P.property_status_id NOT IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold") AND E.id = id
	GROUP BY E.id, P.state;
END//
DELIMITER ;

-- Get Feature Count
DELIMITER //
DROP PROCEDURE IF EXISTS GetFeatureCount;
CREATE PROCEDURE GetFeatureCount()
BEGIN
	SELECT feature_description, COUNT(*) AS `Feature Count` 
	FROM FEATURE AS F LEFT JOIN PROPERTY_FEATURE AS PF ON F.id = PF.feature_id
	GROUP BY F.id
	ORDER BY `Feature Count` DESC;
END//
DELIMITER ;

-- Get Yearly Property Profit
DELIMITER //
DROP PROCEDURE IF EXISTS GetYearlyPropertyProfit;
CREATE PROCEDURE GetYearlyPropertyProfit()
BEGIN
	SELECT YEAR(C.signed_date) AS `Year`, SUM(C.price - P.price) AS Profit 
	FROM PROPERTY AS P LEFT JOIN CONTRACT AS C 
	ON P.id = C.property_id
	WHERE P.property_status_id IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold")
	GROUP BY `Year` ORDER BY `Year`;
END//
DELIMITER ;

-- Get Property Sold by Type
DELIMITER //
DROP PROCEDURE IF EXISTS GetPropertySoldByType;
CREATE PROCEDURE GetPropertySoldByType()
BEGIN
	SELECT PT.`description` AS `Property Type`, COUNT(*) AS `Count`
	FROM PROPERTY AS P 
	LEFT JOIN PROPERTY_TYPE AS PT 
	ON P.property_type_id = PT.id
	WHERE P.property_status_id IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold")
	GROUP BY PT.id;
END//
DELIMITER ;

-- Get Number of Inspections by Employee
DELIMITER //
DROP PROCEDURE IF EXISTS GetInspectionCountByEmp;
CREATE PROCEDURE GetInspectionCountByEmp(emp_id int)
BEGIN
	SELECT COUNT(*) AS `Inspection Count`
	FROM INSPECTION
	WHERE responsible_employee_id = emp_id
	GROUP BY responsible_employee_id;
END//
DELIMITER ;

-- Get the average value of properties by state (only active properties)
DELIMITER //
DROP PROCEDURE IF EXISTS GetAvgPropertyValueByState;
CREATE PROCEDURE GetAvgPropertyValueByState()
BEGIN
	SELECT state, AVG(price) AS `Average Price`
	FROM PROPERTY
	WHERE property_status_id NOT IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold") 
	GROUP BY state
	ORDER BY `Average Price` DESC;
END//
DELIMITER ;

-- Get the employee with the greatest number of sales.
DELIMITER //
DROP PROCEDURE IF EXISTS GetEmpWithMostSales;
CREATE PROCEDURE GetEmpWithMostSales()
BEGIN
	SELECT E.id, E.first_name, E.last_name, E.job_title, E.monthly_salary, COUNT(property_id) AS `Sale Count`
	FROM EMPLOYEE AS E RIGHT JOIN PROPERTY_EMPLOYEE AS PE ON PE.employee_id = E.id 
	JOIN PROPERTY AS P ON PE.property_id = P.id 
	WHERE P.property_status_id IN (SELECT id FROM STATUS_TYPE WHERE `description` = "Sold")
	GROUP BY E.id ORDER BY `Sale Count` DESC
	LIMIT 1;
END//
DELIMITER ;

-- Get average salary by job title
DELIMITER //
DROP PROCEDURE IF EXISTS GetAvgSalaryByTitle;
CREATE PROCEDURE GetAvgSalaryByTitle()
BEGIN
	SELECT job_title, AVG(monthly_salary) AS `Average Salary`
	FROM EMPLOYEE
	GROUP BY job_title;
END//
DELIMITER ;


-- Get average salary by job title
DELIMITER //
DROP PROCEDURE IF EXISTS GetAvgSalaryByTitle;
CREATE PROCEDURE GetAvgSalaryByTitle()
BEGIN
	SELECT job_title, AVG(monthly_salary) AS `Average Salary`
	FROM EMPLOYEE
	GROUP BY job_title;
END//
DELIMITER ;

-- Get all client contracts
DELIMITER //
DROP PROCEDURE IF EXISTS GetClientContracts;
CREATE PROCEDURE GetClientContracts(c_id int)
BEGIN
	SELECT * FROM CONTRACT
    WHERE client_id = c_id;
END//
DELIMITER ;

-- Get client feature description
DELIMITER //
DROP PROCEDURE IF EXISTS GetClientFeatureDescription;
CREATE PROCEDURE GetClientFeatureDescription(c_id int)
BEGIN
	SELECT PROPERTY.address, FEATURE.`feature_description` FROM CONTRACT
	LEFT JOIN PROPERTY ON CONTRACT.property_id = PROPERTY.id
	JOIN PROPERTY_FEATURE ON PROPERTY.id = PROPERTY_FEATURE.property_id
	JOIN FEATURE ON FEATURE.id = PROPERTY_FEATURE.feature_id
	WHERE client_id = c_id;
END//
DELIMITER ;

-- Get total amount client is expected to pay for rent at the end of their contract
DELIMITER //
DROP PROCEDURE IF EXISTS GetTotalExpectedRent;
CREATE PROCEDURE GetTotalExpectedRent(c_id int)
BEGIN
	SELECT price * (SELECT TIMESTAMPDIFF(MONTH, start_date, end_date)) AS `Expected Total Rent`
	FROM CONTRACT
	WHERE listing_type_id IN (SELECT id FROM LISTING_TYPE WHERE DESCRIPTION = "For Rent")
	AND client_id = c_id;
END//
DELIMITER ;

