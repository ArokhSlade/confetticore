extends Node
class_name OrderVisualizerFactory	

const NullOrderVisualizer = preload("res://ui/hud/order_visualizer/null_order_visualizer.tscn")
const IdleOrderVisualizer = preload("res://ui/hud/order_visualizer/idle_order_visualizer.tscn")
const MoveOrderVisualizer = preload("res://ui/hud/order_visualizer/move_order_visualizer.tscn")
const AttackOrderVisualizer = preload("res://ui/hud/order_visualizer/attack_order_visualizer.tscn")

func create_order_visualizer(in_order):	
	var result = null
		
	if in_order == null:
		result = NullOrderVisualizer.instantiate()
		
	elif in_order is IdleOrder:
		result = IdleOrderVisualizer.instantiate()
		
	elif in_order is MoveOrder:
		result = MoveOrderVisualizer.instantiate()
		result.start_position = in_order.executor.global_position
		
		#HACK(ArokhSlade, 2025 09 29): is there a better way to get the target position? should this factory have access to the HexMap? should executor be required to expose a HexMap?
		var HACK_hex_map = in_order.executor.hex_map		
		result.target_position = HACK_hex_map.hex_to_global(in_order.target)
		
	elif in_order is AttackOrder:
		result = AttackOrderVisualizer.instantiate()
		result.start_position = in_order.executor.global_position
		result.target_position = in_order.target.global_position
		
	result.order = in_order
	
	return result
