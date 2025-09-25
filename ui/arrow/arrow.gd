@tool
extends Node2D

@export var from : Vector2i
@export var to : Vector2i

@export var neck : Line2D
@export var head : Polygon2D

func _ready():
	setup()

func setup():
	update_positions()

func update_positions():
	neck.points[0] = from as Vector2
	neck.points[1] = to as Vector2
	head.position = to as Vector2 
	var look_direction = (to - from) as Vector2
	var look_at_target = (head.position) + look_direction
	look_at_target = self.global_transform * look_at_target
	head.look_at(look_at_target)

func _process(_delta):
	update_positions()
