extends PlayerInputState

func on_enter():
	player_input.order_builder.reset()
	player_input.selected_mech = null

func on_primary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var result = self
		
	var mouse_hex = null
	player_input.request_mouse_hex()
	mouse_hex = player_input._mouse_hex
	
	if mouse_hex == null:
		push_warning("mouse_hex requested, received null")
		return self
	
	if mouse_hex.occupant is Mech:
		var mech = mouse_hex.occupant
		if mech.affiliation == player_input.affiliation:
			player_input.order_builder.executor = mech
			result = player_input.ally_mech_selected_state
		else:
			result = player_input.enemy_mech_selected_state
		player_input.selected_mech = mech
		player_input.mech_selected.emit(player_input.selected_mech)
	return result
