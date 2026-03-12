extends MechAction

func execute_tick():
	mech.hide()
	mech.hp = 0
	performed.emit()
