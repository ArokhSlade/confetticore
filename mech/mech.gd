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
@onready var attacking_state = $States/Attacking
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
var order : Order
var plan : Plan

var combat_target : Mech

func setup(in_hex_map):
	for mech_state : MechState in $States.get_children():
		mech_state.setup(self)
	state = idle_state
	hex_map = in_hex_map
	path_finder.setup(hex_map)

func start_execution():
	reset_action_memory()
	update_plan()

#TODO(ArokhSlade, 2025 08 18): delete these parameters
func reset_action_memory():
	combat_target = null
	path = null

#TODO:delete
func stop_execution():
	pass

func execute_tick():
	var action : Action = decide_next_action()
	var target_state = state
	match(action):
		Action.IDLE:
			target_state = idle_state
		Action.MOVE:
			target_state = moving_state
		Action.ATTACK:
			target_state = attacking_state
	state.check_transition(target_state)
	state.execute_tick()

func update_order(in_order:Order):
	order = in_order

func update_plan():
	if order == null:
		order = Order.new()
		order.type = Order.Type.NONE
	match order.type:
		Order.Type.ATTACK:
			plan = make_attack_plan(order.attack_target)
		Order.Type.MOVE:
			plan = make_move_plan(order.move_target)
		_:
			plan = Plan.new()

class Plan:
	pass
	
class AttackPlan extends Plan:
	var target : Mech
	var path : Path

enum Action {
	NONE,
	MOVE,
	ATTACK,
	IDLE
}

func make_attack_plan(enemy : Mech):
	
	var enemy_cube = hex_map.get_cube_coords(enemy)
	var path = path_finder.compute_path(enemy_cube)
	if path.back.cube_coords == enemy_cube:
		path.pop_back()
		
	var attack_plan = AttackPlan.new()
	
	attack_plan.target = enemy
	attack_plan.path = path
	
	return attack_plan
	
	
class MovePlan extends Plan:
	var path : Path
		
func make_move_plan(target_hex):
	var path = path_finder.compute_path_to_hex(target_hex)	
	var move_plan = MovePlan.new()
	move_plan.path = path	
	return move_plan	

func move():
	if not path.is_empty():
		var old_hex = hex_map.global_to_hex(global_position)
		var new_hex = path.pop_front()
		var new_position = hex_map.hex_to_global(new_hex)
		global_position = new_position
		hex_map.move_occupant(self, old_hex, new_hex)

func decide_next_action():
	var action = Action.NONE
	if plan is MovePlan:
		path = plan.path
		if path == null or path.is_empty():
			action = Action.IDLE
		#TODO(ArokhSlade, 2025 09 18): delete?
		#elif combat_target != null and distance_to(combat_target) <= attack_range:
			#action = Action.ATTACK
		else: 
			var front_hex = path.front
			if front_hex.is_occupied():
				action = Action.IDLE
			else:
				action = Action.MOVE
	elif plan is AttackPlan:
		combat_target = plan.target
		if combat_target == null or combat_target.is_dead():
			action = Action.IDLE
		elif distance_to(combat_target) > attack_range:
			print_debug("combat target out of range")
			action = Action.IDLE
		else: 
			action = Action.ATTACK
		
	return action

func attack():
	assert(combat_target != null)
	assert(distance_to(combat_target) <= attack_range)
	$AnimationPlayer.play("attack")
	combat_target.modify_hp(-damage)

func modify_hp(value:int):
	assert(state != dead_state)
	hp += value
	if hp < 0:
		die()

func die():
	state.die()

func idle():
	pass
	
func path_next_to(enemy_cube):
	path = path_finder.compute_path(enemy_cube)
	if path.back.cube_coords == enemy_cube:
		path.pop_back()

func distance_to(target_node2d):
	return hex_map.distance_node2d(self, target_node2d)

func is_dead():
	assert(state == dead_state or hp > 0)
	return hp <= 0
