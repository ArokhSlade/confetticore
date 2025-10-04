extends Node
class_name OrderBuilder

const Hex = HexMap.Hex

var executor : Mech
var attack_target : Mech
var move_target : Hex
var mold : Order

func set_executor(mech):
	executor = mech

func set_attack_target(mech):
	attack_target = mech

func set_move_target(hex):
	move_target = hex
	
func set_mold(specific_order : Order):
	mold = specific_order

func finalize() -> Order:
	mold.executor = executor
	if mold is IdleOrder:
		pass
	elif mold is MoveOrder:
		mold.target = move_target
	elif mold is AttackOrder:
		mold.target = attack_target
	else:
		push_error("order type not supported")
	return mold

func reset():
	executor = null
	attack_target = null
	move_target = null
