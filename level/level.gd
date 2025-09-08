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

func move_all_mechs():
	mechs.move_all()
	state = GameState.EXECUTE

func update_mech_path(mech, target):
	mechs.update_mech_path(mech, target)
	
func get_hex(cube_coords) -> Hex:
	return hex_map.get_hex(cube_coords)

func _on_hex_map_finished_moving_all_mechs():
	state = GameState.PLAN
	finished_moving_all_mechs.emit()
