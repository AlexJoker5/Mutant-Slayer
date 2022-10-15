extends Node

export(int) var max_heath = 3
onready var health = max_heath setget set_health

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
