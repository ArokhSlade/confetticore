extends Node2D
const Pilot = preload("res://pilot.gd")
const Level = preload("res://level.gd")

signal position_changed(Vector2i)

@export var pilot : Pilot
var hit_points : int

@export var level : Level

func _to_string():
	return "mech"

func attack(target):
	print(self.to_string() + " attacked " + target.to_string())
	
func move(target):
	print(self.to_string() + " moved to " + target.to_string())

func get_coords():
	var coords = level.hex_layer.local_to_map(self.position)
	return coords

func _ready():
	_on_position_changed(get_coords())

func _physics_process(delta):
	var coords = get_coords()
	var old_coords = coords
	
	if Input.is_action_just_pressed("left"):
		coords.x += -1
	if Input.is_action_just_pressed("right"):
		coords.x += 1
	if Input.is_action_just_pressed("down"):
		coords.y += +1
	if Input.is_action_just_pressed("up"):
		coords.y += -1	
	
	position = level.hex_layer.map_to_local(coords)
	if (coords != old_coords):
		position_changed.emit(position)

func _on_position_changed(position: Vector2i):
	var coords = level.hex_layer.local_to_map(position)
	print("mech coords %s" % coords)
