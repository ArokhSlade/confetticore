extends Node
class_name PlayerInput

signal mech_path_changed(mech, point_path)

@export var input_state : InputState = InputState.NEUTRAL
@export var hex_map : ConfetticoreHexagonTileMapLayer

var selected_mech : Mech = null

enum InputState {
	NEUTRAL,
	MECH_SELECTED,
	DORMANT
}

func setup(new_hex_map):
	hex_map = new_hex_map

func _process(_delta):
	
	match (input_state):
		InputState.NEUTRAL:
			pass
		InputState.MECH_SELECTED:
			pass
		_:
			pass
			
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("player input mouse button left")
			match (input_state):
				InputState.NEUTRAL:
					var mouse_hex = hex_map.get_closest_cell_from_mouse()
					
					# TODO(Gerald, 2025 08 22): control flow cuts across. better way?
					selected_mech = hex_map.try_get_mech(mouse_hex)
					if selected_mech != null:
						input_state = InputState.MECH_SELECTED
				InputState.MECH_SELECTED:
					var selected_mech_coords = hex_map.get_coords(selected_mech)
					var from_id = hex_map.pathfinding_get_point_id(selected_mech_coords)
					
					var mouse_hex = hex_map.get_closest_cell_from_mouse()
					var mouse_coords = hex_map.cube_to_map(mouse_hex)
					
					var to_id = hex_map.pathfinding_get_point_id(mouse_coords)
					
					var point_path = hex_map.astar.get_point_path(from_id, to_id)
					mech_path_changed.emit(selected_mech, point_path)
				_:
					pass
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			match (input_state):
				InputState.NEUTRAL:
					pass
				InputState.MECH_SELECTED:
					input_state = InputState.NEUTRAL
					selected_mech = null
				_:
					pass
	
	if event is InputEventMouseMotion:
		pass

func finish_sleeping():
	match (input_state):
		InputState.DORMANT:
			input_state = InputState.NEUTRAL
		InputState.NEUTRAL, InputState.MECH_SELECTED:
			print_debug("tried to finish sleeping while not dormant")
		_:
			pass

func go_to_sleep():
	match (input_state):
		InputState.NEUTRAL, InputState.MECH_SELECTED:
			input_state = InputState.DORMANT
		InputState.DORMANT:
			print_debug("tried to go to sleep while dormant")
		_:
			pass
