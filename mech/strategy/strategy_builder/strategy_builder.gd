extends Node
class_name StrategyBuilder


func _create_attack_strategy(attack_order, path_finder):
	const AttackStrategy = preload("res://mech/strategy/attack_strategy/attack_strategy.gd")
	var attack_strategy = AttackStrategy.new()
	attack_strategy.target = attack_order.target
	attack_strategy.path_finder = path_finder
	return attack_strategy
	
func _create_move_strategy(move_order, path_finder):
	const MoveStrategy = preload("res://mech/strategy/move_strategy/move_strategy.gd")
	var move_strategy = MoveStrategy.new()
	move_strategy.target = move_order.target
	move_strategy.path_finder = path_finder
	return move_strategy
	
func _create_idle_strategy(idle_order):
	const IdleStrategy = preload("res://mech/strategy/idle_strategy/idle_strategy.gd")
	var idle_strategy = IdleStrategy.new()
	return idle_strategy

func create_strategy(order, path_finder):
	var result = null
	if order is IdleOrder:
		result = _create_idle_strategy(order)
	elif order is MoveOrder:
		result = _create_move_strategy(order, path_finder)
	elif order is AttackOrder:
		result = _create_attack_strategy(order, path_finder)
	else:
		push_error("cannot create strategy: unexpected order type")
	return result
