extends Node
class_name HUDMode

const GameData = Game.Data
const UIData = UI.UIData

@export var hud : HUD

func update(game_data : Game.Data):
	
	var selected_mech = game_data.level.commanders.player_commander.player_input.selected_mech
	hud.screen_space_hud.update_mech_info_panel(selected_mech)
