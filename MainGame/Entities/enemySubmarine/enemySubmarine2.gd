extends CharacterBody2D

var explosion = preload("res://MainGame/Effects/explosion.tscn")
var projectile_path = preload("res://MainGame/Entities/enemySubmarine/projectile2.tscn")
@onready var submarine_sprite = $Sprite2D

var speed = 200
var direction = -1
var cont = 0
var submarineHitted = false
var flipCount = 0

const fire_cooldown = 3.0
var fire_timer = 0.0

func _ready() -> void:
	submarine_sprite.flip_h = (direction == -1)

func fire():
	fire_timer = fire_cooldown
	var projectile = projectile_path.instantiate()
	var spawn_point = $shootPos.global_position
	projectile.global_position = spawn_point
	projectile.initial_velocity = Vector2(direction, 0) * projectile.SPEED + velocity
	projectile.should_flip = (direction == -1)
	get_tree().current_scene.add_child(projectile)

func _physics_process(delta):
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()
	fire_timer -= delta
	if fire_timer <= 0:
		fire()
	if global_position.x < -150:
		queue_free()
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		var area = col.get_collider()
		var body = col.get_collider()
		if area and area.is_in_group("Diver"):
			if area.has_method("diver_death"):
				area.diver_death()
		if body is CharacterBody2D and body.is_in_group("EnemySubmarine") and flipCount == 0:
			direction *= -1
			submarine_sprite.flip_h = (direction == -1)
			global_position.x -= 50
			flipCount = 1
			return

func submarine_death():
	submarineHitted = true
	var deathEffect = explosion.instantiate()
	deathEffect.position = position
	get_parent().add_child(deathEffect)
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile") and body.is_in_group("Player"):
		body.queue_free()
		cont += 1
	if cont == 2 or body.is_in_group("Shark"):
		submarine_death()
		if body.is_in_group("Player"):
			GameStartRoutine.add_score(300)
