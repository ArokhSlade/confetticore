extends Node2D
class_name Mech

signal position_changed(Vector2i)

@export var pilot : Pilot
var hit_points : int

@export var level : Level

@export var path : PackedVector2Array = []
@export var path_marker : PackedScene

var markers : Array
var markers_changed_since_last_draw = false

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

func _process(_delta):
	draw_path()

func _physics_process(_delta):
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

func _on_position_changed(new_position: Vector2i):
	var coords = level.hex_layer.local_to_map(new_position)
	print("mech coords %s" % coords)

func set_path(new_path : PackedVector2Array):
	clear_path()
	self.path = new_path
	
func clear_path():
	for marker : Node in markers:
		marker.queue_free()
	markers = []
	
	path = []
		
	markers_changed_since_last_draw = true
	
func draw_path():
	
	if not markers_changed_since_last_draw:
		return
	
	print("drawing path")
	for point in path:
		var marker = path_marker.instantiate()
		add_child(marker)
		marker.global_position = point
		markers.append(marker)
	markers_changed_since_last_draw = false
		
