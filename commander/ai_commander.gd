extends Commander

class InitData:
	var hex_map : HexMap
	var all_mechs : Node ## has_method("get_mechs")
	
	func _init(in_hex_map, in_all_mechs):
		self.hex_map = in_hex_map
		self.all_mechs = in_all_mechs

var all_mechs : Node

func setup(init_data):
	super(init_data.hex_map)
