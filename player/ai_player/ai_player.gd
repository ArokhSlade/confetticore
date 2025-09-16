extends Node
class_name AIPlayer

signal order_created(order)

@export var affiliation = Mech.Affiliation.BLUE

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
		order.executor = mech
		
		var target_mech = pick_target_mech()
		if target_mech != null:
			order.type = Order.Type.ATTACK
			order.attack_target = target_mech
		else:	
			order.type = Order.Type.MOVE
			order.move_target = hex_map.get_hex(mech)
		order_created.emit(order)
		
func get_opposing_mechs():
	for mech in all_mechs.get_mechs():
		if mech.affiliation != affiliation:
			opposing_mechs.append(mech)
			
func get_owned_mechs():
	for mech in all_mechs.get_mechs():
		if mech.affiliation == affiliation:
			owned_mechs.append(mech)

func pick_target_mech():
	var result = null
	for mech in opposing_mechs:
		if mech.is_dead():
			continue
		result = mech
		break
	return result
		
