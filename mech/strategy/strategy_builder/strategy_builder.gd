extends Node
class_name StrategyBuilder


func _create_attack_strategy(attack_order):
	const AttackStrategy = preload("res://mech/strategy/attack_strategy/attack_strategy.gd")
	var attack_strategy = AttackStrategy.new()
	attack_strategy.target = attack_order.target
	return attack_strategy
	
func _create_move_strategy(move_order):
	const MoveStrategy = preload("res://mech/strategy/move_strategy/move_strategy.gd")
	var move_strategy = MoveStrategy.new()
	move_strategy.target = move_order.target
	return move_strategy
	
func _create_idle_strategy(idle_order):
	const IdleStrategy = preload("res://mech/strategy/idle_strategy/idle_strategy.gd")
	var idle_strategy = IdleStrategy.new()
	return idle_strategy

func create_strategy(order):
	var result = null
	if order is StayOrder:
		result = _create_idle_strategy(order)
	elif order is MoveOrder:
		result = _create_move_strategy(order)
	elif order is AttackOrder:
		result = _create_attack_strategy(order)
	else:
		push_error("cannot create strategy: unexpected order type")
	return result
