extends Node
class_name Game

@export var level : Level
@export var tick_duration : float = .5
@export var ui : UI
@export var tick_timer : Timer

var tick_count = 0

func _ready():
	level.setup()
	var hex_map = level.get_hex_map()
	ui.setup(hex_map)

func start_execution():
	level.start_execution()
	tick_timer.start(tick_duration)
	ui.update_tick_count_display(tick_count)

func execute_tick():
	level.execute_tick()
	tick_count += 1
	ui.update_tick_count_display(tick_count)

func stop_execution():
	level.stop_execution()
	tick_timer.stop()
	tick_count = 0
	ui.switch_to_planning_mode()
	ui.update_tick_count_display(tick_count)

func _on_ui_planning_finished():
	start_execution()

func _on_ui_mech_target_selected(mech, target):
	level.update_mech_orders(mech, target)

func _on_tick_timer_timeout():
	assert(tick_count < level.ticks_per_turn)
	execute_tick()
	if tick_count == level.ticks_per_turn:
		stop_execution()
