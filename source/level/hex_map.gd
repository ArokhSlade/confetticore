@tool
extends HexagonTileMapLayer
class_name HexMap

var hex_data : Dictionary[Vector3i, Hex]

func move_occupant(occupant, old_hex, new_hex):
	if (old_hex != null):
		old_hex.occupant = null
	new_hex.occupant = occupant
	
func get_closest_hex_from_mouse():
	var mouse_cube_coords = get_closest_cell_from_mouse()
	return cube_to_hex(mouse_cube_coords)
	
func get_closest_hex_from_global_coords(global_coords):
	var local_coords = to_local(global_coords)
	var cube_coords = get_closest_cell_from_local(local_coords)
	var result = cube_to_hex(cube_coords)
	return result

func get_hex(node_2d : Node2D):
	var cube = get_cube_coords(node_2d)
	var hex = cube_to_hex(cube)
	return hex
	
func get_cube_coords(node_2d : Node2D):
	var local_position = to_local(node_2d.global_position)
	var cube_coords = local_to_cube(local_position)
	return cube_coords
	
func get_map_coords(node_2d : Node2D):
	var local_coords = to_local(node_2d.global_position)
	var map_coords = local_to_map(local_coords)
	return map_coords

func local_to_hex(local_coords) -> Hex:
	var cube_coords = local_to_cube(local_coords)
	return cube_to_hex(cube_coords)

func global_to_hex(global_coords):
	var local_coords = to_local(global_coords)
	return local_to_hex(local_coords)
	
func cube_to_hex(cube_coords) -> Hex:
	if not hex_data.has(cube_coords):
		hex_data[cube_coords] = Hex.new(self, cube_coords)
	return hex_data[cube_coords]

func hex_to_global(hex : Hex):
	var local_coords = cube_to_local(hex.cube_coords)
	var global_coords = to_global(local_coords)
	return global_coords

func distance_cube(cube_0, cube_1):
	var result = absi(cube_1.x - cube_0.x) + absi(cube_1.y - cube_0.y) + absi(cube_1.z - cube_0.z)
	result /= 2
	return result

func distance_hex(hex_0, hex_1):
	return distance_cube(hex_0.cube_coords, hex_1.cube_coords)
	
func distance_node2d(node_0, node_1):
	var hex_0 = get_hex(node_0)
	var hex_1 = get_hex(node_1)
	return distance_hex(hex_0, hex_1)
	
class Hex:
	var cube_coords : Vector3i 
	
	var tile_data : TileData
	var occupant : Object 
	
	func _init(hex_map : HexMap, in_cube_coords):
		cube_coords = in_cube_coords
		var map_coords = hex_map.cube_to_map(cube_coords)
		tile_data = hex_map.get_cell_tile_data(map_coords)
			
	func is_occupied():
		return occupant != null
