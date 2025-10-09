extends Commander

func setup(hex_map):
	super(hex_map)

func _on_player_input_order_created(order):
	give_order(order)
