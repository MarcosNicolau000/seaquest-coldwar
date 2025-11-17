extends CharacterBody2D

@export var SPEED = 1000
var initial_velocity = Vector2.ZERO
const LIFETIME = 2.0
@onready var projectile_sprite = $Sprite2D
var should_flip = false 

func _ready() -> void:
	projectile_sprite.flip_h = should_flip
	if should_flip:
		initial_velocity = Vector2.LEFT * SPEED
	else:
		initial_velocity = Vector2.RIGHT * SPEED   
	get_tree().create_timer(LIFETIME).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	velocity = initial_velocity
	move_and_slide()
	if global_position.x > 1300 or global_position.x < -100:
		queue_free()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if body and body.is_in_group("Enemies"):
			if body.has_method("shark_death"):
				body.shark_death()
			queue_free()
			return
