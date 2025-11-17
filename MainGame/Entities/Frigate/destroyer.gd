extends CharacterBody2D

var speed = 100
var direction = -1

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()
	if global_position.x < -200:
		queue_free()
