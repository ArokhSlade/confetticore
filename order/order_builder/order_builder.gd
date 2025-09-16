extends Node
class_name OrderBuilder

const Hex = HexMap.Hex

var executor : Mech
var attack_target : Mech
var move_target : Hex
var type : Order.Type

#static func create_attack_order(attack_target):
	#var order = AttackOrder.new()
	#order.attack_target = attack_target
	#return order
#
#static func create_move_order(move_target):
	#var order = MoveOrder.new()
	#order.move_target = move_target
	#return order
#
#static func create_stay_order():
	#var order = StayOrder.new()
	#return order

func set_executor(mech):
	executor = mech

func set_attack_target(mech):
	attack_target = mech

func set_move_target(hex):
	move_target = hex
	
func set_type(order_type):
	type = order_type

func finalize():
	var result = Order.new()
	result.type = type
	result.executor = executor
	match type:
		Order.Type.ATTACK:			
			result.attack_target = attack_target
		Order.Type.MOVE:
			result.move_target = move_target
		_:
			push_error("order type %s not supported" % str(type))
	return result

func reset():
	executor = null
	attack_target = null
	move_target = null
