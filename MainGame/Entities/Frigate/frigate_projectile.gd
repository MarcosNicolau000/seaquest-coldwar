extends CharacterBody2D

@export var SPEED = 100
var initial_velocity = Vector2.ZERO

func _physics_process(delta):
	velocity = initial_velocity
	move_and_slide()
	if global_position.y > 670:
		queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Enemies") and not body.is_in_group("Frigate"):
		if body.has_method("submarine_death"):
			body.submarine_death()
		if body.has_method("player_death"): 
			body.player_death()
		if body.has_method("shark_death"): 
			body.shark_death()
		queue_free()
