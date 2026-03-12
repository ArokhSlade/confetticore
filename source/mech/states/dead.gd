extends MechState


func enter():
	mech.hide()
	
func exit():
	mech.show()

func start_execution():
		return

func execute_tick():
	assert(mech.hp <= 0, "mech has positive hp while in dead state")

func die():
	push_error("die() called while in dead state")
