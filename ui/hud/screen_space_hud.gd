extends CanvasLayer
class_name ScreenSpaceHUD

signal execute_button_pressed

@export var execute_button : Button
@export var mech_info_panel : MechInfoPanel

@onready var tick_count_display = $TickCountDisplay


func update_mech_info_panel(mech):
	if mech != null:
		mech_info_panel.show()
		mech_info_panel.update(mech)
	else:
		mech_info_panel.hide()

func switch_to_planning_mode():
	execute_button.disabled = false
	tick_count_display.hide()
	
	
func switch_to_execute_mode(ticks_per_turn):
	execute_button.disabled = true
	tick_count_display.update(0, ticks_per_turn)
	tick_count_display.show()


func _on_execute_button_pressed():
	execute_button_pressed.emit()
	
func show_mech_info_panel(mech):
	mech_info_panel.show()
	mech_info_panel.update(mech)

func hide_mech_info_panel():
	mech_info_panel.hide()

func update_tick_count_display(tick_count, ticks_per_turn):
	tick_count_display.update(tick_count, ticks_per_turn)
	
