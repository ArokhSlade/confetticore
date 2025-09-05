extends Node
class_name PlayerInputState

@export var player_input : PlayerInput

func on_primary_click() -> PlayerInputState:
	return self
	
func on_secondary_click() -> PlayerInputState:
	return self
	
func on_enter():
	pass
	
func on_exit():
	pass
