extends Node

@export var damping := 800.0
var velocity := Vector2.ZERO

func add_impulse(direction: Vector2, force: float) -> void:
	velocity += direction.normalized() * force

func tick(delta: float) -> Vector2:
	velocity = velocity.move_toward(Vector2.ZERO, damping * delta)
	return velocity
