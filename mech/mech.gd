extends Node2D
class_name Mech

const HexMap = preload("res://confetticore_hexagon_tilemaplayer.gd")
const Hex = HexMap.Hex


signal finished_moving

@onready var dormant_state = $States/Dormant
@onready var moving_state = $States/Moving

@export var pilot : Pilot
@export var move_range : int
@export var path_finder : PathFinder

var state : MechState
var path : Path
var hex_map : HexMap
var hex : Hex

var path_length : int:
	get:
		if path:
			return path.length
		else:
			return 0

func setup(in_hex_map):
	for mech_state : MechState in $States.get_children():
		mech_state.setup(self)
	state = dormant_state
	hex_map = in_hex_map
	path_finder.setup(hex_map)
	hex = hex_map.get_hex_at_global(global_position)

func update_state():
	var old_state = state
	state = state.next()
	if state != old_state:
		old_state.on_exit()
		state.on_enter()

func _move_step():
	if not path.is_empty():
		var old_hex = hex
		#hex = path.pop_front()
		#
		#global_position = hex.global_coords
		#moved.emit(self, old_hex, hex)
		#
		#hex_map.move(self, hex)
		global_position = path.points[0]
		hex = path.pop_front()
		hex_map.move_occupant(self, old_hex, hex)
		#
		#hex_map.move(self, hex)

func _finish_moving():
	path = null
	finished_moving.emit()

func start_moving():
	assert(state == dormant_state)
	state.switch(moving_state)

func update_path(target):
	path = path_finder.compute_path(target)
