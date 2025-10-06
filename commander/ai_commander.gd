extends Commander

class Data extends Commander.Data:
	pass	

func get_data():
	var result = Data.new()
	result.mechs = mechs.get_data()
	return result

## NOTE(ArokhSlade 2025 10 06): needed to "overload" setup() for different sub-classes
class InitData:
	var hex_map : HexMap
	var all_mechs : Node ## has_method("get_mechs")
	
	func _init(in_hex_map, in_all_mechs):
		self.hex_map = in_hex_map
		self.all_mechs = in_all_mechs
		

@onready var ai_player = $AIPlayer

var all_mechs : Node

func setup(init_data):
	super(init_data.hex_map)
	ai_player.setup(init_data.all_mechs, init_data.hex_map)

func give_orders():
	ai_player.give_orders()

func _on_ai_player_order_created(order):
	give_order(order)
