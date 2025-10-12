extends Node2D

@onready var hex_map = $HexMap

func _ready():
	pass # Replace with function body.



func _process(delta):
	var tile_map_data = hex_map.tile_map_data
	print("tile map data retrieved")
