extends Node
class_name Level

const Hex = HexMap.Hex

# TODO(Gerald 2025 08 22): do we really need this?
enum GameState 
{
	PLAN,
	EXECUTE
}

signal tick_count_changed(tick_count)
signal execution_stopped

@export var state = GameState.PLAN
@export var hex_map : HexMap
@export var mechs : Mechs
@export var tick_timer : Timer
var mech_step_time : float
var ticks_per_turn : int
var tick_count = 0

func get_hex_map():
	return hex_map

func setup(in_mech_step_time, in_ticks_per_turn):
	ticks_per_turn = in_ticks_per_turn
	mech_step_time = in_mech_step_time	
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
	tick_timer.start(mech_step_time)
	state = GameState.EXECUTE
	
func stop_execution():
	mechs.stop_execution()
	tick_timer.stop()
	tick_count = 0
	execution_stopped.emit()
	state = GameState.PLAN

func update_mech_target(mech, target):
	mechs.update_mech_target(mech, target)

func _on_mech_step_timer_timeout():
	assert(tick_count < ticks_per_turn)
	mechs.execute_tick()
	tick_count += 1
	tick_count_changed.emit(tick_count)
	if tick_count == ticks_per_turn:
		stop_execution()
