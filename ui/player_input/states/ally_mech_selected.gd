extends PlayerInputState


func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:	
	var next_state = self
	var hex = player_input.hex_map.get_closest_hex_from_mouse()
	if (hex.is_occupied()):
		if hex.occupant is Mech:
			var mech = hex.occupant as Mech
			if mech.affiliation == player_input.affiliation:
				player_input.order_builder.set_executor(mech)
				player_input.selected_ally_mech = mech
				player_input.mech_selected.emit(player_input.selected_ally_mech)
			else:
				player_input.order_builder.set_type(Order.Type.ATTACK)
				player_input.order_builder.set_attack_target(mech)
				var order = player_input.order_builder.finalize()
				player_input.order_created.emit(order)
	else:
		player_input.order_builder.set_type(Order.Type.MOVE)
		player_input.order_builder.set_move_target(hex)
		var order = player_input.order_builder.finalize()
		player_input.order_created.emit(order)
	return next_state
	
func on_secondary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	player_input.mech_deselected.emit()
	player_input.selected_ally_mech = null
	return player_input.neutral_state
