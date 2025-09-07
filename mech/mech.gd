extends Node2D
class_name Mech

const HexMap = preload("res://confetticore_hexagon_tilemaplayer.gd")

signal finished_moving

@onready var dormant_state = $States/Dormant
@onready var moving_state = $States/Moving

@export var pilot : Pilot
@export var move_range : int

var state : MechState
var path : Path
var hex_map : HexMap

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

func update_state():
	var old_state = state
	state = state.next()
	if state != old_state:
		old_state.on_exit()
		state.on_enter()

func _move_step():
	if not path.is_empty():
		global_position = path.points[0]
		path.pop_front()
		
func _finish_moving():
	path = null
	finished_moving.emit()

func start_moving():
	assert(state == dormant_state)
	state.switch(moving_state)
	
func set_path(new_path):
	path = new_path
