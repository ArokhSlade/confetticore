@tool
extends Node
@onready var sub_viewport = $HBoxContainer/SubViewportContainer/SubViewport
@onready var sub_viewport_2 = $HBoxContainer/SubViewportContainer2/SubViewport


func _ready():
	sub_viewport.size = get_tree().root.size
	sub_viewport.size.x /= 2
	sub_viewport_2.world_2d = sub_viewport.world_2d
	sub_viewport_2.size = sub_viewport.size
	
func _process(delta):
	pass
