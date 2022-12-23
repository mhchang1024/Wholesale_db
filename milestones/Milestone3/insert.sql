-- Script name: inserts.sql
-- Author:      Michael Chang
-- Purpose:     insert sample data to test the integrity of this database system


USE `CSC675WholeSale` ;

-- User
INSERT INTO User (user_id, name, age) VALUES(1, 'Michael', 24), (2, 'jett', 22), (3, 'Darren', 19);
-- Brand
INSERT INTO Brand (brand_id, name, place) VALUES(1, 'Scarpa', 'Italy'), (2, "La Sportiva", 'Italy'), (3, "Evolv", "America");
-- Manager
INSERT INTO Manager (manager_id, name, age) VALUES(1, 'Radu', 26), (2, 'Grace', 29), (3, 'Evan', 40);
-- Admin
INSERT INTO Admin (admin_id, name, person) VALUES(1,'Radu',1), (2,'Tom',2), (3,'Sally',3);
-- Gym_Staff
INSERT INTO Gym_Staff (staff_id, user_id, age) VALUES(1, 1, 24), (2,2, 23), (3, 3, 19);
-- Agressive_shoes
INSERT INTO Agressive_shoes (aggresive_id, size, name) VALUES(1, 44, 'Scarpa Instinct'), (2, 32, 'La Sportiva Solutions'), (3, 38, 'Evolv Shamans');
-- Moderate_Shoe
INSERT INTO Moderate_Shoe (moderate_id, name, size) VALUES(1, 'Scarpa Vapor V', 44), (2, 'Evolv Kronos', 42), (3,'La Sportiva Mantra', 34 );
-- Climbing_Shoe
INSERT INTO Climbing_Shoe (Shoe_id, name, size, gear_id, moderate_shoes, aggresive_shoes) VALUES(1, "Insticts", 44, 1, 1, 1), (2, 'Evolv Defy', 13, 2, 2, 2), (3, 'La Sportiva Mythos', 32, 3, 3, 3);
-- Harness
INSERT INTO Harness (harness_id, type, name) VALUES(1,1,"session"), (2,2,'jaye'), (3,3,'momentum');
-- Climbing_Gear
INSERT INTO Climbing_Gear(gear_id, name, price) VALUES(1, 'climbing shoes', 200), (2, 'harness', 60), (3, 'belay device', 100);
-- Gym
INSERT INTO Gym(gym_id, place, name, gear_sold, climbing_gear, Gear_orders) VALUES(1,'belmont', 'Movement Belmont', 24, 'Black Diamond', '8 momentum Harness from Black Diamond'), (2,'fountain valley', 'Movement Fountain Valley',600, 'Scarpa', '6 pairs of Instincts vs Climbing Shoe From Scarpa'), (3,'Santa Clara', 'Movement Santa Clara', 855, 'La Sportiva', '3 pairs of Mira climbing Shoes from La Sportiva ');
-- Director
INSERT INTO Director(director_id, admin, age, staff_fk) VALUES(1,1,26,1), (2,2,29,2),(3,3,40,3);
-- Deliveries
INSERT INTO Deliveries(deliveries_id, packages, drivers) VALUES(1, 'shoes','stan'), (2, 'harness', 'bob'),(3, 'shirts', 'bill');
-- Manufacturer
INSERT INTO Manufacturer(manufacturer_id, name, place, deliveries_fk) VALUES(1,'balck Diamond', 'Boulder, colorado', 1), (2, 'scarpa', 'Italy', 2), (3, 'evolv', 'America', 3);
-- Deliverer
INSERT INTO Deliverer(deliverer_id, driver, age, manufature_id, gym_fk) VALUES(1, 'stan', 52, 1,1), (2, 'bob', 43, 2, 2), (3, 'ron', 35, 3, 3);
-- Representative
INSERT INTO Representative(rep_id,name,age,brand_id, gear_shown, gear_at_gyms, gym_visited) VALUES(1, 'Veronica', 23,1, 'Scarpa instincts', 21,'Movement Belmont'), (2,'aldrie', 22, 2, 'Black Diamond Momentum Harness', 31, 'Movement Fountain Valley'), (3,'Acuna', 24, 3, 'Lasportiva Solution Climbing Shoes', 24,'Movement Santa Clara');
-- Retail_Manager
INSERT INTO Retail_Manager(retail_id, packages, Profits_Fk) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Gym_Profits
INSERT INTO Gym_Profits(profits_id,profit,earning,Retail_fk) VALUES(1,1, '2022-10-29' ,1), (2,2, '2022-10-28' ,2), (3,3, '2022-10-23',3);
-- Rock_Climber
INSERT INTO Rock_Climber(climber_id, name, gear_bought) VALUES(1, 'Scott', 5), (2, 'Nico', 13), (3, 'Alex', 3);
-- Gym_Frontdesk
INSERT INTO Gym_Frontdesk(frontdesk_id,name,age, start_sales, mid_sales, end_sales ) VALUES( 1, 'Michael', 24, 100.00, 150.00, 60.00), (2, 'Angela', 22, 120.00, 20.00, 90.00), (3, 'Steven', 24, 5.00, 160.00, 50.00);
-- worker
INSERT INTO worker(worker_id, name, age) VALUES(1, 'Lin', 21), (2, 'joe', 41), (3, 'elisa', 21);
-- Stores
INSERT INTO Stores(store_id, place, name, gear_sold, climbing_gear, gear_type) VALUES(1, 'Belmont', 'REI', 24, 'Black Diamond', 'Harness'), (2,  'fountain valley', 'DICKS Sporting Goods', 855, 'Scarpa', 'Harness' ), (3, 'San Francisco', 'Sport Basement', 600, 'La Sportiva', 'Climbing Shoes' );
-- BuyingGear
INSERT INTO BuyingGear(climber_id,gear_id,buying_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- GoTO
INSERT INTO GoTO(store_id, climber_id, go_id ) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Sports_Harness
INSERT INTO Sports_Harness(Harness_id, Size, name) VALUES(1,'Large','solution'), (2, 'medium', 'Sama'), (3, 'small', 'Zone');
-- Recieves
INSERT INTO Recieves(gym_id, climbing_gear_id,recieves_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Orders
INSERT INTO Orders(manager_id,gear_id, orders_id, current_oder,previous_order ) VALUES(1,1,1,23, 14),(2,2,2, 21, 24),(3,3,3, 18, 12);
-- Shown
INSERT INTO Shown(rep_id,gear_id, shown_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Talks
INSERT INTO Talks(manager_id, rep_id, talk_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Profits
INSERT INTO Profits(profit_id, gym_id, profits_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Sales_Account
INSERT INTO Sales_Account(sales_id, accounts, brand_Fk, user_Fk, climber) VALUES(1, "Scarpa", 1, 1,1), (2, 'REI', 2, 2,2), (3, 'La Sportiva', 3, 3,3);
-- checking
INSERT INTO checking(manager_id, sales_id, check_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Receiver
INSERT INTO Receiver(Retail_fk, Deliveries_Fk, receiver_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Inventory
INSERT INTO Inventory(inventory_id, items, count, admin_Fk, Frontdesk_Fk) VALUES(1, 'shoes', 33, 1, 1), (2, 'climbing shoes', 43, 2, 2), (3, 'Harness', 15, 3, 3);
-- Invoice
INSERT INTO Invoice(user_Fk, admin_Fk, invoice_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Location
INSERT INTO Locations(location_id, place, staff_fk, gym_fk) VALUES(1, 'belmont', 1,'Movement belmont'), (2,'fountain valley', 2, 'Movement fountain valley'), (3, 'Santa Clara', 3, 'Movement Santa Clara');
-- checks
INSERT INTO checks(inventory_id, Frontdesk_id, checks_id) VALUES(1,1,1),(2,2,2),(3,3,3);
-- Sales_PreDay
INSERT INTO Sale_PerDay(sales_id, previous_sales, current_sales, gym_sales, gym_name, mon, tue, wed, thur, fri) VALUES(1, 342.00, 234.00, 1, 'Movement Belmont', 232.00, 214.00, 232.00,222.00, 423.00),(2, 240.00, 321.00, 2, 'Movement Fountain Valley', 340.00, 322.00, 230.00, 210.00, 232.00),(3, 250.00, 220.00, 3, 'Movement Santa Clara', 313.00, 231.00, 421.00, 210.00, 123.00);
-- Climber_purchase
INSERT INTO climber_purchase(purchase_id, climber, climbers_purchases ) VALUES(1,1,0.00),(2, 2,0.00),(3,3,0.00);

