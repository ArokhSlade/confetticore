extends Game

@onready var human_player = $HumanPlayer

func _ready():
	super._ready()
	human_player.setup(level.hex_map)
