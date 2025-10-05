extends Node
class_name AIPlayer

signal order_created(order)

@export var ai_commander : Commander

@onready var order_builder = $OrderBuilder

var all_mechs : Mechs
var hex_map : HexMap

var opposing_mechs : Array[Mech]
var owned_mechs : Array[Mech]


func setup(mechs, in_hex_map):
	all_mechs = mechs
	hex_map = in_hex_map

func give_orders():
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
		order_created.emit(order)
		
func get_opposing_mechs():
	for mech in all_mechs.get_mechs():
		if mech.affiliation != ai_commander.affiliation:
			opposing_mechs.append(mech)
			
func get_owned_mechs():
	for mech in all_mechs.get_mechs():
		if mech.affiliation == ai_commander.affiliation:
			owned_mechs.append(mech)

func pick_target_mech():
	var result = null
	for mech in opposing_mechs:
		if mech.is_dead():
			continue
		result = mech
		break
	return result
		
