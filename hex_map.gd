@tool
extends HexagonTileMapLayer
class_name HexMap

var hex_data : Dictionary[Vector3i, Hex]

func move_occupant(occupant, old_hex, new_hex):
	if (old_hex != null):
		old_hex.occupant = null
	new_hex.occupant = occupant

func get_cube_coords(node_2d : Node2D):
	var local_position = to_local(node_2d.global_position)
	var cube_coords = local_to_cube(local_position)
	return cube_coords

func get_map_coords(node_2d : Node2D):
	var cube_coords = get_cube_coords(node_2d)
	var map_coords = cube_to_map(cube_coords)
	return map_coords

func get_hex_at_local(local_coords) -> Hex:
	return get_hex_at_cube(local_to_cube(local_coords))

func get_hex_at_global(global_coords):
	var local_coords = to_local(global_coords)
	return get_hex_at_local(local_coords)
	
func hex_to_global(hex : Hex):
	var local_coords = cube_to_local(hex.cube_coords)
	var global_coords = to_global(local_coords)
	return global_coords
	
func get_hex_at_cube(cube_coords) -> Hex:
	if not hex_data.has(cube_coords):
		hex_data[cube_coords] = Hex.new(self, cube_coords)
	return hex_data[cube_coords]

func get_closest_hex_from_mouse():
	var mouse_cube_coords = get_closest_cell_from_mouse()
	return get_hex_at_cube(mouse_cube_coords)
	
	
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
	
	func print_data():
		print("hex data: " + str(tile_data.get_custom_data_by_layer_id(0)))
