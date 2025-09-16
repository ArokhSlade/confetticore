extends Node

signal primary_click_pressed(position)
signal secondary_click_pressed(position)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("PrimaryClick"):
			primary_click_pressed.emit(event.global_position)
		elif event.is_action_pressed("SecondaryClick"):
			secondary_click_pressed.emit(event.global_position)
