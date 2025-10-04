extends Node
class_name Game

@export var level : Level
@export var tick_duration : float = .5
@export var ui : UI
@export var ai : AIPlayer
@export var tick_timer : Timer

var tick_count = 0

class GameData:
	var ticks_per_turn = 0
	var tick_count = 0
	var orders = []


func _ready():
	level.setup()
	var hex_map = level.get_hex_map()
	ui.setup(hex_map)
	ui.switch_to_planning_mode()
	ai.setup(level.mechs, level.hex_map)	
	DEBUG_initiate_planning_mode_for_the_first_time()

func _process(_delta):
	var game_data = GameData.new()
	game_data.tick_count = tick_count
	game_data.ticks_per_turn = level.ticks_per_turn
	game_data.orders = _get_orders()	
	
	ui.update(game_data)

func _get_orders():
	var mechs = level.mechs.get_mechs()
	var orders = []
	for mech : Mech in mechs:
		orders.append(mech.order)
	return orders
		
func DEBUG_initiate_planning_mode_for_the_first_time():
	ai.give_orders()

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
	ai.give_orders()
	ui.switch_to_planning_mode()

func _on_ui_execute_phase_requested():
	start_execution_phase()

func _on_tick_timer_timeout():
	assert(tick_count < level.ticks_per_turn)
	execute_tick()
	if tick_count == level.ticks_per_turn:
		start_planning_phase()

func _on_commander_order_given(order):
	level.update_order(order)
