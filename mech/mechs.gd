extends Node2D
class_name Mechs

func setup(hex_map, affiliation):
	for mech : Mech in get_children():
		mech.setup(hex_map, affiliation)

func get_mechs():
	return get_children()

func get_mechs_count():
	return get_children().size()

func update_order(order):
	order.executor.update_order(order)

func start_execution():
	for mech : Mech in get_children():
		mech.start_execution()

func execute_tick():
	for mech : Mech in get_children():
		mech.execute_tick()

func stop_execution():
	for mech : Mech in get_children():
		mech.stop_execution()
