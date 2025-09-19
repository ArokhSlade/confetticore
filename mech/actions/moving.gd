extends MechAction

var path : Path
	
func execute_tick():
	if not path.is_empty():
		var hex_map = mech.path_finder.hex_map
		var old_hex = mech.path_finder.hex_map.global_to_hex(mech.global_position)
		var new_hex = path.pop_front()
		var new_position = hex_map.hex_to_global(new_hex)
		mech.global_position = new_position
		hex_map.move_occupant(self, old_hex, new_hex)
