extends Node
class_name Commander

class Data:
	var mechs : Mechs.Data

func get_data():
	var result = Data.new()
	result.mechs = mechs.get_data()
	return result

@export var mechs : Mechs

func setup(hex_map):
	mechs.setup(hex_map, self)

func give_order(order):
	mechs.update_order(order)

func get_mechs():
	var result = mechs.get_mechs()
	return result

func start_execution():
	mechs.start_execution()
	
func execute_tick():
	mechs.execute_tick()
	
func stop_execution():
	mechs.stop_execution()
	
func _to_string():
	return str(name)
