extends Commander

class Data extends Commander.Data:
	var player_input : PlayerInput.Data

func get_data():
	# TODO(ArokhSlade 2025 10 06): make this work. figure out how to re-use base method.
	# var result = super()
	# result.player_input = player_input.get_data()	
	var result = Data.new()
	result.mechs = mechs.get_data()
	result.player_input = player_input.get_data()
	return result
	

@onready var player_input = $PlayerInput

func setup(hex_map):
	super(hex_map)
	player_input.setup(hex_map, self)

func _on_player_input_order_created(order):
	give_order(order)
