extends Node
class_name Order

const Hex = HexMap.Hex

class Data:
	var executor : Mech
	var attack_target : Mech
	var move_target : Hex

func get_data():
	var result = Data.new()
	result.executor = executor
	result.attack_target = attack_target
	result.move_target = move_target
	return result

var executor : Mech
var attack_target : Mech
var move_target : Hex
