extends PlayerInputState


func on_primary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	push_warning("enemy mech selected state - primary click")
	return self
	
func on_secondary_click(global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	push_warning("enemy mech selected state - secondary click")
	return self
