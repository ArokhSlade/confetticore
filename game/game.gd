extends Node
class_name Game

@export var tick_duration : float = .5

@onready var ui = $UI
@onready var level = $Level
@onready var tick_timer = $TickTimer
@onready var data_collector = $DataCollector

var tick_count = 0

func _ready():
	level.setup()
	var hex_map = level.hex_map
	
	ui.setup(hex_map, data_collector)
	ui.switch_to_planning_mode()
	
	DEBUG_initiate_planning_mode_for_the_first_time()


func _process(_delta):
	ui.update()


func DEBUG_initiate_planning_mode_for_the_first_time():
	level.let_ai_give_orders()


func start_execution_phase():
	level.start_execution()
	tick_timer.start(tick_duration)
	ui.switch_to_execute_mode()


func execute_tick():
	level.execute_tick()
	tick_count += 1
	# ui.update_tick_count_display(tick_count, level.ticks_per_turn)


func start_planning_phase():
	level.stop_execution()
	tick_timer.stop()
	tick_count = 0
	level.let_ai_give_orders()
	ui.switch_to_planning_mode()


func _on_ui_execute_phase_requested():
	start_execution_phase()


func _on_tick_timer_timeout():
	assert(tick_count < level.ticks_per_turn)
	execute_tick()
	if tick_count == level.ticks_per_turn:
		start_planning_phase()
