extends Panel

@onready var tick_count_label = $VBoxContainer/TickCountLabel

func update(tick_count, ticks_per_turn):
	tick_count_label.text = "Ticks: %d / %d" % [tick_count, ticks_per_turn]
