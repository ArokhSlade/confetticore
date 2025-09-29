extends Node2D
class_name WorldSpaceHUD

@export var arrow_scene : PackedScene
@export var order_visualizers : Node2D
@export var order_visualizer_factory : OrderVisualizerFactory

const Arrow = preload("res://ui/arrow/arrow.gd")

func _ready():
	clean_up_after_render()

func clean_up_after_render():
	while true:
		await RenderingServer.frame_post_draw	
		_reset_order_visualizers()

func visualize_orders(orders):
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
	var result = order_visualizer_factory.create_order_visualizer(order)
	assert (result != null)
	return result
