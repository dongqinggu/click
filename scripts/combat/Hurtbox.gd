extends Area2D

signal damaged(damage: Damage)

var _invincible := false

func take_hit(damage: Damage) -> void:
	if _invincible:
		return
	emit_signal("damaged", damage)

func set_invincible_for(seconds: float) -> void:
	_invincible = true
	await get_tree().create_timer(seconds).timeout
	_invincible = false
