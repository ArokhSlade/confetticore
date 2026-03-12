extends Strategy

func decide_action() -> MechAction:
	var action = mech.idle_action
	return action
