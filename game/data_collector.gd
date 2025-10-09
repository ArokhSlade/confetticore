extends Node


@export var game : Game

class GameData:
	var ticks_per_turn = 0
	var tick_count = 0
	var orders = []
	var selected_mech = null

func collect_data():
	var game_data = GameData.new()
	game_data.tick_count = game.tick_count
	game_data.ticks_per_turn = game.level.ticks_per_turn
	game_data.orders = get_all_orders()
	game_data.selected_mech = game.ui.player_input.selected_mech
	return game_data
	

func get_all_orders():
	var mechs = game.level.commanders.get_mechs()
	var orders = []
	for mech : Mech in mechs:
		orders.append(mech.order)
	return orders
