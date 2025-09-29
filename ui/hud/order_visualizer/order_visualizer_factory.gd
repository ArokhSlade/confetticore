extends Node
class_name OrderVisualizerFactory	

const NullOrderVisualizer = preload("res://ui/hud/order_visualizer/null_order_visualizer.tscn")

func create_order_visualizer(in_order):
	
	var result = null
	
	if in_order == null:
		result = NullOrderVisualizer.instantiate()
	elif in_order is IdleOrder:
		result = IdleOrderVisualizer.instantiate()
		
	result.order = in_order
	
	return result
