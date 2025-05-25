CREATE DATABASE real_estate;

USE real_estate;

CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(60) NOT NULL
);

CREATE TABLE city (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(60) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

CREATE TABLE neighborhood (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(60) NOT NULL,
    description VARCHAR(150) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(id)
);

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name_or_company_name VARCHAR(255) NOT NULL,
    surname_or_company VARCHAR(255),
    id_type VARCHAR(255),
    neighborhood_id INT,
    id_number VARCHAR(255) UNIQUE,
    address VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    user_type ENUM('admin', 'real estate agent'),
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(id)
);

CREATE TABLE person (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name_business_name VARCHAR(100) NOT NULL,
    last_name_company_name VARCHAR(100),
    id_type VARCHAR(50) NOT NULL,
    person_type VARCHAR(50) NOT NULL,
    address VARCHAR(200),
    email VARCHAR(100),
    phone VARCHAR(20),
    neighborhood_id INT,
    id_number VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(id)
);

CREATE TABLE client (
    id INT PRIMARY KEY AUTO_INCREMENT,
    legal_representative_id INT,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
); 

CREATE TABLE property (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_type ENUM('vertical', 'horizontal') NOT NULL,
    address VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    property_registration VARCHAR(20) NOT NULL,
    additional_information VARCHAR(100) NOT NULL,
    construction_year DATE,
    private_area VARCHAR(6),
    built_area VARCHAR(6),
    neighborhood_id INT NOT NULL,
    FOREIGN KEY(neighborhood_id) REFERENCES neighborhood(id)
);

CREATE TABLE owner (
    client_id INT NOT NULL,
    property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(id),
    FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE contract (
    Contract_id INT PRIMARY KEY AUTO_INCREMENT, 
    Tenant_id INT NOT NULL,
    Landlord_id INT NOT NULL,
    Contract_Date DATE NOT NULL,
    Value DECIMAL(10, 2) NOT NULL,
    Duration VARCHAR(50),
    Real_Estate_Agent_id INT NOT NULL,
    Property_id INT NOT NULL,
    Late_payment ENUM('paid', 'pending') DEFAULT 'paid',
    FOREIGN KEY (Tenant_id) REFERENCES client(id),
    FOREIGN KEY (Landlord_id) REFERENCES client(id),
    FOREIGN KEY (Real_Estate_Agent_id) REFERENCES user(id),
    FOREIGN KEY (Property_id) REFERENCES property (id)
);