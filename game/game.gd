extends Node
class_name Game

@export var level : Level
@export var tick_duration : float = .5
@export var ui : UI
@export var ai : AIPlayer
@export var tick_timer : Timer

var tick_count = 0

func _ready():
	level.setup()
	var hex_map = level.get_hex_map()
	ui.setup(hex_map)
	ai.setup(level.mechs, level.hex_map)	
	DEBUG_initiate_planning_mode_for_the_first_time()

func DEBUG_initiate_planning_mode_for_the_first_time():
	ai.give_orders()

func start_execution_phase():
	level.start_execution()
	tick_timer.start(tick_duration)
	ui.switch_to_execute_mode(level.ticks_per_turn)

func execute_tick():
	level.execute_tick()
	tick_count += 1
	ui.update_tick_count_display(tick_count, level.ticks_per_turn)

func start_planning_phase():
	level.stop_execution()
	tick_timer.stop()
	tick_count = 0
	ai.give_orders()
	ui.switch_to_planning_mode()

func _on_ui_execute_phase_requested():
	start_execution_phase()

func _on_ui_mech_target_selected(mech, target):
	level.update_mech_orders(mech, target)

func _on_tick_timer_timeout():
	assert(tick_count < level.ticks_per_turn)
	execute_tick()
	if tick_count == level.ticks_per_turn:
		start_planning_phase()
