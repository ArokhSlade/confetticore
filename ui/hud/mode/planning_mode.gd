extends HUDMode
class_name PlanningMode

func update(game_data):
	super(game_data)
	
	hud.screen_space_hud.execute_button.disabled = false
	hud.screen_space_hud.tick_count_display.hide()
		
	hud.world_space_hud.visualize_orders(game_data.orders)
	
