extends PlayerInputState

func on_enter():
	player_input.order_builder.reset()

func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var result = self
	
	var mouse_hex = player_input.hex_map.get_closest_hex_from_mouse()
	if mouse_hex.occupant is Mech:
		var mech = mouse_hex.occupant
		if mech.affiliation == player_input.affiliation:
			player_input.order_builder.executor = mech
			player_input.selected_ally_mech = mech
			player_input.mech_selected.emit(player_input.selected_ally_mech)
			result = player_input.ally_mech_selected_state
		else:
			player_input.selected_enemy_mech = mech
			result = player_input.enemy_mech_selected_state
	return result
