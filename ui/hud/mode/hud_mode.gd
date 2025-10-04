extends Node
class_name HUDMode

const GameData = Game.GameData
const UIData = UI.UIData

@export var hud : HUD

func update(game_data):
	hud.screen_space_hud.update_mech_info_panel(game_data.selected_mech)
