extends Node2D
class_name Path

var points : PackedVector2Array
var markers : Array[PathMarker]

func setup(path : PackedVector2Array, path_marker: PackedScene):
	points = path
	for point in path:
		var marker = path_marker.instantiate()
		add_child(marker)
		marker.global_position = point
		markers.append(marker)

func pop_front():
	assert(is_valid() and not is_empty())
	markers[0].queue_free()
	points = points.slice(1)
	markers = markers.slice(1)

func set_start(start_index):
	points = points.slice(start_index)
	markers = markers.slice(start_index)

func is_empty():
	assert(markers.is_empty() == points.is_empty())
	return markers.is_empty()

func is_valid():
	var result = true 
	result = result and (points == null and markers == null)
	result = result or (points.size() == markers.size())
	return result
