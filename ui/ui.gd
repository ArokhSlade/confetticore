extends Node
class_name UI

signal execute_phase_requested

@onready var hud = $HUD
@onready var input_receiver = $InputReceiver

@export var player_input : PlayerInput

var data_collector : DataCollector
const DataCollector = preload("res://game/data_collector.gd")


func setup(hex_map, data_collector, player_input : PlayerInput):
	self.data_collector = data_collector
	self.player_input = player_input
	
	connect_player_to_hud()
	connect_input_to_player()
	hud.setup(hex_map)


func connect_player_to_hud():
	for signal_info in player_input.get_signal_list():
		var handler_name = "_on_player_input_" + signal_info.name
		if self.has_method(handler_name):
			var handler = self.get(handler_name)
			player_input.connect(signal_info.name, handler)

func connect_input_to_player():
	for signal_info in input_receiver.get_signal_list():
		var handler_name = "_on_input_receiver_"  + signal_info.name
		if player_input.has_method(handler_name):
			var handler = player_input.get(handler_name)
			input_receiver.connect(signal_info.name, handler)


func update():
	var game_data = data_collector.collect_data()
	hud.update(game_data)

func switch_to_planning_mode():
	hud.switch_to_planning_mode()
	player_input.wake_up()

func switch_to_execute_mode():
	hud.switch_to_execute_mode()
	player_input.go_to_sleep()
	
func update_tick_count_display(tick_count, ticks_per_turn):
	hud.update_tick_count_display(tick_count, ticks_per_turn)

func _on_hud_execute_button_pressed():
	execute_phase_requested.emit()

func _on_player_input_mech_selected(mech):
	hud.on_mech_selected(mech)

func _on_player_input_mech_deselected():
	hud.on_mech_deselected()
