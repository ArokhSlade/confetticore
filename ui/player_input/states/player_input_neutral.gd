extends PlayerInputState

func on_primary_click() -> PlayerInputState:
	var result = self
	var mouse_hex = player_input.hex_map.get_closest_cell_from_mouse()
	var mech : Mech = player_input.hex_map.try_get_mech(mouse_hex)
	player_input.selected_mech = mech
	if player_input.selected_mech != null:
		player_input.mech_selected.emit(player_input.selected_mech)
		result = player_input.mech_selected_state
	return result
