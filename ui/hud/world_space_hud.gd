extends Node2D
class_name WorldSpaceHUD

@export var arrow_scene : PackedScene
@export var arrows : Node2D

const Arrow = preload("res://ui/arrow/arrow.gd")

var order_visualizers : Dictionary[Mech, Arrow]

func switch_to_planning_mode(orders):
	arrows.show()
	draw_arrows(orders)

func switch_to_execute_mode():
	arrows.hide()

#HACK(Gerald, 2025 09 25): hud is not supposed to know about orders or HexMap, it's supposed to get OrderVisualizers not Orders
func draw_arrows(orders):
	for order : Order in orders:
		update_order(order)

func update_order(order):
	if (order == null):
		#BUG(ArokhSlade 2025 09 28): why does this happen
		push_warning("upadte order requested on null order")
		return
	var order_visualizer = order_visualizers.get(order.executor)
	if order_visualizer != null:
		#TODO(ArokhSlade, 2025 09 26): order_visualizer.update()
		update_order_visualizer(order_visualizer, order)
	else:
		order_visualizer = create_order_visualizer(order)
		if order_visualizer != null:
			order_visualizers[order.executor] = order_visualizer
			arrows.add_child(order_visualizer)

func create_order_visualizer(order):	
	if order == null or order is StayOrder:
		return null
		
	var arrow : Arrow = arrow_scene.instantiate()
	arrow.from = order.executor.global_position
	var HACK_hex_map = order.executor.hex_map
	if order is MoveOrder:
		arrow.to = HACK_hex_map.hex_to_global(order.target)
	elif order is AttackOrder:
		arrow.to = order.target.global_position
	arrow.from = arrow.to_local(arrow.from)
	arrow.to = arrow.to_local(arrow.to)	
	return arrow

func update_order_visualizer(order_visualizer, order):
	#HACK(ArokhSlade, 2025 09 26): abusing contextual knowledge: order_visualizer exists so it's a move or attack order.
	if order == null or order is StayOrder:
		if order_visualizer != null:
			assert(order_visualizer.parent != null)
			order_visualizer.parent.remove_child(order_visualizer)
			order_visualizer.queue_free()
		order_visualizers.erase(order.executor)
	elif order is MoveOrder or order is AttackOrder:
		order_visualizer.from = order.executor.global_position
		var HACK_hex_map = order.executor.hex_map
		if order is MoveOrder:
			order_visualizer.to = HACK_hex_map.hex_to_global(order.target)
		elif order is AttackOrder:
			order_visualizer.to = order.target.global_position
		order_visualizer.from = order_visualizer.to_local(order_visualizer.from)
		order_visualizer.to = order_visualizer.to_local(order_visualizer.to)
