extends Area2D

const SPEED = 150.0
var direction = Vector2(1, 0)

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	
