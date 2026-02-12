extends Node

signal changed(current_hp: float, max_hp: float)
signal died

@export var max_hp: float = 100.0
var current_hp: float

func _ready() -> void:
	current_hp = max_hp
	emit_signal("changed", current_hp, max_hp)

func apply_damage(value: float) -> void:
	current_hp = maxf(current_hp - value, 0.0)
	emit_signal("changed", current_hp, max_hp)
	if current_hp <= 0.0:
		emit_signal("died")
