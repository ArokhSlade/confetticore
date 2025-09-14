extends GamePhase

@export var tick_duration : float = .5
@export var tick_timer : Timer
var tick_count = 0

func enter():
	game.level.start_execution()
	tick_timer.start(tick_duration)
	game.ui.switch_to_execute_mode(game.level.ticks_per_turn)

func exit():
	game.level.stop_execution()
	tick_timer.stop()
	tick_count = 0
	
func execute_tick():
	game.level.execute_tick()
	tick_count += 1
	game.ui.update_tick_count_display(tick_count, game.level.ticks_per_turn)

func _on_tick_timer_timeout():
	assert(tick_count < game.level.ticks_per_turn)
	execute_tick()
	if tick_count == game.level.ticks_per_turn:
		transition_to(game.planning_phase)
