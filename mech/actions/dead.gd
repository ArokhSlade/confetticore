extends MechAction

func execute_tick():
	assert(mech.hp <= 0, "mech has positive hp while in dead state")
	mech.hide()
