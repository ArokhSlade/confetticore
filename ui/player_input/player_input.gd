extends Node
class_name PlayerInput

signal mech_selected(mech)
signal mech_deselected
signal mech_target_selected(mech, target_cube)

@export var neutral_state : PlayerInputState
@export var mech_selected_state : PlayerInputState

var dormant = false
var input_state : PlayerInputState
var selected_mech : Mech = null
var hex_map : HexMap

func setup(new_hex_map):
	input_state = neutral_state
	hex_map = new_hex_map

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

func _on_input_receiver_primary_click_pressed(global_viewport_coords = Vector2i.ZERO):
	if not dormant:
		var new_state = input_state.on_primary_click(global_viewport_coords)
		try_transition_to(new_state)

func _on_input_receiver_secondary_click_pressed(global_viewport_coords = Vector2i.ZERO):
	if not dormant:
		var new_state = input_state.on_secondary_click(global_viewport_coords)
		try_transition_to(new_state)

func _on_input_receiver_pointer_moved(global_viewport_coords):
	if not dormant:
		var new_state = input_state.on_pointer_moved(global_viewport_coords)
		try_transition_to(new_state)
