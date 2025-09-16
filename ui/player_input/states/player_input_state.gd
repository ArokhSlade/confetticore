extends Node
class_name PlayerInputState

@export var player_input : PlayerInput

func on_primary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	return self
	
func on_secondary_click(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	return self
	
func on_pointer_moved(_global_viewport_coords = Vector2i.ZERO) -> PlayerInputState:
	return self

func on_enter():
	pass
	
func on_exit():
	pass
