extends CanvasLayer
class_name HUD

signal execute_button_pressed

@export var execute_button : Button
@export var mech_info_panel : MechInfoPanel
@onready var tick_count_display = $TickCountDisplay

func switch_to_planning_mode():
	execute_button.disabled = false
	
func switch_to_execute_mode():
	execute_button.disabled = true

func _on_execute_button_pressed():
	execute_button_pressed.emit()
	
func update_mech_info_panel(mech):
	mech_info_panel.show()
	mech_info_panel.update(mech)

func hide_mech_info_panel():
	mech_info_panel.hide()

func update_tick_count_display(tick_count):
	tick_count_display.update(tick_count)
