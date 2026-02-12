extends CharacterBody2D

@export var speed := 260.0
@export var roll_speed := 420.0
@export var roll_duration := 0.28
@export var roll_cooldown := 0.8

var _can_roll := true

func _physics_process(_delta: float) -> void:
	var input_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vec * speed
	move_and_slide()

func try_roll() -> void:
	if not _can_roll:
		return
	_can_roll = false
	await get_tree().create_timer(roll_duration).timeout
	await get_tree().create_timer(roll_cooldown).timeout
	_can_roll = true
