extends Node2D
class_name Mechs

@export var hex_map : HexMap


func setup():
	for mech : Mech in get_children():
		mech.setup(hex_map)

func get_mechs():
	return get_children()

func get_mechs_count():
	return get_children().size()

func update_mech_orders(mech, target):
	mech.update_orders(target)

func start_execution():
	for mech : Mech in get_children():
		mech.start_execution()

func execute_tick():
	for mech : Mech in get_children():
		mech.execute_tick()

func stop_execution():
	for mech : Mech in get_children():
		mech.stop_execution()
