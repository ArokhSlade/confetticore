extends Node2D
class_name Mech

enum Affiliation {
	RED,
	BLUE
}

const Hex = HexMap.Hex

signal finished_moving

@onready var dormant_state = $States/Dormant
@onready var moving_state = $States/Moving

@export var pilot : Pilot
@export var move_range : int
@export var path_finder : PathFinder
@export var hp : int = 5
@export var damage: int = 2
@export var affiliation = Affiliation.RED

var state : MechState
var path : Path
var hex_map : HexMap

var combat_target : Mech


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

func update_state():
	var old_state = state
	state = state.next()
	if state != old_state:
		old_state.on_exit()
		state.on_enter()

func _move_step():
	if not path.is_empty():
		var old_hex = hex_map.global_to_hex(global_position)
		var new_hex = path.pop_front()
		var new_position = hex_map.hex_to_global(new_hex)
		global_position = new_position
		hex_map.move_occupant(self, old_hex, new_hex)

func _wait_step():
	if not path.is_empty():
		path.pop_back()

func _finish_moving():
	path = null
	finished_moving.emit()

func start_exectution():
	pass

func start_moving():
	assert(state == dormant_state)
	state.switch(moving_state)

func update_target(target_cube):
	var hex = hex_map.cube_to_hex(target_cube)
	if hex.is_occupied():
		var occupant = hex.occupant
		if occupant is Mech:
			if occupant.affiliation != self.affiliation:
				plan_attack(occupant)
	else:
		plan_move(target_cube)

func plan_attack(enemy : Mech):
	var enemy_cube = hex_map.get_cube_coords(enemy)
	path_next_to(enemy_cube)
	combat_target = enemy
	pass

func path_next_to(enemy_cube):
	path = path_finder.compute_path(enemy_cube)
	path.pop_back()

func plan_move(target_cube):
	path = path_finder.compute_path(target_cube)
	combat_target = null
