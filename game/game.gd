extends Node
class_name Game

const Commanders = preload("res://commander/commanders.gd")

@export var level : Level
@export var tick_duration : float = .5
@export var hud : HUD
@export var ai : AIPlayer
@export var tick_timer : Timer
@export var commanders : Commanders


var tick_count = 0

class GameData:
	var ticks_per_turn = 0
	var tick_count = 0
	var orders = []
	var selected_mech = null

func _ready():
	level.setup()
	var hex_map = level.get_hex_map()
	hud.setup(hex_map)
	hud.switch_to_planning_mode()
	ai.setup(level.mechs, level.hex_map)	
	DEBUG_initiate_planning_mode_for_the_first_time()


func _process(_delta):
	var game_data = GameData.new()
	game_data.tick_count = tick_count
	game_data.ticks_per_turn = level.ticks_per_turn
	game_data.orders = _get_orders()	
	var commanders_data = commanders.get_data()
	
	hud.update(game_data)


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
	hud.switch_to_execute_mode()


func execute_tick():
	level.execute_tick()
	tick_count += 1
	# hud.update_tick_count_display(tick_count, level.ticks_per_turn)


func start_planning_phase():
	level.stop_execution()
	tick_timer.stop()
	tick_count = 0
	ai.give_orders()
	hud.switch_to_planning_mode()


func _on_tick_timer_timeout():
	assert(tick_count < level.ticks_per_turn)
	execute_tick()
	if tick_count == level.ticks_per_turn:
		start_planning_phase()


func _on_hud_execute_button_pressed():
	start_execution_phase()


func _on_commanders_order_submitted(order):
	level.update_order(order)
