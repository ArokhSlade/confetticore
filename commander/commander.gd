extends Node
class_name Commander

signal order_submitted(order)

@export var team_color : Color
@export var id : int

func submit_order(order):
	order_submitted.emit(order)

func get_data():
	pass
