extends Node
class_name HUDMode

const GameData = Game.GameData
const UIData = UI.UIData

@export var hud : HUD

func update(game_data, ui_data):
	hud.screen_space_hud.update_mech_info_panel(ui_data.selected_mech)
