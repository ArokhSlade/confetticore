extends Node2D
class_name Paths

@export var path_marker : PackedScene
var markers : Array
var mech_paths : Dictionary

func update_mech_path(mech, point_path):
	if (mech_paths.has(mech)):
		var old_path = mech_paths[mech]
		remove_child(old_path)
		old_path.queue_free() #TODO(Gerald 2025 08 22): is this right?
			
	var path = Path.new()
	path.setup(point_path, path_marker)
	mech_paths[mech] = path
	add_child(path)
	mech.set_path(path)
