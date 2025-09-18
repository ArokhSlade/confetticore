extends Strategy

var idle_state : StrategyState
var chase_state : StrategyState
var attack_state : StrategyState

var target : Mech

func setup_order(order):
	assert(order.type == Order.Type.ATTACK)
	target = order.attack_target
	

func decide_action() -> MechAction:
	#TODO(ArokhSlade 2025 09 18): temporary, replace with mech.attack(target)
	#or perhaps attack.set_target(target)?
	mech.combat_target = target
	mech.path = mech.get_path_next_to_node_2d(target)
	var action = mech.idle_action
	if target == null or target.is_dead():
		action = mech.idle_action
	elif mech.distance_to(target) > mech.attack_range:
		if mech.path == null or mech.path.is_empty():
			action = mech.idle_action
		else:
			var front_hex = mech.path.front
			if front_hex.is_occupied():
				action = mech.idle_action
			else:
				action = mech.move_action
	else: 
		action = mech.attack_action	
	return action
