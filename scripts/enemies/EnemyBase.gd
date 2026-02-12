extends CharacterBody2D

@export var enemy_type := "Charger"

@onready var health = $Health
@onready var hurtbox = $Hurtbox
@onready var knockback = $Knockback

func _ready() -> void:
	if hurtbox:
		hurtbox.damaged.connect(_on_damaged)
	if health:
		health.died.connect(queue_free)
	var dm = get_node_or_null("/root/DataManager")
	if dm and health:
		var cfg = dm.get_enemy_config(enemy_type)
		health.max_hp = cfg.get("hp", 50)
		health.current_hp = health.max_hp

func _physics_process(delta: float) -> void:
	velocity += knockback.tick(delta)
	move_and_slide()

func _on_damaged(damage: Damage) -> void:
	if health:
		health.apply_damage(damage.amount)
	if knockback:
		var dir = global_position - damage.source_global_pos
		knockback.add_impulse(dir, damage.knockback)
	if hurtbox:
		hurtbox.set_invincible_for(0.06)
	var time_ctrl = get_tree().get_first_node_in_group("time")
	if time_ctrl and time_ctrl.has_method("do_hitstop"):
		time_ctrl.do_hitstop(damage.hitstop)
