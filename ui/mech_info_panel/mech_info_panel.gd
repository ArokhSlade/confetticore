extends Panel
class_name MechInfoPanel

@export var move_info_label : Label

func affiliation_name(affiliation: Mech.Affiliation):
	var result = Mech.Affiliation.find_key(affiliation)
	return result

func update(mech):
	move_info_label.text = "Hit Points: %d\nAttack Range: %d\nDamage: %d\nPilot: %s\nAffiliation: %s" % [mech.hp, mech.attack_range, mech.damage, mech.pilot.call_sign, str(affiliation_name(mech.affiliation))]
