extends Node2D
class_name Mech

signal finished_moving

@export var pilot : Pilot
var hit_points : int

@export var level : Level
@export var path : Path

func _to_string():
	return "mech"

func get_coords():
	var coords = level.hex_layer.local_to_map(self.position)
	return coords

func move_step():
	if path == null:
		finished_moving.emit()
		return
		
	if not path.is_empty():
		global_position = path.points[0]
		path.pop_front()
		
	if path.is_empty():
		path = null
		finished_moving.emit()
			
func set_path(new_path):
	path = new_path
