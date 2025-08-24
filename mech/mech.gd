extends Node2D
class_name Mech

signal finished_moving

var has_finished_moving = true

@export var pilot : Pilot

@export var move_points : int = 5

@export var level : Level
@export var path : Path

@export var move_range : int

var path_length : int:
	get:
		if path:
			return path.length
		else:
			return 0

func get_coords():
	var coords = level.hex_layer.local_to_map(self.position)
	return coords



func move_step():
	if has_finished_moving:
		return
		
	if path == null or path.is_empty():
		finish_turn()
		return
		
	if not path.is_empty():
		global_position = path.points[0]
		path.pop_front()
		
func finish_turn():
	path = null
	has_finished_moving = true
	finished_moving.emit()

func start_moving():
	has_finished_moving = false
	
func set_path(new_path):
	path = new_path
