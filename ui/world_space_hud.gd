extends Node2D
class_name WorldSpaceHUD

@export var arrow_scene : PackedScene
@export var arrows : Node2D

func switch_to_planning_mode(get_orders):
	var orders = get_orders.call()
	draw_arrows(orders)

func switch_to_execute_mode():
	erase_arrows()

#HACK(Gerald, 2025 09 25): hud is not supposed to know about orders or HexMap, it's supposed to get OrderVisualizers not Orders
func draw_arrows(orders):
	const Arrow = preload("res://ui/arrow/arrow.gd")
	for order : Order in orders:
		if order == null or order is StayOrder:
			continue
		
		var arrow : Arrow = arrow_scene.instantiate()
		arrow.from = order.executor.global_position
		var HACK_hex_map = order.executor.hex_map
		if order is MoveOrder:
			arrow.to = HACK_hex_map.hex_to_global(order.target)
		elif order is AttackOrder:
			arrow.to = order.target.global_position
		arrow.from = arrow.to_local(arrow.from)
		arrow.to = arrow.to_local(arrow.to)
		
		arrows.add_child(arrow)


func erase_arrows():
	for arrow in arrows.get_children():
		arrows.remove_child(arrow)
		arrow.queue_free()
