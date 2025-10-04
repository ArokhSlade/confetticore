extends Node
class_name HUD

const GameData = Game.GameData

signal execute_button_pressed

@export var screen_space_hud : ScreenSpaceHUD
@export var world_space_hud : WorldSpaceHUD

@export var planning_mode : PlanningMode
@export var execution_mode : ExecutionMode

@onready var current_mode : HUDMode

func setup(hex_map):
	world_space_hud.setup(hex_map)

func update(game_data):
	current_mode.update(game_data)

func switch_to_planning_mode():
	current_mode = planning_mode
	
func switch_to_execute_mode():
	current_mode = execution_mode

func update_tick_count_display(tick_count, ticks_per_turn):
	screen_space_hud.update_tick_count_display(tick_count, ticks_per_turn)

func update_order(order):
	world_space_hud.update_order(order)

func _on_screen_space_hud_execute_button_pressed():
	execute_button_pressed.emit()

func on_mech_selected(mech):
	screen_space_hud.show_mech_info_panel(mech)

func on_mech_deselected():
	screen_space_hud.hide_mech_info_panel()
