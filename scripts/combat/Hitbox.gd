extends Area2D

@export var base_damage: float = 10.0
@export var knockback: float = 140.0
@export var crit_chance: float = 0.1
@export var crit_mul: float = 1.5
@export var hitstop: float = 0.05

var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	_rng.randomize()
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if not area.has_method("take_hit"):
		return
	var d = Damage.new()
	var is_crit = _rng.randf() <= crit_chance
	d.is_crit = is_crit
	d.amount = base_damage * (crit_mul if is_crit else 1.0)
	d.knockback = knockback
	d.source_global_pos = global_position
	d.hitstop = hitstop
	area.take_hit(d)
