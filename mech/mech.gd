extends Node2D
class_name Mech

signal finished_moving

@onready var dormant_state = $States/Dormant
@onready var moving_state = $States/Moving

@export var pilot : Pilot

#TODO(Arokh, 2025 08 26): obsolete?
@export var move_points : int = 5

#TODO(Arokh, 2025 08 26): why export?
@export var path : Path

@export var move_range : int

var state : MechState

var path_length : int:
	get:
		if path:
			return path.length
		else:
			return 0

func setup():
	for mech_state : MechState in $States.get_children():
		mech_state.setup(self)
	state = dormant_state

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
