extends MechState

func next():
	if mech.path == null or mech.path.is_empty():
		next_state = mech.dormant_state	
	else:
		mech._move_step()
	
	return next_state

func on_exit():
	mech._finish_moving()
