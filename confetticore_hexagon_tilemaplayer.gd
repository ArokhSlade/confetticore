@tool
extends HexagonTileMapLayer
class_name HexMap

# TODO(ArokhSlade 2025 08 22): do we really need this?
enum GameState 
{
	PLAN,
	EXECUTE
}

signal finished_moving_all_mechs

@export var mechs : Mechs
@export var state = GameState.PLAN

var hex_data : Dictionary[Vector3i, Hex]

func _ready():
	super._ready()
	add_mechs_to_hex_data()
	
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

func add_mechs_to_hex_data():
	#TODO(ArokhSlade, 2025 08 09): composite pattern?
	for mech in mechs.get_mechs():
		add_mech_to_hex_data(mech)
#
func add_mech_to_hex_data(mech : Mech):
	var mech_cube_coords = local_to_cube(mech.position)
	
	assert(not hex_data.has(mech_cube_coords) or hex_data[mech_cube_coords].occupant == null)
	if not hex_data.has(mech_cube_coords):
		hex_data[mech_cube_coords] = Hex.new(self,mech_cube_coords)
	hex_data[mech_cube_coords].occupant = mech

func move_occupant(mech, old_hex, new_hex):
	old_hex.occupant = null
	new_hex.occupant = mech

func get_cube_coords(node_2d : Node2D):
	var local_position = to_local(node_2d.global_position)
	var cube_coords = local_to_cube(local_position)
	return cube_coords

func get_map_coords(node_2d : Node2D):
	var cube_coords = get_cube_coords(node_2d)
	var map_coords = cube_to_map(cube_coords)
	return map_coords
	
func has_mech(cube_coords : Vector3i):
	return try_get_mech(cube_coords) != null
			
func try_get_mech(cube_coords : Vector3i) -> Mech:
	for mech : Mech in mechs.get_children():
		var mech_cube = get_cube_coords(mech)
		if mech_cube == cube_coords:
			return mech
	return null

func get_hex_at_local(local_coords) -> Hex:
	return get_hex_at_cube(local_to_cube(local_coords))

func get_hex_at_global(global_coords):
	var local_coords = to_local(global_coords)
	return get_hex_at_local(local_coords)
	
func get_hex_at_cube(cube_coords) -> Hex:
	if not hex_data.has(cube_coords):
		hex_data[cube_coords] = Hex.new(self, cube_coords)
	return hex_data[cube_coords]

class Hex:
	var cube_coords : Vector3i 
	var hex_map : HexMap
	
	var tile_data : TileData
	var occupant : Object
	
	var map_coords : Vector2i:
		get:
			var result = hex_map.cube_to_map(cube_coords)
			return result
	
	func _init(in_hex_map, in_cube_coords):
		hex_map = in_hex_map
		cube_coords = in_cube_coords
		map_coords = hex_map.cube_to_map(cube_coords)
		tile_data = hex_map.get_cell_tile_data(map_coords)
			
	func is_occupied():
		return occupant != null
