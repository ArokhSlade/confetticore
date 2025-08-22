extends Node2D
class_name Mech

signal finished_moving

@export var pilot : Pilot
var hit_points : int

@export var level : Level

@export var path : PackedVector2Array = []
@export var path_marker : PackedScene

var markers : Array
var markers_dirty = false
var step_index : int = 0

func _to_string():
	return "mech"

func get_coords():
	var coords = level.hex_layer.local_to_map(self.position)
	return coords

func _process(_delta):
	draw_path()

func move_step():
	if not path.is_empty() and step_index < path.size():
		step_index += 1
		if step_index < path.size():
			global_position = path[step_index]
			markers[0].queue_free()
			markers = markers.slice(1)
	if path.is_empty() or step_index == path.size():
		finished_moving.emit()
			
func set_path(new_path : PackedVector2Array):
	clear_path()
	self.path = new_path
	
func clear_path():
	for marker : Node in markers:
		marker.queue_free()
	markers = []	
	path = []		
	markers_dirty = true
	
func draw_path():	
	if not markers_dirty:
		return
	
	print("drawing path")
	for point in path:
		var marker = path_marker.instantiate()
		add_child(marker)
		marker.global_position = point
		markers.append(marker)
	markers_dirty = false
