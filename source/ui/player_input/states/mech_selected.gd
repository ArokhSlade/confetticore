extends PlayerInputState

func on_primary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:	
	var next_state = self
	var hex = player_input.hex_map.get_closest_hex_from_mouse()
	if (hex.is_occupied()):
		if hex.occupant is Mech:
			var mech = hex.occupant as Mech
			if mech.affiliation == player_input.affiliation:
				player_input.order_builder.set_executor(mech)
				player_input.selected_mech = mech
				player_input.mech_selected.emit(player_input.selected_mech)				
				next_state = player_input.ally_mech_selected_state
			else:
				push_warning("unexpected mech.affiliation in mech_selected state")
		else:
			push_warning("unexpected hex.occupant in mech_selected state")
	
	return next_state
	
func on_secondary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var next_state = player_input.neutral_state
	player_input.mech_deselected.emit()
	return next_state
