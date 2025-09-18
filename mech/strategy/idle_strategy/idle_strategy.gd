extends Strategy

func setup_order(order : Order):
	assert(order.type == Order.Type.IDLE)

func decide_action() -> MechAction:
	var action = mech.idle_action
	return action
