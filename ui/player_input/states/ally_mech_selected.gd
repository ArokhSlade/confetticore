extends "res://ui/player_input/states/mech_selected.gd"
# const MechSelectedState = preload("res://ui/player_input/states/mech_selected.gd")

func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:	
	var next_state = self
	
	var hex = null
	player_input.request_mouse_hex()
	hex = player_input._mouse_hex
	
	if hex == null:
		push_warning("mouse_hex requested, received null")
		return self
	
	if (hex.is_occupied()):
		if hex.occupant is Mech:
			var mech = hex.occupant as Mech
			if mech.affiliation == player_input.affiliation:
				super(global_viewport_coords)
			else:
				player_input.order_builder.set_mold(AttackOrder.new())
				player_input.order_builder.set_attack_target(mech)
				var order = player_input.order_builder.finalize()
				player_input.order_created.emit(order,player_input.affiliation)
	else:
		player_input.order_builder.set_mold(MoveOrder.new())
		player_input.order_builder.set_move_target(hex)
		var order = player_input.order_builder.finalize()
		player_input.order_created.emit(order,player_input.affiliation)
	return next_state
	
func on_secondary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var next_state = super(_global_viewport_coords)
	return next_state
