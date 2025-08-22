extends Node
class_name UI

signal planning_finished

@export var hud : HUD
@export var player_input : PlayerInput

func setup(hex_map):
	player_input.setup(hex_map)

func switch_to_planning_mode():
	hud.switch_to_planning_mode()
	player_input.finish_sleeping()

func switch_to_execute_mode():
	hud.switch_to_execute_mode()
	player_input.go_to_sleep()

func _on_hud_execute_button_pressed():
	switch_to_execute_mode()
	planning_finished.emit()
