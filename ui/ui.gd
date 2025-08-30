extends Node
class_name UI

signal planning_finished
signal mech_path_changed(mech, point_path)

@export var hud : HUD
@export var player_input : PlayerInput

func setup(hex_map):
	player_input.setup(hex_map)

func switch_to_planning_mode():
	hud.switch_to_planning_mode()
	player_input.wake_up()

func switch_to_execute_mode():
	hud.switch_to_execute_mode()
	player_input.go_to_sleep()

func _on_hud_execute_button_pressed():
	switch_to_execute_mode()
	planning_finished.emit()

func _on_player_input_mech_path_changed(mech, path):
	mech_path_changed.emit(mech, path)
	hud.update_mech_info_panel(mech)

func _on_player_input_mech_selected(mech):
	hud.update_mech_info_panel(mech)

func _on_player_input_mech_deselected():
	hud.hide_mech_info_panel()
