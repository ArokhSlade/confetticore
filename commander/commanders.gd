extends Node

signal order_submitted(order)

func submit_order(order):
	order_submitted.emit(order)

func setup(hex_map):
	for commander in get_children():
		commander.setup(hex_map)

func get_data():
	var result = []
	for commander in get_children():
		result.append(commander.get_data())

func _on_ai_commander_order_submitted(order):
	submit_order(order)


func _on_player_commander_order_submitted(order):
	submit_order(order)
