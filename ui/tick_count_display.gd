extends Panel

@onready var tick_count_label = $VBoxContainer/TickCountLabel

func update(tick_count):
	tick_count_label.text = str(tick_count)
