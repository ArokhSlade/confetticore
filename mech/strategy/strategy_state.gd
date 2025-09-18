extends Node
class_name StrategyState

@export var strategy : Strategy
var mech : Mech

func setup(in_mech):
	mech = in_mech

func execute_tick():
	pass

func enter():
	pass
	
func exit(): 
	pass

func check_transition(next_state):
	if next_state != strategy.state:
		strategy.state.exit()
		next_state.enter()
		strategy.state = next_state
