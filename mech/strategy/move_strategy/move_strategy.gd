extends Strategy

var target : HexMap.Hex

func decide_action() -> MechAction:
	if target == null:
		return mech.idle_action
	
	var path = mech.path_finder.compute_path_to_hex(target)
	if path.is_empty():
		return mech.idle_action
	
	var front_hex = path.front
	if front_hex.is_occupied():
		return mech.idle_action
	
	mech.move_action.path = path
	return mech.move_action
	
