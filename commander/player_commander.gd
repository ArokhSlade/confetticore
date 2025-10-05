extends Commander

@onready var player_input = $PlayerInput

func setup(hex_map):
	super(hex_map)
	player_input.setup(hex_map, self)

func _on_player_input_order_created(order):
	give_order(order)

func get_data():
	return player_input.get_data()
