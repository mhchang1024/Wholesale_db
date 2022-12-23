-- Script name: inserts.sql
-- Author:      Michael Chang
-- Purpose:     impletmenting the business requirments for the logic of the data base.
USE `CSC675WholeSale` ;
SET SESSION sql_mode = '';
-- 1.For each admin, check on how much gear is sold to each rock climber.
SELECT Admin.name as 'Admin Name', Rock_Climber.name as 'Rock Climber Name', Rock_Climber.gear_bought as 'Gear bought'
from Admin, Rock_climber;
/*
Outputs:
Admin Name	Rock Climber Name	Gear bought
Tom			Scott				5
Sally		Scott				5
Radu		Scott				5
Tom			Nico				13
Sally		Nico				13
Radu		Nico				13
Tom			Alex				3
Sally		Alex				3
Radu		Alex				3

*/
-- 2.Finds the number of sales each gym front desk had throughout the day for each gym.
SELECT Gym_Frontdesk.name as 'Front Desk Employee', AVG (start_sales + mid_sales + end_sales) as 'Total Sales'
FROM Gym_Frontdesk
GROUP BY Gym_Frontdesk.end_sales, Gym_Frontdesk.start_sales, Gym_Frontdesk.mid_sales ;
/*
Output:
Front Desk Employee		Total Sales
Michael					310.0000
Angela					230.0000
Steven					210.0000
*/

-- 3.For Each manager checks to see how much gear is ordered to the gym.
SELECT Manager.name as 'Manager name', Locations.gym_fk as 'Gym Name', Gym.Gear_orders as 'Gym Orders'
from Manager, Gym
join Locations on Locations.location_id = Gym.gym_id;

/*
Outputs:
Manager name Gym Name					Gym Orders
Radu 	 	Movement Belmont  			 8 momentum Harness from Black Diamond
Grace 		Movement Belmont   			 8 momentum Harness from Black Diamond
Evan 		Movement Belmont 			 8 momentum Harness from Black Diamond
Radu		Movement Fountain Valley	 6 pairs of Instincts vs Climbing Shoe From Scarpa
Grace 		Movement Fountain Valley  	 6 pairs of Instincts vs Climbing Shoe From Scarpa
Evan 		Movement Fountain Valley	 6 pairs of Instincts vs Climbing Shoe From Scarpa
Radu 		Movement Santa Clara		 3 pairs of Mira climbing Shoes from La Sportiva 
Grace		Movement Santa Clara	   	 3 pairs of Mira climbing Shoes from La Sportiva 
Evan 		Movement Santa Clara    	 3 pairs of Mira climbing Shoes from La Sportiva 


*/
-- 4. For each manager that ordered a certain piece of climbing gear, check how much gear was previously ordered before the latest purchase.
SELECT Manager.name as 'Manager Name', Orders.previous_order as 'Previous Orders', Orders.current_oder as 'Latest Orders'
FROM Manager, Orders;
/*
Output:
Manager Name	Previous Orders      Latest Orders
Radu				14						23
Grace				14						23
Evan				14						23
Radu				24						21
Grace				24						21
Evan				24						21
Radu				12						18
Grace				12						18
Evan				12						18

*/

-- 5. Creates a function that allows staff to the number of items is correct to the current count of the inventory
DELIMITER $$
CREATE FUNCTION quantity_check( new_count INT)
    RETURNS INT DETERMINISTIC
    BEGIN
        RETURN (SELECT COUNT(*) FROM Inventory WHERE count = new_count);
    END $$ 
DELIMITER ;
SELECT quantity_check(43) as 'The Current amount of gear is:';
/*
Output:
The Current amount of gear is:
		3

*/
-- 6. Creates a function  that returns the order that is less then or eaqual to 20 items
DELIMITER $$
CREATE FUNCTION manager_orders ()
    RETURNS INT DETERMINISTIC
    BEGIN
        DECLARE order_count INT;
        SET order_count = (SELECT COUNT(*) 
                            FROM Orders 
                            WHERE current_oder < 20);
        RETURN order_count;
    END $$
DELIMITER ;
SELECT manager_orders() as 'Orders less than 20';
/*
Output:
Orders less than 20
	0

*/
-- 7. For each gym, show the average amount of gear sold each week.
SELECT Sale_PerDay.gym_name as 'Gym Name', AVG ((previous_sales + current_sales + mon + tue + wed + thur + fri) / 7) as 'Weekly Sales'
FROM Sale_PerDay
group by Sale_PerDay.gym_name, Sale_PerDay.previous_sales, Sale_PerDay.current_sales,  Sale_PerDay.mon,  Sale_PerDay.tue, Sale_PerDay.wed,Sale_PerDay.thur,Sale_PerDay.fri ;
/*
Output:
Gym Name					Weekly Sales
Movement Belmont			271.2857140000
Movement Fountain Valley	270.7142860000
Movement Santa Clara		252.5714290000

*/
-- 8. Finds the number of stores that orders a specific piece of climbing gear.
SELECT Stores.name as 'Stores Name'
From Stores
WHERE Stores.gear_type = 'Harness';
/*
Output:
Stores Name
REI
DICKS Sporting Goods

*/

-- 9. Creat a trigger so when a new sales is inserted into the data base, the total amount of sales is added to the sals table for rock climbes 

DELIMITER $$
CREATE TRIGGER customer_sales AFTER INSERT ON members_sales
    FOR EACH ROW
        BEGIN 
            DECLARE totals DECIMAL(6,2);
            DECLARE existing_climber INT;
            SET totals = (new.items_bought * new.total_purchase );
            SET existing_climber = (SELECT COUNT(climber) FROM climber_purchase WHERE climber = new.climber);

            IF  existing_climber  > 0 THEN
                UPDATE climber_purchase SET climbers_purchases = climbers_purchases + totals WHERE climber = new.climber;
            ELSE
                INSERT INTO climber_purchase (climber, climbers_purchases) VALUES (new.climber, totals);
            END IF;

        END $$
DELIMITER ;

SELECT * FROM climber_purchase;

INSERT INTO members_sales( `items_bought`, `total_purchase`) 
VALUES(2, 30.00);

SELECT * FROM climber_purchase;

-- 10. Create a trigger updates after a members makes a new purchase and updates the account.
DELIMITER $$
CREATE TRIGGER Store_Purchases AFTER INSERT ON Stores_sales
    FOR EACH ROW
        BEGIN 
            DECLARE totals DECIMAL(6,2);
            DECLARE existing_climber INT;
            SET totals = (new.items_bought * new.total_purchase );
            SET existing_climber = (SELECT COUNT(climber) FROM climber_purchase WHERE climber = new.climber);

            IF  existing_climber  > 0 THEN
                UPDATE climber_purchase SET climbers_purchases = climbers_purchases + totals WHERE climber = new.climber;
            ELSE
                INSERT INTO climber_purchase (climber, climbers_purchases) VALUES (new.climber, totals);
            END IF;

        END $$
DELIMITER ;

INSERT INTO Stores_sales( `items_bought`, `total_purchase`) 
VALUES(22, 360.00);
-- 11. Creates a procedure to check the number of sales made by each representative to each gym.
DELIMITER $$
CREATE PROCEDURE rep_gear ()
BEGIN
	DECLARE shown INT;
	DROP TABLE IF EXISTS `temp_shown`;

    CREATE TEMPORARY TABLE temp_shown
    SELECT gear_at_gyms 
    FROM Representative;
	
   
    insert INTO temp_shown(`gear_at_gyms`) VALUES(gear_at_gyms);
END $$
DELIMITER ;
CALL rep_gear();
-- 12. Create a procudure that Updates the amount made each night of the day's total sales
DELIMITER $$
CREATE PROCEDURE last_night_sales ()
BEGIN

	
	DROP TABLE IF EXISTS `temp_sales`;

    CREATE TEMPORARY TABLE temp_sales
    SELECT  end_sales
    FROM Gym_Frontdesk;
	
  
    insert INTO temp_sales(`end_sales`) VALUES(end_sales);
    
END $$
DELIMITER ;
CALL last_night_sales();
-- 13. Finds out how much gear was sold the previous day versus the current day's sales. 
SELECT AVG (previous_sales - current_sales) as 'Avg Sales'
FROM Sale_PerDay
group by Sale_PerDay.previous_sales, Sale_PerDay.current_sales ;
/*
Output:
Avg Sales
108.00	
-81.00
30.00
*/


-- 14. for each of the representatives, see what gym they went to and see what gear is shown at the gym.
SELECT Representative.name as 'Representative Name', Representative.gym_visited as 'Gym visited', Representative.gear_shown as 'Gear Shown in Gyms'
FROM Representative;
/*
Output:
Representative Name		Gym visited					Gear Shown in Gyms
Veronica				Movement Belmont			Scarpa instincts
aldrie					Movement Fountain Valley	Black Diamond Momentum Harness
Acuna					Movement Santa Clara		Lasportiva Solution Climbing Shoes

*/

-- 15. For each of the items sold,  show the new count after an item is sold in the inventory.
SELECT Inventory.items as 'Climbing Gear', Inventory.count as 'old count ',Inventory.count - 1 as 'New Count'
From Inventory
GROUP BY Inventory.count, Inventory.items, Inventory.count ;
/*
Output:
Climbing Gear	old count 	New Count
shoes			43			42
climbing shoes	23			22
Harness			15			14

*/



-- 16. Finds stores and gyms that are selling the same brand of climbing gear, and shows the brand name.
SELECT Stores.name as ' Store name', Gym.name as 'Gym name' , Brand.name as 'Brand Name'
FROM Stores, Gym
join Brand on Brand.brand_id =  Gym.gym_id;

/*
Outputs:
Store name           Gym name                  Brand Name
Sport Basement       Movement Belmont           Scarpa
DICKS Sporting Goods Movement Belmont           Scarpa
REI                  Movement Belmont           Scarpa
Sport Basement       Movement Fountain Valley   La Sportiva
DICKS Sporting Goods Movement Fountain Valley   La Sportiva
REI                  Movement Fountain Valley   La Sportiva
Sport Basement       Movement Santa Clara       Evolv
DICKS Sporting Goods Movement Santa Clara       Evolv
REI                  Movement Santa Clara       Evolv

*/

