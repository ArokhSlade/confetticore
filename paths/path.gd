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

func _init(path_marker : PackedScene, in_hex_map : HexMap, in_steps : Array[Hex] = []):
	hex_map = in_hex_map
	steps = in_steps
	markers = []	
	for step in steps:
		var global_coords = hex_map.hex_to_global(step)
		var marker = path_marker.instantiate()
		add_child(marker)
		marker.global_position = global_coords
		markers.append(marker)

var front : Hex:
	get:
		var result = null
		if not is_empty():
			result = steps[0]
		return result

func pop_front() -> Hex:
	assert(is_valid() and not is_empty())
	var result = front
	markers[0].queue_free()
	steps = steps.slice(1)
	markers = markers.slice(1)
	return result

var back : Hex:
	get:
		var result = steps[steps.size()-1]
		return result

func pop_back() -> Hex:
	assert(is_valid() and not is_empty())
	var result = back
	markers[steps.size()-1].queue_free()
	steps = steps.slice(0,-1)
	markers = markers.slice(0,-1)
	return result

func is_empty():
	assert(markers.is_empty() == steps.is_empty())
	return markers.is_empty()

func is_valid():
	var result = true 
	result = result and (steps == null and markers == null)
	result = result or (steps.size() == markers.size())
	return result
