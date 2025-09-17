extends Node
class_name MechState

var mech : Mech

func setup(new_mech):
	mech = new_mech

func next() -> MechState:
	return self

func on_enter():
	pass
	
func on_exit(): 
	pass
