extends Node
class_name GamePhase

@export var game : Game

func enter():
	pass
	
func exit():
	pass
	
func transition_to(next_phase):
	exit()
	game.phase = next_phase
	game.phase.enter()
