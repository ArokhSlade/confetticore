extends Node2D
class_name Mechs

signal finished_moving_all

@export var mech_step_timer : Timer
@export var hex_map : HexMap

var has_finished_moving_all = true
var mechs_finished_moving_count = 0

func setup(mech_step_time : float):
	mech_step_timer.wait_time = mech_step_time
	for mech : Mech in get_children():
		mech.setup(hex_map)
		mech.finished_moving.connect(on_mech_finished_moving)

func get_mechs():
	return get_children()

func get_mechs_count():
	return get_children().size()

func update_mech_path(mech, target):
	mech.update_path(target)

func move_all():
	if get_mechs_count() == 0:
		finished_moving_all.emit()
	
	for mech : Mech in get_children():
		mech.start_moving()
	
	has_finished_moving_all = false
	mech_step_timer.start()
		
func on_mech_finished_moving():
	mechs_finished_moving_count += 1
	var mechs_count = get_mechs_count()
	if mechs_count == mechs_finished_moving_count:
		finish_moving_all()
		
func finish_moving_all():	
	mechs_finished_moving_count = 0
	has_finished_moving_all = true
	mech_step_timer.stop()
	finished_moving_all.emit()

func _on_mech_step_timer_timeout():
	assert(not has_finished_moving_all)
	for mech : Mech in get_children():
		mech.update_state()
