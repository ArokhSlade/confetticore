extends "res://ui/player_input/states/mech_selected.gd"

func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var next_state = self
	
	var hex = null
	player_input.request_mouse_hex()
	hex = player_input._mouse_hex
	
	if hex == null:
		push_warning("mouse_hex requested, received null")
		return self
	
	if hex.is_occupied():
		if hex.occupant is Mech:
			var mech = hex.occupant as Mech
			if mech.affiliation == player_input.affiliation:
				next_state = super(global_viewport_coords)
			else:
				#BUG(ArokhSlade 2025 10 05): updte order
				player_input.selected_mech = mech
	return next_state
	
func on_secondary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	var next_state = super(global_viewport_coords)
	return next_state
