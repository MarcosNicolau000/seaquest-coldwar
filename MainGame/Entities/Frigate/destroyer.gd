extends CharacterBody2D

var projectile_path = preload("res://MainGame/Entities/Frigate/frigate_projectile.tscn")
var speed = 100
var direction = -1

const fire_cooldown = 6.0
var fire_timer = 0.0

func fire():
	fire_timer = fire_cooldown
	var projectile = projectile_path.instantiate()
	var spawn_point = $shootPos.global_position
	projectile.global_position = spawn_point
	projectile.initial_velocity = Vector2(0, 1) * projectile.SPEED
	get_tree().current_scene.add_child(projectile)

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()
	fire_timer -= delta
	if fire_timer <= 0:
		fire()
	if global_position.x < -200:
		queue_free()
