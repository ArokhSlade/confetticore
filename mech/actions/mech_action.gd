extends Node
class_name MechAction

signal performed

var mech : Mech

func setup(in_mech):
	mech = in_mech

func execute_tick():
	pass
