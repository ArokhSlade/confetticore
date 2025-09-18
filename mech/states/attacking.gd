extends MechState

func execute_tick():
	if mech.combat_target == null or mech.combat_target.is_dead():
		check_transition(mech.idle_state)
	elif mech.distance_to(mech.combat_target) > mech.attack_range:
		print_debug("combat target out of range")
		check_transition(mech.idle_state)
	else: 
		mech.attack(mech.combat_target)
		check_transition(mech.idle_state)
