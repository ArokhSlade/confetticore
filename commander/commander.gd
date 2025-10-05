extends Node
class_name Commander

signal order_given(order)
			
@export var affiliation : Mech.Affiliation = Mech.Affiliation.RED

func give_order(order):
	order_given.emit(order)
