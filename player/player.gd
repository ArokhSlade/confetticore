extends Node
class_name Player

@export var game : Game

func give_order(unit, order):
	unit.update_order()
