extends Node
class_name OrderBuilder

const Hex = HexMap.Hex

var executor : Mech
var attack_target : Mech
var move_target : Hex
var type : Order.Type
var mold : Order

func create_attack_order(attack_target):
	var order = AttackOrder.new()
	order.attack_target = attack_target
	return order

func create_move_order(move_target):
	var order = MoveOrder.new()
	order.move_target = move_target
	return order

func create_stay_order():
	var order = StayOrder.new()
	return order

func set_executor(mech):
	executor = mech

func set_attack_target(mech):
	attack_target = mech

func set_move_target(hex):
	move_target = hex
	
func set_type(order_type):
	type = order_type

func set_mold(specific_order : Order):
	mold = specific_order

func finalize() -> Order:
	mold.executor = executor
	if mold is StayOrder:
		pass
	elif mold is MoveOrder:
		mold.target = move_target
	elif mold is AttackOrder:
		mold.target = attack_target
	else:
		push_error("order type %s not supported" % str(type))
	return mold

func reset():
	executor = null
	attack_target = null
	move_target = null
