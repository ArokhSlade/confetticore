extends PlayerInputState

func handle_input(event) -> PlayerInputState:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:		
		var mouse_hex = player_input.hex_map.get_closest_cell_from_mouse()
		var mech : Mech = player_input.hex_map.try_get_mech(mouse_hex)
		player_input.selected_mech = mech
		if player_input.selected_mech != null:
			player_input.mech_selected.emit(player_input.selected_mech)
			return player_input.mech_selected_state
	return self
