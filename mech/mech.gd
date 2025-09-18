extends Node2D
class_name Mech

enum Affiliation {
	NONE,
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
	state.execute_tick()
		
func is_dead():
	assert(state == dead_state or hp > 0)
	return hp <= 0

func move_step():
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
	state.die()

func wait_step():
	pass

#TODO(ArokhSlade, 2025 09 11): 
# this looks like transition logic of the planning state
func start_execution():
	state.start_execution()

func stop_execution():
	pass

func update_order(order:Order):
	match order.type:
		Order.Type.ATTACK:
			plan_attack(order.attack_target)
		Order.Type.MOVE:
			plan_move(order.move_target)

func plan_attack(enemy : Mech):
	var enemy_cube = hex_map.get_cube_coords(enemy)
	path_next_to(enemy_cube)
	combat_target = enemy
	pass

func path_next_to(enemy_cube):
	path = path_finder.compute_path(enemy_cube)
	if path.back.cube_coords == enemy_cube:
		path.pop_back()

func plan_move(target_hex):
	path = path_finder.compute_path_to_hex(target_hex)
	combat_target = null
	
func distance_to(target_node2d):
	return hex_map.distance_node2d(self, target_node2d)
