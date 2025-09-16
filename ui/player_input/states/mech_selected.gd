extends PlayerInputState

func on_primary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:	
	var hex = player_input.hex_map.get_closest_hex_from_mouse()
	if (hex.is_occupied()):
		if hex.occupant is Mech:
			var mech = hex.occupant as Mech
			if mech.affiliation == player_input.affiliation:
				player_input.order_builder.set_executor(mech)
				player_input.selected_ally_mech = mech
				player_input.mech_selected.emit(player_input.selected_ally_mech)
			else:
				push_warning("unexpected mech.affiliation in mech_selected state")
		else:
			push_warning("unexpected hex.occupant in mech_selected state")
	
	# NOTE(ArokhSlade 2025 09 16): super-state should not be returned
	return null
	
func on_secondary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	player_input.mech_deselected.emit()
	player_input.selected_ally_mech = null
	# NOTE(ArokhSlade 2025 09 16): super-state should not be returned
	return null
