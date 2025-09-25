extends CanvasLayer
class_name HUD

signal execute_button_pressed

@export var execute_button : Button
@export var mech_info_panel : MechInfoPanel
@export var arrow_scene : PackedScene

@export var arrows : Node2D

@onready var tick_count_display = $TickCountDisplay

func switch_to_planning_mode(get_orders):
	execute_button.disabled = false
	tick_count_display.hide()
	var orders = get_orders.call()
	draw_arrows(orders)
	
func switch_to_execute_mode(ticks_per_turn):
	execute_button.disabled = true
	tick_count_display.update(0, ticks_per_turn)
	tick_count_display.show()
	erase_arrows()

#HACK(Gerald, 2025 09 25): hud is not supposed to know about orders or HexMap, it's supposed to get OrderVisualizers not Orders
func draw_arrows(orders):
	const Arrow = preload("res://ui/arrow/arrow.gd")
	for order : Order in orders:
		if order == null or order is StayOrder:
			continue
		
		var arrow : Arrow = arrow_scene.instantiate()
		arrow.from = order.executor.global_position
		var HACK_hex_map = order.executor.hex_map
		if order is MoveOrder:
			arrow.to = HACK_hex_map.hex_to_global(order.target)
		elif order is AttackOrder:
			arrow.to = order.target.global_position
		arrow.from = arrow.to_local(arrow.from)
		arrow.to = arrow.to_local(arrow.to)
		
		arrows.add_child(arrow)


func erase_arrows():
	for arrow in arrows.get_children():
		arrows.remove_child(arrow)
		arrow.queue_free()

func _on_execute_button_pressed():
	execute_button_pressed.emit()
	
func update_mech_info_panel(mech):
	mech_info_panel.show()
	mech_info_panel.update(mech)

func hide_mech_info_panel():
	mech_info_panel.hide()

func update_tick_count_display(tick_count, ticks_per_turn):
	tick_count_display.update(tick_count, ticks_per_turn)
