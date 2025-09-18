extends Node
class_name Strategy

var mech : Mech
var states: Array[StrategyState]
var state : StrategyState

func setup(new_mech):
	mech = new_mech

func setup_order(order):
	pass

func decide_action() -> MechAction:
	return mech.idle_action
