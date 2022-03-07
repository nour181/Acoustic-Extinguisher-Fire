USE acoustic_extinguisher_fire;

SELECT 
    *
FROM
    acoustic_extinguisher_fire;

# types of liqued fuels in our data 

SELECT DISTINCT
    fuel
FROM
    acoustic_extinguisher_fire
WHERE
    fuel NOT IN ('lpg');
    
# we have also LPG fuel

# we create views that will be helpful in the coming steps **************
# create a view that shows the effect of size, airflow, distance, decibel and frequency with liqued fuel fire status

CREATE VIEW v_acoustic_extinguisher_with_fuel_liqued AS(
SELECT 
    *
FROM
    acoustic_extinguisher_fire
WHERE
	fuel NOT IN ("lpg"));
    
# create a view that shows the effect of size, airflow, distance, decibel and frequency with liqued fuel fire status

CREATE VIEW v_acoustic_extinguisher_with_LPG AS(
SELECT 
    *
FROM
    acoustic_extinguisher_fire
WHERE
	fuel LIKE "lpg");
    

# I create a CTEs that 1) contains data about liqued fuel that Acoustic Extinguisher had been successed to extinction them 
# 2) contains data about LPG fuel that Acoustic Extinguisher had been successed to extinction them
# 3) contains data about all fuel types that Acoustic Extinguisher had been successed to extinction them

# fire extinction with liqued fuel(status = 1) table
WITH successed_to_extinction_fuel_liqued AS(
SELECT 
    *
FROM
    acoustic_extinguisher_fire
WHERE
    fuel IN ('Thinner' , 'Kerosene', 'Gasoline')
        AND status = 1)
        
SELECT 
    *
FROM
    successed_to_extinction_fuel_liqued;


# percentage of flame extinction with liqued fuel(status = 1)

WITH successed_to_extinction_fuel_liqued AS(
SELECT 
    *
FROM
    acoustic_extinguisher_fire
WHERE
    fuel IN ('Thinner' , 'Kerosene', 'Gasoline')
        AND status = 1), successed_to_extinction_overal as(select * from acoustic_extinguisher_fire where STATUS = 1 )
                
SELECT 
    (SELECT 
            COUNT(*)
        FROM
            successed_to_extinction_fuel_liqued) / (SELECT 
            COUNT(*)
        FROM
            successed_to_extinction_overal) * 100 AS percentage_of_fire_extinction_Fuel_Liqued;
    

    
# percentage of flame extinction with LPG(status = 1)

WITH successed_to_extinction_LPG AS(
SELECT 
    *
FROM
    acoustic_extinguisher_fire
WHERE
    fuel IN ('LPG')
        AND status = 1), successed_to_extinction_overal as(select * from acoustic_extinguisher_fire where STATUS = 1 )
                
SELECT 
    (SELECT 
            COUNT(*)
        FROM
            successed_to_extinction_LPG) / (SELECT 
            COUNT(*)
        FROM
            successed_to_extinction_overal) * 100 AS percentage_of_fire_extinction_LPG;
    


# percentage of success when trying to extingushing fire from 10 cm distance:
SELECT 
    (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_fuel_liqued
        WHERE
            distance = 10 AND status = 1) / (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_fuel_liqued
        WHERE
            status = 1) * 100 AS extinction_fire_10_cm;
            
# make procedure that shows the percentage of success when trying to extingushing fire from specific distance(prompt desired distance) Liqued Fuel
delimiter $$
USE acoustic_extinguisher_fire $$ 
CREATE PROCEDURE extingushing_fire_from_different_distances_liqued_fuel (IN distance_cm INT, OUT percent DECIMAL(4,2))
BEGIN
SELECT
    (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_fuel_liqued
        WHERE
            distance = distance_cm AND status = 1) / (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_fuel_liqued
        WHERE
            status = 1) * 100 AS extinction_fire_PERCENT INTO percent;
END $$
delimiter ;


# make procedure that shows the percentage of success when tring to extingushing fire with specific fire size(prompt desired size) Liqued Fuel
delimiter $$
USE acoustic_extinguisher_fire $$ 
CREATE PROCEDURE extingushing_fire_from_with_different_size_liqued_fuel (IN size_cm INT, OUT percent DECIMAL(4,2))
BEGIN
SELECT
    (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_fuel_liqued
        WHERE
            size = size_cm AND status = 1) / (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_fuel_liqued
        WHERE
            status = 1) * 100 AS extinction_fire_PERCENT INTO percent;
END $$
delimiter ;


# make procedure that shows the percentage of success when tring to extingushing fire from specific distance(prompt desired distance) LPG
delimiter $$
USE acoustic_extinguisher_fire $$ 
CREATE PROCEDURE extingushing_fire_from_different_distances_LPG (IN distance_cm INT, OUT percent DECIMAL(4,2))
BEGIN
SELECT
    (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_LPG
        WHERE
            distance = distance_cm AND status = 1) / (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_LPG
        WHERE
            status = 1) * 100 AS extinction_fire_PERCENT INTO percent;
END $$
delimiter ;


# make procedure that shows the percentage of success when tring to extingushing fire with specific fire size(prompt desired size) LPG
delimiter $$
USE acoustic_extinguisher_fire $$ 
CREATE PROCEDURE extingushing_fire_from_with_different_size_LPG (IN size_cm INT, OUT percent DECIMAL(4,2))
BEGIN
SELECT
    (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_LPG
        WHERE
            size = size_cm AND status = 1) / (SELECT 
            COUNT(*)
        FROM
            acoustic_extinguisher_fire.v_acoustic_extinguisher_with_LPG
        WHERE
            status = 1) * 100 AS extinction_fire_PERCENT INTO percent;
END $$
delimiter ;

select * from acoustic_extinguisher_fire;
 



