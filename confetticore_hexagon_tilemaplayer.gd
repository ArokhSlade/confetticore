@tool
extends HexagonTileMapLayer
class_name ConfetticoreHexagonTileMapLayer

@export var mechs : Node2D

var hex_data : Dictionary[Vector3i, Hex]

func get_cube_coords(node_2d : Node2D):
	var local_position = to_local(node_2d.global_position)
	var cube_coords = local_to_cube(local_position)
	return cube_coords

func get_map_coords(node_2d : Node2D):
	var cube_coords = get_cube_coords(node_2d)
	var map_coords = cube_to_map(cube_coords)
	return map_coords
	
func has_mech(cube_coords : Vector3i):
	for mech : Mech in mechs.get_children():
		var mech_cube = get_cube_coords(mech)
		if mech_cube == cube_coords:
			return true
	return false
			
func try_get_mech(cube_coords : Vector3i) -> Mech:
	for mech : Mech in mechs.get_children():
		var mech_cube = get_cube_coords(mech)
		if mech_cube == cube_coords:
			return mech
	return null

func get_occupant(hex : Hex):
	var cell_data = get_cell_tile_data(hex.map_coords)
	var occupant = cell_data.get_custom_data("occupant")
	return occupant
	
func is_occupied(hex : Hex):
	var result = get_occupant(hex) != null
	return result

func get_hex_at_local(local_coords) -> Hex:
	var hex = Hex.new(self, local_coords)
	return hex

func get_hex_at_cube(cube_coords) -> Hex:	
	return get_hex_at_local(cube_to_local(cube_coords))




class Hex:
	var cube_coords : Vector3i 
	var hex_map : ConfetticoreHexagonTileMapLayer
	
	var tile_data : TileData
	var occupant : Object
	
	var map_coords : Vector2i:
		get:
			var result = hex_map.cube_to_map(cube_coords)
			return result
			
	func _init(in_hex_map: ConfetticoreHexagonTileMapLayer = null, local_coords : Vector2 = Vector2.ZERO):
		hex_map = in_hex_map
		cube_coords = hex_map.local_to_cube(local_coords)
		map_coords = hex_map.cube_to_map(cube_coords)
		tile_data = hex_map.get_cell_tile_data(map_coords)
			
	func is_occupied() -> bool:
		var result = hex_map.is_occupied(self)
		return result
