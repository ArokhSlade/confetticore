extends Node
class_name OrderBuilder

const Affiliation = Mech.Affiliation
@export var affiliation : Affiliation = Affiliation.NONE

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
