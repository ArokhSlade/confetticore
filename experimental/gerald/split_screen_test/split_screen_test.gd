@tool
extends Node

@onready var sub_viewport = $HBoxContainer/SubViewportContainer/SubViewport
@onready var sub_viewport_2 = $HBoxContainer/SubViewportContainer2/SubViewport


func _ready():
	sub_viewport_2.world_2d = sub_viewport.world_2d
	
func _process(delta):
	pass
