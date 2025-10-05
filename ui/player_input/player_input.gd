extends Node
class_name PlayerInput

signal mech_selected(mech)
signal mech_deselected
signal order_created(order)

@export var neutral_state : PlayerInputState
@export var ally_mech_selected_state : PlayerInputState
@export var enemy_mech_selected_state : PlayerInputState
@export var order_builder : OrderBuilder

var player_commander : Commander

var affiliation : Commander : 
	get:
		return player_commander

var DEBUG_woke_up_once = false
var dormant = false
var input_state : PlayerInputState
var selected_mech : Mech = null
var hex_map : HexMap

func setup(in_hex_map, commander):
	input_state = neutral_state
	hex_map = in_hex_map
	player_commander = commander
		
func try_transition_to(new_state):
	if new_state != input_state:
		input_state.on_exit()
		input_state = new_state
		input_state.on_enter()

func wake_up():
	#HACK(ArokhSlade, 2025 09 29): we want the assertion for debugging, but it shouldn't fire on first load
	if DEBUG_woke_up_once:
		assert(dormant, "tried to wake up while not dormant")
	else:
		DEBUG_woke_up_once = true
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

func global_viewport_to_world_coords(global_viewpoint_coords):
	var viewport = get_tree().root
	var viewport_to_world_transform = viewport.get_canvas_transform().affine_inverse()
	var global_coords = viewport_to_world_transform * global_viewpoint_coords
	return global_coords
