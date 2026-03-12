extends Node2D

func _unhandled_input(event):
	print(event.as_text())
	if event.is_action_pressed("PrimaryClick"):
		print("""event.is_action_pressed("PrimaryClick"):""")
	if event is InputEventMouseButton:
		print("""InputEventMouseButton at global: %s, local: %s""" % [event.global_position, event.position])
	if event.is_action_pressed("PrimaryClick") and event is InputEventMouseButton:
		print("""it's both""")
		
