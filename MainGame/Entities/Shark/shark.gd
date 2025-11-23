extends CharacterBody2D
var speed = 200
var direction = -1
var blood = preload("res://MainGame/Effects/blood.tscn")
var sharkHitted = false

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()
	if global_position.x < -100:
		queue_free()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var area = collision.get_collider()
		if area and area.is_in_group("Diver"):
			if area.has_method("diver_death"):
				area.diver_death()

func shark_death():
	sharkHitted = true
	var deathEffect = blood.instantiate() as Node2D
	deathEffect.position = position
	get_parent().add_child(deathEffect)
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		body.queue_free()
		if !sharkHitted:
			shark_death()
		if body.is_in_group("Player"):
			Statistics.add_shark()
			GameStartRoutine.add_score(100)
 
