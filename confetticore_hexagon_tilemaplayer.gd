@tool
extends HexagonTileMapLayer
class_name ConfetticoreHexagonTileMapLayer

@export var mechs : Node2D

func get_hex(node_2d : Node2D):
	var local_position = to_local(node_2d.global_position)
	var hex = local_to_cube(local_position)
	return hex

func get_coords(node_2d : Node2D):
	var hex = get_hex(node_2d)
	var coords = cube_to_map(hex)
	return coords
	
func has_mech(hex : Vector3i):
	for mech : Mech in mechs.get_children():		
		var mech_hex = get_hex(mech)
		if mech_hex == hex:
			return true
	return false
			
func try_get_mech(hex : Vector3i) -> Mech:
	for mech : Mech in mechs.get_children():		
		var mech_hex = get_hex(mech)
		if mech_hex == hex:
			return mech
	return null
