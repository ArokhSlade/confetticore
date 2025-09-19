extends Strategy


@export var path_finder : PathFinder
var target : Mech

func decide_action() -> MechAction:
	
	var path = get_path_next_to_node_2d(target)
	var action = mech.idle_action
	if target == null or target.is_dead():
		action = mech.idle_action
	elif mech.distance_to(target) > mech.attack_range:
		if path == null or path.is_empty():
			action = mech.idle_action
		else:
			var front_hex = path.front
			if front_hex.is_occupied():
				action = mech.idle_action
			else:
				mech.move_action.path = path
				action = mech.move_action
	else: 
		mech.attack_action.target = target
		action = mech.attack_action	
	return action

func get_path_next_to_node_2d(target : Node2D):
	var target_cube = path_finder.hex_map.get_cube_coords(target)
	var path = path_finder.compute_path(target_cube)
	if path.back.cube_coords == target_cube:
		path.pop_back()
	return path
