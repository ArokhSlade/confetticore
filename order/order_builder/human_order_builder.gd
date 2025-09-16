extends OrderBuilder
class_name HumanOrderBuilder

const Hex = HexMap.Hex

var selected_ally_mech : Mech
var selected_enemy_mech : Mech
var selected_hex : Hex

func on_hex_clicked(hex : Hex):
	var order = null
	if not hex.is_occupied():
		selected_hex = hex
	elif hex.occupant is Mech:
		var mech = hex.occupant as Mech
		if affiliation == mech.affiliation:
			selected_ally_mech = mech
		
