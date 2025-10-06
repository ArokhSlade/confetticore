extends Node
class_name Level

const Hex = HexMap.Hex
const Commanders = preload("res://commander/commanders.gd")
class Data:
	var ticks_per_turn = 0
	var commanders : Commanders.Data

func get_data():
	var result = Data.new()
	result.ticks_per_turn = ticks_per_turn
	result.commanders = commanders.get_data()
	return result

# TODO(Gerald 2025 08 22): do we really need this?
enum GameState 
{
	PLAN,
	EXECUTE
}
@onready var commanders = $Commanders

@export var state = GameState.PLAN
@export var hex_map : HexMap
@export var tick_timer : Timer
@export var ticks_per_turn : int = 5

func get_player_commander():
	return commanders.player_commander

func get_hex_map():
	return hex_map

func setup():
	commanders.setup(hex_map)
	add_mechs_to_hex_data()
	
	
func add_mechs_to_hex_data():
	for mech in commanders.get_mechs():
		add_mech_to_hex_data(mech)
#
func add_mech_to_hex_data(mech : Mech):
	var hex = hex_map.get_hex(mech)
	assert(hex.occupant == null)
	hex.occupant = mech

func start_execution():
	commanders.start_execution()
	state = GameState.EXECUTE
	
func execute_tick():
	commanders.execute_tick()
	
func stop_execution():
	commanders.stop_execution()
	state = GameState.PLAN

func let_ai_give_orders():
	commanders.let_ai_give_orders()
