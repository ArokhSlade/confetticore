extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for signal_info in self.get_signal_list():
		var handler_name = "_on_" + signal_info.name
		var _signal = self.get(signal_info.name) as Signal
		if self.has_method(handler_name):
			var handler = self.get(handler_name)
			_signal.connect(handler)


func _on_visibility_changed():
	print("visibility changed!")
