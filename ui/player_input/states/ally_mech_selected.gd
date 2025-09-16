extends "res://ui/player_input/states/mech_selected.gd"
# const MechSelectedState = preload("res://ui/player_input/states/mech_selected.gd")

func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:	
	var next_state = self
	var hex = player_input.hex_map.get_closest_hex_from_mouse()
	if (hex.is_occupied()):
		if hex.occupant is Mech:
			var mech = hex.occupant as Mech
			if mech.affiliation == player_input.affiliation:
				super(global_viewport_coords)
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
	
func on_secondary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	super()
	return self
