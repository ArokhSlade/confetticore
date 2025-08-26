extends Node
class_name MechState

var mech : Mech

var next_state = self

func setup(new_mech):
	mech = new_mech

func next() -> MechState:
	return next_state

func on_enter():
	next_state = self
	
func on_exit(): 
	pass

func switch(new_state):
	next_state = new_state
