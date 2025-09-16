extends Node
class_name Level

const Hex = HexMap.Hex

# TODO(Gerald 2025 08 22): do we really need this?
enum GameState 
{
	PLAN,
	EXECUTE
}

@export var state = GameState.PLAN
@export var hex_map : HexMap
@export var mechs : Mechs
@export var tick_timer : Timer
@export var ticks_per_turn : int = 5

func get_hex_map():
	return hex_map

func setup():
	mechs.setup()
	add_mechs_to_hex_data()	
	
func add_mechs_to_hex_data():
	#TODO(ArokhSlade, 2025 08 09): composite pattern?
	for mech in mechs.get_mechs():
		add_mech_to_hex_data(mech)
#
func add_mech_to_hex_data(mech : Mech):
	var hex = hex_map.get_hex(mech)
	assert(hex.occupant == null)
	hex.occupant = mech

func start_execution():
	mechs.start_execution()
	state = GameState.EXECUTE
	
func execute_tick():
	mechs.execute_tick()
	
func stop_execution():
	mechs.stop_execution()
	state = GameState.PLAN

func update_mech_orders(mech, target):
	mechs.update_mech_orders(mech, target)

func update_order(order):
	mechs.update_order(order)
