extends MechState

func execute_tick():
	if mech.path == null or mech.path.is_empty():
		check_transition(mech.idle_state)
	elif mech.combat_target != null and mech.distance_to(mech.combat_target) <= mech.attack_range:
		check_transition(mech.attack_state)
	else: 
		var front_hex = mech.path.front
		if front_hex.is_occupied():
			mech.wait_step()
		else:
			mech.move_step()
