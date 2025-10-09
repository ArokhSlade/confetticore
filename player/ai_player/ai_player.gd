extends Node
class_name AIPlayer

var ai_commander : Commander

@onready var order_builder = $OrderBuilder

var all_mechs : Node
var hex_map : HexMap

var opposing_mechs : Array[Mech]
var owned_mechs : Array[Mech]

func setup(hex_map, ai_commander, all_mechs):
	self.hex_map = hex_map
	self.ai_commander = ai_commander
	assert(all_mechs.has_method("get_mechs"))
	self.all_mechs = all_mechs

func generate_orders():
	get_owned_mechs()
	get_opposing_mechs()
	for mech in owned_mechs:
		var order = Order.new()
		order_builder.set_executor(mech)
		
		var target_mech = pick_target_mech()
		if target_mech != null:
			order_builder.set_mold(AttackOrder.new())
			order_builder.set_attack_target(target_mech)
		else:
			order_builder.set_mold(IdleOrder.new())
		order = order_builder.finalize()
		ai_commander.give_order(order)
		
func get_opposing_mechs():
	for mech in all_mechs.get_mechs():
		if mech.affiliation != ai_commander:
			opposing_mechs.append(mech)
			
func get_owned_mechs():
	#ERROR(2025 10 09, ArokhSlade): Trying to assign an array of type "Array[Node]" to a variable of type "Array[Mech]".
	#owned_mechs = ai_commander.get_mechs() as Array[Mech]
	owned_mechs = []
	for mech : Mech in ai_commander.get_mechs():
		owned_mechs.append(mech)

func pick_target_mech():
	var result = null
	for mech in opposing_mechs:
		if mech.is_dead():
			continue
		result = mech
		break
	return result
		
