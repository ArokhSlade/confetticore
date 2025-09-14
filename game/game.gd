extends Node
class_name Game

@export var level : Level
@export var ui : UI

@export var planning_phase : GamePhase
@export var execution_phase : GamePhase
var phase : GamePhase


func _ready():
	level.setup()
	var hex_map = level.get_hex_map()
	ui.setup(hex_map)
	phase = planning_phase

func _on_ui_execute_phase_requested():
	assert(phase == planning_phase)
	phase.transition_to(execution_phase)

func _on_ui_mech_target_selected(mech, target):
	level.update_mech_orders(mech, target)
