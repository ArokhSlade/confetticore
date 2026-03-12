extends MechAction

var target : Mech

func execute_tick():
	assert(target != null)
	assert(mech.distance_to(target) <= mech.attack_range)
	mech.animation_player.play("attack")
	target.modify_hp(-mech.damage)
