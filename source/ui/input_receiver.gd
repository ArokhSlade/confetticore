extends Node

signal primary_click_pressed(global_viewport_coords)
signal secondary_click_pressed(global_viewport_coords)
signal pointer_moved(global_viewport_coords)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("PrimaryClick"):
			primary_click_pressed.emit(event.global_position)
		elif event.is_action_pressed("SecondaryClick"):
			secondary_click_pressed.emit(event.global_position)
	elif event is InputEventMouseMotion:
		pointer_moved.emit(event.global_position)
