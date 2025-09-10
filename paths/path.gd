extends Node2D
class_name Path

const Hex = HexMap.Hex

var steps : Array[Hex]
var markers : Array[PathMarker]
var hex_map : HexMap

var length: int:
	get:
		assert(steps.size() == markers.size())
		return steps.size()

func setup(path : PackedVector2Array, path_marker: PackedScene, in_hex_map : HexMap):
	hex_map = in_hex_map
	steps = []
	for point in path:
		var step = hex_map.get_hex_at_global(point)
		steps.append(step)
		var marker = path_marker.instantiate()
		add_child(marker)
		marker.global_position = point
		markers.append(marker)

func pop_front() -> Hex:
	assert(is_valid() and not is_empty())
	var result = front
	markers[0].queue_free()
	steps = steps.slice(1)
	markers = markers.slice(1)
	return result

var front : Hex:
	get:
		var result = steps[0]
		return result

func set_start(start_index):
	steps = steps.slice(start_index)
	markers = markers.slice(start_index)

func is_empty():
	assert(markers.is_empty() == steps.is_empty())
	return markers.is_empty()

func is_valid():
	var result = true 
	result = result and (steps == null and markers == null)
	result = result or (steps.size() == markers.size())
	return result
