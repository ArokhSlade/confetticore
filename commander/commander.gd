extends Node

signal order_given(order)

func give_order(order):
	order_given.emit(order)
