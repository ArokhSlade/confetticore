extends Node

signal primary_click_pressed
signal secondary_click_pressed

func _unhandled_input(event):
	if event.is_action_pressed("PrimaryClick"):
		primary_click_pressed.emit()
	elif event.is_action_pressed("SecondaryClick"):
		secondary_click_pressed.emit()
