extends Strategy

var target : HexMap.Hex

func setup_order(order : Order):
	assert(order.type == Order.Type.MOVE)
	target = order.move_target

func decide_action() -> MechAction:
	
	
	if target == null:
		return mech.idle_action
	
	mech.path = mech.path_finder.compute_path_to_hex(target)
	if mech.path.is_empty():
		return mech.idle_action
	
	var front_hex = mech.path.front
	if front_hex.is_occupied():
		return mech.idle_action
	
	return mech.move_action
	
