extends Node
class_name PathFinder


@export var mech : Mech
@export var path_marker : PackedScene

var hex_map : HexMap
var path : Path

func setup(in_hex_map):
	hex_map = in_hex_map
	
func compute_path(target_hex) -> Path:
	var mech_coords = hex_map.get_map_coords(mech)
	var from_id = hex_map.pathfinding_get_point_id(mech_coords)
	
	var target_coords = hex_map.cube_to_map(target_hex)
	var to_id = hex_map.pathfinding_get_point_id(target_coords)

	#NOTE(ArokhSlade, 2025 09 10): points are local
	var point_path = hex_map.astar.get_point_path(from_id, to_id)

	#NOTE(Gerald, 2025 09 07) sanity check
	var first_point = point_path[0]
	first_point = hex_map.local_to_map(first_point)
	first_point = hex_map.pathfinding_get_point_id(first_point)
	var first_point_is_from_id = point_path and point_path.size() >= 1 and first_point == from_id
	assert(first_point_is_from_id)
	
	point_path = point_path.slice(1)
	var trimmed_point_path = point_path.slice(0, mech.move_range)
	
	if path != null:
		path.queue_free()
	
	var steps : Array[HexMap.Hex] = []
	for point in trimmed_point_path:
		var step = hex_map.get_hex_at_local(point)
		steps.append(step)
	
	path = Path.new(path_marker, hex_map, steps)
	
	add_child(path)
	
	return path
	
	
	
