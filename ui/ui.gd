extends Node
class_name UI

const GameData = Game.GameData

signal execute_phase_requested
signal order_created(order)

@export var player_commander : Commander

@onready var hud = $HUD
@onready var player_input = $PlayerInput

class UIData:
	var selected_mech : Mech = null

func setup(hex_map, player_commander):
	#player_input.setup(hex_map, player_commander)
	hud.setup(hex_map)

func update(game_data):
	hud.update(game_data)

func switch_to_planning_mode():
	hud.switch_to_planning_mode()
	#player_input.wake_up()

func switch_to_execute_mode():
	hud.switch_to_execute_mode()
	#player_input.go_to_sleep()
	
func update_tick_count_display(tick_count, ticks_per_turn):
	hud.update_tick_count_display(tick_count, ticks_per_turn)

func _on_hud_execute_button_pressed():
	execute_phase_requested.emit()

func _on_player_input_order_created(order):
	order_created.emit(order)
