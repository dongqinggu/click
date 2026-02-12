extends Node

var state := "idle"

func set_state(next_state: String) -> void:
	state = next_state
