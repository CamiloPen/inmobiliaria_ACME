
CREATE VIEW Cities_properties_by_month AS 
SELECT
    DATE_FORMAT(co.Contract_Date, '%Y-%m') AS contract_month,
    c.name AS city,
    GROUP_CONCAT(DISTINCT n.name SEPARATOR ', ') AS neighborhoods,
    COUNT(DISTINCT p.id) AS num_properties,
    SUM(co.Value) AS total
FROM
    property p
JOIN neighborhood n ON p.neighborhood_id = n.id
JOIN city c ON n.city_id = c.id
JOIN contract co ON co.Property_id = p.id 
GROUP BY contract_month, city;

CREATE VIEW Property_pending AS
SELECT 
    c.Contract_id,
    p.first_name_business_name AS tenant_name,
    pr.address AS property_address,
    pr.property_registration,
    ct.first_name_business_name AS landlord_name,
    c.Value,
    c.Contract_Date,
    c.Late_payment
FROM contract c
JOIN client t ON c.Tenant_id = t.id
JOIN person p ON t.person_id = p.id
JOIN client l ON c.Landlord_id = l.id
JOIN person ct ON l.person_id = ct.id
JOIN property pr ON c.Property_id = pr.id
WHERE c.Late_payment = 'pending';

