extends Node
class_name PlayerInput

signal mech_selected(mech)
signal mech_deselected
signal mech_path_changed(mech, target_cube)

@export var hex_map : ConfetticoreHexagonTileMapLayer

@export var neutral_state : PlayerInputState
@export var mech_selected_state : PlayerInputState

var dormant = false
var input_state : PlayerInputState
var selected_mech : Mech = null

func setup(new_hex_map):
	input_state = neutral_state
	hex_map = new_hex_map

func _unhandled_input(event):
	if not dormant:
		var new_state = input_state
		if event is InputEventMouseButton:
			if event.pressed:
				if event.button_index == MOUSE_BUTTON_LEFT:
					new_state = input_state.on_primary_click()
				elif event.button_index == MOUSE_BUTTON_RIGHT:
					new_state = input_state.on_secondary_click()			
		try_transition_to(new_state)

func try_transition_to(new_state):
	if new_state != input_state:
		input_state.on_exit()
		input_state = new_state
		input_state.on_enter()

func wake_up():
	assert(dormant, "tried to finish sleeping while not dormant")
	dormant = false
	
func go_to_sleep():
	assert(not dormant, "tried to go to sleep while dormant")
	dormant = true
