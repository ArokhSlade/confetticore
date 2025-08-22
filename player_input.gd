extends Node

@export var input_state : InputState = InputState.NEUTRAL
@export var hex_map : ConfetticoreHexagonTileMapLayer

var selected_mech : Mech = null

enum InputState {
	NEUTRAL,
	MECH_SELECTED,
	
}

func _process(_delta):
	
	match (input_state):
		InputState.NEUTRAL:
			pass
		InputState.MECH_SELECTED:
			pass
		_:
			pass
			
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("player input mouse button left")
			match (input_state):
				InputState.NEUTRAL:
					var mouse_hex = hex_map.get_closest_cell_from_mouse()
					selected_mech = hex_map.try_get_mech(mouse_hex)
					if selected_mech != null:
						input_state = InputState.MECH_SELECTED
				InputState.MECH_SELECTED:
					var selected_mech_coords = hex_map.get_coords(selected_mech)
					var from_id = hex_map.pathfinding_get_point_id(selected_mech_coords)
					
					var mouse_hex = hex_map.get_closest_cell_from_mouse()
					var mouse_coords = hex_map.cube_to_map(mouse_hex)
					
					var to_id = hex_map.pathfinding_get_point_id(mouse_coords)
					
					var path = hex_map.astar.get_point_path(from_id, to_id)
					selected_mech.set_path(path)
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
		
					
			
		
