extends Player
class_name HumanPlayer

@onready var input_interpreter = $InputInterpreter

func setup(hex_map):
	input_interpreter.setup(hex_map)
	
func _on_input_interpreter_mech_selected(mech):
	print("mech selected")
