extends Node
class_name Game

@export var level : Level
@export var mech_step_time : float = .5
@export var ticks_per_turn : int = 5
@export var ui : UI

func _ready():
	level.setup(mech_step_time, ticks_per_turn)
	var hex_map = level.get_hex_map()
	ui.setup(hex_map)

func _on_ui_planning_finished():
	level.start_execution()

func _on_ui_mech_target_selected(mech, target):
	level.update_mech_target(mech, target)

func _on_level_tick_count_changed(tick_count):
	ui.update_tick_count_display(tick_count)

func _on_level_execution_stopped():
	ui.switch_to_planning_mode()
