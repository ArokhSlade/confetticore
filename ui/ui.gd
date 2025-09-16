extends Node
class_name UI

signal execute_phase_requested
signal order_created(order)

@export var hud : HUD
@export var player_input : PlayerInput

func setup(hex_map):
	player_input.setup(hex_map)

func switch_to_planning_mode():
	hud.switch_to_planning_mode()
	player_input.wake_up()

func switch_to_execute_mode(ticks_per_turn):
	hud.switch_to_execute_mode(ticks_per_turn)
	player_input.go_to_sleep()
	
func update_tick_count_display(tick_count, ticks_per_turn):
	hud.update_tick_count_display(tick_count, ticks_per_turn)

func _on_hud_execute_button_pressed():
	execute_phase_requested.emit()

func _on_player_input_mech_selected(mech):
	hud.update_mech_info_panel(mech)

func _on_player_input_mech_deselected():
	hud.hide_mech_info_panel()

func _on_player_input_order_created(order):
	order_created.emit(order)
