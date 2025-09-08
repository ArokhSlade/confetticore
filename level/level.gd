extends Node
class_name Level

const HexMap = preload("res://confetticore_hexagon_tilemaplayer.gd")
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
@export var paths : Paths

func get_hex_map():
	return hex_map

func setup(mech_step_time):
	mechs.setup(mech_step_time)

func move_all_mechs():
	mechs.move_all()
	state = GameState.EXECUTE

func _on_mechs_finished_moving_all():
	state = GameState.PLAN
	finished_moving_all_mechs.emit()

func update_mech_path(mech, target):
	mechs.update_mech_path(mech, target)
	
func get_hex(cube_coords) -> Hex:
	return hex_map.get_hex(cube_coords)
