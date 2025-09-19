extends Strategy

var idle_state : StrategyState
var chase_state : StrategyState
var attack_state : StrategyState

var target : Mech

func decide_action() -> MechAction:
	
	var path = mech.get_path_next_to_node_2d(target)
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
