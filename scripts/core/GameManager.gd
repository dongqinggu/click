extends Node

@export var rooms_before_boss := 6
var current_room := 1

func on_room_cleared() -> void:
	current_room += 1
