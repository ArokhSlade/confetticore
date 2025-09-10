extends Node
class_name Level

const Hex = HexMap.Hex

# TODO(Gerald 2025 08 22): do we really need this?
enum GameState 
{
	PLAN,
	EXECUTE
}

signal finished_moving_all_mechs

@export var state = GameState.PLAN
@export var hex_map : HexMap
@export var mechs : Mechs

func get_hex_map():
	return hex_map

func setup(mech_step_time):
	mechs.setup(mech_step_time)
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

func move_all_mechs():
	mechs.move_all()
	state = GameState.EXECUTE

func update_mech_path(mech, target):
	mechs.update_mech_path(mech, target)
	
func _on_mechs_finished_moving_all():
	state = GameState.PLAN
	finished_moving_all_mechs.emit()
