extends Node

const Hex = HexMap.Hex

signal mech_selected(mech)
signal mech_deselected
signal mech_target_selected(mech, target_cube)
signal context_menu_opened(position)
signal context_menu_closed()

@export var neutral_state : PlayerInputState
@export var mech_selected_state : PlayerInputState
var hex_map : HexMap

var input_state :PlayerInputState
var selected_ally_mech : Mech
var selected_enemy_mech : Mech
var selected_hex : Hex

func setup(in_hex_map):
	hex_map = in_hex_map

func try_get_mech_at_position(position):
	var result = null
	var global_position = viewport_to_world(position)
	var hex = hex_map.get_closest_hex_from_global_coords(global_position)
	if hex != null and hex.is_occupied():
		if hex.occupant is Mech:
			result = hex.occupant
	return result
	
func viewport_to_world(position):
	var viewport = get_tree().root
	var viewport_to_world_transform = viewport.get_canvas_transform().affine_inverse()
	var global_position = viewport_to_world_transform * position
	return global_position

func _on_input_receiver_primary_click_pressed(position):
	var mech = try_get_mech_at_position(position)
	if mech != null:
		mech_selected.emit(mech)

func _on_input_receiver_secondary_click_pressed(position):
	mech_deselected.emit()
