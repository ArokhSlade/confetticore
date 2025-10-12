extends Commander

@onready var player_input = $PlayerInput

func setup(hex_map):
	super(hex_map)
	player_input.setup(hex_map, self)
