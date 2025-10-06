extends HUDMode
class_name PlanningMode



func update(game_data : Game.Data):
	super(game_data)
	
	hud.screen_space_hud.execute_button.disabled = false
	hud.screen_space_hud.tick_count_display.hide()
	var orders = extract_orders(game_data)
	hud.world_space_hud.visualize_orders(orders)
	
func extract_orders(game_data : Game.Data):
	var commanders = game_data.level.commanders
	var mechs = []
	for commander in commanders.commanders:
		for mech in commander.mechs.mechs:
			mechs.append(mech)
	var orders = []
	for mech in mechs:
		orders.append(mech.order)	
	return orders

	
	
	
