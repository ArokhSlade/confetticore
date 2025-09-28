extends HUDMode
class_name ExecutionMode

func update(game_data, ui_data):
	hud.screen_space_hud.execute_button.disabled = true
	hud.screen_space_hud.tick_count_display.update(game_data.tick_count, game_data.ticks_per_turn)
	hud.screen_space_hud.tick_count_display.show()
