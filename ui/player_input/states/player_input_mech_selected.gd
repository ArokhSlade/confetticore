extends PlayerInputState


func on_primary_click() -> PlayerInputState:
	var selected_mech_coords = player_input.hex_map.get_coords(player_input.selected_mech)
	var from_id = player_input.hex_map.pathfinding_get_point_id(selected_mech_coords)
	

	var mouse_hex = player_input.hex_map.get_closest_cell_from_mouse()
	var mouse_coords = player_input.hex_map.cube_to_map(mouse_hex)
	var to_id = player_input.hex_map.pathfinding_get_point_id(mouse_coords)

	var point_path = player_input.hex_map.astar.get_point_path(from_id, to_id)

	var first_point = player_input.hex_map.to_local(point_path[0])
	first_point = player_input.hex_map.local_to_map(first_point)
	first_point = player_input.hex_map.pathfinding_get_point_id(first_point)

	#NOTE(Gerald, 2025 09 05) sanity check
	var first_point_is_from_id = point_path and point_path.size() >= 1 and first_point == from_id
	assert(first_point_is_from_id)
	point_path = point_path.slice(1)

	player_input.mech_path_changed.emit(player_input.selected_mech, point_path)	
	return self
	
func on_secondary_click() -> PlayerInputState:
	player_input.mech_deselected.emit()
	player_input.selected_mech = null
	return player_input.neutral_state
