@tool
extends OrderVisualizer

@onready var arrow = $Arrow

@export var start_position : Vector2i : 
	set(value):
		start_position = value
		arrow.from = start_position
		
@export var target_position : Vector2i : 
	set(value):
		target_position = value
		arrow.to = target_position

@export var color : Color : 
	set(value):
		color = value
		arrow.modulate = color

func _ready():
	refresh_values()

func refresh_values():
	start_position = start_position
	target_position = target_position
	color = color
