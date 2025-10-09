extends PlayerInputState

func on_enter():
	player_input.order_builder.reset()
	player_input.selected_mech = null

func on_primary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var result = self
	
	var mouse_hex = player_input.hex_map.get_closest_hex_from_mouse()
	if mouse_hex.occupant is Mech:
		var mech = mouse_hex.occupant
		if mech.affiliation == player_input.player_commander:
			player_input.order_builder.executor = mech
			result = player_input.ally_mech_selected_state
		else:
			result = player_input.enemy_mech_selected_state
		player_input.selected_mech = mech
		player_input.mech_selected.emit(player_input.selected_mech)
	return result
