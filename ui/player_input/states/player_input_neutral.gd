extends PlayerInputState

func on_primary_click(position = Vector2i.ZERO) -> PlayerInputState:
	var result = self
	
	#player_input.input_interpreter.get_unit_at_position(position)
	
	var mouse_hex = player_input.hex_map.get_closest_hex_from_mouse()
	if mouse_hex.occupant is Mech:
		player_input.selected_mech = mouse_hex.occupant
		player_input.mech_selected.emit(player_input.selected_mech)
		result = player_input.mech_selected_state
	return result
