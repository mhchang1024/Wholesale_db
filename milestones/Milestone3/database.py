# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", 
                               cursorclass=pymysql.cursors.DictCursor,
                              ssl={"fake_flag_to_enable_tls":True})
        print("Bot connected to database {}".format(db_name))
        return conn
    except Exception as e:
        print(e)
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# your code here

def gear_sold():
  try:
    connection = connect()
    if connection:
      sql = """ 
      SELECT Admin.name as 'Admin Name', Rock_Climber.name as 'Rock Climber Name', Rock_Climber.gear_bought as 'Gear bought'
      from Admin, Rock_climber;"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Directors Name:"] = row.pop('Admin Name')
        row["Climbers Name:"] = row.pop('Rock Climber Name')
        row["Purchased Gear:"] = row.pop('Gear bought')
      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"

def fd_endsales():
  try:
    connection = connect()
    if connection:
      sql = """ 
      SELECT Gym_Frontdesk.name as 'Front Desk Employee', AVG (start_sales + mid_sales + end_sales)        as 'Total Sales'
      FROM Gym_Frontdesk
      GROUP BY Gym_Frontdesk.name, Gym_Frontdesk.end_sales, Gym_Frontdesk.start_sales, Gym_Frontdesk.mid_sales ;"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Front Desk Name"] = row.pop('Front Desk Employee')
        row["Sales Made"] = row.pop('Total Sales')
      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas" 

    
def gear_check():
  try:
    connection = connect()
    if connection:
      sql = """ 
      SELECT Manager.name as 'Manager name', Locations.gym_fk as 'Gym Name', Gym.Gear_orders as 'Gym Orders'
from Manager, Gym
join Locations on Locations.location_id = Gym.gym_id;"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Director Name"] = row.pop('Manager name')
        row["Gym"] = row.pop('Gym Name')
        row["Gear Checked"] = row.pop('Gym Orders')
      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"

def sale_at_gym():
  try:
    connection = connect()
    if connection:

      cursor = connection.cursor()

      sqltri = """SELECT * FROM climber_purchase;"""
      cursor.execute(sqltri)
      results = cursor.fetchall()
      sql = """ 
      INSERT INTO members_sales( `items_bought`, `total_purchase`) VALUES(2, 30.00);
      """
      cursor.execute(sql)
      connection.commit()
      sql = """ 
      INSERT INTO members_sales( `items_bought`, `total_purchase`) VALUES(3, 40.00);
      """
      cursor.execute(sql)
      connection.commit()

      cursor.execute(sqltri)
      results += cursor.fetchall()
      cursor = connection.cursor()
      
      return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"

    
def sale_at_store():
  try:
    connection = connect()
    if connection:

      cursor = connection.cursor()

      sqltri = """SELECT * FROM climber_purchase;"""
      cursor.execute(sqltri)
      results = cursor.fetchall()
      sql = """ 
      INSERT INTO Stores_sales( `items_bought`, `total_purchase`) VALUES(4, 32.65);
      """
      cursor.execute(sql)
      connection.commit()
      sql = """ 
      INSERT INTO Stores_sales( `items_bought`, `total_purchase`) VALUES(3, 14.50);
      """
      cursor.execute(sql)
      connection.commit()

      cursor.execute(sqltri)
      results += cursor.fetchall()
      cursor = connection.cursor()
      
      return results
  
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"


def old_and_new_orders():
  try:
    connection = connect()
    if connection:
      sql = """ 
      SELECT Manager.name as 'Manager Name', Orders.previous_order as 'Previous Orders', Orders.current_oder as 'Latest Orders'
FROM Manager, Orders;"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Director Name"] = row.pop('Manager Name')
        row["Old Order"] = row.pop('Previous Orders')
        row["New Order"] = row.pop('Latest Orders')
      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"  
    
def inventory_check_right(arg):
  try:
    connection = connect()
    if connection:
      sql = """ 
     SELECT quantity_check(%s) as 'The Current amount of gear is:'
    """   
      arg = (arg)
      cursor = connection.cursor()
      cursor.execute(sql, arg)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Inventory Number Correct"] = row.pop('The Current amount of gear is:')
    
      print(results)
      if results:
        return results
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"        
def under_count():
  try:
    connection = connect()
    if connection:
      sql = """ 
    SELECT manager_orders() as 'Orders less than 20';
    """   
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Count of gear that is under 20"] = row.pop('Orders less than 20')
      print(results)
      if results:
        return results
      else:
        return "You can only look for Harness or Climbing Shoes "
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"
    
def end_of_week_sales():
  try:
    connection = connect()
    if connection:
      sql = """ 
      SELECT Sale_PerDay.gym_name as 'Gym Name', AVG ((previous_sales + current_sales + mon + tue + wed + thur + fri) / 7) as 'Weekly Sales'
FROM Sale_PerDay
group by Sale_PerDay.gym_name, Sale_PerDay.previous_sales, Sale_PerDay.current_sales,  Sale_PerDay.mon,  Sale_PerDay.tue, Sale_PerDay.wed,Sale_PerDay.thur,Sale_PerDay.fri ;
"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Gym"] = row.pop('Gym Name')
        row["Weekly Profit"] = row.pop('Weekly Sales')
      print(results)
      if results:
        return result
  except Exception as e:
    print(e)
    return "failed to retrieve datas"
    
def specific_gear_found(arg):
  try:
    connection = connect()
    if connection:
      sql = """ 
     SELECT Stores.name as 'Stores Name',
     Stores.gear_type as 'Specfic gear'
    From Stores
    WHERE Stores.gear_type = %s;
    """   
      arg = (arg)
      cursor = connection.cursor()
      cursor.execute(sql, arg)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Stores Name"] = row.pop('Stores Name')
        row["specific gear"] = row.pop('Specfic gear')
      print(results)
      if results:
        return results
      else:
        return "You can only look for Harness or Climbing Shoes "
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"    



def gear_sold_by_rep():
  print("rep gear sold is working")
  try:
    connection = connect()
    if connection:
      sql = """ 
      CALL rep_gear();
      """
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      
      if results:
        return " this has worked"
      else:
        return "There is data!"
  except Exception as e:
    print(e)
    return "failed to retrieve datas"
    
def last_night_sales():
  try:
    connection = connect()
    if connection:
      sql = """ 
       CALL last_night_sales();
      """
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      
      if results:
        return " this has worked"
      else:
        return "There is data!"
     
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"
    

def old_vs_new_day():
  try:
    connection = connect()
    if connection:
      sql = """ 
      SELECT AVG (previous_sales - current_sales) as 'Avg Sales'
FROM Sale_PerDay
group by Sale_PerDay.previous_sales, Sale_PerDay.current_sales ;
"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Avg Between two days"] = row.pop('Avg Sales')
      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"
    
def reps_gear():
  try:
    connection = connect()
    if connection:
      sql = """ 
     SELECT Representative.name as 'Representative Name', Representative.gym_visited as 'Gym visited', Representative.gear_shown as 'Gear Shown in Gyms'
FROM Representative;
"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Representative"] = row.pop('Representative Name')
        row["Gyms Visited"] = row.pop('Gym visited')
        row["Gear Shown By Reps"] = row.pop('Gear Shown in Gyms')

      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"

def gear_purchase():
  try:
    connection = connect()
    if connection:
      sql = """ 
     SELECT Inventory.items as 'Climbing Gear', Inventory.count as 
     'old count',Inventory.count - 1 as 'New Count'
From Inventory
GROUP BY Inventory.count, Inventory.items, Inventory.count ;
"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Gear That Was bought"] = row.pop('Climbing Gear')
        row["Before Purchase"] = row.pop('old count')
        row["After Purchase"] = row.pop('New Count')

      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"

def same_brand():
  try:
    connection = connect()
    if connection:
      sql = """ 
     SELECT Stores.name as ' Store name', Gym.name as 'Gym name' , Brand.name as 'Brand Name'
FROM Stores, Gym
join Brand on Brand.brand_id =  Gym.gym_id;
"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Store Name"] = row.pop(' Store name')
        row["Gyms Name"] = row.pop('Gym name')
        row["Gear At Both"] = row.pop('Brand Name')

      print(results)
      if results:
        return results
      
    
  except Exception as e:
    print(e)
    return "failed to retrieve datas"