extends Node2D
class_name Path

const HexMap = preload("res://confetticore_hexagon_tilemaplayer.gd")
const Hex = HexMap.Hex

var points : PackedVector2Array
var markers : Array[PathMarker]
var hex_map : HexMap

var length: int:
	get:
		assert(points.size() == markers.size())
		return points.size()

func setup(path : PackedVector2Array, path_marker: PackedScene, in_hex_map : HexMap):
	hex_map = in_hex_map
	points = path
	for point in path:
		var marker = path_marker.instantiate()
		add_child(marker)
		marker.global_position = point
		markers.append(marker)

func pop_front() -> Hex:
	assert(is_valid() and not is_empty())
	var result = Hex.new(hex_map, points[0])
	markers[0].queue_free()
	points = points.slice(1)
	markers = markers.slice(1)
	return result

var front : Hex:
	get:
		var result = Hex.new(hex_map, points[0])
		return result

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
