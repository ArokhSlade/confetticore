extends Node
class_name Game

@export var level : Level
@export var mech_step_time : float = .5
@export var ui : UI

func _ready():
	level.setup(mech_step_time)
	var hex_map = level.get_hex_map()
	ui.setup(hex_map)

func _on_ui_planning_finished():
	level.move_all_mechs()

func _on_level_finished_moving_all_mechs():
	ui.switch_to_planning_mode()
