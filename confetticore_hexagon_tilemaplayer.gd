@tool
extends HexagonTileMapLayer
class_name ConfetticoreHexagonTileMapLayer

@export var mechs : Node2D

func get_cube(node_2d : Node2D):
	var local_position = to_local(node_2d.global_position)
	var cube = local_to_cube(local_position)
	return cube

func get_coords(node_2d : Node2D):
	var cube = get_cube(node_2d)
	var coords = cube_to_map(cube)
	return coords
	
func has_mech(cube : Vector3i):
	for mech : Mech in mechs.get_children():
		var mech_cube = get_cube(mech)
		if mech_cube == cube:
			return true
	return false
			
func try_get_mech(cube : Vector3i) -> Mech:
	for mech : Mech in mechs.get_children():
		var mech_cube = get_cube(mech)
		if mech_cube == cube:
			return mech
	return null

func get_occupant(hex : Hex):
	var cell_data = get_cell_tile_data(hex.map_coords)
	var occupant = cell_data.get_custom_data("occupant")
	return occupant
	
func is_occupied(hex : Hex):
	var result = get_occupant(hex) != null
	return result

class Hex:
	var cube_coords : Vector3i 
	var hex_map : ConfetticoreHexagonTileMapLayer
	
	var map_coords : Vector2i:
		get:
			var result = hex_map.cube_to_map(cube_coords)
			return result
			
	func _init(in_hex_map: ConfetticoreHexagonTileMapLayer = null, local_coords : Vector2 = Vector2.ZERO):
		hex_map = in_hex_map
		cube_coords = hex_map.local_to_cube(local_coords)
			
	func is_occupied() -> bool:
		var result = hex_map.is_occupied(self)
		return result
