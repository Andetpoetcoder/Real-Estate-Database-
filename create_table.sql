/********************************************************************************/
/*	      This file is to create all the table for our database system          */
/********************************************************************************/

DROP DATABASE IF EXISTS RealEstate;
CREATE DATABASE RealEstate;
USE RealEstate;


CREATE TABLE PROPERTY (
  id int AUTO_INCREMENT PRIMARY KEY,
  property_type_id int,
  listing_type_id int,
  property_status_id int,
  price int,
  city varchar(20),
  state varchar(20),
  address varchar(100),
  num_bath int,
  num_bed int,
  car_space int
);

CREATE TABLE PROPERTY_TYPE (
  id int AUTO_INCREMENT PRIMARY KEY,
  description varchar(20)
);

CREATE TABLE PROPERTY_FEATURE (
  property_id int,
  feature_id int
);

CREATE TABLE FEATURE (
  id int AUTO_INCREMENT PRIMARY KEY,
  feature_description varchar(20)
);

CREATE TABLE LISTING_TYPE (
  id int AUTO_INCREMENT PRIMARY KEY,
  description varchar(20)
);

CREATE TABLE STATUS_TYPE (
  id int AUTO_INCREMENT PRIMARY KEY,
  description varchar(20)
);

CREATE TABLE LISTING (
  id int AUTO_INCREMENT PRIMARY KEY,
  property_id int,
  listing_status_id int,
  listing_type_id int,
  price int,
  create_date date
);

CREATE TABLE EMPLOYEE (
  id int AUTO_INCREMENT PRIMARY KEY,
  first_name varchar(30),
  last_name varchar(30),
  start_date date,
  end_date date,
  job_title varchar(20),
  monthly_salary int
);

CREATE TABLE PROPERTY_EMPLOYEE (
  employee_id int,
  property_id int,
  role_type_id int
);

CREATE TABLE ROLE_TYPE (
  id int AUTO_INCREMENT PRIMARY KEY,
  description varchar(20)
);

CREATE TABLE INSPECTION (
  id int AUTO_INCREMENT PRIMARY KEY,
  property_id int,
  inspection_date datetime,
  responsible_employee_id int
);

CREATE TABLE CLIENT (
  id int AUTO_INCREMENT PRIMARY KEY,
  first_name varchar(30),
  last_name varchar(30),
  email_address varchar(50),
  phone_number varchar(20)
);

CREATE TABLE CLIENT_PROPERTY_INTEREST (
  client_id int,
  property_id int
);

CREATE TABLE CLIENT_INSPECTION (
  client_id int,
  inspection_id int
);

CREATE TABLE OFFER (
  id int AUTO_INCREMENT PRIMARY KEY,
  client_id int,
  property_id int,
  offer_status_id int,
  offer_amount int
);

CREATE TABLE OFFER_STATUS (
  id int AUTO_INCREMENT PRIMARY KEY,
  description varchar(20)
);

CREATE TABLE CONTRACT (
  id int AUTO_INCREMENT PRIMARY KEY,
  property_id int,
  listing_type_id int,
  contract_document varchar(255),
  responsible_employee_id int,
  client_id int,
  contract_status_id int,
  signed_date date,
  start_date date,
  end_date date,
  price int
);

CREATE TABLE CONTRACT_STATUS (
  id int AUTO_INCREMENT PRIMARY KEY,
  description varchar(20)
);

ALTER TABLE PROPERTY_TYPE COMMENT = 'Example: house, unit, townhouse';
ALTER TABLE LISTING_TYPE COMMENT = 'Sale, Rent, or Both';
ALTER TABLE STATUS_TYPE COMMENT = 'Sold, listed, leased, under_offer';
ALTER TABLE ROLE_TYPE COMMENT = 'Ex: Manager or Sale Agent';
ALTER TABLE OFFER_STATUS COMMENT = 'Stores values such as Accepted, Rejected, In Rent ';
ALTER TABLE CONTRACT_STATUS COMMENT = 'Signed or In Progress';

ALTER TABLE PROPERTY ADD FOREIGN KEY (property_status_id) REFERENCES STATUS_TYPE (id);
ALTER TABLE PROPERTY ADD FOREIGN KEY (listing_type_id) REFERENCES LISTING_TYPE (id);
ALTER TABLE PROPERTY ADD FOREIGN KEY (property_type_id) REFERENCES PROPERTY_TYPE (id);

ALTER TABLE LISTING ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);
ALTER TABLE LISTING ADD FOREIGN KEY (listing_type_id) REFERENCES PROPERTY_TYPE (id);

ALTER TABLE PROPERTY_FEATURE ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);
ALTER TABLE PROPERTY_FEATURE ADD FOREIGN KEY (feature_id) REFERENCES FEATURE (id);

ALTER TABLE PROPERTY_EMPLOYEE ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);
ALTER TABLE PROPERTY_EMPLOYEE ADD FOREIGN KEY (employee_id) REFERENCES EMPLOYEE (id);
ALTER TABLE PROPERTY_EMPLOYEE ADD FOREIGN KEY (role_type_id) REFERENCES ROLE_TYPE (id);

ALTER TABLE INSPECTION ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);
ALTER TABLE INSPECTION ADD FOREIGN KEY (responsible_employee_id) REFERENCES EMPLOYEE (id);

ALTER TABLE CLIENT_PROPERTY_INTEREST ADD FOREIGN KEY (client_id) REFERENCES CLIENT (id);
ALTER TABLE CLIENT_PROPERTY_INTEREST ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);

ALTER TABLE CLIENT_INSPECTION ADD FOREIGN KEY (inspection_id) REFERENCES INSPECTION (id);
ALTER TABLE CLIENT_INSPECTION ADD FOREIGN KEY (client_id) REFERENCES CLIENT (id);

ALTER TABLE OFFER ADD FOREIGN KEY (client_id) REFERENCES CLIENT (id);
ALTER TABLE OFFER ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);
ALTER TABLE OFFER ADD FOREIGN KEY (offer_status_id) REFERENCES OFFER_STATUS (id);

ALTER TABLE CONTRACT ADD FOREIGN KEY (property_id) REFERENCES PROPERTY (id);
ALTER TABLE CONTRACT ADD FOREIGN KEY (listing_type_id) REFERENCES LISTING_TYPE (id);
ALTER TABLE CONTRACT ADD FOREIGN KEY (contract_status_id) REFERENCES CONTRACT_STATUS (id);
ALTER TABLE CONTRACT ADD FOREIGN KEY (client_id) REFERENCES CLIENT (id);
ALTER TABLE CONTRACT ADD FOREIGN KEY (responsible_employee_id) REFERENCES EMPLOYEE (id);