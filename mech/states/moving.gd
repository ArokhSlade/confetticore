extends MechState

func next():
	
	if mech.path == null or mech.path.is_empty():
		next_state = mech.dormant_state
	elif mech.combat_target != null and mech.distance_to(mech.combat_target) <= mech.attack_range:
		next_state = mech.attack_state
	else: 
		var front_hex = mech.path.front
		if front_hex.is_occupied():
			mech._wait_step()
		else:
			mech._move_step()
	
	return next_state

func on_exit():
	mech._finish_moving()
