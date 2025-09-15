extends Node2D
class_name Mech

enum Affiliation {
	RED,
	BLUE
}

const Hex = HexMap.Hex

@onready var idle_state = $States/Idle
@onready var moving_state = $States/Moving
@onready var attack_state = $States/Attacking
@onready var dead_state = $States/Dead

@export var pilot : Pilot
@export var path_finder : PathFinder
@export var hp : int = 5
@export var damage: int = 2
@export var affiliation = Affiliation.RED
@export var attack_range : int = 1

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
	state = idle_state
	hex_map = in_hex_map
	path_finder.setup(hex_map)

func execute_tick():
	var old_state = state
	state = state.next()
	check_switch(state, old_state)

func check_switch(new_state, old_state):
	if new_state != old_state:
		old_state.on_exit()
		state = new_state
		state.on_enter()
		
func is_dead():
	return hp <= 0

func _move_step():
	if not path.is_empty():
		var old_hex = hex_map.global_to_hex(global_position)
		var new_hex = path.pop_front()
		var new_position = hex_map.hex_to_global(new_hex)
		global_position = new_position
		hex_map.move_occupant(self, old_hex, new_hex)
		
func attack(target):
	assert(target != null)
	assert(distance_to(target) <= attack_range)
	$AnimationPlayer.play("attack")
	combat_target.modify_hp(-damage)

func modify_hp(value:int):
	assert(state != dead_state)
	hp += value
	if hp < 0:
		die()

func die():
	state.switch(dead_state)

func _wait_step():
	pass

#TODO(ArokhSlade, 2025 09 11): 
# this looks like transition logic of the planning state
func start_execution():
	if combat_target != null:
		if distance_to(combat_target) <= attack_range:
			check_switch(attack_state, state)
		else:
			check_switch(moving_state, state)
	else:
		check_switch(moving_state, state)

func stop_execution():
	check_switch(moving_state, state)

func update_orders(target_cube):
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
	if path.back.cube_coords == enemy_cube:
		path.pop_back()

func plan_move(target_cube):
	path = path_finder.compute_path(target_cube)
	combat_target = null
	
func distance_to(target_node2d):
	return hex_map.distance_node2d(self, target_node2d)
