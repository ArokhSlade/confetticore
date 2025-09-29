@tool
extends OrderVisualizer

@onready var arrow = $Arrow

@export var start_position : Vector2i : 
	set(value):
		start_position = value
		if is_inside_tree():
			arrow.from = start_position
		
@export var target_position : Vector2i : 
	set(value):
		target_position = value
		if is_inside_tree():
			arrow.to = target_position

@export var color : Color : 
	set(value):
		color = value
		if is_inside_tree():
			arrow.modulate = color

func _ready():
	# trigger is_inside_tree()-restricted setter code that was skipped during _init()
	_refresh_values()

func _refresh_values():
	start_position = start_position
	target_position = target_position
	color = color
