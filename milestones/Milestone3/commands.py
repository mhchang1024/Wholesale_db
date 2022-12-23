import botcommands
import database

def response(msg):
  response_data = None #Null
  msg_data = msg.split()
  botcommand = msg_data[0]
  arguments = msg_data[1:]

  if botcommand in botcommands.GEAR_SOLD_TO_CLIMBERS:
        
    response_data = database.gear_sold()
  elif botcommand in botcommands.FRONT_DESK_TOTAL_SALES:
        
    response_data = database.fd_endsales()
  elif botcommand in botcommands.GEAR_ORDERED_TO_GYMS:
     
    response_data = database.gear_check()
    
  elif botcommand in botcommands.GYM_SALES:

    response_data = database.sale_at_gym()
    
    
  elif botcommand in botcommands.STORE_SALES:
    
    response_data = database.sale_at_store()
 
  elif botcommand in botcommands.PREVIOUS_CURRENT_ORDERS:
     
    response_data = database.old_and_new_orders()  
  elif botcommand in botcommands.INVENTORY_CHECK:
    if len(arguments) == arguments: 
      arg = arguments[0]
      response_data = database.inventory_check_right(arg)
    else: 
      return "please select between 43, 33, 15"
  elif botcommand in botcommands.MANAGER_ORDERS:
     
    response_data = database.under_count() 
  elif botcommand in botcommands.WEEKLY_SALES:
        
    response_data = database.end_of_week_sales()
  elif botcommand in botcommands.SPECIFIC_GEAR:
    if len(arguments) == "Harness" or "Climbing Shoes": 
      gear = arguments[0]
      response_data = database.specific_gear_found(gear)
    else: 
      return "please select between Harness or Climbing Shoes"
  elif botcommand in botcommands.REP_GEAR:
        
    response_data = database.gear_sold_by_rep()
  elif botcommand in botcommands.END_DAY_SALES:
        
    response_data = database.last_night_sales()
  elif botcommand in botcommands.AVG_SALES:
        
    response_data = database.old_vs_new_day()
  elif botcommand in botcommands.GYMS_VISITED:
        
    response_data = database.reps_gear()
  elif botcommand in botcommands.GEAR_BOUGHT:
        
    response_data = database.gear_purchase()
  elif botcommand in botcommands.SAME_GEAR:
        
    response_data = database.gear_sold()
  if response_data: # if response_data is not NULL
    return response_data
  return "Your error message"

