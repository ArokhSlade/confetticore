extends Order
class_name MoveOrder

class Data extends Order.Data:
	var target : HexMap.Hex
	
func get_data():
	var super_result = super()
	var result = Data.new()
	result.executor = super_result.executor
	result.attack_target = super_result.attack_target
	result.move_target = super_result.move_target
	result.target = target
	return result

var target : HexMap.Hex
