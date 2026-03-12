extends Panel

@onready var tick_count_label = $VBoxContainer/TickCountLabel

func update(tick_count, ticks_per_turn):
	var ticks_remaining = ticks_per_turn - tick_count
	tick_count_label.text = "Ticks: %d / %d" % [ticks_remaining, ticks_per_turn]
