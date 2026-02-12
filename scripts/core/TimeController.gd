extends Node

var _active := false

func do_hitstop(duration: float, scale: float = 0.05) -> void:
	if _active:
		return
	_active = true
	Engine.time_scale = clampf(scale, 0.01, 1.0)
	await get_tree().create_timer(duration * (1.0 / maxf(scale, 0.01)), true, false, true).timeout
	Engine.time_scale = 1.0
	_active = false
