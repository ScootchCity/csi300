-- =============================================================================
-- Exercise 1: Introduction to Subqueries
-- PawCare Veterinary Clinic
-- =============================================================================

-- Task 1.1: Scalar Subquery in SELECT (4 points)
-- Display each pet's weight compared to the average of all pets
-- Return: pet_name, weight_kg, avg_all_pets, weight_difference
-- Filter: Only pets with weight recorded (NOT NULL)
-- Order by: weight_difference descending
-- Tables: pets
-- Tip: Use (SELECT AVG(weight_kg) FROM pets WHERE weight_kg IS NOT NULL) as scalar subquery
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    pet_name,
    weight_kg,
    ROUND((SELECT AVG(weight_kg) FROM pets), 2) AS avg_all_pets,
    ROUND((weight_kg - (SELECT AVG(weight_kg) FROM pets)), 2) AS weight_difference
FROM pets
ORDER BY weight_difference DESC;

-- Task 1.2: Scalar Subquery in WHERE (4 points)
-- Find pets whose weight is above the average weight of their species
-- Return: pet_name, species_name, weight_kg
-- Order by: species_name, weight_kg descending
-- Tables: pets, species
-- Tip: Use correlated subquery: WHERE p.weight_kg > (SELECT AVG(...) WHERE species_id = p.species_id)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    p.pet_name,
    species.species_name,
    p.weight_kg
FROM pets p
LEFT JOIN species ON p.species_id = species.species_id
WHERE p.weight_kg > (
    SELECT
        AVG(pets.weight_kg)
    FROM pets
    WHERE pets.species_id = p.species_id
        )
ORDER BY species.species_name, p.weight_kg DESC;

-- Task 1.3: Using IN with Subqueries (4 points)
-- Find owners who have pets that have been seen by the emergency clinic (clinic_id = 4)
-- Return: first_name, last_name, email
-- Tables: owners, pets, appointments
-- Tip: Use nested IN subqueries: owner_id IN (SELECT ... WHERE pet_id IN (SELECT ...))
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    owners.first_name,
    owners.last_name,
    owners.email
FROM owners
WHERE owners.owner_id IN (
    SELECT
        pets.owner_id
    FROM pets
    WHERE pets.pet_id IN (
        SELECT
            appointments.pet_id
        FROM appointments
        WHERE appointments.clinic_id = 4
        )
    );

-- Task 1.4: Using NOT IN (4 points)
-- Find pets that have NEVER had a vaccination recorded
-- Return: pet_name, species_name, owner_full_name
-- Order by: species_name, pet_name
-- Tables: pets, species, owners, vaccinations
-- Tip: WHERE pet_id NOT IN (SELECT DISTINCT pet_id FROM vaccinations)
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    pets.pet_name,
    species.species_name,
    CONCAT(owners.first_name, ' ', owners.last_name) AS owner_full_name
FROM pets
LEFT JOIN species ON pets.species_id = species.species_id
LEFT JOIN owners ON pets.owner_id = owners.owner_id
WHERE pets.pet_id NOT IN (
    SELECT
        DISTINCT vaccinations.pet_id
    FROM vaccinations
    )
ORDER BY species.species_name, pets.pet_name;

-- Task 1.5: Subquery in FROM Clause (Derived Table) (4 points)
-- Calculate total revenue by clinic using a subquery in FROM
-- Return: clinic_name, total_revenue, avg_invoice
-- Order by: total_revenue descending
-- Tables: clinics, invoices, appointments
-- Tip: Join clinics to a subquery that aggregates invoices by clinic
-- -----------------------------------------------------------------------------
-- TODO: Write your SELECT statement here

SELECT
    clinic_name,

FROM (
    SELECT

    FROM clinics
    LEFT JOIN invoices
     )