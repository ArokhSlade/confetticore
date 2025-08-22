extends CanvasLayer
class_name HUD

signal execute_button_pressed

@export var execute_button : Button

func switch_to_planning_mode():
	execute_button.disabled = false
	
func switch_to_execute_mode():
	execute_button.disabled = true

func _on_execute_button_pressed():
	execute_button_pressed.emit()
