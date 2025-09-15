extends MechState

func next():
	
	if mech.combat_target == null or mech.combat_target.is_dead():
		next_state = mech.idle_state	
	elif mech.distance_to(mech.combat_target) > mech.attack_range:
		print_debug("combat target out of range")
		next_state = mech.idle_state	
	else: 
		mech.attack(mech.combat_target)
		next_state = mech.idle_state
	
	return next_state
