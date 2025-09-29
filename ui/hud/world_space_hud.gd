extends Node2D
class_name WorldSpaceHUD

@export var arrow_scene : PackedScene
@export var order_visualizers : Node2D

const Arrow = preload("res://ui/arrow/arrow.gd")

func visualize_orders(orders):	
	_reset_order_visualizers()	
	for order in orders:
		var order_visualizer = create_order_visualizer(order)
		order_visualizers.add_child(order_visualizer)
	order_visualizers.show()

func hide_order_visualizers():
	order_visualizers.hide()

func _reset_order_visualizers():
	for arrow in order_visualizers.get_children():
		order_visualizers.remove_child(arrow)
		arrow.queue_free()

func create_order_visualizer(order):	
	if order == null or order is StayOrder:
		return null
		
	var arrow : Arrow = arrow_scene.instantiate()
	arrow.from = order.executor.global_position
	#HACK(ArokhSlade, 2025 09 29): hud is not supposed to know about orders or hexmap
	var HACK_hex_map = order.executor.hex_map
	if order is MoveOrder:
		arrow.to = HACK_hex_map.hex_to_global(order.target)
	elif order is AttackOrder:
		arrow.to = order.target.global_position
	arrow.from = arrow.to_local(arrow.from)
	arrow.to = arrow.to_local(arrow.to)	
	return arrow
