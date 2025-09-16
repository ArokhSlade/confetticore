extends PlayerInputState


func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	
	var target_cube = player_input.hex_map.get_closest_cell_from_mouse()
	
	player_input.mech_target_selected.emit(player_input.selected_mech, target_cube)	
	return self
	
func on_secondary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	player_input.mech_deselected.emit()
	player_input.selected_mech = null
	return player_input.neutral_state
