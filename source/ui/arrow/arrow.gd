@tool
extends Node2D

@export var from : Vector2i:
	set(value):
		from = value
		if is_inside_tree():
			shaft.points[0] = from as Vector2
			
@export var to : Vector2i :
	set(value):
		to = value
		if is_inside_tree():
			shaft.points[-1] = to as Vector2
			head.global_position = to
			align_head()

@export var shaft : Line2D
@export var head : Polygon2D

func align_head():
	var look_direction = (to - from) as Vector2
	var look_at_target = head.position + look_direction
	look_at_target = self.global_transform * look_at_target
	head.look_at(look_at_target)
	
func _ready():
	# trigger is_inside_tree()-restricted setter code that was skipped during _init()
	_refresh_values() 
	
func _refresh_values():
	from = from
	to = to
