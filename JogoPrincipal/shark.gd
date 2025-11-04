extends CharacterBody2D
var speed = 8000
var direction = -1

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed * delta
	move_and_slide()
	if global_position.x < -10000:
		queue_free()
