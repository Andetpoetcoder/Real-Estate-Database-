/********************************************************************************/
/*	    This file calls the procedure to retrive necessary information			*/
/********************************************************************************/

SELECT * FROM PROPERTY;

-- Get Property Count by Listing Type
CALL GetPropertyCountByListingType();

-- Get Feature Count
CALL GetFeatureCount();

-- Get Active Contract
CALL GetActiveContract();

-- Get Property Leased by City
CALL GetPropertyLeasedByCity();

-- Get Property Listed by City
CALL GetPropertyListedByCity();

-- Get Total Sale Value of Each Employee
CALL GetTotalSaleValueByEmp(-1); -- all time
CALL GetTotalSaleValueByEmp(2018); -- by specific year

-- Get Total Property Count Each Employee is Responsible For
CALL GetPropertyCountByEmp();

-- Get Property Sold of Each Employee By State
CALL GetPropertySoldByState(10);

-- Get Current Total Monthly Rent Value
CALL GetTotalRent();

-- Get Total Asset Value
CALL GetTotalAsset();

-- Get Total Yearly Salary
CALL GetTotalYearlySalary();

-- Get Yearly Property Profit (only sold)
CALL GetYearlyPropertyProfit();

-- Get Property Sold by Type
CALL GetPropertySoldByType();

-- Get Number of Inspections by Employee
CALL GetInspectionCountByEmp(6);

-- Get the average value of properties by state (only active properties)
CALL GetAvgPropertyValueByState();

-- Get the employee with the greatest number of sales.
CALL GetEmpWithMostSales();

-- Get average salary by job title
CALL GetAvgSalaryByTitle();

-- Get all contracts by client ID
CALL GetClientContracts(10);

-- Get client feature description
CALL GetClientFeatureDescription(10);

-- Get total amount client is expected to pay for rent at the end of their contract
CALL GetTotalExpectedRent(105);
