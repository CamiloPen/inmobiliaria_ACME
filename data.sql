-- 1. Departamentos

INSERT INTO department (code, name) VALUES 
('D01', 'Antioquia'),
('D02', 'Cundinamarca'),
('D03', 'Valle del Cauca');

-- 2. Ciudades

CREATE TABLE city_temp AS
SELECT code, name, NULL AS department FROM city WHERE false;

ALTER TABLE city_temp MODIFY COLUMN department VARCHAR(10);

INSERT INTO city_temp (code, name, department) VALUES 
('C01', 'Medellín', 'D01'),
('C02', 'Bogotá', 'D02'),
('C03', 'Cali', 'D03');

INSERT INTO city (code, name, department_id)
(SELECT code, name, (SELECT id FROM department WHERE code = C.department) FROM city_temp C);

DROP TABLE city_temp;

-- 3. Barrios

CREATE TABLE neighborhood_temp AS
SELECT code, name, description, NULL AS city FROM neighborhood WHERE false;

ALTER TABLE neighborhood_temp MODIFY COLUMN city VARCHAR(10);

INSERT INTO neighborhood_temp (code, name, description, city) VALUES 
('N01', 'El Poblado', 'Zona residencial y comercial', 'C01'),
('N02', 'Chapinero', 'Zona mixta, comercial y universitaria', 'C02'),
('N03', 'San Fernando', 'Zona residencial', 'C03'),
('N04', 'Versalles', 'Zona mixta', 'C03');

INSERT INTO neighborhood (code, name, description, city_id)
(SELECT code, name, description, (SELECT id FROM city WHERE code = N.city) FROM neighborhood_temp N);

DROP TABLE neighborhood_temp;

-- 4. Agentes inmobiliarios

CREATE TABLE user_temp AS
SELECT name_or_company_name, surname_or_company, id_type, NULL AS neighborhood, id_number, address, email, phone, user_type FROM user WHERE false;

ALTER TABLE user_temp MODIFY COLUMN neighborhood VARCHAR(10);

INSERT INTO user_temp (name_or_company_name, surname_or_company, id_type, neighborhood, id_number, address, email, phone, user_type) VALUES 
('Carlos', 'Gómez', 'CC', 'N01', '10001', 'Cra 1 #1-1', 'carlos@gomez.com', '3001234567', 'real estate agent'),
('Marcela', 'Torres', 'CC', 'N03', '10002', 'Cra 10 #5-10', 'marcela@torres.com', '3112233445', 'real estate agent');

INSERT INTO user (name_or_company_name, surname_or_company, id_type, neighborhood_id, id_number, address, email, phone, user_type)
(SELECT name_or_company_name, surname_or_company, id_type, (SELECT id FROM neighborhood WHERE code = U.neighborhood), id_number, address, email, phone, user_type FROM user_temp U);

DROP TABLE user_temp;

-- 5. Personas (7)

CREATE TABLE person_temp AS
SELECT first_name_business_name, last_name_company_name, id_type, person_type, address, email, phone, NULL AS neighborhood, id_number FROM person WHERE false;

ALTER TABLE person_temp MODIFY COLUMN neighborhood VARCHAR(10);

INSERT INTO person_temp (first_name_business_name, last_name_company_name, id_type, person_type, address, email, phone, neighborhood, id_number) VALUES 
-- Inquilinos en mora
('Laura', 'Pérez', 'CC', 'natural', 'Calle 45 #23-11', 'laura@correo.com', '3001122334', 'N01', '20001'),
('Juan', 'Martínez', 'CC', 'natural', 'Calle 80 #45-60', 'juan@correo.com', '3105566778', 'N03', '20002'),
('Marta', 'González', 'CC', 'natural', 'Cra 22 #34-56', 'marta@correo.com', '3126677889', 'N04', '20003'),
-- Propietarios (empresas)
('Inmobiliaria S.A.', '', 'NIT', 'juridica', 'Av. Caracas #23', 'contacto@inmobiliaria.com', '3109988776', 'N02', '30001'),
('Propiedades del Valle', '', 'NIT', 'juridica', 'Calle 10 #10-10', 'contacto@valle.com', '3117788990', 'N04', '30002'),
-- Inquilinos sin mora
('Andrés', 'Lozano', 'CC', 'natural', 'Calle 90 #10-20', 'andres@correo.com', '3134455667', 'N01', '20004'),
('Sofía', 'Ramírez', 'CC', 'natural', 'Cra 15 #22-33', 'sofia@correo.com', '3159988776', 'N02', '20005');

INSERT INTO person (first_name_business_name, last_name_company_name, id_type, person_type, address, email, phone, neighborhood_id, id_number)
(SELECT first_name_business_name, last_name_company_name, id_type, person_type, address, email, phone, (SELECT id FROM neighborhood WHERE code = P.neighborhood), id_number FROM person_temp P);

DROP TABLE person_temp;

-- 6. Clientes (5)

CREATE TABLE client_temp AS
SELECT legal_representative_id, NULL AS person FROM client WHERE false;

ALTER TABLE client_temp MODIFY COLUMN person VARCHAR(10);

-- Inquilinos (Laura, Juan, Marta)
INSERT INTO client_temp (legal_representative_id, person) VALUES 
(NULL, '20001'),
(NULL, '20002'),
(NULL, '20003'),
-- Propietarios (Inmobiliaria, Propiedades del Valle)
(NULL, '30001'),
(NULL, '30002'),
-- Inquilinos sin mora (Andrés, Sofía)
(NULL, '20004'),
(NULL, '20005');

INSERT INTO client (legal_representative_id, person_id)
(SELECT legal_representative_id, (SELECT id FROM person WHERE id_number = C.person) FROM client_temp C);

DROP TABLE client_temp;

-- 7. Propiedades (5)

CREATE TABLE property_temp AS
SELECT property_type, property_use, address, price, property_registration, additional_information, construction_year, private_area, built_area, Null AS neighborhood FROM property WHERE false;

ALTER TABLE property_temp MODIFY COLUMN neighborhood VARCHAR(10);

INSERT INTO property_temp (property_type, property_use, address, price, property_registration, additional_information, construction_year, private_area, built_area, neighborhood) VALUES 
('vertical', 'residencial', 'Cra 50 #20-30', 1500000, 'PR001', 'Apartamento con balcón', '2015-01-01', '70', '90', 'N01'),
('horizontal', 'residencial', 'Calle 100 #50-50', 1200000, 'PR002', 'Casa unifamiliar amplia', '2010-05-01', '95', '120', 'N03'),
('vertical', 'comercial', 'Cra 40 #10-20', 1800000, 'PR003', 'Penthouse con vista', '2018-08-01', '85', '110', 'N04'),
('horizontal', 'comercial', 'Calle 70 #30-40', 1100000, 'PR004', 'Casa remodelada', '2012-04-01', '80', '100', 'N01'),
('vertical', 'mixto', 'Av. Caracas #100-20', 1700000, 'PR005', 'Apartamento moderno', '2019-10-15', '75', '95', 'N02');

INSERT INTO property (property_type, property_use, address, price, property_registration, additional_information, construction_year, private_area, built_area, neighborhood_id)
(SELECT property_type, property_use, address, price, property_registration, additional_information, construction_year, private_area, built_area, (SELECT id FROM neighborhood WHERE code = P.neighborhood) FROM property_temp P);

DROP TABLE property_temp;

-- 8. Propietarios (5 propiedades)

CREATE TABLE owner_temp AS
SELECT NULL AS client, NULL AS property FROM owner WHERE false;

ALTER TABLE owner_temp MODIFY COLUMN client VARCHAR(10);
ALTER TABLE owner_temp MODIFY COLUMN property VARCHAR(10);

INSERT INTO owner_temp (client, property) VALUES 
('30001', 'PR001'), -- Inmobiliaria 
('30002', 'PR002'), -- Prop. del Valle 
('30002', 'PR003'), -- Prop. del Valle 
('30001', 'PR004'), -- Inmobiliaria 
('30002', 'PR005'); -- Prop. del Valle 

INSERT INTO owner (client_id, property_id)
(SELECT (SELECT C.id FROM client C INNER JOIN person P ON C.person_id = P.id WHERE P.id_number = O.client), (SELECT id FROM property WHERE property_registration = O.property) FROM owner_temp O);

DROP TABLE owner_temp;

-- 9. Contratos (3 en mora, 2 pagados)

CREATE TABLE contract_temp AS
SELECT NULL AS Tenant, NULL AS Landlord, Contract_Date, Value, Duration, NULL AS Real_Estate_Agent, NULL AS Property, Late_payment FROM contract WHERE false;

ALTER TABLE contract_temp MODIFY COLUMN Tenant VARCHAR(10);
ALTER TABLE contract_temp MODIFY COLUMN Landlord VARCHAR(10);
ALTER TABLE contract_temp MODIFY COLUMN Real_Estate_Agent VARCHAR(10);
ALTER TABLE contract_temp MODIFY COLUMN Property VARCHAR(10);

INSERT INTO contract (Tenant, Landlord, Contract_Date, Value, Duration, Real_Estate_Agent, Property, Late_payment) VALUES 
(1, 4, '2024-01-15', 1500000.00, '12 meses', 1, 1, 'pending'), -- Laura
(2, 5, '2024-02-10', 1200000.00, '6 meses', 2, 2, 'pending'), -- Juan
(3, 5, '2024-03-05', 1800000.00, '12 meses', 2, 3, 'pending'), -- Marta
(6, 4, '2024-01-10', 1100000.00, '6 meses', 1, 4, 'paid'),     -- Andrés
(7, 5, '2024-03-01', 1700000.00, '12 meses', 2, 5, 'paid');    -- Sofía
