extends Panel
class_name MechInfoPanel

@export var move_info_label : Label

func update(mech):
	move_info_label.text = "Move: %d/%d" % [mech.path_length, mech.move_range]
