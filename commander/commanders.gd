extends Node2D

const PlayerCommander = preload("res://commander/player_commander.gd")
const AICommander = preload("res://commander/ai_commander.gd")

var player_commander : PlayerCommander
var ai_commanders :  Array[AICommander]
	
	
func setup(hex_map):
	setup_player_commander(hex_map)
	setup_ai_commanders(hex_map)


func setup_player_commander(hex_map):
	player_commander = null
	for commander : Commander in get_children():
		if commander is PlayerCommander:
			player_commander = commander
			break	
			
	if player_commander:
		player_commander.setup(hex_map)
	else:
		push_warning("this Commanders has no player_commander")


func setup_ai_commanders(hex_map):
	var all_mechs = self
	var init_data = AICommander.InitData.new(hex_map, all_mechs)
	
	ai_commanders = []
	for commander : Commander in get_children():
		if commander is AICommander:
			commander.setup(init_data)
			ai_commanders.append(commander)


func get_mechs():
	var result = []
	for mechs_owner in get_children():
		assert(mechs_owner.has_method("get_mechs"))
		result.append_array(mechs_owner.get_mechs())
	return result


func start_execution():
	for commander : Commander in get_children():
		commander.start_execution()
	
func execute_tick():
	for commander : Commander in get_children():
		commander.execute_tick()
	
func stop_execution():
	for commander : Commander in get_children():
		commander.stop_execution()

func let_ai_give_orders():
	for commander : AICommander in ai_commanders:
		commander.give_orders()

func update_order(order, in_commander):
	for commander : Commander in get_children():
		if commander == in_commander:
			commander.give_order(order)
