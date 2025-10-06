extends Node
class_name OrderVisualizerFactory	

const NullOrderVisualizer = preload("res://ui/hud/order_visualizer/null_order_visualizer.tscn")
const IdleOrderVisualizer = preload("res://ui/hud/order_visualizer/idle_order_visualizer.tscn")
const MoveOrderVisualizer = preload("res://ui/hud/order_visualizer/move_order_visualizer.tscn")
const AttackOrderVisualizer = preload("res://ui/hud/order_visualizer/attack_order_visualizer.tscn")

var hex_map : HexMap

func setup(in_hex_map):
	hex_map = in_hex_map
	
func create_order_visualizer(in_order):	
	var result = null
		
	if in_order == null:
		result = NullOrderVisualizer.instantiate()
		
	elif in_order is IdleOrder.Data:
		result = IdleOrderVisualizer.instantiate()
		
	elif in_order is MoveOrder.Data:
		result = MoveOrderVisualizer.instantiate()
		result.start_position = in_order.executor.global_position
		
		result.target_position = hex_map.hex_to_global(in_order.target)
		
	elif in_order is AttackOrder.Data:
		result = AttackOrderVisualizer.instantiate()
		result.start_position = in_order.executor.global_position
		result.target_position = in_order.target.global_position
		
	result.order = in_order
	
	return result
