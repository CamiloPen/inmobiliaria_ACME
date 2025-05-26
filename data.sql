-- 1. Departamentos
INSERT INTO department (code, name) VALUES 
('D01', 'Antioquia'),
('D02', 'Cundinamarca'),
('D03', 'Valle del Cauca');

-- 2. Ciudades
INSERT INTO city (code, name, department_id) VALUES 
('C01', 'Medellín', 1),
('C02', 'Bogotá', 2),
('C03', 'Cali', 3);

-- 3. Barrios
INSERT INTO neighborhood (code, name, description, city_id) VALUES 
('N01', 'El Poblado', 'Zona residencial y comercial', 1),
('N02', 'Chapinero', 'Zona mixta, comercial y universitaria', 2),
('N03', 'San Fernando', 'Zona residencial', 3),
('N04', 'Versalles', 'Zona mixta', 3);

-- 4. Agentes inmobiliarios
INSERT INTO user (name_or_company_name, surname_or_company, id_type, neighborhood_id, id_number, address, email, phone, user_type) VALUES 
('Carlos', 'Gómez', 'CC', 1, '10001', 'Cra 1 #1-1', 'carlos@gomez.com', '3001234567', 'real estate agent'),
('Marcela', 'Torres', 'CC', 3, '10002', 'Cra 10 #5-10', 'marcela@torres.com', '3112233445', 'real estate agent');

-- 5. Personas (7)
INSERT INTO person (first_name_business_name, last_name_company_name, id_type, person_type, address, email, phone, neighborhood_id, id_number) VALUES 
-- Inquilinos en mora
('Laura', 'Pérez', 'CC', 'natural', 'Calle 45 #23-11', 'laura@correo.com', '3001122334', 1, '20001'),
('Juan', 'Martínez', 'CC', 'natural', 'Calle 80 #45-60', 'juan@correo.com', '3105566778', 3, '20002'),
('Marta', 'González', 'CC', 'natural', 'Cra 22 #34-56', 'marta@correo.com', '3126677889', 4, '20003'),
-- Propietarios (empresas)
('Inmobiliaria S.A.', '', 'NIT', 'juridica', 'Av. Caracas #23', 'contacto@inmobiliaria.com', '3109988776', 2, '30001'),
('Propiedades del Valle', '', 'NIT', 'juridica', 'Calle 10 #10-10', 'contacto@valle.com', '3117788990', 4, '30002'),
-- Inquilinos sin mora
('Andrés', 'Lozano', 'CC', 'natural', 'Calle 90 #10-20', 'andres@correo.com', '3134455667', 1, '20004'),
('Sofía', 'Ramírez', 'CC', 'natural', 'Cra 15 #22-33', 'sofia@correo.com', '3159988776', 2, '20005');

-- 6. Clientes (5)
-- Inquilinos (Laura, Juan, Marta)
INSERT INTO client (legal_representative_id, person_id) VALUES 
(NULL, 1),
(NULL, 2),
(NULL, 3);
-- Propietarios (Inmobiliaria, Propiedades del Valle)
INSERT INTO client (legal_representative_id, person_id) VALUES 
(NULL, 4),
(NULL, 5);
-- Inquilinos sin mora (Andrés, Sofía)
INSERT INTO client (legal_representative_id, person_id) VALUES 
(NULL, 6),
(NULL, 7);

-- 7. Propiedades (5)
INSERT INTO property (
    property_type, property_use, address, price, property_registration, 
    additional_information, construction_year, private_area, built_area, neighborhood_id
) VALUES 
('vertical', 'residencial', 'Cra 50 #20-30', 1500000, 'PR001', 'Apartamento con balcón', '2015-01-01', '70', '90', 1),
('horizontal', 'residencial', 'Calle 100 #50-50', 1200000, 'PR002', 'Casa unifamiliar amplia', '2010-05-01', '95', '120', 3),
('vertical', 'comercial', 'Cra 40 #10-20', 1800000, 'PR003', 'Penthouse con vista', '2018-08-01', '85', '110', 4),
('horizontal', 'comercial', 'Calle 70 #30-40', 1100000, 'PR004', 'Casa remodelada', '2012-04-01', '80', '100', 1),
('vertical', 'mixto', 'Av. Caracas #100-20', 1700000, 'PR005', 'Apartamento moderno', '2019-10-15', '75', '95', 2);

-- 8. Propietarios (5 propiedades)
INSERT INTO owner (client_id, property_id) VALUES 
(4, 1), -- Inmobiliaria -> PR001
(5, 2), -- Prop. del Valle -> PR002
(5, 3), -- Prop. del Valle -> PR003
(4, 4), -- Inmobiliaria -> PR004
(5, 5); -- Prop. del Valle -> PR005

-- 9. Contratos (3 en mora, 2 pagados)
INSERT INTO contract (Tenant_id, Landlord_id, Contract_Date, Value, Duration, Real_Estate_Agent_id, Property_id, Late_payment) VALUES 
(1, 4, '2024-01-15', 1500000.00, '12 meses', 1, 1, 'pending'), -- Laura
(2, 5, '2024-02-10', 1200000.00, '6 meses', 2, 2, 'pending'), -- Juan
(3, 5, '2024-03-05', 1800000.00, '12 meses', 2, 3, 'pending'), -- Marta
(6, 4, '2024-01-10', 1100000.00, '6 meses', 1, 4, 'paid'),     -- Andrés
(7, 5, '2024-03-01', 1700000.00, '12 meses', 2, 5, 'paid');    -- Sofía
