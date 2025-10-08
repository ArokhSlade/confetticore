extends Node
class_name Level

# TODO(Gerald 2025 08 22): do we really need this?
enum GameState 
{
	PLAN,
	EXECUTE
}
@export var tick_timer : Timer
@export var ticks_per_turn : int = 5
@export var state = GameState.PLAN

@onready var commanders = $Commanders
@onready var hex_map = $HexMap

const Hex = HexMap.Hex

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
