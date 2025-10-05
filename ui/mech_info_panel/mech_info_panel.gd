extends Panel
class_name MechInfoPanel

@export var move_info_label : Label

func update(mech):
	#TODO(ArokhSlade, 2025 10 05): str(affiliation) not working as expected
	move_info_label.text = "Hit Points: %d\nAttack Range: %d\nDamage: %d\nPilot: %s\nAffiliation: %s" % [mech.hp, mech.attack_range, mech.damage, mech.pilot.call_sign, str(mech.affiliation)]
