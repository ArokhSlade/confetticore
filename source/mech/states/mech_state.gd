extends Node
class_name MechState

var mech : Mech

func setup(new_mech):
	mech = new_mech

func execute_tick():
	#NOTE(ArokhSlade, 2025 09 17): do it like this
	# mech.do_mech_things()
	# var next_state = mech.some_state
	# check_transition(next_state)
	pass

func check_transition(next_state):
	if next_state != mech.state:
		mech.state.exit()
		next_state.enter()
		mech.state = next_state

func enter():
	pass
	
func exit(): 
	pass
	
func die():
	check_transition(mech.dead_state)
	
