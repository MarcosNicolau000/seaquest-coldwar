extends CharacterBody2D

@export var SPEED = 500
@onready var projectile_sprite = $Sprite2D
var initial_velocity = Vector2.ZERO
var should_flip = false
const LIFETIME = 2.0

func _ready():
	projectile_sprite.flip_h = should_flip
	get_tree().create_timer(LIFETIME).timeout.connect(queue_free)

func _physics_process(delta):
	velocity = initial_velocity
	move_and_slide()
	if global_position.x > 1300 or global_position.x < -100:
		queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Shark"):
		if body.has_method("player_death"): 
			body.player_death()
		if body.has_method("shark_death"): 
			body.shark_death()
		queue_free()
